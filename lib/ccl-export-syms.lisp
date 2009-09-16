;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: ccl-export-syms.lisp,v $
;;  Revision 1.15  2006/03/08 20:42:03  alice
;;  ;; export a few more MOP things - from Pascal C.
;; --- 5.2b1
;;
;;  Revision 1.14  2005/02/02 00:53:05  alice
;;  ;; export standard-slot-definition etal
;;
;;  Revision 1.13  2004/05/11 20:34:35  alice
;;  ;; put back MCL-MOP package - ?? export class-own-wrapper from ccl
;;
;;  Revision 1.12  2004/05/02 01:32:30  alice
;;  ;; akh comment out MCL-MOP package ?
;;
;;  Revision 1.11  2004/02/23 04:15:29  svspire
;;  5.1b2 comment was premature
;;
;;  Revision 1.10  2004/02/18 05:12:37  svspire
;;  export '*alias-resolution-policy*
;;
;;  Revision 1.9  2004/02/08 02:06:51  alice
;;  ; akh - copy-instance was not exported from CCL.
;;
;;  Revision 1.8  2004/01/16 19:43:28  svspire
;;  export 'reference-method
;;
;;  Revision 1.7  2003/12/29 03:37:21  gtbyers
;;  Don't export *SUPER-OPTIMIZE-PRIMARY-SLOT-ACCESS*, which doesn't exist anymore ...
;;
;;  Revision 1.6  2003/12/08 08:01:43  gtbyers
;;  Export MOP symbols, define an MCL-MOP package and export them from there as
;;  well.
;;
;;  4 3/14/97  akh  export launch app etc
;;  12 7/18/96 akh  get-dead-keys-state
;;  9 6/7/96   akh  extended-string-p etal
;;  7 5/20/96  akh  load-patches and load-all-patches
;;  4 3/16/96  akh  get/set fpu-mode
;;  2 10/17/95 akh  merge patches
;;  20 6/6/95  akh  fred-item, window-fred-item
;;  19 5/23/95 akh  application-eval-enqueue
;;  14 5/10/95 akh  window-key-handler
;;  9 5/4/95   akh  %str-from-ptr-in-script
;;  6 4/25/95  akh  add ones reported by Andrews
;;  4 4/10/95  akh  3d-button
;;  6 3/14/95  akh  *elements-per-buffer*, *default-character-type*
;;  5 3/2/95   akh  application-file-creator *tool-line-color*, *tool-back-color
;;  4 2/17/95  slh  *pascal-full-longs*
;;  (do not edit before this line!!)

;; ccl-export-syms.lisp

;; Copyright 1985-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.

#|
Modification History
;; export *load-verbose* - it even has documentation
;; export a few more MOP things - from Pascal C.
;; --- 5.2b1
;; export standard-slot-definition etal
;; --------- 5.1 final
;; put back MCL-MOP package - ?? export class-own-wrapper from ccl
;; akh comment out MCL-MOP package ?
; ss  - export *alias-resolution-policy*
; akh - copy-instance was not exported from CCL.
; --------- 5.1b1
; akh osx-p bbox-p
; --------- 4.4b3
06/03/99 akh  provide etal, export to CL package
;;------------- 4.3b2
09/24/98 akh selected-cell-contents, first-selected-cell, arrow-dialog-item (crummy name)
07/25/98 akh  ensure-directories-exist
07/18/98 akh   boolean
07/04/98 akh   spell add-to-shared-library-search-path right
03/11/97 bill  file-data-size, file-resource-size, file-allocated-data-size,
               file-allocated-resource-size, file-info
03/04/97 bill  *use-external-style-scrap*, *minimum-stack-overflow-size*
01/30/97 bill  *super-optimize-primary-slot-access*,
               table-row-height, table-column-width,
               separator-size, separator-visible-p, separator-color,
               separator-pattern
11/11/96 bill  lock-name
10/29/96 bill  process-poll, process-poll-with-timeout, *always-process-poll-p*
 ------------  4.0
 9/30/96 bill  %get-double-float, %get-single-float, and friends.
 ------------- 4.0b2
07/08/96 bill  add-to-shared-library-search-patch, remove-from-shared-library-search-path
 5/27/96 bill  fred-autoscroll-h-p, fred-autoscroll-v-p
 akh - load/all-patches
 ------------  MCL-PPC 3.9
 5/03/96 slh   application-init-file
 3/29/96 bill  define-entry-point
 3/28/96 bill  store-conditional
 2/27/96 bill  terminate-when-unreachable, terminate, drain-termination-queue,
               cancel-terminate-when-unreachable, termination-function, *enable-automatic-termination*
 5/19/95 slh   with-clip-rect-intersect
 5/16/95 slh   more process & lock symbols
 5/15/95 slh   current-app-name
 5/12/95 slh   deftrap-inline
 5/06/95 slh   application-XXX
 5/05/95 slh   *autoclose-inactive-listeners*
 4/27/95 slh   process, stack-group, misc.
 4/07/95 slh   dialog-item-enabled-p
 4/07/95 akh   nuke emacs-mode add control-key-mapping
 3/29/95 slh   export gestalt
 3/24/95 slh   *all-processes*
 3/16/95 slh   underlined-view
    ?    akh   *default-character-type*, *elements-per-buffer*
 2/17/95 slh   *pascal-full-longs*
-------------  3.0d17
12/30/94 alice let-globally, ed-set-view-font
10/04/93 bill startup-finished
------------  3.0d13
05/04/93 bill *menu-id-object-alist* -> *menu-id-object-table*
04/30/93 bill current-process -> *current-process*
04/28/93 bill %get-fixnum, %hget-fixnum
              more process accessors
------------- 2.1d5
02/22/93 bill open-application-document, print-application-document
12/09/92 bill menu-item-icon-num, set-menu-item-icon-num
10/26/92 bill without-event-processing, with-event-processing-enabled.
07/31/92 bill window-on-screen-position, window-on-screen-size, machine-owner.
              remove *machine-instance*
07/22/92 bill slot-definition-initargs, slot-definition-initform,
              slot-definition-initfunction, slot-definition-type, slot-readers, slot-writers,
              accessor-method-slot-definition
;------------ 2.0
01/28/92 bill *FRED-HISTORY-LENGTH*, *LISTENER-HISTORY-LENGTH*, *MULTI-CLICK-COUNT*,
              CHOOSE-DIRECTORY-DIALOG, COMPILER-POLICY, CURRENT-COMPILER-POLICY,
              CURRENT-FILE-COMPILER-POLICY, FIND-MACTYPE, INSTALL-QUEUED-REPLY-HANDLER,
              MENU-ELEMENT, MENU-UPDATE-FUNCTION, NEW-COMPILER-POLICY, WINDOW-SAVE-COPY-AS,
              SET-CURRENT-COMPILER-POLICY, SET-CURRENT-FILE-COMPILER-POLICY,
              STANDARD-METHOD-COMBINATION, STREAM-DIRECTION, UNDO-MORE, WINDOW-DEFS-DIALOG,
              WINDOW-EVAL-SELECTION, WINDOW-EVAL-WHOLE-BUFFER
01/24/92 gb   run-fred-command.
;-------------- 2.0f1
01/13/92 gb   nuke *FASL-COMPILER-WARNINGS*
01/08/92 bill %hget-unsiged-byte, %hget-unsigned-word, %hget-signed-long, %hget-unsigned-long,
              advisedp, queued-reply-handler, no-queued-reply-handler, print-call-history,
              backtrace -> select-backtrace, buffer-remove-unused-fonts
01/04/92 gb   egc-configuration.
12/31/91 bill view-level, set-view-level, view-bring-to-front, view-send-to-back
12/27/91 bill set-dialog-item-action-function, throw-cancel
12/29/91 gb   gccounts,gctime.
11/26/91 alice nuke *undo-menu-item*, add set-fred-undo-string, fred-shadowing-comtab, set-..
;-------------- 2.0b4
11/05/91 bill with-cstrs
10/22/91 bill %gen-trap
10/18/91 bill nuke remove-buffer-font, replace-buffer-font
10/15/91 bill add invalidate-region, validate-region
10/13/91 bill add view-default-font
10/11/91 bill clear-class-direct-methods-caches -> clear-specializer-direct-methods-caches
10/10/91 bill remove slot-value-if-bound
              add metaobject, long-method-combination, short-method-combination,
              standard-accessor-method, standard-reader-method,
              standard-writer-method, specializer, class,
              funcallable-standard-class
10/04/91 bill with-focused-dialog-item
10/03/91 bill kill class-direct-slots.  Add class-direct-instance-slots, class-direct-class-slots,
              class-class-slots
09/13/91 bill with-font-focused-view
-------- 2.0b3
08/30/91 gb   configure-egc.
08/29/91 bill remove *time-zone*
07/31/91 bill class-slots -> class-instance-slots
07/21/91 alice same-buffer-p, ed-insert-with-undo, ed-replace-with-undo, nuke pp-cadr
07/21/91 gb   export ccl:*break-on-warnings*, debugging-function-name.  Nuke
              dumplisp, %get-safe-ptr.  Export egc*.
07/08/91 bill nuke *documentation-font-spec*,copy-into-float,with-temporary-numbers,
              with-permanent-numbers,max-temp-numbers,count-temp-numbers,
              temp-float-p, put, window-default-font, window-font,
              set-window-font, set-part-color-loop, *keyword-package*,
              *common-lisp-package*, *ccl-package*, do-dialog-items,
              ensure-simple-string
07/01/91 bill help-spec
06/21/91 bill with-back-color
06/18/91 bill %get-cstring, %put-cstring, point<=
06/29/91 alice *stepper-running* => *stepping*
06/04/91 joe  add l1-highlevel-event symbols
------------- 2.0b2
05/28/91 bill  window-on-screen-p
05/20/91 gb    %uvsize -> uvsize; add &restv.
05/13/91 bill  view-mini-buffer
05/06/91 bill  copy-instance
05/03/91 alice fred-prefix...
04/03/91 bill find-clicked-subview
04/02/91 bill accept-key-events, toggle-blinkers, *last-mouse-click-window*, window-under
03/25/91 bill buffer-line, fred-blink-position
03/22/91 bill unadvise
02/28/91 bill *print-simple-vector*, *print-simple-bit-vector*, *print-string-length*
              *print-abbreviate-quote*
01/14/91 gb   flush *use-wait-next-event*.	   
----------------- 2.0b1
02/04/91 bill class-precedence-list, put MOP functions together
01/29/91 bill @
01/28/91 bill CLASS-direct-methods, CLASS-direct-generic-functions -> SPECIALIZER-direct-xxx
01/28/91 bill set-menu-item-action-function
01/18/91 bill reverse-mark does not yet exist.
              stream-reader, stream-writer,
              maybe-default-stream-reader, maybe-default-stream-writer
01/08/91 bill require-trap, require-trap-constant, reindex-interfaces
01/09/91 gb   Don't export CONTINUE, METHOD-QUALIFIERS, STREAM, GET-OUTPUT-STREAM-STRING,
              STRUCTURE-CLASS, or ABORT from :ccl package.
01/07/91 gb   *autoload-lisp-package*.
01/04/91 bill set-view-nick-name, fred-copy-styles-p, *step-print-level*,
              *step-print-length*, *environs*, buffer-replace-font-codes,
              buffer-replace-font-spec
01/01/91 bill *inspector-disassembly*, *fast-help -> *fast-help*
12/12/90 bill arglist-string
12/11/90 bill set-menu-item-update-function
12/10/90 bill *fast-help*
12/07/90 bill ff-call, ff-load, convert-scrap
11/28/90 bill get-next-queued-form
11/26/90 alice nuke *fast-eval*
11/01/90 bill window-default-font.
11/05/90 alice *trace-bar-frequency*, advise
10/02/90 bill with-clip-rect, with-pen-saved.
10/01/90 bill add-self-to-dialog -> install-view-in-window
              remove-self-from-dialog -> remove-view-from-window
09/28/90 bill macptrp, macptr, pointer-size, edit-definition-p
09/27/90 bill *save-position-on-window-close*, handle-locked-p
09/25/90 bill wptr-color-p
09/20/90 bill *autoload-traps*
09/19/90 bill method-function, method-name, method-generic-function, class-own-wrapper,
              class-direct-superclasses, class-direct-subclasses, class-direct-methods,
              class-direct-generic-functions, class-direct-slots
10/16/90 gb   don't export WHILE or UNTIL; do export *MODULES* and UVECTORP.
09/17/90 bill nix buffer-replace-font-codes, buffer-replace-font-spec until
              they're implemented.
              Add %uvsize, uvectorp, stream-rubout-handler, add-definition-type,
              lsh, replace-buffer-font, remove-buffer-font,
              (set-)gc-event-check-enabled-p
09/15/90 bill *default-editor-class*, *default-listener-class*,
              structure-class, structure-object
09/13/90 bill borderless-button-dialog-item, compile-load
09/12/90 bill nix find-named-subview, add *signal-printing-errors*
09/05/90 bill fred-hscroll, set-fred-hscroll, fred-margin, set-fred-margin
08/31/90 bill any-modifier-keys-p
08/29/90 bill view-control-click-event-handler, window-close-event-handler,
              window-drag-event-handler, window-grow-event-handler
08/27/90 joe  REMOVED: define-record, record-length, record-storage,
              record-default, record-fields, field-info, record-info, make-record
              set-record, copy-record, dispose-record, print-record, get-record-field
              set-record-field, rref, rset, rlet (moved them to defrecord.lisp so
              defrecord could be library loaded without having all the symbols around)
              (Defrecord is still here!) *fred-window-position* and *fred-window-size*

              ADDED: deftrap, %get-unsigned-byte, %get-unsigned-word, %get-signed-long
              *window-default-position* *window-default-size*
              *window-default-zoom-position* *window-default-zoom-size*
              set-window-zoom-position set-window-zoom-size window-default-zoom-position
              window-default-zoom-size

08/25/90 bill *always-eval-user-defvars*, list-length-and-final-cdr
08/24/90 bill compiled-lexical-closure, function-args, fred-last-command, 
              set-fred-last-command
              Remove *action-menu-item*, *action-menu*, *action-object*,
                     *str-of-spaces*, *user-package*,
                     set-h-specifier,h-specifier,set-v-specifier,v-specifier,
                     cell-to-subscript,subscript-to-cell,array-dialog-item,
                     table-array,set-table-array,table-subscript,set-table-subscript
                     buffer-line,choose-font-dialog,declare-initargs,
                     get-declared-initargs,dialog-item-click-event-handler,
                     enter-editable-text,exit-editable-text,last-command,menu-dispose,
                     menus,record-default,set-record,width-correction
08/23/90 bill fred-start-mark -> fred-display-start-mark, set-fred-display-start-mark,
              tyo, tyi, untyi, while, until
08/22/90 bill def-load-pointers, *lisp-cleanup-functions*, *lisp-startup-functions*
08/20/90 bill From Mark: add-key-handler backtrace, buffer-replace-font-codes,
              buffer-set-font-codes, change-key-handler, column, ed-current-symbol,
              enter-key-handler, exit-key-handler, fred, highlight-table-cell,
              key-handler-idle, key-handler-list, key-handler-p,
              menu-item-update-function, method, remove-key-handler,
              rgb-to-color, trace-tab, view-mouse-enter-event-handler,
              view-mouse-leave-event-handler, window-do-first-click
              *windoid-count*, *trace-max-indent*, *trace-level*,
              *record-types*, *mouse-view*, *mini-buffer-help-output*,
              *idle-sleep-ticks*, *fred-keystroke-hook*, *foreground-event-ticks*,
              *fasl-save-doc-strings*, *fasl-save-definitions*,
              *fasl-compiler-warnings*, *current-view*, *color-available*,
              *background-event-ticks*, *foreground-sleep-ticks*,
              *background-sleep-ticks*
08/17/90 bill string-output-stream, get-output-stream-string, grafport-font-codes,
              truncating-string-stream, make-truncating-string-stream
08/16/90 bill slot-value-if-bound
08/14/90 bill view-origin, set-grafport-font-codes
08/13/90 bill apropos-dialog, show-documentation, with-temporary-consing, temp-cons,
              arglist, arglist-to-stream, regions-overlap-p, discard-all-subviews
08/11/90 blll *defmethod-congruency-override*
08/10/90 gb   remove %svref; add uvref, provide, require, compiler-let.
08/10/90 bill nremove, display-in-windows-menu, generic-function-methods,
              method-specializers, method-qualifiers
08/09/90 bill font-spec
08/08/90 bill press-button, set-menu-item-enabled-p, get-source-files,
              edit-definition
08/07/90 bill fred-tabcount, ed-push-mark, ed-pop-mark
08/06/90 bill %address-of, ensure-simple-string, method-exists-p,
              grafport-write-string, %getpen, input-stream, output-stream,
              ensure-simple-string, wptr-font-codes, set-wptr-font-codes,
              view-clip-region
08/01/90 bill find-dialog-item, set-fore-color, view-scroll-position,
              set-view-scroll-position, record-source-file
              color-red, color-green, color-blue, color-values, make-color
              color-to-rgb, cell-font, set-cell-font, draw-menubar-if,
              buffer-mark-p, with-font-codes
07/31/90 bill clear-gf-cache, clear-all-gf-caches, clear-clos-caches,
              Remove allocate-instance (it's part of common-lisp),
              buffer-previous-font-change, %svref, target, window-show-cursor
07/30/90 bill *arglist-on-space*, *help-output*, *listener-default-font-spec*,
              *mini-buffer-font-spec*, next-screen-context-lines
07/23/90 bill *clear-mini-buffer*
07/06/90 bill window-ensure-on-screen, dialog-item-width-correction
07/05/90 bill clear-class-direct-methods-caches, *check-call-next-method-with-args*,
              view-default-position, do-dialog-items, buffer-insert-substring
06/29/90 bill point-in-click-region-p, view-contains-point-p
06/25/90 bill get-dead-keys, set-dead-keys
06/19/90 bill set-dialog-item-handle, %ptr-eql, %get-unsigned-long
06/14/90 bill ed-kill-forward-sexp, ed-kill-backward-sexp, fred-vpos,
              set-allow-tabs, set-allow-returns
06/12/90 bill ed-current-sexp, window-point-position -> fred-point-position,
              window-hpos -> fred-hpos, window-line-vpos -> fred-line-vpos,
              window-update -> fred-update, window-buffer -> fred-buffer,
              window-start-mark -> fred-start-mark
              ed-skip-fwd-wsp&comments -> buffer-skip-fwd-wsp&comments.
06/10/90 gb   *make-package-use-defaults*, DOWNWARD-FUNCTION.
06/08/90 gb   compiler-macroexpand & compiler-macroexpand-1 .
06/07/90 bill Remove fred-font, set-fred-font
05/24/90 bill Remove window-(de)activate-event-handler, window-click-event-handler,
              (set-)window-position, (set-)window-size
              Add view-mouse-position
05/23/90 bill dialog-item-default-size -> view-default-size
05/07/90 bill map-windows
05/05/90 bill *scrap-state*, *scrap-handler-alist*, scrap-handler,
              get-internal-scrap, set-internal-scrap, internalize-scrap,
              externalize-scrap.
05/01/90 bill window-size-parts
04/30/90 gb   export from CL what is CL's.
04/30/90 bill do-subviews, map-subviews, subviews
04/27/90 bill default-button-dialog-item
04/25/90 bill convert-coordinates, window-active-p
04/23/90 bill view-convert-coordinates-and-click
04/16/90 bill font-codes-info, merge-font-codes
4/15/90  gz  logical-pathname -> logical-directory
04/11/90 bill stream-write-string, %get-point, stream-line-length
04/10/90 gz  dialog-item-font -> view-font
04/07/90 bill font-codes, view-font-codes, set-view-font-codes
04/01/90 bill dovector
03/30/90 gz  %setf-macptr, %incf-ptr, %null-ptr, %null-ptr-p, stream-peek
03/28/90 bill invalidate-corners, validate-corners
03/21/90 bill view-corners, inset-corners, validate-view
03/17/90 bill menu-owner, menu-item-title, menu-title, menu-item-enabled-p, menu-enabled-p,
              menu-item-style, menu-style, menu-item-action-function, apple-menu, function-name,
              with-fore-color, get-fore-color, get-back-color
03/16/90 bill *menubar*, part-color-with-default, class-prototype, require-type
03/13/90 bill window-type, view-subviews, window-color-p, default-button-p,
              menu-owner => menu-item-owner
03/07/90 bill dialog-item-action-function, view-nick-name, focus-view, with-focused-view,
              invalidate-view, get-next-event, allow-returns => allow-returns-p, allow-tabs-p
03/07/90 bill dialog-item-action-function, view-nick-name, focus-view, with-focused-view,
              invalidate-view, get-next-event
03/06/90 bill make-dialog-item., view-cursor, find-named-subview, find-named-sibling,
              view-named, view-put, view-get, view-remprop, view-container, set-view-container,
              view-window, windoid, find-view-containing-point
03/05/90 bill window-draw-contents & window-key-event-handler => view-xxx.
              dialog-item-key-event-handler removed.  key-handler-mixin.
03/01/90 bill fred-initialize, fred-text-edit-sel-p, fred-wrap-p, fred-font, set-fred-font,
              fred-package, set-fred-package, fred-buffer, fred-start-mark, fred-chunk-size,
              buffer-insert-with-style
02/28/90 bill color-dialog
02/27/90 bill set-part-color, view-click-event-handler, *modal-dialog-on-top*, fred-mixin,
              simple-view, view, frec, *xxx-color*, set-part-color-loop, part-color,
              part-color-list, menu-owner, user-pick-color, with-rgb, real-color-equal
              class-slots, slot-definition-name, allocate-instance
02/26/90 bill Add with-macptrs
02/16/90 bill current-editable-text => current-key-handler
01/03/89 gz  No more %_Pr*.
             Export everything from comtabs.
12/28/89 gz  No more catch-error.
12/27/89 gz  Added ansi-cl symbols.
9/30/89 bill Remove pr-%print-form from export list: it no longer exists.
9/17/89 gb no object lisp symbols (well, maybe some ...).
9/8/89  gz error system
3/17/89 gz Do fixups once only.
9-apr-89 as removed get-next-key-event
03/03/89 gz Run fixups after all loaded up.
9/01/88  gz more file sys mods.
8/29/88  gz removed expand-logical-pathname, expand-logical-namestring.
8/23/88  gz removed *warnings* and *warn-hook*
7/11/88 jaj added %word-to-int %copy-float
6/28/88 jaj added unignore, mini-buffer.  added proclaim object-variable
            for exported object-variables
6/24/88 as  added *idle* and *use-wait-next-event*
6/23/88 as  buffer-insert-with-style -> ed-insert-with-style
            added *paste-with-styles*, *menubar-frozen*
6/22/88 as  added local and set-local
6/22/88 jaj added enter-editable-text, exit-editable-text, fixed
            catch/throw exports
6/21/88 jaj added and removed a bunch of stuff to be accurate with release-notes
6/13/88 as  added print-listener-prompt, %set-toplevel, *save-local-symbols*,
                  *save-local-symbols*
6/9/88  jaj added [catch/throw]-[toplevel/error/cancel/break]
5/31/88 as  added menu-id, dialog-item-key-event-handler, finder-parameters,
            editable-text-enter-hook, editable-text-exit-hook, *inhibit-error*
            *break-loop-tag*, *save-fred-window-positions*
            punted get-selected-string
5/29/88 as  added *fred-default-font-spec*, select-item-from-list, *compiler-warnings*
                  redraw-cell, inherit-from-p, define-record, get-scrap, put-scrap
            punted *car-dialog-item*
5/26/88 as  added *car-dialog-item*, menu-handle, table-print-function
                  dialog-item-handle
5/26/88 jaj added *menu-id-object-alist*
5/20/88 as  put window-hardcopy back
5/20/88 jaj added *fred-special-indent-alist*, removed window-hardcopy
5/19/88  as   punted *abort-char*
5/13/88 jaj removed some useless commented out code
5/12/88 jaj added window-needs-saving-p
4/12/88  cfry added *line-width*
 2/8/88   jaj num-temp-floats/max-temp-floats -> count-temp-numbers/max-temp-numbers
 1/29/88 jaj added defccallable
 01/28/88 as  removed fred-menu-p
12/23/87 jaj with-[temporary|permanent]-floats -> numbers
12/18/87 cfry added *listener*
10/26/87 jaj added abort
10/25/87 jaj added temporary float stuff and moved preload-all-functions from
             sysutils
10/23/87 cfry get-selected-string
10/22/87 jaj removed with-file-or-dir
10/21/87 jaj with-file-or-dir *last-command* last-command uncompile-function
             window-zoom-event-handler window-grow-rect window-drag-rect
10/18/87 cfry *stepper-running*
10/16/87 jaj  pr-%print-form
10/15/87 cfry *ibeam-cursor* -> *i-beam-cursor*
10/15/87 jaj  added print-functions, flavors stuff, *user-package*
              ignore-if-unused def-function-spec-handler 
	      *warn-if-redefine-kernel*
10/12/87 cfry added increment-pathname-version, dialog-item-click-event-handler,
              *user-dialog-item*, pp-cadr, definition-from-file, hardcopy-file,
              5 stream fns, *open-file-streams*
10/05/87 jaj  added %get-safe-ptr
-----------------------------------Version 1.0-------------------------------
8/7/87  gz    added menu-disable
8/6/87  gz    %int-to-ptr, stack-trap, register-trap
8/5/87  gz    added nfunction, *print-structure*, *save-definitions*
8/5/87  gz    removed menu-disabled, menu-item-select. Added objvar.
8/05/87 jaj   added undo setup-undo window-can-undo-p eval-enqueue
8/4/87  gz    window-save, window-save-as, window-revert, window-hardcopy,
              clear, select-all, 
              buffer-current-sexp-start, buffer-current-sexp
8/04/87 jaj   choose-font-spec -> choose-font-dialog added *undo-menu-item*
              and double-click-spacing-p
8/03/87 jaj   added event-ticks, set-event-ticks
8/03/87 gz    Added directoryp, choose-font-spec, *killed-strings*,
              *gray-pattern*, *white-pattern*, *black-pattern*,
              *light-gray-pattern*, *dark-gray-pattern*,
              *trace-print-level*, *trace-print-length*
7/31/87 gz    added %inc-ptr, %get/put-full-long, with-returned-pstrs,
              %ptr-to-int. Changed file stuff for newest doc.
              buffer-setprop -> buffer-putprop.
              commented out fred-menu stuff.
	      buttonp -> mouse-down-p
7/31/87 jaj   export font stuff and some stream stuff. window-update-event-handler
              window-select
7/30/87 gz    programming fred stuff, whitespacep. goodbye -> quit.
	      Removed yes and no.
7/28/87 as    added set/command-key, font-spec stuff, *logical-pathname-alist*
              *d*, yes, no (yes and no should actually be in lisp package)
7/28/87 gz    added find-menu-item
7/27/87 jaj   added a bunch of stuff
7/27/87 jaj   my-sequence -> table-sequence
7/26/87 as    *menu-bar-bottom* ==>  *menubar-bottom*
7/25/87 gz   added lisp-pathnamep, *time-zone*
7/25/87 cfry added *next-screen-context-lines*
7/25/87  gz   have-function -> fhave. object-xxx.
              Removed unhave, *root-object*.
	      added fset, neq, continue, abort-break.
7/24/87 jaj   added *emacs-mode* removed emacs-mode and emacs-mode-p
              added event-handler symbols
7/23/87 cfry ?* -> *
7/2/23   cfry renamed inspector-value to top-inspect-form
              added OBJECT [its a type specifier]
7/22/87  as   added menu globals, inspector-value
              removed *help-menu-position* *help-menu-size*
7/18/87  gz   %get/%hget-signed-word/byte, true, false, fset-globally, with-mark
              removed with-outer-object.
7/17/87  jaj  removed some old init-list syms. added set-xxx for new spec
7/16/87  as   removed modal-fred-menu-p modeless-fred-menu-p, choose-fred-menu
7/11/87  gz   added emacs-mode-p, *style-alist*, *pen-modes*,
	      proclaimed-special-p, displaced-array-p, *keyword-package*,
	      *lisp-package*, *ccl-package*, mac-filename, *stream*,
	      caps-lock-key-p, control-key-p, ed-beep, %hget/put-xxx,
              set-mac-file-creator, set-mac-file-type, set-file-write-date,
              set-file-create-date, set-mac-default-directory, hfsp,
              mac-volume-number, make-mac-pathname, mac-directory,
              mac-pathnamep, *pathname-escape-character*, *module-file-alist*,
              *module-search-path*, without-interrupts, *fast-eval*
7/11/87  as   added table-double-click-p
7/11/87 cfry added errorp, errorp-macro, *fred-window*, *top-listener*
             double-click-p shift-key-p command-key-p option-key-p
7/5/87    gz  removed code to export traps, now done in AllTraps.
              removed making of user package, now done in level-1.
              old object spec -> new object spec, more or less.
              gcoll -> gc.
              moved file-loader exports to file-loader.
              added fred-comtab fns.
87 06 24 cfry added window init symbols, point symbols
|#
(export   ;remember "CCL" at end of list
;setq %ccl-package-export-syms
'(
;dumplisp

;boolean   ;; an afterthought

local
set-local
*elements-per-buffer*
*default-character-type*
application-file-creator
*tool-line-color*
*tool-back-color*
save-application
def-load-pointers
*save-exit-functions*
*restore-lisp-functions*
*lisp-cleanup-functions*
*lisp-startup-functions*
*break-on-warnings*
; misc
*load-verbose*
record-source-file
get-source-files
edit-definition
edit-definition-p
*loading-file-source-file*
apropos-dialog
show-documentation
%set-toplevel
toplevel-loop
toplevel-function
toplevel
cancel
catch-cancel
throw-cancel
*backtrace-on-break*
select-backtrace
print-call-history
compiler-macroexpand
compiler-macroexpand-1
compile-load
temp-cons
preload-all-functions
*last-command*
fred-last-command
set-fred-last-command
uncompile-function
get-print-record
;*emacs-mode*
*control-key-mapping*
*save-position-on-window-close*
*next-screen-context-lines*
next-screen-context-lines
cpu-number
mouse-down-p
*style-alist*
*pen-modes*
*gray-pattern*
*white-pattern*
*black-pattern*
*light-gray-pattern*
*dark-gray-pattern*
;*fast-eval*
abort-break
*trace-print-level*
*trace-print-length*
*trace-bar-frequency*
*environs*
advise
unadvise
advisedp
nfunction
function-name
*stepping*
*step-print-level*
*step-print-length*
finder-parameters
%getpen
*autoload-traps*
require-trap
require-trap-constant
reindex-interfaces

;Left out of CL but in other lisps, or should be
assq
bignump
bitp
constant-symbol-p
proclaimed-special-p
daylight-saving-time-p
delq
fixnump
quit
include
memq
nremove
;put
ratiop
structure-typep
structurep
type-specifier-p
displaced-array-p
without-interrupts
true
false
neq
whitespacep
*print-structure*
*print-simple-vector*
*print-simple-bit-vector*
*print-string-length*
*print-abbreviate-quote*
*signal-printing-errors*
def-function-spec-handler
ignore-if-unused
unignore
*warn-if-redefine-kernel*
require-type
dovector
debugging-function-name
*make-package-use-defaults*
*autoload-lisp-package*
tyo
tyi
untyi
;while
;until
compiled-lexical-closure                ; the type name
list-length-and-final-cdr
lsh



; The MOP
accessor-method-slot-definition
add-dependent
add-direct-method
add-direct-subclass
add-method
class-default-initargs
class-direct-default-initargs
class-direct-slots
class-direct-subclasses
class-direct-superclasses
class-finalized-p
class-precedence-list
class-prototype
class-slots
class-own-wrapper
compute-applicable-methods
compute-applicable-methods-using-classes
compute-class-precedence-list
compute-default-initargs
compute-discriminating-function
compute-effective-method
compute-effective-slot-definition
compute-slots
direct-slot-definition
direct-slot-definition-class
effective-slot-definition
effective-slot-definition-class
ensure-class
ensure-class-using-class
ensure-generic-function-using-class
eql-specializer
eql-specializer-object
extract-lambda-list
extract-specializer-names
finalize-inheritance
find-method-combination
funcallable-standard-instance-access
generic-function-argument-precedence-order
generic-function-declarations
generic-function-lambda-list
generic-function-method-class
generic-function-method-combination
generic-function-methods
generic-function-name
intern-eql-specializer
make-method-lambda
map-dependents
method-function
method-generic-function
method-lambda-list
method-specializers
method-qualifiers
slot-definition
slot-definition-allocation
slot-definition-initargs
slot-definition-initform
slot-definition-initfunction
slot-definition-name
slot-definition-type
slot-definition-readers
slot-definition-writers
slot-definition-location
standard-slot-definition
reader-method-class
remove-dependent
remove-direct-method
remove-direct-subclass
remove-method
set-funcallable-instance-function
slot-boundp-using-class
slot-makunbound-using-class
slot-value-using-class
specializer-direct-generic-functions
specializer-direct-methods
standard-instance-access
update-dependent
validate-superclass
writer-method-class

metaobject
long-method-combination
short-method-combination
standard-accessor-method
standard-reader-method
standard-writer-method
specializer

funcallable-standard-class
forward-referenced-class
standard-direct-slot-definition
standard-effective-slot-definition
standard-slot-definition
slot-definition
effective-slot-definition
direct-slot-definition

clear-specializer-direct-methods-caches
*check-call-next-method-with-args*
clear-gf-cache
clear-all-gf-caches
clear-clos-caches
;structure-object
method-exists-p
copy-instance

string-studlify		;** DO NOT REMOVE, DO NOT DOCUMENT
nstring-studlify	;** DO NOT REMOVE, DO NOT DOCUMENT

; User Options
*compile-definitions*
*record-source-file*
*save-doc-strings*
*verbose-eval-selection*
*warn-if-redefine*
*break-on-errors* 
*save-definitions*
*save-local-symbols*
*fasl-save-local-symbols*
*paste-with-styles*
*always-eval-user-defvars*

;These 3 need to be set by the user in order for the correspondingly named
;functions to return something other than "unspecified".
*short-site-name*
*long-site-name*
machine-owner

init-list-default
fset
;boundp
;fboundp

; Files.
mac-namestring
mac-file-namestring
mac-directory-namestring
mac-default-directory
directory-pathname-p
set-mac-default-directory
;*working-directory*
def-logical-directory
full-pathname
*logical-directory-alist*
create-file
create-directory
;ensure-directories-exist
file-create-date
set-file-write-date
set-file-create-date
file-data-size
file-resource-size
file-allocated-data-size
file-allocated-resource-size
file-info
copy-file
lock-file
unlock-file
file-locked-p
mac-file-type
mac-file-creator
set-mac-file-type
set-mac-file-creator
eject-disk
eject&unmount-disk
disk-ejected-p
hfs-volume-p
flush-volume
volume-number
drive-number
drive-name
directoryp
choose-file-dialog
choose-new-file-dialog
;choose-directory-dialog
choose-new-directory-dialog
choose-file-default-directory
set-choose-file-default-directory
;hardcopy-file        ; who's he?

*module-file-alist*
*module-search-path*
*.lisp-pathname*
*.fasl-pathname*
*pathname-translations-pathname*

;font-spec stuff
*font-list*
real-font
font-info
font-line-height
wptr-font-codes
set-wptr-font-codes
grafport-font-codes
set-grafport-font-codes
string-width
font-spec

; Points ;documented in quickdraw but defined in the default system
point-string
point-h
point-v
make-point
add-points
subtract-points
point<=

; Events -- definately not yet complete
*current-event*
*eventhook*
*cursorhook*
event-ticks
set-event-ticks
event-dispatch
get-next-event
window-event
window-null-event-handler
view-control-click-event-handler
window-close-event-handler
window-drag-event-handler
window-grow-event-handler
view-key-event-handler
view-put
view-get
view-remprop
window-mouse-up-event-handler
window-key-up-event-handler
window-active-p
window-select-event-handler
window-update-event-handler
window-zoom-event-handler
window-size-parts
window-grow-rect
window-drag-rect

accept-key-events
toggle-blinkers
*last-mouse-click-window*
window-under

window-draw-grow-icon
window-cursor
view-cursor
with-cursor
update-cursor
window-update-cursor
set-cursor
*arrow-cursor*
*i-beam-cursor*
*watch-cursor*

;these should be marked as redefinable
get-scrap
put-scrap
@
*scrap-state*
*scrap-handler-alist*
scrap-handler
get-internal-scrap
set-internal-scrap
internalize-scrap
externalize-scrap
convert-scrap
*use-external-style-scrap*

; Highlevel Events (appleevents)
*highlevel-eventhook*
appleevent-error 
ae-error-str
ae-error
with-aedescs
check-required-params
install-appleevent-handler
deinstall-appleevent-handler
application
*application*
appleevent-idle
%path-from-fsspec
open-application-handler
quit-application-handler
open-documents-handler
print-documents-handler
open-application-document
print-application-document
queued-reply-handler
no-queued-reply-handler
launch-application-handler
activate-application-handler

; Windows
;*window*
window
;*fred-window*
fred-window
*default-editor-class*
fred-mixin
fred-item
window-fred-item
fred-initialize
fred-text-edit-sel-p
fred-wrap-p
fred-copy-styles-p
fred-chunk-size
fred-tabcount
fred-package
set-fred-package
fred-buffer
fred-blink-position
fred-prefix-argument
fred-prefix-numeric-value
*top-listener*
windows
map-windows
target
wptr
window-object
with-port
front-window
find-window
window-close
window-select
window-key-handler
window-show
window-hide
window-shown-p
window-zoom-position
window-zoom-size
set-window-zoom-position
set-window-zoom-size
window-default-zoom-position
window-default-zoom-size

window-layer
set-window-layer
window-title
set-window-title
view-draw-contents
view-mouse-position
font-codes
view-font-codes
with-font-codes
buffer-font-codes
ed-view-font-codes
font-codes-line-height
font-codes-string-width
set-view-font-codes
font-codes-info
merge-font-codes
window-type
window-color-p
wptr-color-p
with-clip-rect
with-clip-rect-intersect
with-pen-saved

; screen info
*screen-width*
*screen-height*
*pixels-per-inch-x*
*pixels-per-inch-y*
*menubar-bottom*

; window defaults
*window-default-position*
*window-default-size*
*window-default-zoom-position*
*window-default-zoom-size*
;*fred-window-position*
;*fred-window-size*

;*listener*
listener
*listener-window-position*
*listener-window-size*
*listener-default-font-spec*
*default-listener-class*
*arglist-on-space*
*inspector-disassembly*
arglist
arglist-string
arglist-to-stream
function-args
*help-output*
*mini-buffer-font-spec*
*fast-help*
help-spec

*fred-default-font-spec*
*save-fred-window-positions*

double-click-p
double-click-spacing-p
shift-key-p
command-key-p
option-key-p
caps-lock-key-p
control-key-p
any-modifier-keys-p

; Views
simple-view
view
underlined-view
windoid
frec
view-container
set-view-container
view-window
view-subviews
focus-view
with-focused-view
with-font-focused-view
with-focused-dialog-item
invalidate-view
validate-view
view-corners
invalidate-corners
validate-corners
invalidate-region
validate-region
inset-corners
view-level
set-view-level
view-bring-to-front
view-send-to-back

;Quickdraw ;in AUX. has its own EXPORT statement

;MENUS
typein-menu-item
*menu-id-object-table*
menubar
*menubar-frozen*
set-menubar
*default-menubar*
*menubar*
draw-menubar-if
find-menu
menu
apple-menu
menu-title
set-menu-title
menu-item-owner
menu-owner
menu-item-title
menu-title
menu-item-enabled-p
set-menu-item-enabled-p
menu-enabled-p
menu-item-style
menu-style
menu-item-action-function
set-menu-item-action-function
menu-item-icon-num
set-menu-item-icon-num
menu-install
menu-deinstall
menu-installed-p
menu-enable
menu-disable
menu-enabled-p
add-menu-items
add-new-item
remove-menu-items
menu-items
menu-update
update-menu-items
menu-select
menu-handle
menu-id

menu-item
;*window-menu-item*
window-menu-item
menu-item-title
set-menu-item-title
menu-item-action
menu-item-enable
menu-item-disable
menu-item-enabled-p
command-key
set-command-key
menu-item-check-mark
set-menu-item-check-mark
menu-item-style
set-menu-item-style
menu-item-update
find-menu-item

;the menus
*apple-menu*
*file-menu*
*edit-menu*
*eval-menu*
*tools-menu*
*windows-menu*
display-in-windows-menu

; Dialogs 
;*dialog*
dialog
color-dialog
modal-dialog
return-from-modal-dialog
*modal-dialog-on-top*

add-subviews
remove-subviews
discard-all-subviews
do-subviews
map-subviews
subviews
dialog-items
make-dialog-item
find-named-sibling
view-nick-name
set-view-nick-name
view-named
find-view-containing-point
find-clicked-subview
point-in-click-region-p
view-contains-point-p
set-current-key-handler
current-key-handler
set-default-button
default-button
default-button-p
press-button
pushed-radio-button
3d-button
cut
copy
paste
undo
setup-undo
setup-undo-with-args
window-can-undo-p
window-can-do-operation
window-needs-saving-p
eval-enqueue
*eval-queue*
get-next-queued-form
*idle*
without-event-processing
with-event-processing-enabled

;*dialog-item*
dialog-item

dialog-item-action
dialog-item-action-function
set-dialog-item-action-function
find-dialog-item
set-view-position
view-position
set-view-size
view-size
view-clip-region
view-origin
set-dialog-item-text
dialog-item-text
set-view-font
ed-set-view-font
view-font
view-draw-contents
view-focus-and-draw-contents
regions-overlap-p
dialog-item-disable
dialog-item-enable
dialog-item-enabled-p
set-dialog-item-enabled-p
view-deactivate-event-handler
view-activate-event-handler
view-click-event-handler
view-convert-coordinates-and-click
convert-coordinates
install-view-in-window
remove-view-from-window
dialog-item-handle
set-dialog-item-handle
view-default-size
view-default-position
view-default-font
view-scroll-position
set-view-scroll-position
window-ensure-on-screen
window-on-screen-p
window-on-screen-position
window-on-screen-size
dialog-item-width-correction
part-color
part-color-with-default
set-part-color
part-color-list
user-pick-color
get-fore-color
get-back-color
set-fore-color
set-back-color
with-fore-color
with-back-color
button-dialog-item
borderless-button-dialog-item
default-button-dialog-item
static-text-dialog-item
editable-text-dialog-item
fred-dialog-item
key-handler-mixin

allow-returns-p
allow-tabs-p
set-allow-tabs
set-allow-returns
;*check-box-dialog-item*
check-box-dialog-item
check-box-checked-p
check-box-check
check-box-uncheck
;*radio-button-dialog-item*
radio-button-dialog-item
radio-button-push
radio-button-unpush
radio-button-pushed-p
radio-button-cluster

;*table-dialog-item*
table-dialog-item
table-hscrollp
table-vscrollp
cell-contents
selected-cell-contents
first-selected-cell
cell-font
set-cell-font
redraw-cell
draw-cell-contents
set-table-dimensions
table-dimensions
set-cell-size
cell-size
cell-select
cell-deselect
cell-selected-p
set-visible-dimensions
visible-dimensions
selected-cells
cell-position
scroll-to-cell
scroll-position
point-to-cell
table-print-function
table-row-height
table-column-width
separator-size
separator-visible-p
separator-color
separator-pattern

;*sequence-dialog-item*
sequence-dialog-item

table-sequence
set-table-sequence
cell-to-index
index-to-cell
arrow-dialog-item

;*user-dialog-item*
user-dialog-item

; fred: comtabs and keystrokes
comtabp
copy-comtab
make-comtab
comtab-get-key
comtab-set-key
def-fred-command
comtab-key-documentation
comtab-find-keys
keystroke-name
keystroke-code
event-keystroke
keystroke-function
get-dead-keys
get-dead-keys-state
set-dead-keys
comtab        ;instance var
*comtab*
*listener-comtab*
*control-x-comtab*
*fred-special-indent-alist*
add-definition-type
*current-character*
*current-keystroke*
buffer-skip-fwd-wsp&comments
buffer-word-bounds
ed-push-mark
;ed-pop-mark
ed-insert-char
ed-self-insert
ed-delete-with-undo
ed-insert-with-undo
ed-replace-with-undo
set-fred-undo-string
add-to-killed-strings
rotate-killed-strings
ed-kill-selection
ed-kill-forward-sexp
ed-kill-backward-sexp
ed-beep
run-fred-prefix
run-fred-command
fred-shadowing-comtab
set-fred-shadowing-comtab
buffer-mark
buffer-mark-p
buffer-position
make-mark
set-mark
move-mark
mark-backward-p
;reverse-mark
make-buffer
buffer-size
buffer-modcnt
buffer-plist
buffer-getprop
buffer-putprop
buffer-line-start
buffer-line-end
buffer-column
lines-in-buffer
buffer-line
buffer-char
buffer-char-replace
buffer-insert
buffer-insert-with-style
buffer-insert-substring
buffer-substring
buffer-delete
;buffer-studlify-region		;** DO NOT REMOVE, DO NOT DOCUMENT
buffer-downcase-region
buffer-upcase-region
buffer-capitalize-region
buffer-char-pos
buffer-not-char-pos
buffer-string-pos
buffer-substring-p
buffer-word-bounds
buffer-fwd-sexp
buffer-bwd-sexp
buffer-current-sexp
buffer-current-sexp-bounds
ed-current-sexp
buffer-current-sexp-start
buffer-insert-file
buffer-write-file
same-buffer-p
fred-buffer
fred-update
window-show-cursor
fred-display-start-mark
set-fred-display-start-mark
fred-hscroll
set-fred-hscroll
fred-autoscroll-h-p
fred-autoscroll-v-p
add-scroller
remove-scroller
h-scroller
v-scroller
fred-margin
set-fred-margin
fred-point-position
fred-hpos
fred-vpos
fred-line-vpos
selection-range
set-selection-range
collapse-selection
window-filename
set-window-filename
window-package
set-window-package
*show-cursor-p*
*killed-strings*
window-save
window-save-as
window-revert
window-hardcopy
clear
select-all
;multiple-font stuff
buffer-get-style
buffer-set-style
ed-insert-with-style
buffer-set-font-spec
buffer-char-font-spec
buffer-current-font-spec
buffer-next-font-change
buffer-previous-font-change
buffer-replace-font-spec
buffer-replace-font-codes
buffer-remove-unused-fonts

;mini-buffers
mini-buffer
set-mini-buffer
mini-buffer-update
mini-buffer-string
*clear-mini-buffer*
view-mini-buffer

; colors
with-rgb
real-color-equal
color-red
color-green
color-blue
color-values
make-color
color-to-rgb
*white-color*
*black-color*
*pink-color*
*red-color*
*orange-color*
*yellow-color*
*green-color*
*dark-green-color*
*light-blue-color*
*blue-color*
*purple-color*
*brown-color*
*tan-color*
*light-gray-color*
*gray-color*
*light-gray-color*
*dark-gray-color*
*black-rgb*
*white-rgb*

#|
; Selection Dialogs ;for now, fred-menus
make-fred-menu
add-cancel-item-p
modelessp
|#

get-string-from-user
y-or-n-dialog
; choose-file ;now called choose-file-dialog and documented in the new Files Doc
message-dialog
select-item-from-list


; Low-level
%stack-block
%vstack-block
%get-byte
%get-signed-byte
%get-unsigned-byte
%get-word
%get-signed-word
%get-unsigned-word
%get-long
%get-unsigned-long
%get-signed-long
%get-fixnum
%get-point
%get-ptr
%get-full-long
%hget-byte
%hget-signed-byte
%hget-unsigned-byte
%hget-word
%hget-signed-word
%hget-unsigned-word
%hget-fixnum
%hget-long
%hget-signed-long
%hget-unsigned-long
%hget-ptr
%get-string
%get-cstring
%str-from-ptr-in-script
%get-ostype
%put-byte
%put-word
%put-long
%put-ptr
%put-full-long
%hput-byte
%hput-word
%hput-long
%hput-ptr
%put-string
%put-cstring
%put-ostype
%get-double-float
%get-single-float
%put-double-float
%put-single-float
%hget-double-float
%hget-single-float
%hput-double-float
%hput-single-float
%inc-ptr
%incf-ptr
%setf-macptr
%null-ptr
%null-ptr-p
%ptr-eql
%ptr-to-int
%int-to-ptr
%word-to-int
%address-of
ensure-simple-string
%copy-float
with-pstrs
with-cstrs
with-macptrs
with-returned-pstrs
pointerp
zone-pointerp
handlep
macptrp
macptr
pointer-size
handle-locked-p
with-dereferenced-handles
with-pointers
stack-trap
register-trap
%gen-trap

; records & traps... most of the defrecord symbols are exported in defrecord.lisp
defrecord
deftrap
#+interfaces-2 deftrap-inline
define-entry-point
add-to-shared-library-search-path
remove-from-shared-library-search-path
defpascal
defccallable
ff-call
ff-load
uvref
uvectorp
uvsize

;Streams (should be made more complete sometime
input-stream
output-stream
stream-tyo
stream-write-string
grafport-write-string
stream-tyi
stream-untyi
stream-eofp
stream-force-output
stream-close
stream-fresh-line
stream-clear-input
stream-listen
stream-abort
stream-column
stream-peek
*open-file-streams*
stream-line-length
string-output-stream
truncating-string-stream
make-truncating-string-stream
stream-rubout-handler
stream-reader
stream-writer
maybe-default-stream-reader
maybe-default-stream-writer

; Tools
print-db
*break-on-errors* 
gc
gc-event-check-enabled-p
set-gc-event-check-enabled-p
egc
egc-enabled-p
egc-active-p
egc-mmu-support-available-p
configure-egc
egc-configuration
gccounts
gctime
top-inspect-form

; Random stuff found automagically
add-key-handler
buffer-set-font-codes
change-key-handler
column
ed-current-symbol
enter-key-handler
exit-key-handler
fred
highlight-table-cell
key-handler-idle
key-handler-list
key-handler-p
menu-item-update-function
set-menu-item-update-function
;method
reference-method
remove-key-handler
rgb-to-color
trace-tab
view-mouse-enter-event-handler
view-mouse-leave-event-handler
window-do-first-click
gestalt
*windoid-count* 
*trace-max-indent* 
*trace-level* 
*record-types* 
*mouse-view* 
*mini-buffer-help-output* 
*idle-sleep-ticks*
*foreground-sleep-ticks*
*background-sleep-ticks*
*fred-keystroke-hook* 
*foreground-event-ticks* 
*fasl-save-doc-strings* 
*fasl-save-definitions* 
*current-view* 
*color-available* 
*background-event-ticks* 
*pascal-full-longs*
bbox-p
osx-p

; Advise not included yet

; Old CL stuff; should go in :lisp package.
provide
require
compiler-let
*modules*

;; loading patches
load-patches
load-all-patches

; Last minute stuff that was in the manual but not exported
*FRED-HISTORY-LENGTH*
*LISTENER-HISTORY-LENGTH*
*MULTI-CLICK-COUNT*
CHOOSE-DIRECTORY-DIALOG
COMPILER-POLICY
CURRENT-COMPILER-POLICY
CURRENT-FILE-COMPILER-POLICY
FIND-MACTYPE
INSTALL-QUEUED-REPLY-HANDLER
MENU-ELEMENT
MENU-UPDATE-FUNCTION
NEW-COMPILER-POLICY
WINDOW-SAVE-COPY-AS
SET-CURRENT-COMPILER-POLICY
SET-CURRENT-FILE-COMPILER-POLICY
STANDARD-METHOD-COMBINATION
STREAM-DIRECTION
UNDO-MORE
WINDOW-DEFS-DIALOG
WINDOW-EVAL-SELECTION
WINDOW-EVAL-WHOLE-BUFFER
beep

; Processes, stack-groups
*current-process*
*all-processes*
*active-processes*
process-preset
process-reset
process-reset-and-enable
process-abort
process-flush
process-kill
process-interrupt
process-name
process-stack-group
process-initial-stack-group
process-run-function
make-process
process-active-p
process-initial-form
process-wait-function
process-wait-argument-list
process-whostate
*default-quantum*
*default-process-stackseg-size*
process-quantum-remaining
process-priority
process-warm-boot-action
process-simple-p
process-background-p
process-last-run-time
process-total-run-time
process-creation-time
clear-process-run-time
process-run-reasons
process-arrest-reasons
process-enable
process-disable
let-globally
process-block
process-block-with-timeout
process-unblock
process-enable-run-reason
process-disable-run-reason
process-enable-arrest-reason
process-disable-arrest-reason
process-wait
process-wait-with-timeout
process-poll
process-poll-with-timeout
*always-process-poll-p*
sleep
make-lock
lock-owner
lock-name 
with-lock-grabbed
store-conditional
process-lock
process-unlock
make-process-queue
process-enqueue
process-enqueue-with-timeout
process-allow-schedule
with-process-enqueued
process-dequeue
process-queue-locker
reset-process-queue
symbol-value-in-process
make-stack-group
stack-group-preset
stack-group-resume
stack-group-return
previous-stack-group
symbol-value-in-stack-group
*minimum-stack-overflow-size*

; termination
terminate-when-unreachable
terminate
drain-termination-queue
cancel-terminate-when-unreachable
termination-function
*enable-automatic-termination*

get-fpu-mode
set-fpu-mode

; There's more. Like...

*listener-indent*
*error-print-circle*
*break-loop-when-uninterruptable*
*string-compare-script*
set-extended-string-font
 set-extended-string-script
 *input-file-script*
 convert-kanji-fred

extended-string-p
extended-character-p
base-string-p
base-character-p
extended-string-script
extended-string-font
extended-string-font-codes
byte-length

*lisp-menu*
*autoclose-inactive-listeners*
*bind-io-control-vars-per-process*
*preferences-file-name*
application-about-dialog
application-about-view
application-error
application-name
application-overwrite-dialog
application-resource-file
application-sizes
current-app-name
*hide-windoids-on-suspend*
application-suspend-event-handler
application-resume-event-handler
application-eval-enqueue
application-init-file
*alias-resolution-policy*

; altivec
*altivec-available*
altivec-available-p
*altivec-lapmacros-maintain-vrsave-p*

native-mcl-kernel-version

) "CCL"
)

;Export all the fred functions from the comtab.
(labels ((export-comtab (comtab) (dolist (x (comtab-data comtab))
                                   (let ((fn (cadr x)))
                                     (cond ((and (non-nil-symbol-p fn)
                                                 (eq *ccl-package* (symbol-package fn)))
                                            (export fn *ccl-package*))
                                           ((comtabp fn)
                                            (export-comtab fn)))))))
  (export-comtab *comtab*))

(import '(ccl:*modules* ccl:provide ccl:require) "CL")
(export '(ccl:*modules* ccl:provide ccl:require) "CL")


#|
;;;See comment above
(put '*window* :instance-variables
     '(wptr window-drag-rect window-grow-rect window-zoom-position
               window-zoom-size window-cursor))
(put '*fred-window* :instance-variables '(last-command comtab))
(put '*dialog-item* :instance-variables
     '(width-correction dialog-item-handle my-dialog))
(put '*radio-button-dialog-item* :instance-variables '(radio-button-cluster))
(put '*editable-text-dialog-item* :instance-variables '(allow-returns))
(put '*table-dialog-item* :instance-variables '(table-print-function))
(put '*terminal-io* :instance-variables '(selection-queue))
|#


;;; Define a package for MOP extensions.
(defpackage "MCL-MOP"
  (:use)
  (:import-from
   "CCL"
   "ACCESSOR-METHOD-SLOT-DEFINITION"
   "ADD-DEPENDENT"
   "ADD-DIRECT-METHOD"
   "ADD-DIRECT-SUBCLASS"
   "ADD-METHOD"
   "CLASS-DEFAULT-INITARGS"
   "CLASS-DIRECT-DEFAULT-INITARGS"
   "CLASS-DIRECT-SLOTS"
   "CLASS-DIRECT-SUBCLASSES"
   "CLASS-DIRECT-SUPERCLASSES"
   "CLASS-FINALIZED-P"
   "CLASS-PRECEDENCE-LIST"
   "CLASS-PROTOTYPE"
   "CLASS-SLOTS"
   "COMPUTE-APPLICABLE-METHODS"
   "COMPUTE-APPLICABLE-METHODS-USING-CLASSES"
   "COMPUTE-CLASS-PRECEDENCE-LIST"
   "COMPUTE-DEFAULT-INITARGS"
   "COMPUTE-DISCRIMINATING-FUNCTION"
   "COMPUTE-EFFECTIVE-METHOD"
   "COMPUTE-EFFECTIVE-SLOT-DEFINITION"
   "COMPUTE-SLOTS"
   "DIRECT-SLOT-DEFINITION-CLASS"
   "EFFECTIVE-SLOT-DEFINITION-CLASS"
   "ENSURE-CLASS"
   "ENSURE-CLASS-USING-CLASS"
   "ENSURE-GENERIC-FUNCTION-USING-CLASS"
   "EQL-SPECIALIZER-OBJECT"
   "EXTRACT-LAMBDA-LIST"
   "EXTRACT-SPECIALIZER-NAMES"
   "FINALIZE-INHERITANCE"
   "FIND-METHOD-COMBINATION"
   "FUNCALLABLE-STANDARD-INSTANCE-ACCESS"
   "GENERIC-FUNCTION-ARGUMENT-PRECEDENCE-ORDER"
   "GENERIC-FUNCTION-DECLARATIONS"
   "GENERIC-FUNCTION-LAMBDA-LIST"
   "GENERIC-FUNCTION-METHOD-CLASS"
   "GENERIC-FUNCTION-METHOD-COMBINATION"
   "GENERIC-FUNCTION-METHODS"
   "GENERIC-FUNCTION-NAME"
   "INTERN-EQL-SPECIALIZER"
   "MAKE-METHOD-LAMBDA"
   "MAP-DEPENDENTS"
   "METHOD-FUNCTION"
   "METHOD-GENERIC-FUNCTION"
   "METHOD-LAMBDA-LIST"
   "METHOD-SPECIALIZERS"
   "METHOD-QUALIFIERS"
   "SLOT-DEFINITION-ALLOCATION"
   "SLOT-DEFINITION-INITARGS"
   "SLOT-DEFINITION-INITFORM"
   "SLOT-DEFINITION-INITFUNCTION"
   "SLOT-DEFINITION-NAME"
   "SLOT-DEFINITION-TYPE"
   "SLOT-DEFINITION-READERS"
   "SLOT-DEFINITION-WRITERS"
   "SLOT-DEFINITION-LOCATION"
   "READER-METHOD-CLASS"
   "REMOVE-DEPENDENT"
   "REMOVE-DIRECT-METHOD"
   "REMOVE-DIRECT-SUBCLASS"
   "REMOVE-METHOD"
   "SET-FUNCALLABLE-INSTANCE-FUNCTION"
   "SLOT-BOUNDP-USING-CLASS"
   "SLOT-MAKUNBOUND-USING-CLASS"
   "SLOT-VALUE-USING-CLASS"
   "SPECIALIZER-DIRECT-GENERIC-FUNCTIONS"
   "SPECIALIZER-DIRECT-METHODS"
   "STANDARD-DIRECT-SLOT-DEFINITION"
   "STANDARD-EFFECTIVE-SLOT-DEFINITION"
   "STANDARD-INSTANCE-ACCESS"
   "UPDATE-DEPENDENT"
   "VALIDATE-SUPERCLASS"
   "WRITER-METHOD-CLASS"
     
   "METAOBJECT"
   "LONG-METHOD-COMBINATION"
   "SHORT-METHOD-COMBINATION"
   "STANDARD-ACCESSOR-METHOD"
   "STANDARD-READER-METHOD"
   "STANDARD-WRITER-METHOD"
   "SPECIALIZER"

   "FUNCALLABLE-STANDARD-CLASS"
   "FORWARD-REFERENCED-CLASS"

   "CLEAR-SPECIALIZER-DIRECT-METHODS-CACHES"
   "*CHECK-CALL-NEXT-METHOD-WITH-ARGS*"
   "CLEAR-GF-CACHE"
   "CLEAR-ALL-GF-CACHES"
   "CLEAR-CLOS-CACHES"

   "METHOD-EXISTS-P"
   "METHOD-SPECIALIZERS"
   "CLASS-OWN-WRAPPER"
   "SPECIALIZER-DIRECT-METHODS"
   "SPECIALIZER-DIRECT-GENERIC-FUNCTIONS"
   "COPY-INSTANCE")
  (:export
   "ACCESSOR-METHOD-SLOT-DEFINITION"
   "ADD-DEPENDENT"
   "ADD-DIRECT-METHOD"
   "ADD-DIRECT-SUBCLASS"
   "ADD-METHOD"
   "CLASS-DEFAULT-INITARGS"
   "CLASS-DIRECT-DEFAULT-INITARGS"
   "CLASS-DIRECT-SLOTS"
   "CLASS-DIRECT-SUBCLASSES"
   "CLASS-DIRECT-SUPERCLASSES"
   "CLASS-FINALIZED-P"
   "CLASS-PRECEDENCE-LIST"
   "CLASS-PROTOTYPE"
   "CLASS-SLOTS"
   "COMPUTE-APPLICABLE-METHODS"
   "COMPUTE-APPLICABLE-METHODS-USING-CLASSES"
   "COMPUTE-CLASS-PRECEDENCE-LIST"
   "COMPUTE-DEFAULT-INITARGS"
   "COMPUTE-DISCRIMINATING-FUNCTION"
   "COMPUTE-EFFECTIVE-METHOD"
   "COMPUTE-EFFECTIVE-SLOT-DEFINITION"
   "COMPUTE-SLOTS"
   "DIRECT-SLOT-DEFINITION-CLASS"
   "EFFECTIVE-SLOT-DEFINITION-CLASS"
   "ENSURE-CLASS"
   "ENSURE-CLASS-USING-CLASS"
   "ENSURE-GENERIC-FUNCTION-USING-CLASS"
   "EQL-SPECIALIZER-OBJECT"
   "EXTRACT-LAMBDA-LIST"
   "EXTRACT-SPECIALIZER-NAMES"
   "FINALIZE-INHERITANCE"
   "FIND-METHOD-COMBINATION"
   "FUNCALLABLE-STANDARD-INSTANCE-ACCESS"
   "GENERIC-FUNCTION-ARGUMENT-PRECEDENCE-ORDER"
   "GENERIC-FUNCTION-DECLARATIONS"
   "GENERIC-FUNCTION-LAMBDA-LIST"
   "GENERIC-FUNCTION-METHOD-CLASS"
   "GENERIC-FUNCTION-METHOD-COMBINATION"
   "GENERIC-FUNCTION-METHODS"
   "GENERIC-FUNCTION-NAME"
   "INTERN-EQL-SPECIALIZER"
   "MAKE-METHOD-LAMBDA"
   "MAP-DEPENDENTS"
   "METHOD-FUNCTION"
   "METHOD-GENERIC-FUNCTION"
   "METHOD-LAMBDA-LIST"
   "METHOD-SPECIALIZERS"
   "METHOD-QUALIFIERS"
   "SLOT-DEFINITION-ALLOCATION"
   "SLOT-DEFINITION-INITARGS"
   "SLOT-DEFINITION-INITFORM"
   "SLOT-DEFINITION-INITFUNCTION"
   "SLOT-DEFINITION-NAME"
   "SLOT-DEFINITION-TYPE"
   "SLOT-DEFINITION-READERS"
   "SLOT-DEFINITION-WRITERS"
   "SLOT-DEFINITION-LOCATION"
   "READER-METHOD-CLASS"
   "REMOVE-DEPENDENT"
   "REMOVE-DIRECT-METHOD"
   "REMOVE-DIRECT-SUBCLASS"
   "REMOVE-METHOD"
   "SET-FUNCALLABLE-INSTANCE-FUNCTION"
   "SLOT-BOUNDP-USING-CLASS"
   "SLOT-MAKUNBOUND-USING-CLASS"
   "SLOT-VALUE-USING-CLASS"
   "SPECIALIZER-DIRECT-GENERIC-FUNCTIONS"
   "SPECIALIZER-DIRECT-METHODS"
   "STANDARD-DIRECT-SLOT-DEFINITION"
   "STANDARD-EFFECTIVE-SLOT-DEFINITION"
   "STANDARD-INSTANCE-ACCESS"
   "UPDATE-DEPENDENT"
   "VALIDATE-SUPERCLASS"
   "WRITER-METHOD-CLASS"
     
   "METAOBJECT"
   "LONG-METHOD-COMBINATION"
   "SHORT-METHOD-COMBINATION"
   "STANDARD-ACCESSOR-METHOD"
   "STANDARD-READER-METHOD"
   "STANDARD-WRITER-METHOD"
   "SPECIALIZER"

   "FUNCALLABLE-STANDARD-CLASS"
   "FORWARD-REFERENCED-CLASS"


   "CLEAR-SPECIALIZER-DIRECT-METHODS-CACHES"
   "*CHECK-CALL-NEXT-METHOD-WITH-ARGS*"
   "CLEAR-GF-CACHE"
   "CLEAR-ALL-GF-CACHES"
   "CLEAR-CLOS-CACHES"

   "METHOD-EXISTS-P"
   "METHOD-SPECIALIZERS"
   "CLASS-OWN-WRAPPER"
   "SPECIALIZER-DIRECT-METHODS"
   "SPECIALIZER-DIRECT-GENERIC-FUNCTIONS"
   "COPY-INSTANCE"))


(unless (eq %lisp-system-fixups% T)
  (while %lisp-system-fixups%
    (let* ((fn.source (car %lisp-system-fixups%))
           (*loading-file-source-file* (cdr fn.source)))
      (funcall (car fn.source)))
    (setq %lisp-system-fixups% (cdr %lisp-system-fixups%)))
  (setq %lisp-system-fixups% T))



#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	let-globally
|# ;(do not edit past this line!!)
