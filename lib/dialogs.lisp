;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: dialogs.lisp,v $
;;  Revision 1.59  2006/02/03 22:23:39  alice
;;  ; use get-tick-count vs #_tickcount in press-button of button-dialog-item and 3d-button
;; static-text-dialog-item draws gray if inactive
;; $usewfont -> $kControlUsesOwningWindowsFontVariant 
;; scroll-to-cell - do with-back-color around call to #_scrollrect - prevents flashies if container has color background
;; add table-cell-color-hash to table-dialog-item - more efficient than using part-color-list if many colored cells
;; colored-cells-p is now a method
;; another fix to install-view-in-window for table-dialog-item - from Walker Sigismund
;;
;;  Revision 1.58  2005/08/07 03:40:09  alice
;;  ;; initialize-instance fred-dialog-item - fix for :view-container provided
;; install-view-in-window :before ((dialog-item control-dialog-item) dialog) don't do #_newcontrol for scroll-bar or pop-up - happens later
;;
;;  Revision 1.57  2005/07/02 10:46:27  alice
;;  ;; y-or-n-dialog usually -> standard-alert-dialog if OSX-p
;;
;;  Revision 1.56  2005/06/25 23:45:37  alice
;;  ;; modal-dialog - don't set-window-layer if *in-foreign-window*, process-wait even if not event-processor?
;;
;;  Revision 1.55  2005/05/07 08:31:37  alice
;;  ;; view-draw-text of 3d-button uses grafport-write-string
;; draw-cell-contents uses new function draw-string-crop-in-rect - uses ugly draw-theme-text-box less often
;;
;;  Revision 1.54  2005/04/05 18:44:28  alice
;;  ;; scroll-to-cell - don't use #_scrollrect if abs dh or dv > 32767 - just invalidate the whole view
;; install-view-in-window ((item table-dialog-item) ... does compute-selection-regions sooner
;;
;;  Revision 1.53  2005/02/18 09:04:50  alice
;;  ;; fix vdc for static-text-dialog-item
;;
;;  Revision 1.52  2005/02/08 00:24:14  alice
;;  ;;; remove bad call to convert-string
;;
;;  Revision 1.51  2005/02/04 05:12:12  alice
;;  ;; 02/01/04 draw-cell-contents for table-dialog-item unicode savvy
;;
;;  Revision 1.50  2004/12/20 22:11:05  alice
;;  ;; 12/10/04 eol stuff
;;
;;  Revision 1.49  2004/11/24 03:59:55  alice
;;  ;; add method selection-range ((item (eql nil))) in case window has no key-handler
;; ------ 5.1 final
;;
;;  Revision 1.48  2004/10/12 00:02:34  alice
;;  ;; use with-pen-saved-simple
;; 3d-button frame-p initform is t
;; view-clip-region of editable-text-dialog-item does not include corners
;; view-click-event-handler for table-dialog-item - use wait-mouse-up-or-moved more carefully
;;
;;  Revision 1.47  2004/09/15 04:25:13  alice
;;  ;; modal-dialog does with-focused-view NIL in case invoked when focused on an allow-vdc window and also enables any menus
;;
;;  Revision 1.46  2004/09/07 02:28:30  alice
;;  ;; view-default-size for 3d-button bigger veritcally, view-click-event-handler calls allow-view-draw-contents, force-view-draw-contents doesn't invalidate-view,
;;
;;  Revision 1.45  2004/08/30 20:16:52  svspire
;;  (declare (special handle->dialog-item)) ; defined elsewhere
;;
;;  Revision 1.44  2004/08/11 04:02:15  alice
;;  ;; fix view-draw-contents :before for button-dialog-item
;;
;;  Revision 1.43  2004/08/03 01:53:38  alice
;;  ;; view-default-size for check box - no more osx-fudge?
;; view-activate/deactivate -event-handler ((item control-dialog-item)) - do if has colors but also redraw on activate if has colors
;;
;;  Revision 1.42  2004/07/29 19:59:15  alice
;;  ;; y-or-n-dialog - cancel-button farther right, view-activate/deactivate -event-handler ((item control-dialog-item)) don't if has colors
;;
;;  Revision 1.41  2004/07/20 23:20:47  alice
;;  ;; default-button stuff  done in initialize-instance if view-container provided
;; view-focus-and-draw-contents for dialog-item fixed ala method for simple-view
;; view-draw-contents for static-text-dialog-item uses with-fore-and-back-color
;;
;;  Revision 1.40  2004/07/14 15:35:29  alice
;;  ;; set-view-size for table-dialog-item works around a bug when back-color, not theme
;; frame-dialog-item -> frame-key-handler, add view-activate/deactivate for control-dialog-item, ergo lose for button
;;
;;  Revision 1.39  2004/07/08 22:26:41  alice
;;  ;; all of set-current-key-handler is woi
;; add cancel-button initarg to default-button-mixin, use in y-or-n-dialog etc
;;
;;  Revision 1.38  2004/07/04 08:29:57  alice
;;  ;; rename frame-table-item => frame-dialog-item
;; set-current-key-handler - clear old before call view-deactivate so frame... knows
;;
;;  Revision 1.37  2004/06/30 19:40:02  alice
;;  ;; 06/28/04 set-view-size for dialog-item invalidates what it erases
;; 06/28/04 set-view-size for control-dialog-item - don't do validate-control-dialog-item
;; 06/28/04 no mo eraserect - back to invalidate view in set-view-position for dialog-item
;;
;;  Revision 1.36  2004/06/26 16:45:22  alice
;;  ;; set-view-size & position for dialog-item erase old with back-color
;;
;;  Revision 1.35  2004/06/26 03:02:52  alice
;;  ;; set-view-size & position for dialog-item erase old
;; view-draw-contents static-text-dialog-item - eraserect first don't ask me why
;;
;;  Revision 1.34  2004/06/24 00:04:48  alice
;;  ;; view-draw-contents :before button-dialog-item - only move if not in right place
;;
;;  Revision 1.33  2004/06/20 23:07:45  alice
;;  ;; lose some obsolete stuff in  view-draw-contents :after basic-editable-text-dialog-item
;;
;;  Revision 1.32  2004/05/26 18:24:45  alice
;;  ;; fixup fixup-scroll-bars - for osx the scroll bars were 2 pixels too long and off by one in position
;;
;;  Revision 1.31  2004/05/22 18:23:42  alice
;;  ;; remove-view-from-window method for table-dialog-item is :after vs :before
;;
;;  Revision 1.30  2004/05/11 20:41:56  alice
;;  ; view-find-vacant-position accounts for possible frame size, add method view-outer-size
;;
;;  Revision 1.29  2004/05/06 22:05:39  alice
;;  ;; make search-window-dialog 4 bits higher
;; basic-editable-text-dialog-item does drawthemefocusrect
;;
;;  Revision 1.28  2004/05/03 19:46:18  alice
;;  ;; theme-background-p (view-window view) -> theme-background-p view
;;
;;  Revision 1.27  2004/04/26 15:44:34  alice
;;  ;;; put back the ignores in make-dialog-item - sometimes called with class that ain't dialog-item - UGH
;;
;;  Revision 1.26  2004/04/26 04:11:47  alice
;;  ;; initialize-instance :after for fred-dialog-item does the font
;; 04/25/04 make-dialog-item - omit some :ignore's
;;
;;  Revision 1.25  2004/04/09 02:13:53  alice
;;  ;; 04/08/04 use wait-mouse-up-or-moved vs. mouse-down-p
;;
;;  Revision 1.24  2004/02/26 20:35:14  alice
;;  ;; 02/26/04 install-view-in-window :before ((dialog-item control-dialog-item) - don't create handle if already has one
;;
;;  Revision 1.23  2004/02/23 18:46:44  alice
;;  ;; 02/22/04 lose set-text-colors
;; 02/22/04 track-thumb-p initarg for table scroll bar is T
;;
;;  Revision 1.22  2004/02/18 20:15:10  alice
;;  ;; 02/17/04 modal-dialog does setwindowmodality - thanks Takehiko Abe
;;
;;  Revision 1.21  2004/02/08 02:04:07  alice
;;  ;; 02/07/04 (method => (reference-method in dialog-item-action-p
;;
;;  Revision 1.20  2004/02/05 03:15:01  alice
;;  ;; 02/04/04 macro with-text-colors uses with-fore-color and with-back-color
;;
;;  Revision 1.19  2004/01/06 00:44:41  svspire
;;  Make static-text-dialog-items erase themselves when you set their text.
;;
;;  Revision 1.18  2003/12/08 08:07:39  gtbyers
;;  Use WITH-SLOTS instead of WITH-SLOT-VALUES.
;;
;;  15 10/5/97 akh  see below
;;  14 7/4/97  akh  see
;;  13 6/9/97  akh  see below
;;  12 6/2/97  akh  table-dialog-item stuff
;;  7 4/8/97   akh  view-default-size for 3d-button does multi lines
;;  5 4/1/97   akh  see below
;;  17 1/22/97 akh  make scrolling and 2d tables work for table-dialog-item
;;  11 5/23/96 akh  fix draw-string-crop for extended string
;;  10 5/20/96 akh  scroll-to-cell and old-view-click-evt-hdlr do it with-back-color
;;                  disposergn's in hilite-rect-frame
;;  8 3/16/96  akh  kludge to fix LNEW ignoring nil for vscroll
;;  5 12/1/95  akh  mouse-drag scrolls sequence-dialog-item
;;  4 11/15/95 gb   change trap names
;;  3 11/9/95  akh  view-click-event-handler for sequence-dialog-item - drag again
;;  2 10/17/95 akh  merge patches
;;  19 5/30/95 akh  Travers suggestion for drawing pushed 3d-button
;;  18 5/25/95 akh  no buffer-delete in instance-init fred-dialog-item
;;  17 5/16/95 akh  search dialog enables "replace all" more often.
;;  16 5/15/95 akh  installed-item-p for control-dialog-item checks for non nil handle
;;  15 5/7/95  slh  balloon help mods.
;;  11 4/28/95 akh  probably no change
;;  9 4/11/95  akh  simplify 3d-button a little, make spellings more consistent
;;  7 4/10/95  akh  fix 3d-button focusing when disabled. Draw disable button with gray text unless 1 bit screen
;;  5 4/7/95   akh  let 3d-buttons  be default-button
;;  4 4/6/95   akh  add 3d-button
;;  3 4/4/95   akh  nuke funcall-key-handler
;;  16 3/20/95 akh  set-default-size-and-position ((item fred-dialog-item) only focus if need to call frec-set-size
;;  15 3/14/95 akh  set-current-key-handler nukes selection before view-deactivate vs after
;;  14 3/2/95  akh  change modal-dialogs eventhook to do nothing if the dialog is not on top
;;  13 3/2/95  akh  *tool-back-color*, set-default-size-and-position for fred-dialog-item focuses. Ignore default-table-dimensions!
;;  12 2/17/95 slh  y-or-n-dialog size mod
;;  11 2/17/95 akh  kludge part-color method moves from fred-dialog-item to fred-mixin.
;;  10 2/6/95  akh  get it right.
;;  9 2/6/95   akh  VIEW-click-event-handler for table now works for :contiguous
;;  8 1/30/95  akh  *modal-dialog-on-top* is a list now
;;  6 1/25/95  akh  *modal-dialog-on-top* is a list now - simplifies things when more than one in more than one process
;;                  remove dirty words
;;  5 1/17/95  akh  see below
;;  5 1/17/95  akh  fix a bunch of problems with modal dialog
;;                  make table dialog items be white when back-color not
;;                  add part-color methods for fred-dialog item etal that will say *white-color* for :body if none on color-list
;;  4 1/11/95  akh  put the modeline back in the right place
;;  3 1/11/95  akh  see below
;;  (do not edit before this line!!)

;;dialogs.lisp
; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2007 Digitool, Inc.
 
; Modification History
;;
;; set-view-size/position for focus-rect-mixin - do nothing if unchanged
;; vdc static-text-dialog-item - fix for  back-color of containing window or theme-background
;; standard-alert-dialog gets action-function arg and help arg (t to include a help button)
;; standard-alert-dialog moved here - schar -> char, if message not string, coerce to same
;;   allow keywords for alert-type 
;; fred-dialog-item heeds part-color :text
;; draw-theme-text-box - faster if truncate
;; ------ 5.2b6
;; erase-focus-rect - check for wptr
;; define class focus-rect-mixin - used by basic-editable-text-dialog-item and arrow-dialog-item
;; fix set-view-size, position of basic-editable-text-dialog-item, lose view-corners
;; static-text-dialog-item gets truncation and compress-text slots, back to using draw-string-in-rect
;; draw-string-in-rect does word wrap
;; y-or-n-dialog - don't pass position to standard-alert-dialog, say :position :main-screen
;; moved draw-theme-text-box here
;; static-text-dialog-item back to draw-theme-text-box which does word wrap of long lines
;; draw-string-in-rect does #_ATSUSetTransientFontMatching, export draw-string-in-rect
;; add function put-scraps and use it
;; --------- 5.2b5
;; string-width-for-focused-control takes args ff ms and passes them along
;; draw-string-in-rect handles multiple lines
;; lose draw-cell-contents
;; rename draw-string-in-rect-with-options -> draw-string-in-rect 
;; static-text-dialog-item - fix for text  more than 1 line
;; add draw-string-in-rect-with-options, fiddle with 3d-button
;; lose view-default-size of static-text-dialog-item - same as dialog-item
;; avoid draw-theme-text-box for static-text-dialog-item
;; ----- 5.2b4
;; view-draw-text for 3d-button does *use-quickdraw-for-roman* - not any more
;; add tsm-document-mixin to class fred-dialog-item
;; ---- 5.2b1
;; use get-tick-count vs #_tickcount in press-button of button-dialog-item and 3d-button
;; static-text-dialog-item draws gray if inactive
;; $usewfont -> $kControlUsesOwningWindowsFontVariant 
;; scroll-to-cell - do with-back-color around call to #_scrollrect - prevents flashies if container has color background
;; add table-cell-color-hash to table-dialog-item - more efficient than using part-color-list if many colored cells
;; colored-cells-p is now a method
;; another fix to install-view-in-window for table-dialog-item - from Walker Sigismund
;; initialize-instance fred-dialog-item - fix for :view-container provided
;; install-view-in-window :before ((dialog-item control-dialog-item) dialog) don't do #_newcontrol for scroll-bar - happens later
;; remove some stuff re handle for static-text-dialog-item
;; y-or-n-dialog usually -> standard-alert-dialog if OSX-p
;; modal-dialog - don't set-window-layer if *in-foreign-window*, process-wait even if not event-processor?
;; view-draw-text of 3d-button uses grafport-write-string
;; draw-cell-contents uses new function draw-string-crop-in-rect - uses ugly draw-theme-text-box less often
;; scroll-to-cell - don't use #_scrollrect if abs dh or dv > 32767 - just invalidate the whole view
;; install-view-in-window ((item table-dialog-item) ... does compute-selection-regions sooner
;; draw-cell-contents ((item table-dialog-item) ...) doesn't use draw-theme-text-box in prefs dialog - it's ugly
;; default-cell-size for ²-item uses xtext-width
;; fix vdc for static-text-dialog-item
;; remove bad call to convert-string
;; set-dialog-item-text - extended-string -> unicode
;; 02/01/04 draw-cell-contents for table-dialog-item unicode savvy
;; 12/10/04 eol stuff
;; add method selection-range ((item (eql nil))) in case window has no key-handler
;; ------ 5.1 final
;; use with-pen-saved-simple
;; 3d-button frame-p initform is t
;; view-clip-region of editable-text-dialog-item does not include corners
;; view-click-event-handler for table-dialog-item - use wait-mouse-up-or-moved more carefully
;; -------- 5.1b3
;; modal-dialog does with-focused-view NIL in case invoked when focused on an allow-vdc window and also enables any menus
;; view-default-size for 3d-button bigger veritcally, view-click-event-handler calls allow-view-draw-contents, force-view-draw-contents doesn't invalidate-view, 
;; fix view-draw-contents :before for button-dialog-item
;; view-default-size for check box - no more osx-fudge?
;; view-activate/deactivate -event-handler ((item control-dialog-item)) - do if has colors but also redraw on activate if has colors
;; y-or-n-dialog - cancel-button farther right, view-activate/deactivate -event-handler ((item control-dialog-item)) don't if has colors
;; default-button stuff  done in initialize-instance if view-container provided
;; view-focus-and-draw-contents for dialog-item fixed ala method for simple-view
;; view-draw-contents for static-text-dialog-item uses with-fore-and-back-color
;; set-view-size for table-dialog-item works around a bug when back-color, not theme
;; frame-dialog-item -> frame-key-handler, add view-activate/deactivate for control-dialog-item, ergo lose for button
;; all of set-current-key-handler is woi
;; add cancel-button initarg to default-button-mixin, use in y-or-n-dialog etc
;; rename frame-table-item => frame-dialog-item
;; set-current-key-handler - clear old before call view-deactivate so frame... knows
;; 06/28/04 set-view-size for dialog-item invalidates what it erases
;; 06/28/04 set-view-size for control-dialog-item - don't do validate-control-dialog-item
;; 06/28/04 no mo eraserect - back to invalidate view in set-view-position for dialog-item
;; set-view-size & position for dialog-item erase old with back-color
;; view-draw-contents static-text-dialog-item - eraserect first don't ask me why
;; view-draw-contents :before button-dialog-item - only move if not in right place         
;; lose some obsolete stuff in  view-draw-contents :after basic-editable-text-dialog-item
;; fixup fixup-scroll-bars - for osx the scroll bars were 2 pixels too long and off by one in position
;; ------ 5.1b2
;; remove-view-from-window method for table-dialog-item is :after vs :before
;; view-find-vacant-position accounts for possible frame size, add method view-outer-size
;; make search-window-dialog 4 bits higher
;; basic-editable-text-dialog-item does drawthemefocusrect
;; theme-background-p (view-window view) -> theme-background-p view
;; put back the ignores in make-dialog-item - sometimes called with class that ain't dialog-item - UGH
;; initialize-instance :after for fred-dialog-item does the font
;; 04/25/04 make-dialog-item - omit some :ignore's
;; 04/08/04 use wait-mouse-up-or-moved vs. mouse-down-p
;; 02/26/04 install-view-in-window :before ((dialog-item control-dialog-item) - don't create handle if already has one
;; 02/22/04 lose set-text-colors
;; 02/22/04 track-thumb-p initarg for table scroll bar is T
;; 02/17/04 modal-dialog does setwindowmodality - thanks Takehiko Abe
;; 02/07/04 (method => (reference-method in dialog-item-action-p
;; 02/04/04 macro with-text-colors uses with-fore-color and with-back-color
;; --------- 5.1b1
;; 12/07/03 view-key-event-handler for window handles #\esc for buttons in subviews
;; 11/30/03 search-window-dialog - make buttons wider fer OSX
;; 11/22/03 no more with-pointers of handle
;; 11/10/03 fix the fix for default-button in subview so only affects default buttons, not all buttons. 
;; Fixes apropos-dialog mess re cursor in other windows that I don't understand.
;; 11/02/03 better view-activate/deactivate for buttons - from Takehiko Abe
;; 10/29/03 fix button-sizes in y-or-n-dialog for osx-p
;; 10/28/03 theme things don't require osx-p
;; use activate/deactivate control for aesthetic reasons
;; fix buttons so default button can be contained in a subview
;; add function theme-color - not used
;; after method for set-view-font is now after method on set-view-font-codes instead
;; use font-to-encoding for controls
;; fix for buttons and other control-dialog-items on OSX when font is symbol or dingbats, also non roman
;; also fix font for buttons on OSX when change the font - for IFT or whatever
;; dont-throb no longer checks for multi-line - seems to work now (10.2.1)
;;  install-view-in-window :after ((button button-dialog-item) w) - fixes font, change dont-throb
;; %draw-table-cell-new undo "fix" from Gilles Bisson - the real problem was elsewhere
;; view-click-event-handler for table-dialog-item less without-interrupts intensive
;; modal-dialog put back SetWindowClass always not conditionally, don't #_hidefloatingwindows
;; --------- 5.0 final
;; search-window-dialog gets theme-background t
;; ---------- 5.0b3
;; 12/27/02 akh modal-dialog does hide/show floatingwindows, omits setwindowclass
;; fix to set-visible-dimensions from Takehiko Abe
;; force-view-draw-contents does #_qdflushportbuffer if osx-p.
;; %draw-table-cell-new from Gilles Bisson
;; modal-dialogs not collapsible
;; --------- 4.4b5
;; add font-codes-string-width-with-eol-for-control for osx and use it in view-default-size
;; view-default-size ((item check-box-dialog-item)) - fudge for osx-p
;; --------- 4.4b4
;; y-or-n-dialog gets possible theme-background arg  - defaults to t
;; static-text-dialog-item uses different stuff if theme-background - small fonts appear to lose boldness
;; defclass button-dialog-item fixes font - dunno why - from Brendan Burns
;; view-corners for button changed for osx
;; ---------- 4.4b3 
;; modal-dialog does setwindowclass always, not just for drag-receivers
;; ------- 4.4b2
;; 02/14/02 akh add-to-selection-region - guard against visible-dimensions nil - from Takehiko Abe
;; akh change dont-throb - move view-container test inside default-button-p clause
;; akh '("chicago" ...)  => sys-font-spec
;; akh view-corners for button and osx (gag)
;; 06/??/01 akh see modal-dialog re update-menus
;; 05/15/01 akh sick of throbbing buttons in inactive windows on OSX
;; akh carbon stuff re default button
;; modal-dialog re windowclass garbage for carbon
;; carbon-compat stuff
;; 02/20/00 akh lmgetticks => tickcount
;; 01/20/00 AKH set-view-size for table dialog item fixes the scroll-bars when dims > 1
;; 10/30/99 akh modal-dialog - if the provided eventhook returns t, do no more
;; 10/03/99 akh  text-position centers vertically too. 
;; draw-string-crop uses #_truncstring as suggested by T. Norderhaug
;; view-draw-text for 3d-button clips to inner size, text-position deals with possibly too small for text
;; -------- 4.3f1c1
;; AKH MODAL-DIALOG - more fixes for eventhook and restoring menubar
;; akh fix set-table-dimensions which was erasing outside the table, scroll-bar-changed don't do window-update... if from fixup-scroll-bars
; akh more default fonts are system font
;; -------------- 4.3b2
; akh y-or-n-dialog adjusts button sizes for text length
; 04/12/99 akh y-or-n-dialog uses *tool-back-color*
; 04/12/99 akh view-default-font for editable-text-dialog-item is always the system font (not just when non-roman)
; ------------- 4.3b1
; 02/13/99 akh y-or-n-dialog gets back-color arg and is movable, also window-title arg which defaults to ""
; 01/19/98 akh with-clip-region macro intersects with existing clip-region - hope it doesnt nest incorrectly??
; 12/05/98 akh compute-selection-regions - defend against dead macptrs
; 10/23/98 akh fixup-scroll-bars calls scroll-bar-changed if max changed
; 09/19/98 akh dialog-item-text and set thereof for static-text-dialog-item somewhat less silly
; 08/12/98 akh merge clim changes for table-dialog-item
; 07/30/98 akh add dialog-item-disable :before for key-handler-mixin
; 05/12/98 akh remove-key-handler calls set-current-key-handler for last/only key-handler so exit-key-handler will be called
; 04/16/98 akh set-table-dimensions - dont scroll if scroll pos is still within new dims, deselect cells outside new dims
; 02/25/98 akh %draw-table-cell-new  also clips to container, set-table-sequence - beware new-seq eq old-seq but not really (different fill-pointer)
; 02/14/98 akh cell-position - dont include upper bound
; 01/26/97 akh draw-string-crop - just get first 255 chars 
; 01/14/97 akh %draw-table-cell-new  clips to table-inner-size, redraw-cell doesn't do redundant _eraserect
; 11/15/97 akh y-or-n-dialog puts cancel button second for escape key
; 09/19/97 akh new method make-scroll-bar-for-table - for CLIM
; 09/15/97 akh view-draw-contents ((item table-dialog-item)) - draw the column separator more often
; 09/14/97 akh point-to-cell - rets nil if no such cell
; 09/12/97 akh view-click-event-handler for table  calls cell-select when  no modifiers, already selected
;              for double-click detection
; 06/25/97 akh  fixup-scroll-bar-levels does nothing - it caused trouble and appears unnecessary
; 06/14/97 akh  use make-big-point, add-big.., subtract-big.. where appropriate (I wasn't being very careful)
; 06/06/97 akh  another case of :contiguous table and another of :disjoint
; 06/05/97 akh  make first-selected-cell be the first one now selected vs the first one that got selected
; 06/03/97 akh  cell-contents-string-new from Stefan Bamberger
; 06/03/97 akh  we lost the set-view-size fix for not installed - now its back
; 05/21/97 akh   table-dialog-item - don't select when click beyond existing cells
; 05/14/97 akh   set-view-size table-di - move bindings so don't error when not installed
; 05/13/97 akh   added cell-colors initarg to table-dialog-item, :cell-colors :background means color applies to 
;                to cell background rather than text, fix :disjoint selection (not same as :contiguous when shift-key-p)
; 05/12/97 akh   table-dialog-item mods for colored cells
; 05/10/97 akh   redraw-cell does nothing if no wptr (for call from set-part-color)

; 05/27/97 bill  (method view-click-event-handler (table-dialog-item t)) calls cell-select
;                twice if the cell is clicked on twice. It also, doesn't perform its body
;                except when the mouse moves to another cell.
; 04/28/97 bill  scroll-to-cell now accounts for the separator-size in determining pixels to scroll
;                scroll-to-cell also allows scrolling to make entirely visible a partially visible
;                final row or column.
;                fixup-scroll-bars honors the table-grow-icon-p value when there is only one scroll bar.
;                fixup-scroll-bars also enables scrolling for a partially visible final row or column.
;                table-inner-size handles :undetermined scroll bars.
;                Scrolling by a page now works correctly with custom row heights & column widths.
; 04/26/97 bill  Andrew Begels's fix to redraw-cell, erase with the correct background color.
; -------------  4.1f1
; 04/21/97 bill  The table separator-pattern can now be a symbol or function instead of just a macptr.
;                If a bound symbol, take its symbol-value. If a function, funcall it with
;                no args. The defclass defines the separator-pattern-slot method. A new
;                separator-pattern method handles the DWIMmy stuff. The view-draw-contents
;                method doesn't implement the pattern if the separator-size is #@(0 0) or the
;                separator-pattern is not a macptr.
; -------------  4.1b2
; 04/10/97 bill  (method view-click-event-handler (table-dialog-item)) deselects all but
;                the clicked on cell if no shift or command modifier.
;                shift-click works the same in :disjoint as :contiguous.
; 04/09/97 bill  Remove debugging PRINT call from (method text-position (3d-button))
; 04/02/97 akh   add font-codes-string-width-with-eol - for  3d-button
; 04/02/97 bill  fixup-scroll-bars does nothing unless the table is installed in a window.
; 03/29/97 akh   3d-button handles multi line text
; 03/21/97 akh   define current-key-handler for nil to be nil
; 03/31/97 bill  scroll-to-cell scrolls the update region to fix a redisplay bug discovered by
;                Rainer Joswig.
;                :cell-fonts table-dialog-item init arg handled by initialize-instance method
;                instead of being an :initarg in the defclass.
; 03/25/97 bill  Doug Currie's fix to set-visible-dimensions
; -------------  4.1b1
; 03/06/97 bill  invalidate-all-but-left-column only operates if installed-item-p
; 03/04/97 bill  (setf table-hscrollp), (setf table-vscrollp).
;                (method set-view-container :after (table-dialog-item t)) moves the scroll bars
;                to the new container.
; 02/06/97 akh   selected-cells does make-point vs cons
; 01/27/97 bill  New table-dialog-item implementation including gjb's separator code
; -------------  4.0
; 12/07/96 akh   window-close :after updates edit-menu
; 09/27/96 bill  window-top, window-search, window-replace, window-replace-all now
;                all call maybe-apply-to-key-handler so that they will beep and
;                cancel instead of error if applied to a window with no key handler
;                or a key handler that doesn't support the find/replace protocol.
;  9/18/96 slh   Bill's table-inner-size patch: works if view-size is null
; 09/16/96 bill  modal-dialog does a process-wait if operating in the *event-processor*.
; -------------  4.0b1
; 08/12/96 bill  New method: cell-position-possibly-invisible.
;                set-table-dimensions invalidates only as necessary.
;                set-table-sequence only invalidates if the contents have changed.
; akh fix draw-string-crop for extended string
; 04/24/96 akh   scroll-to-cell and old-view-click-evt-hdlr do it with-back-color
;                disposergn's in hilite-rect-frame
; -------------- MCL-PPC 3.9
; 03/26/96  gb   lowmem accessors.
; 12/04/95 bill  remove duplicate (method view-key-event-handler (window t))
; 11/29/95 bill  more new trap names
; 11/15/95 gb    new trap names.  Didn't check if they were defined on 68k.
;  5/04/95 slh   removed print-db
;  4/20/95 slh   modal-dialog: update-menus handles modal keys now
;  4/07/95 slh   added set-dialog-item-enabled-p (from inspector, sort of)
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
;;  2/15/95 slh   y-or-n-dialog: use variable for default size
;; 01/10/95 alice y-or-n-dialog - no-text can be nil too.
;; fred-update ((item fred-dialog-item) - do action even if quieted but not if no wptr.
;;start of retained text
; install-view-in-window ((item table-dialog-item) - disjoint is #x10
; selected-cell  frame for inactive table is in highlight color
; view-focus-and-draw-contents for dialog-item calls factored out view-is-invalid-p
; fred-update of fred-dialog-item calls fred-mixin method
; modal-dialog eventhook doesnt need to deal with menubar - let do-event handle it
; draw-string-crop - use length in bytes in case fat - but who knows what ellipsis is in any random script
; set-table-dimensions invalidated 1 pixel too few, draw-table-cell does not require full cell
; (seems consistent with scrolling up which can show partial cell, also visually implies
; that there be more below)
; in draw-table-cell base of string is f (descent, leading) or ascent from top vs constant 3 from bottom.
; break the string cropper out of draw-cell-contents so pop-up-menu can use it too
; Define table-inner-size and use it in a bunch of places, set-view-size (table-dialog-item) sets
; the cell size consistent with install-view-in-window (-15 vs -16)
; set-view-size (table-dialog-item) sets cell size if dims 0 (empty table) - makes apropos happy
; error msg for selection-type more helpful
; minor simplification in draw-cell-contents - also looks better
; set-view-size (table-dialog-item) - validate scroll bars insofar as they are correct, then no need to 
;	invalidate-view-border. Also nuke contents of bar intersection.
; search dialog - buttons more in sync
; nuke special *search-dialog*, some search-dialog stuff need not be methods
; 10/29/93 alice fix highlight-table-cell for inactive table.
; 10/19/93 alice dialog-item-disable basic-editable-text.. nukes selection caused by
;	 change-key-handler/set-current-key-handler when disabling the last key-handler
; 10/15/93 alice view-draw-contents fred-dialog-item more tasteful if color or gray and disabled
; 10/15/93 alice view-draw-contents :after ((item basic-editable-text-dialog-item)) more tasteful
;		when color and not enabled
; 10/14/93 alice view-click-event-handler (mostly), view-key-event-handler, key-handler-idle,
;		 set-view-size  move from fred-dialog-item to fred-mixin
; 09/30/93  alice view-cursor (key-handler-mixin) arrow if not current-key-handler
;		view-cursor fred-dialog-item not needed
;----------
;;start of added text
; 05/27/94 bill  ensure that both coordinates of the cell-size passed to
;                the table manager are positive.
; 03/21/94 bill  modal-dialog no longer wedges if you window-close its window.
; 03/11/94 bill  editing-dialogs-p method to prevent graphic-items from erroring
;                when the mouse is over them, and the interface toolkit is not loaded.
; 03/09/94 bill  view-default-size's width computation now accounts for newlines.
; -------------- 3.0d13
; 11/11/93 bill  call-with-focused-dialog-item becomes a generic function.
;                The button-dialog-item method handles clipping for borderless buttons.
;                Other button-dialog-item methods no longer do the clipping explicitly.
; 07/28/93 bill  in modal-dialog: enable menus before closing modal dialog so that
;                the right menu will be enabled if a user window has its own menubar.
;; end of added text
; -------------- 3.0d12
; 06/14/93 alice dialog-item-text (static-text-dialog-item) uses %str-from-ptr-in-script
;		 remove-view-from-window (static-text-dialog-item) calls dialog-item-text if handle
; 04/29/93 bill current-process -> *current-process*
; 04/22/93 bill dialog-item-action-p.
;               Call it in (method view-key-event-handler (keystroke-action-dialog))
; 04/21/93 bill no args to event-dispatch - new *idle* handling
; 03/31/93 bill (method remove-view-from-window :after (control-dialog-item)) now focuses
;               to prevent blinking when a control is in a subview that is not at #@(0 0)
;               (method dialog-item-enable (table-dialog-item)) now invalidates always,
;               not just when the item's window is not active.
;--------------- 2.1d5
; 04/25/93 alice view-draw-contents for table-dialog-item draws cell outlines if the table is inactive
; 04/04/93 alice history-length of fred-dialog-item defaults to 2 
; -------------- 2.1d4
; 03 22/92 alice set-dialog-item-text for fred-dialog-item no longer invals outline
; 03/10/93 alice add view-default-size for button-dialog-item
; 02/04/93 alice view-default-size for dialog-item dont focus, just use the font-codes so
;		position is not required.
; 01/29/93 alice draw-outline can be a number
; 01/24/93 alice cell-deselect nukes the border when table inactive
; 01/18/93 alice check for no-border in more places
; 12/01/92 alice instance-initialize fred-dialog-item - dont clobber buffer or file!
; 11/23/92 alice nuke set-view-font-codes :before ((item fred-dialog-item)
;		it changed the entire text - should be ala fred-mixin
; 07/16/92 alice window-close - return-from-modal... iff the window is the modal-dialog
; 02/21/92 alice modal-dialog - freeze menubar around window-close
; -------------- 2.1d3
; 12/31/92 bill return-from-modal-dialog now works with processes.
;               modal-dialog operates (with-cursor 'cursorhook ...)
; 11/25/92 bill Draw a gray outline around an editable-text-dialog-item if it is disabled.
; 11/19/92 bill activation and deactivation no longer cause the selected cells
;               of a table dialog item to be drawn with the :frame color. 
;               (table-frame-color-patch)
; 11/15/92 bill Only draw a dialog-item if its view-corners intersect the instersection
;               of visrgn & cliprgn.
; 11/13/92 bill don't replace the buffer's contents if a fred-dialog-item is given
;               a :buffer initarg but no :dialog-item-text initarg.
; 11/02/92 bill (view-default-size basic-editable-text-dialog-item) is no longer
;               one pixel higher than (view-default-size dialog-item)
;               Move (method instance-initialize :after (fred-dialog-item)) into
;               (method instance-initialize (fred-dialog-item)) to remove a 
;               startup transient that made the text appear 3 pixels to the
;               right of where it belongs in:
;               (make-instance 'fred-dialog-item :view-container foo :dialog-item-text "text")
; 10/16/92 bill set-table-sequence deselects all cells before setting the
;               sequence
; 09/18/92 bill view-find-vacant-position now sets the view-size, not size
;               slot of the view.
; 08/28/92 bill text-justification is now an :instance slot of
;               static-text-dialog-item. It used to be a :class slot which
;               made no sense at all.
; 08/25/92 bill (method remove-view-from-window (table-dialog-item)) clears the
;               visible-dimensions slot so that install-view-in-window won't
;               call set-visible-dimensions if it is installed again.
; 07/30/92 bill Flavors patch to gray the default-button border when it is disabled.
; 07/16/92 bill disabled table-dialog-item's no longer appear enabled at times.
;               visible-dimensions now returns NIL instead of signalling an error
;               due to an attempt to do arithmetic on null view-size or cell-size
; 07/03/92 bill add-key-handler now calls key-handler-p instead of dialog-item-enabled-p
; 06/01/92 bill fred-dialog-item supports :body color now.
; 05/29/92 bill move-to-end-of-control-list before #_LClick so that
;               #_LClick's #_FindControl call will work correctly.
;               Fixes a bug reported by Flavors Technology.
; 05/06/92 bill It now works to add radio buttons to a view before adding
;               the view to a window.
; 04/16/92 bill set-current-key-handler always clears the selection in the
;               old key handler.
;               set-selection-range for fred-dialog-item is a little quieter.
; 04/14/92 bill The set-dialog-item-text method for control-dialog-item
;               is now a primary instead of an after method, so that
;               users can change the args to call-next-method.
; -------------  2.0
; 02/22/92 (bill from "post 2.0f2c5:radio-button-patch")
;               make radio-button-dialog-item's do the right thing about
;               radio-button-push when not a direct subview of their window.
; 02/22/92 (bill from "post 2.0f2c5:table-dialog-item-patch")
;                make a table-dialog-item respect the clip region
;                of its container by fixing VIEW-DRAW-CONTENTS and SET-VIEW-SIZE
;                methods on TABLE-DIALOG-ITEM.
;-------------- 2.0f2c5
; 01/30/92 gb   change VIEW-DRAW-CONTENTS, SET-VIEW-SIZE on TABLE-DIALOG-ITEMs
;               per Bill.
; 01/10/92 bill controlRecord.contrlvis is unsigned-byte, not boolean.
; 01/07/92 gb   don't require RECORDS.
; 12/27/91 bill set-dialog-item-action-function
; 11/26/91 alice function y-or-n-dialog put yes button on bottom right
; 11/26/91 bill nuke the y-or-n-dialog class
;-------------- 2.0b4
; 11/11/91 bill Call dialog-item-action for editable-text-dialog-item
;               whether or not there is a dialog-item-action-function.
; 11/08/91 bill add :text-justification initarg to static-text-dialog-item
;               Parse it in view-draw-contents
; 10/30/91 bill remove "-iv" on the end of slot names
; 10/29/91 bill add :help-spec keyword to y-or-n-dialog.
;               Add help specs to search-window-dialog.
; 10/24/91 bill prevent flashing in (method view-click-event-handler (fred-dialog-item t))
; 10/29/91 alice def-load-pointers => def-ccl-pointers
; 10/10/91 alice update windows-menu unless its disabled.
; 09/26/91 bill call the dialog-item-width-correction method vice using slot-value.
; 09/13/91 bill with-focused-font-view -> with-focused-dialog-item
; 10/02/91 alice window-close updates windows-menu (one less pointer to the window)
;-------------- 2.0b3
; 09/05/91 bill  Alice's fix to modal-dialog
; 08/30/91 alice modal-dialog saves enabled-ness of menus & restores before doing menu-update
;		This will fail if the modal dialog side-effects menu state or menubar contents
; 08/26/91 bill don't directly reference window slots in a wptr in (method view-draw-contents (table-dialog-item))
; 08/24/91 gb   use new trap syntax.
; 08/08/91 bill Remove ancient commented out code
; 08/06/91 bill view-draw-contents should not focus-view
; 08/04/91 bill set-cell-font defaults unspecified portions to the table's font
; 08/02/91 bill Another fix for ROM not erasing between round rect and
;               the corners of a button-dialog-item
; 08/12/91 alice modal-dialog call update-menus before and after
; 07/29/91 alice do-replace-all give window-replace-all  0 to really do all
; 07/26/91 alice nuke the window-can-xxx, cut, etc methods from window. (maybe)
; 07/21/91 gb   PREF, DYNAMIC-EXTENT, badarg fixes.
; 07/21/91 alice window-can cut,copy,clear paste
; 07/08/91 alice method window-can-undo-next-p for window ala window-can-undo-p
; 07/08/91 bill specialize a few methods on key-handler-mixin vice basic-editable-text-dialog-item
; 07/02/91 bill install-view-in-window for table-dialog-item neglected to honour the scroll
;               bar size in computing cell-size
; 07/01/91 bill cell-select & cell-deselect needed with-focused-font-view
; 06/21/91 bill static-text-dialog-item's support :body color.
; 06/17/91 blil with-focused-font-view no longer uses downward-function.
;               uses the new font-view arg to call-with-focused-view
; 06/11/91 bill *allow-without-interrupts-abort* goes away.
; 06/29/91 alice search-dialog requires non-empty search string
; 06/26/91 alice nuked car-dialog-item, press-button do action last
;------------ 2.0b2
; 06/04/91 bill set-cell-font uses invalidate-corners vice redraw-cell
; 05/24/91 bill view-activate-event-handler for table-dialog-item needed
;               to hilite the scroll bars to fix a bug in System 6.
; 05/23/91 bill modal-dialog keeps its dialog in front a little more persistently
; 05/16/91 bill simplify the fred-shadowing-comtab determination in
;               view-key-event-handler: don't need to worry about
;               fred-window as it has it uses the method on fred-mixin.
; 05/13/91 bill set-current-key-handler does select-all even if the selected item was
;               already the current-key-handler.
; 05/08/91 bill more invaling in set-view-size for table-dialog-item to erase "..."
; 04/25/91 bill (method view-key-event-handler (window t)) now passes #\return to a
;               key-handler which allows returns even if there is a default button.
; 04/16/91 bill (method install-view-in-window (table-dialog-item t)) needed to focus
;               around _LNew to keep scroll bars form drawing in the wrong place.
; 03/25/91 bill set-view-position & set-view-size for control-dialog-item
;               now work correctly if the control is not visible.
;               They're also smarter about erasing.
; 03/20/91 bill ALMS's patch to draw-table-cell
; 03/15/91 bill (method set-view-size (table-dialog-item t)) does set-cell-size on
;               tables with only one column.
; 03/13/91 bill ALMS's bug: cell-contents-string should pass CONTENTS vice (OR CONTENTS "")
; 03/11/91 bill be smarter about invalling in set-table-dimensions.
; 03/05/91 bill invalidate some more in (set-view-size table-dialog-item).
; 02/28/91 bill set-visible-dimensions missing objectLisp implicit arg.
;               (view-default-size basic-editable-text-dialog-item) is now one pixel higher.
; 02/27/91 bill default-cell-size no longer maxes out at table-max-width & table-max-height
; 02/14/91 bill (method view-key-event-handler (keystroke-action-dialog t)) special-cases
;               ENTER key as well as RETURN.
; 02/07/91 bill modal-dialog's eventhook is now (how novel) called at event processing time.
; 03/20/91 alice shadowing comtab is in some fred window
; 03/04/91 alice report-bad-arg gets 2 args
; 02/28/91 alice patch to set-cell-size from patch 2.0b1p1
;----------- 2.0b1
; 02/04/91 bill Limit value passed to ROM for table-dialog-item dimension to 4095
; 02/01/91 bill Handle disabled fred-dialog-items correctly.
; 01/22/91 bill cell-select & cell-deselect needed to invalidate-view if the window was
;               not active.
; 01/18/91 bill set-allow-returns & set-allow-tabs are no longer :writer's (wrong arg order)
; 01/16/91 bill rename subview-class parameter to subview-type in do-subviews & friends.
;               add silent-p arg to window-search.
; 12/11/90 bill (method set-view-size (table-dialog-item)) now works if the view has no container
; 11/16/90 bill set-view-size (control-dialog-item) no longer calls invalidate-view-corners
;               unless the dialog-item has a size and a position.
; 11/07/90 bill Only call one of _ShowControl & _Draw1Control
; 11/02/90 bill (:default-initarg :view-font ...) -> (defmethod view-default-font ...)
;               validate-control-dialog-item (yuck!)
; 10/29/90 bill Bug in (method set-view-position (control-dialog-item t))
;               Remove extraneous old code from set-default-button
;10/24/90 bill fred-mixin comes before basic-editable-text-dialog-item in fred-dialog-item's
;              class-prcedence-list.  view-click-event-handler for fred-dialog-item
;              does call-next-method to inherit, instead of copy, the fred-mixin method.
;              Fix the "I'm not drawn" bug in set-default-button
;10/18/90 bill Fix instance-initialize for button-dialog-item so that the default-button
;              flag gets set before a :view-container is processed.
;10/12/90 bill editable-text-dialog-item also defaults to ("Chicago" 12 :plain)
;10/11/90 bill buttons, check-boxes, and radio buttons have ("Chicago" 12 :plain) as their
;              default :view-font.
;10/02/90 bill Search dialog searches the current-key-handler of random windows.
;10/01/90 bill modal-dialog: set *processing-events* true before unwind-protect cleanup,
;              replace a few slot-value's with accessors.
;              add-self-to-dialog -> install-view-in-window
;              remove-self-from-dialog -> remove-view-from-window
;              minimum default-view-size height for check-box-dialog-item & radio-button-dialog-item
;09/27/90 bill set-current-key-handler: dont-select-all -> select-all, default t.
;09/21/90 bill borderless-button-dialog-item -> :border-p initarg for button-dialog-item
;09/20/90 bill (dialog-item-text fred-dialog-item) was broken
;09/13/90 bill remove (method set-view-size (static-text-dialog-item t)),
;              :dialog-item-action initarg must be a function.
;09/11/90 bill allow NIL as a value for :dialog-item-text initarg,
;              (method view-key-event-handler (simple-view t))
;09/10/90 bill alms's fix for default-cell-size
;09/05/90 bill add :margin initarg to fred-dialog-item
;08/27/90 bill set-visible-dimensions call missing first arg.
;08/24/90 bill move array-dialog-items to examples;array-dialog-items.lisp
;08/22/90 bill ALMS's patch to outline-selected-cells
;08/16/90 bill (method set-view-size (static-text-dialog-item))
;08/08/90 bill pull press-button out of (method view-key-event-handler (window t))
;08/03/90 bill :parent -> :class
;08/01/90 bill eventhook arg to modal-dialog.  Don't validate-view when
;              moving or resizing a control-dialog-item. invalidate-view-border
;              in (method set-view-size (dialog-item t))
;07/25/90 bill set-table-dimensions set the table-dimensions-iv too early.
;07/06/90 bill color-dialog uses a :default-initarg instead of color-window-mixin
;07/05/90 bill nix wptr-if-bound, view-default-position & view-default-size for DIALOG
;              buffer-insert-string -> buffer-insert-substring
;              keyword args to front-window, (windows nil) -> (windows)
;07/04/90 bill The "Search for" & "Replace with" dialog-items were too big.
;06/22/90 bill :window-font -> :view-font
;06/19/90 bill Make clicking close box work if a modal-dialog invokes another one.
;              find-dialog-item specializes on view vice window.
;              fix the exit-key-handler example.
;              pushed-radio-button specializes on view vice window.
;06/12/90 bill window-update -> fred-update, set-dialog-item-handle
;06/11/90 bill set-allow-returns & set-allow-tabs
;06/07/90 bill fred-dialog-item defaults :save-buffer-p to true.
;06/04/90 bill :dialog-item-colors initarg for dialog-item -> :part-color-list
;05/24/90 bill window-position & window-size -> view-position & view-size
;05/07/90 bill Don't click a default-button if it's not enabled.
;04/30/90 gb   Don't call dialog-te-handle.
;04/30/90 bill do-subviews, map-subviews, subviews.
;04/30/90 bill Fix brain-damaged reversal of table-vscrollp & table-hscrollp on 4/15.
;              call dialog-item-action in view-click-event-handler when the user
;              clicks outside of a cell.
;04/27/90 bill view-find-vacant-position: handle case of unpositioned siblings
;              maybe-draw-button-outline: default-button on the window, not the container.
;04/26/90 bill dialog-items needed to nreverse its result.
;              Add :cell-fonts initarg to table-dialog-item
;04/23/90 bill view-convert-coordinates-and-click replaces :around method for
;              view-click-event-handler
;04/19/90 bill dialog-item-click-event-handler => view-click-event-handler
;04/15/90 bill prevent consing in cell-contents-string if possible.
;04/15/90 bill table-vscrollp & table-hscrollp accessors were reversed
;04/10/90 gz   dialog-item-font -> view-font
;              with-focused-dialog-item => with-focused-font-view.
;              with-dialog-item-font-codes => with-view-font-codes
;04/09/90 bill item-size unused in (method set-view-position :before (table-dialog-item t))
;04/03/90 bill set-view-size for table-dialog-item
;04/02/90 bill font & color binding moves from draw-cell-contents to draw-table-cell
;04/01/90 bill set-view-size for a dialog-item must erase the whole thing.
;03/28/90 bill set-view-size & set-view-position check for setting to current value.
;03/20/90 bill initialize-instance => instance-initialize where appropriate.
;03/17/90 bill scroll-position returns 0 if a sequence-dialog-item has no container
;              restore clip-region after frec-draw-contents.
;03/16/90 bill aborts were missed sometimes in modal-dialog
;03/15/90 bill with-fore-color around (method dialog-item-click-event-handler (fred-window))
;              remove window-update from view-activate-event-handler &
;              view-deactivate-event-handler for fred-dialog-item.
;03/13/90 bill dialog-item-color-list => part-color-list, default-button-p
;              allow-tabs-p & allow-returns-p accessors for basic-editable-text-dialog-item
;              table-hscrollp & table-vscrollp accessors.
;03/12/90 bill don't invalidate-view if the size & position don't exist yet.
;              Call set-default-size-and-position at the right time in set-view-container.
;              Fix view-find-vacant-position
;              (:method dialog-item-disable (basic-editable-text-dialog-item))
;03/06/90 bill Added :default-button initarg to button-dialog-item.
;03/05/90 bill key-handler-mixin maintains the key-handler-list for dialog-items.
;03/05/90 bill window-key-event-handler & dialog-key-event-handler => view-key-event-handler
;03/01/90 bill view-buffer => fred-buffer
;02/26/90 bill Removed text-edit-dialog-item to dialog ccl;items:text-edit-dialog-item.lisp
;02/21/90 bill :text-edit-sel-p defaults to T for fred-dialog-item.
;02/20/90 bill fred-dialog-item defaults :buffer-chunk-size to 128.
;              with-port must be without-interrupts.
;02/16/90 bill current-editable-text & friends => current-key-handler & friends.
;02/15/90 bill Adding a default button to a window that already has one is no longer
;              an error.
;              Pass off undo & window-can-undo-p to a window's current-editable-text.
;              Make ^Q work for tab & return in fred-dialog-items.
;              window-get & friends => view-get & friends.
;02/14/90 gz   Made with-dialog-item-font-codes and with-focused-dialog-item call
;              functions.  Rearranged things somewhat so the resulting closures
;              close over fewer vars.
;01/13/90 gz   More wfind renaming.  moved %str-to-handle to level-1.
;02/12/90 bill *modal-dialog-on-top* is now the dialog if non-NIL.
;              Make sure the modal-dialog stays on top.
;02/07/90 bill Make option-. same as cancel in modal-dialog.
;02/02/90 bill Dialogs converted so that any window can easily use them.
;              The dialog class still exists
;01/29/90 bill *te-handle* replaces a seperate text-edit record for each dialog.
;              Remove all but DIALOG-ITEMS from the DIALOG class.
;12/27/89 gz   wfind-dialog-class -> search-dialog.
;              setf methods take new value as _first_ arg.
;              In outline-selected-cells, allow for cell-position being null (when
;              selected cell is off-screen).
;10/27/89 bill More conditialization on null wptr's
;10/22/89 bill in remove-self-from-dialog: prevent error if half-removed
;09/27/89 gb simple-string -> ensure-simple-string.
; 09/16/89 bill Remove the last vestiges of object-lisp windows
; 09/13/89 bill Update search dialog to work with CLOS fred-window's
;               Various test for null dialog-item-handle and (dialog-item-text (t)) to
;               prevent errors on half-closed dialogs
; 09/11/89 bill Add (window-update-cursor (dialog t))
; 09/09/89 bill in (add-self-to-dialog :after (check-box-dialog-item t)): add (ignore dialog)
; 09/07/89 bill add without-dialog-item-drawing & without-dialog-item-drawing-if to allow user
;               to do multiple updates before redrawing. Look for %disabled-dialog-item%
; 09/06/89 bill in set-table-dimensions (_LDoDraw :word nil ...) => (_LDoDraw :word 0 ...)
;               This prevents double drawing when rows are added
; 09/06/89 bill Change dialog-item-action for radio-button-dialog-item & check-box-dialog-item
;               to call-next-method to the regular dispatcher.
; 09/05/89 bill (defmethod initialize-instance ((d dialog)) ...) changed from an
;               :after method to a primary.
; 09/05/89 bill Conversion to CLOS complete
; 07/29/89 bill Start conversion to CLOS
; 08/24/89  gz  added first-selected-cell.
;               Fix in add-self-to-dialog-object for controls so initially-disabled controls work.
;               Made cell-contents return nil (rather than "") if no cell.  Kinda like lisp.
; 07/29/89 bill modal-dialog: change from defun to defmethod
; 07/28/89 bill "dialog" => "dialog-object".  Added (defmethod ...dialog...)
; 07/20/89  gz clos syntax for set-part-color-loop.
; 22-mar-89 as merged 1.3
; 04/01/89 gz New defpascal syntax.
; 03/18/89 gz window-foo -> window-object-foo
; 01/03/89 gz require l1-macros, removed redundant macros.
; 12/3/88 gz From 1.3: make-dialog-item and bind *processing-events* in modal-dialog.
; 11/27/88 gz new fred windows.
; 10/27/88 gb %i/ -> floor.
; 10/23/88 gb 8.9 upload
; 8/21/88 gz  declarations
; 8/07/88 gz  Use buffer-search (instead of buffer-string-pos from :code:)
;	      in do-replace-all.

; 6/23/88 as  modal-dialog binds *idle* to t
; 6/21/88 jaj throw :cancel -> throw-cancel, [enter/exit]-editable-text up to spec
; 6/20/88 jaj enableing editable-text-items activates if necessary
; 6/7/88  jaj moved string-width, font-info, real-font to sysutils
; 6/01/88 as  printing to truncating streams catches :truncate
; 5/31/88 as  editable-text-enter/exit-hook, dialog-item-key-event-handler
; 5/23/88 as  table-print-function
; 5/20/88 jaj removed icon-dialog-items. default-size recognizes returns.
;             radio-buton-push calls radio-button-unpush on others.
;             assorted other fixes merged from Pearl
;             put without-interrupts around body of [add|remove]-dialog-items
; 5/19/88 as  punted choose-font-dialog
; 5/18/88 as  wreplace coded inline, more support for mini-buffer
; 5/16/88 as  replace-all dialog counts replacements
; 3/14/88 jaj choose-font-dialog now returns :plain if no styles are checked
; 2/18/88 jaj conditionalized for beany. Mac2 inversion for tables.
; 2/16/88 jaj merged with andrew's changes
; 2/01/88 as  removed table-format-string i-var, reduced table consing
; 1/29/88 as  draw-cell-contents doesn't cons out the wazoo
; 1/28/88 as  choose-font-dialog has a name for debugging purposes
;             *table-dialog-item* no longer inherits from *stream*
;             new, faster draw-cell-contents
;             removed stream-tyo for *table-dialog-item*
;             removed ellipsis-width i-var for tables from exist
;             supporting mods in draw-table-cell
;                                default-cell-size
;             removed excessive support for dialog designer

; 5/24/88 gb  Don't show dialog until made in (window-make-parts *dialog*).
; 4/8/88  gz  new macptr scheme.  Flushed pre-1.0 edit history.
; 3/17/88 gz  watch out for null table-handle.
; 3/02/88  gz declarations for less verbiage at compile-time.
; 2/14/88  gz typo in (set-dialog-item-text *static-text-dialog-item*)
; 2/16/88 gb  lambda-ized actions.
;             Neat idea: when constant and macro definitions are required in
;             order to compile a file, put appropriate "require" statements
;             inside an "eval-when" form at the beginning of the file.
;             Hope this catches on.
; 2/8/88  jaj fixed disabling/enabling de-installed editable-text and set-dialog-item
;             -position for de-installed items. with-font-codes before dialog-item-action
;             in controls and tables
; 1/28/88 jaj window-draw-contents doesn't call usual to avoid double-drawing controls
; 1/6/88  jaj all dialogs have font ivs. Added dlg with-font-codes to add-dialog-items
; 1/5/88  jaj call rset instead of _TESetSelect to fix tabbing problem
;12/23/87 jaj removing editable-text decrements editfield
;10/25/87 jaj added without-interrupts to draw-table-cell, check for my-dialog
;             in button set-di-size, set-di-position. properly set
;             grow-icon-p in window-make-parts
;10/23/87 jaj *[grow/drag]-rect* -> window-[grow/drag]-rect added many cases
;             of with-font-codes.
;10/18/87 jaj added table-print-function to tables
; 9/18/87 jaj put in with-port to fix problem with set-dialog-item-text for
;             editabl and static text. Got rid of rlet with inits.
; 9/17/87 jaj fixed default-button flickering. changed sleep in grow-gray-rect
;             to 0.16 to get rid of ratio. added dialog-item-draw for buttons
;             to ouline if default button. made all set-xxx fns return new
;             value
; 9/16/87 as  removed redundant find items in window-click/item-drag
; 9/16/87 jaj adding items with fonts no longer affects whole dialog
; 9/15/87 as  unfrozen allows moving and resizing of dialog-boxes
;             allows resizing (as well os moving) dialog-items
; 9/15/87 jaj changes in text handling for editable and static text so that
;             no longer used handles will be disposed. 
;             Fixed moving default button
;--------------------------Version 1.0--------------------------------------


(eval-when (eval compile)
  (require 'level-2)
  (require 'defrecord)
  (require 'sysequ)
  ;(require 'toolequ)
  (require 'backquote))



(in-package :ccl)


(eval-when (eval compile load)

(defmacro with-item-rect ((var the-item) &body body)
  (let ((pos (gensym))
        (size (gensym))
        (item (gensym)))
    `(let* ((,item ,the-item)
            (,pos (view-position ,item))
            (,size (view-size ,item)))
       (rlet ((,var :rect :topleft ,pos :bottomright (add-points ,pos ,size)))
         ,@body))))
)

(eval-when (:execute :compile-toplevel)
(defmacro do-column-widths ((item column-width &optional (column (gensym))) (&optional start end from-end)
                            &body body)
  (let ((thunk (gensym)))
    `(block nil
       (let ((,thunk #'(lambda (,column-width ,column)
                         (declare (ignore-if-unused ,column))
                         ,@body)))
         (declare (dynamic-extent ,thunk))
         (map-column-widths ,thunk ,item ,start ,end ,from-end)))))

(defmacro do-row-heights ((item row-height &optional (row (gensym))) (&optional start end from-end)
                          &body body)
  (let ((thunk (gensym)))
    `(block nil
       (let ((,thunk #'(lambda (,row-height ,row)
                         (declare (ignore-if-unused ,row))
                         ,@body)))
         (declare (dynamic-extent ,thunk))
         (map-row-heights ,thunk ,item ,start ,end ,from-end)))))

(defmacro get-adjusted-size (where hash def sep)
  (let ((tmp (gensym))
        (new-hash (gensym)))
    `(let* ((,new-hash ,hash)
            (,tmp (or (and ,new-hash (gethash ,where ,new-hash)) ,def)))
       (if (zerop ,tmp)
         0
         (+ ,tmp ,sep)))))
)

(defclass dialog (window) 
  ()
  (:default-initargs 
   :window-title "Untitled Dialog"
   :window-type :document))

(defmethod view-default-font ((view dialog))
  (sys-font-spec)
  ;'("chicago" 12 :plain)
  )

(defmethod view-default-size ((dialog dialog)) #@(300 200))
(defmethod view-default-position ((dialog dialog)) '(:top 100))

(defmacro %get-current-key-handler (window)
  `(view-get ,window '%current-key-handler))

(defmethod current-key-handler ((w window))
  (%get-current-key-handler w))

(defmethod current-key-handler ((w (eql nil)))  nil)

(defmacro %get-key-handler-list (window)
  `(view-get ,window '%key-handler-list))

(defmethod key-handler-list ((view simple-view))
  (let ((w (view-window view)))
    (and w (%get-key-handler-list w))))

(defmacro %get-default-button (window)
  `(view-get ,window '%default-button))

(defmacro %get-cancel-button (window)
  `(view-get ,window '%cancel-button))

(defmethod editing-dialogs-p ((window t))
  nil)

(defclass color-dialog (dialog)
  ()
  (:default-initargs :color-p t))

(defclass dialog-item (simple-view)
  ((width-correction :allocation :class :initform 0 
                     :accessor dialog-item-width-correction)
   (dialog-item-text :initarg :dialog-item-text :initform ""
                     :accessor dialog-item-text)
   (dialog-item-handle :initarg :dialog-item-handle :initform nil
                       :accessor dialog-item-handle)
   (dialog-item-enabled-p :initarg :dialog-item-enabled-p :initform t
                          :accessor dialog-item-enabled-p)
   (color-list :initarg :part-color-list :initform nil
               :accessor part-color-list)
   (dialog-item-action-function :initarg :dialog-item-action
                                :initform nil
                                :accessor dialog-item-action-function))
  (:default-initargs
    :view-position nil
    :view-size nil))

(defmethod set-dialog-item-handle ((item dialog-item) new-value)
  (setf (dialog-item-handle item) new-value))

(defmethod set-dialog-item-text ((dialog-item dialog-item) text)
  (setf (slot-value dialog-item 'dialog-item-text) (ensure-simple-string text))
  text)

(defmethod set-dialog-item-text :after ((dialog-item dialog-item) text)
  (declare (ignore text))
  (invalidate-view dialog-item))   ; different for fred-dialog-item's

(defmethod set-dialog-item-action-function ((dialog-item dialog-item) f)
  (setf (dialog-item-action-function dialog-item) f))

 ;; what does this do - the next method is a noop
#|
(defmethod instance-initialize ((dialog-item dialog-item) &rest initargs &key
                                (dialog-item-text ""))
  (declare (dynamic-extent initargs))

  (apply #'call-next-method dialog-item
         :dialog-item-text (if dialog-item-text 
                             (ensure-simple-string dialog-item-text)
                             "")
         initargs))
|#

(defclass control-dialog-item (dialog-item) 
  ((procid :allocation :class :reader control-dialog-item-procid)))

(defmethod view-cursor ((item control-dialog-item) where)
  (declare (ignore where))
  *arrow-cursor*)

(defmethod installed-item-p ((item control-dialog-item))
  (let ((dialog (view-container item)))
    (and dialog (wptr dialog)(dialog-item-handle item))))

(defclass default-button-mixin ()())


(defclass button-dialog-item (default-button-mixin control-dialog-item)
  ((procid :initarg :procid :initform  #$PushButProc
           :allocation :class )
   (width-correction :allocation :class :initform 10)))



(defmethod view-default-size ((b button-dialog-item))
  (let ((size (call-next-method)))
    (make-point (max 60 (+ (if t #|(osx-p)|# 12 4) (point-h size)))
                (+ (if t #|(osx-p)|# 4 2) (point-v size)))))


;;  - errors at boot if scroll-bar-dialog-item - which certainly does not have meaningful text
(defmethod install-view-in-window :after ((button control-dialog-item) w)
  (declare (ignore w))
  (when (and (not (typep button 'scroll-bar-dialog-item)))
    (let ((text (dialog-item-text button)))
      (when text
        #+ignore ;; done earlier
        (when (not (7bit-ascii-p text))  ;; fix it
          (set-dialog-item-text button text))
        (fix-osx-dialog-item-font button)))))

(defmethod set-view-font-codes :after ((button control-dialog-item) ff ms &optional m1 m2)
  (declare (ignore ff ms m1 m2))  
  (when (and (not (typep button 'scroll-bar-dialog-item))  (dialog-item-handle button))  ;; it's a reset
    ;(set-dialog-item-text button (dialog-item-text button))
    (fix-osx-dialog-item-font button)))

(defmethod fix-osx-dialog-item-font ((button control-dialog-item))
  (when (dialog-item-handle button)
    (multiple-value-bind (ff ms)(view-font-codes button)  ;; dont bother if eql sys-font?
      (rlet ((fsrec :controlfontstylerec))
        (setf (pref fsrec :controlfontstylerec.flags) (logior #$kControlUseFontMask #$kControlUseFaceMask
                                                              #$kControlUseSizeMask #$kControlUseModeMask)
              (pref fsrec :controlfontstylerec.font) (ash ff -16)
              (pref fsrec :controlfontstylerec.size) (logand ms #xffff)
              (pref fsrec :controlfontstylerec.style) (ash (logand ff #xffff) -8)
              (pref fsrec :controlfontstylerec.mode) (ash ms -16))
        (#_SetControlFontStyle (dialog-item-handle button) fsrec)))))
 


(defmethod set-dialog-item-text ((item control-dialog-item) text)
  (call-next-method)
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (let* ()
        (if (not (7bit-ascii-p text))
          (set-control-title-cfstring item text)
          (with-pstrs ((tp text))
            (#_SetControlTitle (dialog-item-handle item) tp))))))
  text)



(defmethod set-control-title-cfstring ((item control-dialog-item) text)
  (let* ((len (length text)))
    (declare (fixnum len))
    (setq text (ensure-simple-string text))
    (%stack-block ((sb  (%i+ len len)))      
      (copy-string-to-ptr text 0 len sb)
      (with-macptrs ((cfstr (#_CFStringCreatewithCharacters (%null-ptr) sb len)))
        (#_SetControlTitleWithCFString (dialog-item-handle item) cfstr)
        (#_cfrelease cfstr)))
    ))
  
  

#|
(setq w (make-instance 'window
          :view-subviews
          (list 
           (setq d (make-instance 'button-dialog-item
                     :dialog-item-text "zoe
byron"
                     :view-font `("Symbol" 24 (:color ,*blue-color*)))))))

;; too bad color doesn;t seem to work - see below

;Not all font attributes are used by all controls. Most, in fact, ignore
;                 the fore and back color
(defmethod install-view-in-window :after ((button button-dialog-item) w)
  (declare (ignore w))
  (when t ;(osx-p)
    (multiple-value-bind (ff ms)(view-font-codes button)  ;; dont bother if eql sys-font?
      (let* ((color (logand ff #xff))
             (color-bit (if (neq 0 color) #$kControlUseForeColorMask 0)))
      (rlet ((fsrec :controlfontstylerec))
        (setf (pref fsrec :controlfontstylerec.flags) (logior #$kControlUseFontMask #$kControlUseFaceMask
                                                              #$kControlUseSizeMask #$kControlUseModeMask
                                                              color-bit)
              (pref fsrec :controlfontstylerec.font) (ash ff -16)
              (pref fsrec :controlfontstylerec.size) (logand ms #xffff)
              (pref fsrec :controlfontstylerec.style) (ash (logand ff #xffff) -8)
              (pref fsrec :controlfontstylerec.mode) (ash ms -16))
        (when (neq 0 color)
          (rlet ((rgb :rgbcolor))
            (fred-color-index->rgb color rgb)
            (setf (pref fsrec :controlfontstylerec.forecolor.red)   (pref rgb rgbcolor.red)
                  (pref fsrec :controlfontstylerec.forecolor.green) (pref rgb rgbcolor.green)
                  (pref fsrec :controlfontstylerec.forecolor.blue)  (pref rgb rgbcolor.blue))))
        ;(print-record fsrec :controlfontstylerec)
        (#_SetControlFontStyle (dialog-item-handle button) fsrec))))))
|#



(defmethod view-default-font ((view button-dialog-item))
  (sys-font-spec))

(defclass default-button-dialog-item (button-dialog-item)
  ()
  (:default-initargs :dialog-item-text "OK" :default-button t
    :cancel-button nil))

(defclass check-box-dialog-item (control-dialog-item)
  ((width-correction :allocation :class :initform 20)
   (procid :initform #.(+ #$checkBoxProc #$kControlUsesOwningWindowsFontVariant) :allocation :class)
   (check-box-checked-p :initarg :check-box-checked-p :initform nil
                        :accessor check-box-checked-p)))



(defmethod view-default-font ((view check-box-dialog-item))
  (sys-font-spec))

(defclass radio-button-dialog-item (control-dialog-item)
  ((width-correction :allocation :class :initform 20)
   (procid :initform #.(+ #$RadioButProc #$kControlUsesOwningWindowsFontVariant) :allocation :class)
   (radio-button-cluster :initarg :radio-button-cluster :initform 0
                         :accessor radio-button-cluster)
   (radio-button-pushed-p :initarg :radio-button-pushed-p :initform nil
                          :accessor radio-button-pushed-p)))

(defmethod view-default-font ((view radio-button-dialog-item))
  (sys-font-spec))



;;; ;;;;;;;;;;;;
;; 3d-button - borrowed from RSTAR esp. Paul Chu - ask if OK 

; is there any good reason for this to be a dialog-item?
(defclass 3d-button (default-button-mixin dialog-item)
  ((pushed-state :initform nil :accessor pushed-state)
   (frame-p :initform t :initarg :frame-p :accessor frame-p))  ;; maybe initform should be T - all known callers provide t
  (:default-initargs
    :part-color-list `(:back-color ,*tool-back-color* :dark-color ,*tool-line-color*)))

#|
(setq w (make-instance 'window))
(setq d (make-instance '3d-button :view-size #@(60 20) :dialog-item-text "Foo"
 :view-container w :frame-p t))
|#


(defmethod default-button-p ((b default-button-mixin))
  (let ((window (view-window b)))
    (and window (eq b (default-button window)))))

#|
(defmethod instance-initialize ((item default-button-mixin) &key default-button)
  (when default-button
    (setf (view-get item 'default-button-p) t))
  (call-next-method))
|#


(defmethod initialize-instance :after ((item default-button-mixin) &key default-button cancel-button view-container)  
  (when default-button
    (setf (view-get item 'default-button-p) t))
  (when cancel-button
    (setf (view-get item 'cancel-button-p) t)
    (when (not (dialog-item-action-function item))
      (setf (dialog-item-action-function item) 
            #'(lambda (item)(declare (ignore item)) (return-from-modal-dialog :cancel)))))
  (when view-container
    (let ((w (view-window view-container)))
      (when (and w (or default-button cancel-button))
        (button-props-to-window item w)))))

(defmethod button-props-to-window ((item default-button-mixin) window)
  (cond ((view-get item 'default-button-p)
         (setf (%get-default-button window) item)
         (when (and (wptr window)(dialog-item-handle item)) ;; might be a 3d-button
           (if (dont-throb item)
             nil
             (#_setwindowdefaultbutton (wptr window) (dialog-item-handle item)))))
        ((view-get item 'cancel-button-p)
         (setf (%get-cancel-button window) item))))

#|
(defmethod install-view-in-window :before ((item default-button-mixin) view)
  ;(declare (ignore view))
  (let ((dialog (view-window view)))
    (when dialog
      (when (view-get item 'default-button-p)        
        (setf (%get-default-button dialog) item))
      (when (view-get item 'cancel-button-p)
        (setf (%get-cancel-button dialog) item)))))
|#

(defmethod install-view-in-window :after ((item default-button-mixin) view)
  ;(declare (ignore view))
  (let ((window (view-window view)))
    (when window
      (button-props-to-window item window))))

(defmethod remove-view-from-window :before ((item default-button-mixin))
  (let ((dialog (view-window item)))
    (when dialog
      (cond ((eq item (%get-default-button dialog))
             (setf (%get-default-button dialog) nil)
             ;; dunno if this matters
             (when (and (wptr dialog)(dialog-item-handle item))
               (#_setwindowdefaultbutton (wptr dialog) (%null-ptr))))
            ((eq item (%get-cancel-button dialog))
             (setf (%get-cancel-button dialog) nil))))))

#|
(defmethod press-button ((button 3d-button))
  (with-focused-view button
    (setf (pushed-state button) t)
    (force-view-draw-contents button)
    (let ((time (+ 3 (#_TickCount))))
      (while (< (#_TickCount) time)))
    (setf (pushed-state button) nil)
    (force-view-draw-contents button)      
    (dialog-item-action button)))
|#

(defmethod press-button ((button 3d-button))
  (with-focused-view button
    (setf (pushed-state button) t)
    (force-view-draw-contents button)
    (let ((time (%tick-sum 3 (get-tick-count))))
      (while (< (%tick-difference (get-tick-count) time) 0 )))
    (setf (pushed-state button) nil)
    (force-view-draw-contents button)      
    (dialog-item-action button)))
(defmethod frame-color ((b 3d-button))
  (or (part-color b :frame) *black-color*))

(defmethod button-color ((b 3d-button))
  (part-color b :back-color))

(defmethod dark-color ((b 3d-button))
  (or (part-color b :dark-color)))

(defmethod light-color ((b 3d-button))
  (or (part-color b :light-color) *white-color*))

(defmethod lighter-color ((b 3d-button))
  (or (part-color b :lighter-color) (light-color b)))

(defmethod darker-color ((b 3d-button))
  (or (part-color b :darker-color) #x777777))

(defmethod button-default-color ((b 3d-button))
  (or (part-color b :default-color)(part-color b :dark-color)))

(defmethod text-color ((b 3d-button))
  (or (part-color b :text) *black-color*))

(defmethod text-position ((b 3d-button))
  (let* ((size (view-size b))
         (height (point-v size))
         (width (point-h size))
         (text (dialog-item-text b))
         ;(*use-quickdraw-for-roman* t)
         )
    (declare (fixnum height width))
    (multiple-value-bind (ff ms)(view-font-codes b)    
      (multiple-value-bind (a d w l)(font-codes-info ff ms)
        (declare (fixnum a d l))
        (declare (ignore  w))
        (multiple-value-bind (string-width nlines)
                             (font-codes-string-width-with-eol text ff ms)
          (declare (fixnum string-width nlines))
          (let* ((line-height (+ a d l))
                 (string-height (* nlines line-height))
                 (height-delta (ash (the fixnum (- height string-height)) -1)))
            (declare (fixnum line-height string-height height-delta))
            (make-point (max 3 (the fixnum (ash (the fixnum (- width string-width)) -1)))
                        (if (plusp height-delta) (the fixnum (+ a height-delta)) a))))))))

(defmethod view-default-size ((b 3d-button))
  (let ((text (dialog-item-text b)))
    (if text
      (let ()
        (multiple-value-bind (ff ms)(view-font-codes b)
          (multiple-value-bind (string-width nlines)
                               (font-codes-string-width-with-eol text ff ms)
            (make-point (+ string-width 12)
                        (+ (* nlines (font-codes-line-height ff ms)) 10)))))
      #@(60 20))))

  
#|
(defmethod view-click-event-handler ((item 3d-button) where)
  (declare (ignore where))
  (let ((in-p t))
    (when (dialog-item-enabled-p item)
      (with-focused-view item
        (rlet ((button-frame :rect :topleft #@(0 0) :botright (view-size item)))
          (setf (pushed-state item) t)
          (force-view-draw-contents item)      
          (loop (if (mouse-down-p)
                  (let ((new-mouse-loc (view-mouse-position item)))                
                    (if (#_ptinrect new-mouse-loc button-frame)
                      (progn
                        (unless in-p
                          (setf (pushed-state item) t)
                          (force-view-draw-contents item)                        
                          (setf in-p t)))
                      (when in-p
                        (setf (pushed-state item) nil)
                        (force-view-draw-contents item)
                        (setf in-p nil))))
                  (return)))
          (setf (pushed-state item) nil)
          (force-view-draw-contents item)))
        (if in-p (dialog-item-action item)))))
|#

;; works on both OS9 and OSX
(defmethod view-click-event-handler ((item 3d-button) where)
  (declare (ignore where))
  (let ((in-p t))
    (when (dialog-item-enabled-p item)
      (progn ;with-focused-view item ;; force-view-draw-contents does it
        (allow-view-draw-contents (view-window item))  ;; <<
        (rlet ((button-frame :rect :topleft #@(0 0) :botright (view-size item)))
          (setf (pushed-state item) t)
          (force-view-draw-contents item)
          (with-timer
            (loop (if (wait-mouse-up-or-moved)
                    (let ((new-mouse-loc (view-mouse-position item)))                
                      (if (#_ptinrect new-mouse-loc button-frame)
                        (progn
                          (unless in-p
                            (setf (pushed-state item) t)
                            (force-view-draw-contents item)                        
                            (setf in-p t)))
                        (when in-p
                          (setf (pushed-state item) nil)
                          (force-view-draw-contents item)
                          (setf in-p nil))))
                    (return))))
          (setf (pushed-state item) nil)
          (force-view-draw-contents item)))
      (if in-p (dialog-item-action item)))))


(defun force-view-draw-contents (view)
  (with-focused-view view
    ;(invalidate-view view)  ; may not be needed       
    (view-draw-contents view)
    (when t ;(osx-p)  ;; aargh
      (with-port-macptr port
        (#_QDFlushPortBuffer port (%null-ptr))))))

(defun draw-up-rect (top-left bottom-right light-color dark-color)
  (let* ((h1 (point-h top-left))
         (v1 (point-v top-left))
         (h2 (point-h bottom-right))
         (v2 (point-v bottom-right)))
    (with-fore-color light-color
      (#_moveto  h1 v1)
      (#_lineto  h1 v2))
    (with-fore-color dark-color
      (#_moveto  h2 v1)
      (#_lineto  h2 v2)
      (#_lineto  h1 v2))
    (with-fore-color light-color
      (#_moveto  h1 v1)
      (#_lineto  h2 v1))))

(defun draw-down-rect (top-left bottom-right light-color dark-color)
  (draw-up-rect top-left bottom-right dark-color light-color))

(defmethod view-draw-contents :before ((item 3d-button))
  "erase area with appropriate color"
  (when (and (view-container item) (view-window item))
    (with-focused-view item
      (rlet ((rect :rect :topleft #@(1 1) 
                   :botright (subtract-points (view-size item) #@(1 1))))
        (with-back-color
          (if (and (dialog-item-enabled-p item)
                   (default-button-p item))
            (or (button-default-color item) (darker-color item))
            (or (button-color item) (get-back-color (view-window item))))
          (#_eraserect rect)))
      (when (frame-p item)
        (with-fore-color (frame-color item)
          (rlet ((rect :rect :topleft #@(0 0) 
                       :botright (view-size item)))
            (#_framerect rect)))))))

 #|       
(defmethod view-draw-text ((item 3d-button) offset)
  (when (and (view-window item) (dialog-item-text item) (string-not-equal (dialog-item-text item)
                                                                          ""))
    ;; text-position is the bottom of the text 
    (progn
      (#_moveto :long (add-points offset (text-position item)))
      (with-pstrs ((button-string (dialog-item-text item)))
        (with-fore-color (if (and (not (dialog-item-enabled-p item))(color-or-gray-p item))
                           *gray-color*
                           (text-color item))
          (with-back-color
            (if (and (dialog-item-enabled-p item)
                     (default-button-p item))
              (or (button-default-color item) (darker-color item))
              (or (button-color item) (get-back-color (view-window item))))            
            (#_drawstring button-string)))))))
|#

(defun font-codes-string-width-with-eol (string ff ms)  
  (let ((pos 0)
        (nextpos 0)
        (nlines 1)
        (max 0))
    (declare (fixnum nlines))
    (loop
      (if (setq nextpos (string-eol-position string pos))
        (progn
          (setq max (max max (font-codes-string-width string ff ms pos nextpos)))
          (setq nlines (1+ nlines))
          (setq pos (1+ nextpos)))
        (return (values (max max (font-codes-string-width string ff ms pos))
                        nlines))))))

(defun font-codes-string-width-with-eol-for-control (string ff ms)  
  (let ((pos 0)
        (nextpos 0)
        (nlines 1)
        (max 0))
    (declare (fixnum nlines pos))
    (loop
      (if (setq nextpos (string-eol-position string pos))
        (progn
          (setq max (max max (font-codes-string-width-for-control string ff ms pos nextpos)))
          (setq nlines (1+ nlines))
          (setq pos (1+ nextpos)))
        (return (values (max max (font-codes-string-width-for-control string ff ms pos))
                        nlines))))))
      

(defmethod view-draw-text ((item 3d-button) offset)
  (when (and (view-window item) (dialog-item-text item) (string-not-equal (dialog-item-text item)
                                                                          ""))
    ;; text-position is the bottom of the text - the first line thereof
    (let* ((pos #@(0 0)) ;(view-position item)) ;; dont scrible outside text region
           (inner-size (subtract-points (view-size item) #@(3 3))))
      (multiple-value-bind (ff ms)(view-font-codes item)
        (rlet ((rect :rect :topleft pos :botright (add-points pos inner-size)))
          (with-clip-rect-intersect rect
            (let* ((text-pos (add-points offset (text-position item)))
                   (fore-color (if (and (not (dialog-item-enabled-p item))(color-or-gray-p item))
                                 *gray-color*
                                 (text-color item))))              
              (with-back-color
                (if (and (dialog-item-enabled-p item)
                         (default-button-p item))
                  (or (button-default-color item) (darker-color item))
                  (or (button-color item) (get-back-color (view-window item))))
                (let* ((curstr (dialog-item-text item))) 
                  (#_moveto (point-h text-pos)(point-v text-pos))
                  (grafport-write-unicode curstr 0 (length curstr) ff ms fore-color))                      
                ))))))))

(defmethod view-draw-contents ((item 3d-button))
  (with-font-focused-view item
    (let* ((forecolor (light-color item))
           (backcolor (dark-color item))
           (lighter-forecolor (lighter-color item))
           (darker-backcolor (darker-color item)))
      (cond 
       ((null (pushed-state item))      
        (view-draw-text item #@(0 0))
        (if (dialog-item-enabled-p item)
          (progn
            (draw-up-rect #@(1 1) (subtract-points (view-size item) #@(2 2)) forecolor backcolor)
            (draw-up-rect #@(2 2) (subtract-points (view-size item) #@(3 3))
                          lighter-forecolor darker-backcolor))
          (draw-up-rect #@(1 1) (subtract-points (view-size item) #@(2 2)) forecolor lighter-forecolor)))
       (t 
        (view-draw-text item #@(1 1))
        (draw-down-rect  #@(1 1) (subtract-points (view-size item) #@(2 2)) forecolor backcolor)
        (draw-down-rect  #@(2 2) (subtract-points (view-size item) #@(3 3))
                        lighter-forecolor darker-backcolor)))
      ;gray out button if it is disabled and not color
      (unless (or (dialog-item-enabled-p item)(color-or-gray-p item))
        (with-pen-saved-simple
          (#_penpat *gray-pattern*)
          (#_penmode #$notpatbic)
          (with-fore-color (get-back-color (view-window item))
            (rlet ((rect :rect :topleft #@(2 2) 
                         :botright (subtract-points (view-size item) #@(2 2))))
              (#_paintrect rect))))))))
#| ; same as simple-view
(defmethod view-corners ((item 3d-button))
  (values (view-position item)
          (add-points (view-position item) (view-size item))))
|#
  

(defclass static-text-dialog-item (dialog-item)
  ((width-correction :allocation :class :initform 4)
   (text-justification :initform nil :initarg :text-justification)
   (text-truncation :initform nil :initarg :text-truncation)
   (compress-text :initarg :compress-text :initform nil :reader compress-text)
   )
  (:default-initargs :dialog-item-text "Untitled"))

(defmethod view-default-font ((view static-text-dialog-item))
  (sys-font-spec))

(defclass key-handler-mixin ()
  ((allow-returns :initarg :allow-returns :initform nil :accessor allow-returns-p)
   (allow-tabs :initarg :allow-tabs :initform nil :accessor allow-tabs-p)))

(defclass focus-rect-mixin ()()
)

; basis for text-edit-dialog-item & fred-dialog-item
(defclass basic-editable-text-dialog-item (key-handler-mixin dialog-item)
  ((width-correction :allocation :class :initform 4)
   (text-justification :allocation :class :initform 0)
  ; (draw-outline :initarg :draw-outline :initform t)   ;; not used today
   ;(line-height :initform nil)   ;; not used
   ;(font-ascent :initform nil)
   ))

(defmethod set-allow-returns ((item key-handler-mixin) value)
  (setf (allow-returns-p item) value))

(defmethod set-allow-tabs ((item key-handler-mixin) value)
  (setf (allow-tabs-p item) value))

(defmethod selection-range ((item key-handler-mixin))
  (values 0 0))

(defmethod selection-range ((item (eql nil)))
  (values 0 0))

(defmethod set-selection-range ((item key-handler-mixin) &optional pos curpos)
  (declare (ignore pos curpos))
  0)

(defclass fred-dialog-item (focus-rect-mixin tsm-document-mixin fred-mixin basic-editable-text-dialog-item)
  ()
  (:default-initargs :buffer-chunk-size 128
                     :history-length 2
                     :text-edit-sel-p t
                     :save-buffer-p t))


(defmethod install-view-in-window ((view fred-dialog-item) window)
  (call-next-method)
  (when (null (getf (slot-value view 'color-list) :body nil))
    (set-part-color view :body *white-color*)))

; Write the update-instance-for-redefined-class method, and this can
; be changed to be text-edit-dialog-item instead.
(defclass editable-text-dialog-item (fred-dialog-item) ())

#|
(defmethod view-default-font ((view editable-text-dialog-item))
  (if (eql (default-script #$smSystemscript) #$smRoman)
    '("Chicago" 12 :plain)
    (let ((font (get-script #$smRoman #$smScriptAppFond)))
      (multiple-value-bind (ff ms)(font-codes '("Chicago" 12 :plain))
        (font-spec (make-point (point-h ff) font) ms)))))
|#

;; don't include frame
(defmethod view-clip-region ((view editable-text-dialog-item))
  (old-view-clip-region view))

(defmethod view-default-font ((view editable-text-dialog-item))
  (sys-font-spec))

(defvar *first-menustate* nil)

#|
(defmethod modal-dialog ((dialog window) &optional (close-on-exit t) eventhook 
                           &aux ret)
  (#_FlushEvents #xfff7 0)
  (let ((eventhook
         #'(lambda (&aux (event *current-event*)
                         (what (rref event eventrecord.what)))
             (when (and *modal-dialog-on-top* (eq dialog (caar *modal-dialog-on-top*)))
               (unless (wptr dialog)    ; this does nothing if *modal-dialog-on-top* is nil
                 (return-from-modal-dialog :cancel))
               (when (wptr dialog)  ; it may be gone
                 (unless (eq (window-layer dialog) 0)
                   (set-window-layer dialog 0))
                 (unless (and eventhook
                              (if (listp eventhook)
                                (dolist (f eventhook)
                                  (when (funcall f) (return t)))
                                (funcall eventhook)))
                   (if (eq #$mouseDown what)
                     (%stack-block ((wp 4))
                       (let* ((code (#_FindWindow (rref event eventrecord.where) wp)))
                         (cond 
                          ((eq code #$inMenubar) nil)
                          ((%ptr-eql (wptr dialog) (%get-ptr wp))
                           nil)                          
                          (t  (#_Sysbeep 5) t))))
                     (if nil ; (or (eq what #$keyDown) (eq what #$autoKey))
                       (when (menukey-modifiers-p (rref event eventrecord.modifiers))
                         (ed-beep)
                         t))))))))
        (*interrupt-level* 0)
        (old-modal-dialog *modal-dialog-on-top*)
        #+REMOVE (old-window-process (window-process dialog))
        )
    (declare (dynamic-extent eventhook))
    (progn ;let-globally ()        
      ;(declare (special *processing-events*))
      
      (setq *processing-events* nil)
      (let ()
        (unwind-protect
          (with-cursor 'cursorhook 
            (setq ret (multiple-value-list
                       (restart-case
                         (catch '%modal-dialog
                           (progn ; (let-globally (*modal-dialog-process* *current-process*))
                             (set-window-layer dialog 0)
                             
                             #+REMOVE (setf (window-process dialog) *current-process*)  ; do this first
                             (setq *modal-dialog-on-top* (cons (list dialog *current-process* eventhook) *modal-dialog-on-top*)
                                   ;*eventhook* eventhook
                                   )
                             (when (not old-modal-dialog)
                               (setq *first-menustate* (update-menus :disable))
                               )
                             (window-show dialog)
                             ;(setq ms (update-menus :disable))
                             (loop
                               (when (eq *current-process* *event-processor*)
                                 (process-wait "Event-poll" #'event-available-p))
                               (event-dispatch))))
                         (abort () :cancel)
                         (abort-break () :cancel))))
            (if (eq (car ret) :cancel)
              (throw-cancel :cancel)
              (apply #'values ret)))
          (without-interrupts  ; << maybe this helps - not really
           (without-event-processing ; delay events until the window-close is over
             #+REMOVE (setf (window-process dialog) old-window-process)
             ; if this one is still on top reset to nil, else leave alone
             (setq *modal-dialog-on-top* (nremove (assq dialog *modal-dialog-on-top*) *modal-dialog-on-top*))
             (let ((mdot *modal-dialog-on-top*))
               (when mdot
                 (when (not (wptr (caar mdot)))
                   (setq *modal-dialog-on-top* (cdr *modal-dialog-on-top*)))))
             ;(setq *eventhook* nil)  ; kill the same bug 2 ways.             
             ; used to be after window-close - 
             (if (not *modal-dialog-on-top*)(update-menus :enable *first-menustate*))
             (if close-on-exit
               (window-close dialog)
               (progn (window-hide dialog)
                      (set-window-layer dialog 9999))))))))))
|#

(defmethod modal-dialog ((dialog window) &optional (close-on-exit t) eventhook 
                           &aux ret)
  (#_FlushEvents #xfff7 0)
  (let ((eventhook
         #'(lambda (&aux (event *current-event*)
                         (what (rref event eventrecord.what)))
             (when (and *modal-dialog-on-top* (eq dialog (caar *modal-dialog-on-top*)))
               (unless (wptr dialog)    ; this does nothing if *modal-dialog-on-top* is nil
                 (return-from-modal-dialog :cancel))
               (when (wptr dialog)  ; it may be gone
                 (when (not *in-foreign-window*)  ;; added 05/24/05
                   (unless (eq (window-layer dialog) 0)
                     (set-window-layer dialog 0)))
                 (if (and eventhook
                          (if (listp eventhook)
                            (dolist (f eventhook)
                              (when (funcall f) (return t)))
                            (funcall eventhook)))
                   t                   
                   (if (eq #$mouseDown what)
                     (%stack-block ((wp 4))
                       (let* ((code (#_FindWindow (rref event eventrecord.where) wp)))
                         (cond 
                          ((eq code #$inMenubar) nil)
                          ((%ptr-eql (wptr dialog) (%get-ptr wp))
                           nil)                          
                          (t  (#_Sysbeep 5) t))))
                     (if nil ; (or (eq what #$keyDown) (eq what #$autoKey))
                       (when (menukey-modifiers-p (rref event eventrecord.modifiers))
                         (ed-beep)
                         t))))))))
        (*interrupt-level* 0)
        (old-modal-dialog *modal-dialog-on-top*)
        #+REMOVE (old-window-process (window-process dialog))
        )
    (declare (dynamic-extent eventhook))
    (progn ;let-globally ()        
      ;(declare (special *processing-events*))
      
      (setq *processing-events* nil)
      (let ()
        (unwind-protect
          (with-focused-view nil
            (with-cursor 'cursorhook 
              (setq ret (multiple-value-list
                         (restart-case
                           (catch '%modal-dialog
                             (progn ; (let-globally (*modal-dialog-process* *current-process*))
                               #+carbon-compat
                               (let ((wptr (wptr dialog)))  ;; make it modal now
                                 (when wptr (#_changewindowattributes wptr 0 #$kWindowCollapseBoxAttribute)) ;; lose collapse box
                                 (when (and wptr) ; (wptr-dialog-p wptr)) ;(FIND-CLASS 'DRAG-RECEIVER-DIALOG NIL)(typep dialog 'drag-receiver-dialog)) ;; ??
                                   ;(PUSH (LIST 'ONE (GETWINDOWCLASS WPTR)(WINDOW-LAYER DIALOG) DIALOG) barf)
                                   (#_setwindowclass wptr #$kMovableModalWindowClass) ; CHANGES WINDOW-LAYER
                                   (setwindowmodality wptr #$kWindowModalityAppModal)
                                   ;(PUSH (LIST 'TWO (GETWINDOWCLASS WPTR) (WINDOW-LAYER DIALOG) DIALOG) barf)
                                   ))
                               (set-window-layer dialog 0)
                               ;(#_hidefloatingwindows)
                               
                               #+REMOVE (setf (window-process dialog) *current-process*)  ; do this first
                               (setq *modal-dialog-on-top* (cons (list dialog *current-process* eventhook) *modal-dialog-on-top*)
                                     ;*eventhook* eventhook
                                     )
                               (when (not old-modal-dialog)
                                 (setq *first-menustate* (update-menus :disable))
                                 )
                               
                               (window-show dialog)
                               ;(setq ms (update-menus :disable))
                               (loop
                                 (when t ;(eq *current-process* *event-processor*)  ;; 05/24/05
                                   (process-wait "Event-poll" #'event-available-p))
                                 (event-dispatch))))
                           (abort () :cancel)
                           (abort-break () :cancel))))
              (if (eq (car ret) :cancel)
                (throw-cancel :cancel)
                (apply #'values ret))))
          (without-interrupts  ; << maybe this helps - not really
           (without-event-processing ; delay events until the window-close is over
             #+REMOVE (setf (window-process dialog) old-window-process)
             ; if this one is still on top reset to nil, else leave alone
             (setq *modal-dialog-on-top* (nremove (assq dialog *modal-dialog-on-top*) *modal-dialog-on-top*))
             (let ((mdot *modal-dialog-on-top*))
               (when mdot
                 (when (not (wptr (caar mdot)))
                   (setq *modal-dialog-on-top* (cdr *modal-dialog-on-top*)))))
             ;(setq *eventhook* nil)  ; kill the same bug 2 ways.             
             ; moved update-menus back to after window-close - fixes do-about-dialog when carbon (weird)
             (if close-on-exit
               (window-close dialog)
               (progn (window-hide dialog)
                      (set-window-layer dialog 9999)))
             (when (not *modal-dialog-on-top*)(update-menus :enable *first-menustate*)
                   ;(#_showfloatingwindows)
                   ))))))))

(defmacro return-from-modal-dialog (form)
  `(multiple-value-call '%return-from-modal-dialog ,form))

#|
;; in case clim patch to modal dialog is loaded
(defun modal-dialog-process (thing)
  (when thing
    (let ((p (cdr thing)))
      (if (consp p) (car p) p))))
|#

(defun %return-from-modal-dialog (&rest values)
  (declare (dynamic-extent values))
  ;(when  (not *modal-dialog-on-top*) (dbg 2))
  (when *modal-dialog-on-top* ; << maybe its gone or not set yet
    (let ((process (modal-dialog-process (car *modal-dialog-on-top*))))
      (when process
        (apply #'process-interrupt
               process
               #'(lambda (&rest values)
                   (declare (dynamic-extent values))
                   (throw '%modal-dialog (apply #'values values)))
               values)))))

(defmethod window-close :before ((dialog window))
  (when (wptr dialog)
    (when (assq dialog *modal-dialog-on-top*)
      (return-from-modal-dialog :closed))))

(defmethod window-close :after ((w window))
  (setf (slot-value w 'my-item) nil)
  (let ((wm *windows-menu*))
    (when (and (typep wm 'menu) (menu-enabled-p wm))
      (update-windows-menu wm))
    (let ((em (edit-menu)))
      (when em (menu-update em)))))

(defmacro with-focused-dialog-item ((item &optional container) &body body)
  (let ((fn (gensym))
        (item-var (if (symbolp item) item (gensym))))
    `(let ((,fn #'(lambda (,item-var)
                    (declare (ignore-if-unused ,item-var))
                    ,@body)))
       (declare (dynamic-extent ,fn))
       (call-with-focused-dialog-item
        ,item ,fn ,@(and container `(,container))))))

(defmethod call-with-focused-dialog-item (item fn &optional container)
  (let ((f #'(lambda (container)
               (declare (ignore container))
               (funcall fn item))))
    (declare (dynamic-extent f))
    (call-with-focused-view
     (or container (view-container item))
     f
     item)))

(defmethod call-with-focused-dialog-item ((item button-dialog-item) fn &optional container)
  (if t ;(osx-p)
    (call-next-method item fn (if (default-button-p item)(view-window (or container item)) container)) ;; <<<
    (if (view-get item 'no-border)
      (let ((f #'(lambda (item)
                   (clip-inside-view item 2 2)
                   (funcall fn item))))
        (declare (dynamic-extent f))
        (without-interrupts
         (call-next-method item f container)))
      (call-next-method))))

(defmethod installed-item-p (item)
  (let ((dialog (view-container item)))
    (and dialog (wptr dialog))))



(defmethod window-null-event-handler :before ((dialog window))
  (let ((item (current-key-handler dialog)))
    (when item
      (key-handler-idle item dialog))))

(defmethod key-handler-idle ((item simple-view) &optional dialog)
  (declare (ignore dialog))
  )
#|
(defmethod key-handler-idle ((item fred-dialog-item) &optional dialog)
  (declare (ignore dialog))
  (with-focused-view item
    (frec-idle (frec item))))
|#

; A dialog-item is drawn focused on its parent.
(defmethod view-focus-and-draw-contents ((item dialog-item) &optional visrgn cliprgn)
  (declare (ignore visrgn cliprgn))
  (unless (view-quieted-p item)
    (without-interrupts
     (with-focused-view (view-container item)
       (with-temp-rgns (visrgn cliprgn)
         (get-window-visrgn (wptr item) visrgn)
         (get-window-cliprgn (wptr item) cliprgn)      
         (when (view-is-invalid-p item visrgn cliprgn)
           (call-with-focused-dialog-item item 'view-draw-contents)))))))

#|
(defmethod view-activate-event-handler :before ((item button-dialog-item))
    (when (and (osx-p) (dialog-item-enabled-p item))
      (#_activatecontrol (dialog-item-handle item))))

(defmethod view-deactivate-event-handler :before ((item button-dialog-item))
    (when (osx-p)
      (#_deactivatecontrol (dialog-item-handle item))))  ;; sick of throbbing buttons
|#

(defmethod dialog-item-disable ((item button-dialog-item))
  (view-put item 'was-enabled nil)
  (call-next-method))
 
(defmethod view-activate-event-handler :around ((item dialog-item))
  (when (wptr item)
    (with-focused-dialog-item (item)
      (call-next-method))))

(defmethod view-deactivate-event-handler :around ((item dialog-item))
  (when (wptr item)
    (with-focused-dialog-item (item)
      (call-next-method))))

; Overwrites method in l1-windows
(defmethod view-key-event-handler ((window window) char &aux 
                                   (key-hdlr (current-key-handler window))
                                   ;(d-button (default-button window))
                                   )  
  (when (and (eql char #\esc) (not (any-modifier-keys-p))) ; (not key-hdlr))
    (let ((cancel-button (cancel-button window)))
      (if cancel-button
        (when (dialog-item-enabled-p cancel-button)
          (press-button cancel-button)
          (return-from view-key-event-handler char))
        (when (not key-hdlr) ;; ??  -        
          (let ((x (look-for-a-button-named-cancel window)))
            (when (and x (dialog-item-enabled-p x))
              (press-button x)
              (return-from view-key-event-handler char)))))))      
  (unless (or (any-modifier-keys-p)
              (and key-hdlr 
                   (eq (fred-shadowing-comtab key-hdlr) ;; nil if not fred-mixin
                       *control-q-comtab*)))
    (case char
      (#\tab
       (unless (and key-hdlr (allow-tabs-p key-hdlr))
         (change-key-handler window)
         (setq key-hdlr nil)))
      ((#\return #\enter)
       (let ((d-button (default-button window)))
         (cond
          ((and (eql char #\return)
                key-hdlr
                (or (allow-returns-p key-hdlr) (setq key-hdlr nil))))
          ((and d-button (dialog-item-enabled-p d-button))
           (press-button d-button)
           (setq key-hdlr nil)))))))
  (if key-hdlr
    (view-key-event-handler key-hdlr char)
    (if *top-listener*
      (view-key-event-handler *top-listener* char))))

#|
(defmethod press-button ((button button-dialog-item))
  (with-focused-dialog-item (button)
    (let ((handle (dialog-item-handle button)))
      (#_deactivatecontrol handle) ;(#_HiliteControl handle 1)
      (let ((time (+ 3 (#_TickCount))))
        (while (< (#_TickCount) time)))
      (when (setq handle (dialog-item-handle button))   ; window may have closed
        (#_activatecontrol handle)) ;(#_HiliteControl handle 0))
      (dialog-item-action button))))
|#

(defmethod press-button ((button button-dialog-item))
  (with-focused-dialog-item (button)
    (let ((handle (dialog-item-handle button)))
      (#_deactivatecontrol handle) ;(#_HiliteControl handle 1)
      (let ((time (%tick-sum 3 (get-tick-count))))
        (while (< (%tick-difference (get-tick-count) time) 0)))
      (when (setq handle (dialog-item-handle button))   ; window may have closed
        (#_activatecontrol handle)) ;(#_HiliteControl handle 0))
      (dialog-item-action button))))

(defmacro do-subviews ((subview-var view &optional subview-type)
                       &body body)
  (let* ((type-var-p (not (or (symbolp subview-type) (constantp subview-type))))
         (type-var (if type-var-p (gensym)))
         (subviews-var (gensym))
         (len-var (gensym))
         (i (gensym))
         (subviews-copy-var (gensym)))
    `(with-managed-allocation
       (let* (,@(if type-var-p `((,type-var ,subview-type)))
              (,subviews-var (view-subviews ,view))
              (,len-var (length ,subviews-var))
              (,subviews-copy-var (%make-temp-uvector ,len-var))
              ,subview-var)
         (declare (fixnum ,len-var))
         (dotimes (,i ,len-var)
           (setf (%svref ,subviews-copy-var ,i)
                 (aref ,subviews-var ,i)))
         (dotimes (,i ,len-var)
           (setq ,subview-var (%svref ,subviews-copy-var ,i))
           (when ,(if subview-type
                    `(typep ,subview-var ,(if type-var-p type-var subview-type))
                    t)
             ,@body))))))

(defmethod map-subviews ((view view) function &optional subview-type)
  (if subview-type
    (do-subviews (subview view subview-type)
      (funcall function subview))
    (do-subviews (subview view)
      (funcall function subview))))

(defmethod subviews ((view simple-view) &optional subview-type)
  (declare (ignore subview-type))
  nil)

(defmethod subviews ((view view) &optional subview-type)
  (let ((res nil))
    (let* ((add-em #'(lambda (subview)  (push subview res))))
      (declare (dynamic-extent add-em))
      (map-subviews view add-em subview-type))
    (nreverse res)))

(defmethod find-subview-of-type ((view view) subview-type)
  (let ((subs (view-subviews view)))
    (when subs 
      (dotimes (i (length subs))
        (let ((it (aref subs i)))
          (when (typep  it subview-type)
            (return it)))))))

(defmethod find-subview-of-type ((view simple-view) subview-type)
  nil)
        

; I should really write once-only (either that or stop being so anal).
(defmacro do-dialog-items ((item-var dialog &optional (item-class ''dialog-item) must-be-enabled)
                           &body body)
  (let* ((enabled-var (gensym)))
    `(let ((,enabled-var ,must-be-enabled))
       (do-subviews (,item-var ,dialog ,item-class)
         (when (or (not ,enabled-var) (dialog-item-enabled-p ,item-var))
           ,@body)))))

(defmethod dialog-items ((view view) &optional (item-class 'dialog-item)
                         (must-be-enabled nil)
                         &aux result)
  (do-dialog-items (this-item view item-class must-be-enabled)
    (push this-item result))
  (nreverse result))

(defmethod set-current-key-handler ((dialog window) item &optional (select-all t)
                                      &aux old)
  (unless (or (null item)
              (and (memq item (%get-key-handler-list dialog))
                   (key-handler-p item)))
    (error "~s is either disabled or is not a key-handler item of ~s" item dialog))
  (without-interrupts
   (if (and (neq item (setq old (%get-current-key-handler dialog)))
            (if old 
              (when (exit-key-handler old item)
                (multiple-value-bind (s e) (selection-range old)
                  (declare (ignore s))
                  ; do this first else display may be wrong.
                  (set-selection-range old e e))
                (setf (%get-current-key-handler dialog) nil) ;; << !! so frame.. knows
                (view-deactivate-event-handler old)
                t)
              t))
     (progn
       (setf (%get-current-key-handler dialog) item)
       (when item
         (when select-all
           (set-selection-range item 0 most-positive-fixnum))
         (if (window-active-p dialog)
           (view-activate-event-handler item))
         (enter-key-handler item old)))
     (when (and item (eq item old) select-all)
       (set-selection-range item 0 most-positive-fixnum))))
  item)

;Check for a view-key-event-handler method?
(defmethod key-handler-p ((item dialog-item))
  nil)

(defmethod key-handler-p ((item key-handler-mixin))
  (or (not (method-exists-p #'dialog-item-enabled-p item))
       (dialog-item-enabled-p item)))

(defmethod change-key-handler ((view view))
  (let* ((dialog (view-window view))
         (items (%get-key-handler-list dialog))
         (old-handler (current-key-handler dialog))
         (rest (memq old-handler items)))
    (set-current-key-handler 
     dialog
     (or 
      (dolist (x (cdr rest))
        (if (key-handler-p x)(return x)))
      (dolist(x items)
        (if (key-handler-p x)(return x)))))))

#|
(defmethod cut ((dialog window))
  (window-delegate-op dialog 'cut))

(defmethod copy ((dialog window))
  (window-delegate-op dialog 'copy))

(defmethod paste ((dialog window))
  (window-delegate-op dialog 'paste))

(defmethod clear ((dialog window))
  (window-delegate-op dialog 'clear))

(defmethod undo ((w window))
  (window-delegate-op w 'undo))

(defmethod undo-next ((w window))
  (window-delegate-op w 'undo-next))
|#

(export '(view-outer-size) :ccl)
(defmethod view-outer-size ((view simple-view))
  (let ((old-pos (view-position view))
        (old-size (view-size view)))
    (if (not old-pos) (setf (slot-value view 'view-position) 0))
    (if (not old-size)(setf (slot-value view 'view-size)(view-default-size view)))
    (multiple-value-bind (tl br)(view-corners view)        
      (setf (slot-value view 'view-position) old-pos)
      (subtract-points br tl))))

(defmethod view-find-vacant-position ((view view) subview)
  (let* ((size (view-outer-size subview))
         (inner-size (view-size subview))
         (height (point-v size))
         (width (point-h size))
         (w-size (view-size view))
         (w-height (point-v w-size))
         (w-width (point-h w-size))
         (rect-rgn (#_NewRgn))
         (vacant-rgn (#_NewRgn))
         (v-list (list 4))
         (h-list (list 4))
         (h-delta (ash (- (point-h size)(point-h inner-size)) -1))
         (v-delta (ash (- (point-v size)(point-v inner-size)) -1)))
    (unwind-protect
      (progn
        (rlet ((s-rect :rect :topleft #@(0 0) :bottomright w-size))
          (#_RectRgn vacant-rgn s-rect)
          (dovector (item (view-subviews view))
            (let ((position (view-position item))
                  (size (view-outer-size item)))
              (unless (or (eq item subview) (not position))                
                (let ((lower-right (add-points position size)))
                  (rset s-rect :rect.topleft position)
                  (rset s-rect :rect.bottomright lower-right))
                (#_InsetRect s-rect -4 -4)
                (#_RectRgn rect-rgn s-rect)
                (#_DiffRgn vacant-rgn rect-rgn vacant-rgn)
                (pushnew (%i+ 6 (rref s-rect :rect.right)) h-list)
                (pushnew (%i+ 6 (rref s-rect :rect.bottom)) v-list))))
          (setq v-list (sort v-list #'<)
                h-list (sort h-list #'<))
          (dolist (v v-list)
            (dolist (h h-list)
              (#_SetRectRgn rect-rgn h v (%i+ h width) (%i+ v height))
              (#_UnionRgn  vacant-rgn rect-rgn rect-rgn)
              (when (and (#_EqualRgn rect-rgn vacant-rgn)
                         (%i< (%i+ v height) w-height)
                         (%i< (%i+ h width) w-width))
               (return-from view-find-vacant-position (make-point (+ h h-delta)(+ v v-delta)))))))
        (return-from view-find-vacant-position #@(0 0)))
      (#_disposergn vacant-rgn)
      (#_disposergn rect-rgn))))


(defmethod default-button ((dialog window))
  (%get-default-button dialog))

(defmethod cancel-button ((dialog window))
  (%get-cancel-button dialog))

(defmethod set-cancel-button ((dialog window) new-button)
  (setf (%get-cancel-button dialog) new-button))
  

#|
(defmethod default-button-p ((button button-dialog-item))
  (let ((window (view-window button)))
    (and window (eq button (default-button window)))))
|#

(defmethod set-default-button ((dialog window) new-button)
  (let ((default-button (%get-default-button dialog)))
    (unless (eq default-button new-button)
      (without-interrupts
       (when default-button
         (invalidate-view-border default-button t)
         (when t ; (not new-button)
           (#_setwindowdefaultbutton (wptr dialog) (%null-ptr))))
       (setf (%get-default-button dialog) new-button)
       (when new-button
         (when (dialog-item-handle new-button)
           (if (dont-throb new-button) ;(and (osx-p)(neq (view-container new-button)(view-window new-button)))
             nil  ;; (warn "phooey")  ;; so we act like a default button but dont look like one
             (#_setwindowdefaultbutton (wptr dialog) (dialog-item-handle new-button))))
         (invalidate-view-border new-button)))))
  new-button)


(defmethod pushed-radio-button ((view view) &optional (cluster 0))
  (dovector (item (view-subviews view))
    (if (and 
         (typep item 'radio-button-dialog-item)
         (eq cluster (slot-value item 'radio-button-cluster))
         (radio-button-pushed-p item))
        (return-from pushed-radio-button item))))

;ffing stupid - doc'd but unused
(defmethod find-dialog-item ((view view) text)
  (dovector (item (view-subviews view))
    (if (and (typep item 'dialog-item) (equalp text (dialog-item-text item)))
        (return item))))

;;; Dialog items

(defun make-dialog-item (class position size text
                               &optional action
                               &rest attributes)
  (declare (dynamic-extent attributes))
  (apply #'make-instance class
         (if position :view-position :ignore)
          position
         (if size :view-size :ignore)
         size
         (if text :dialog-item-text :ignore)
         text
         (if action :dialog-item-action :ignore)
         action
         attributes))

(defmethod set-default-size-and-position ((view simple-view) &optional container)
  (or (view-size view)
      (setf (slot-value view 'view-size)
            (view-default-size view)))
  (or (view-position view)
      (progn
        (when (not container)(setq container (view-container view)))
        (when container
          (setf (slot-value view 'view-position)
                (view-find-vacant-position container view))))))

(defmethod install-view-in-window ((dialog-item dialog-item) dialog &aux ok)
  (declare (ignore dialog))
  (without-interrupts
   (unwind-protect
     (let ((container (view-container dialog-item)))
       (set-default-size-and-position dialog-item container)
       (set-part-color-loop dialog-item (part-color-list dialog-item))
       (unless (dialog-item-enabled-p dialog-item)
         (dialog-item-disable dialog-item))
       (setq ok t))
     (unless ok
       (set-view-container dialog-item nil))))
  nil)

(defmethod remove-view-from-window ((dialog-item dialog-item))
  )

(defmethod dialog-item-action ((item dialog-item))
  (let ((f (dialog-item-action-function item)))
    (when f
      (funcall f item))))

(defmethod dialog-item-action-p ((item dialog-item))
  (or (dialog-item-action-function item)
      (neq (find-1st-arg-combined-method #'dialog-item-action item)
           (method-function (reference-method dialog-item-action (dialog-item))))))
      
(defmethod view-default-size ((dialog-item dialog-item))
  (multiple-value-bind (ff ms)(view-font-codes dialog-item)
    (let* ((text (dialog-item-text dialog-item)))
      (let (string-width  nlines)        
        (multiple-value-setq (string-width nlines) 
          (if (and #|(osx-p)|#(typep dialog-item 'control-dialog-item))
            (font-codes-string-width-with-eol-for-control text ff ms)
            (font-codes-string-width-with-eol text ff ms)))
        (make-point (+ (dialog-item-width-correction dialog-item) string-width)
                    (* nlines (font-codes-line-height ff ms)))))))

#|
(defmethod view-default-size ((dialog-item static-text-dialog-item))
  (multiple-value-bind (ff ms)(view-font-codes dialog-item)
    (let* ((text (dialog-item-text dialog-item))
           (back (getf (part-color-list dialog-item) :body nil)))
      (declare (ignore-if-unused back))
      (multiple-value-bind (string-width nlines)
        (if (and nil #|(osx-p)|# (null back)(and (view-window dialog-item)(theme-background-p dialog-item))) ;; ugh - needs to be in window
          (font-codes-string-width-with-eol-for-control text ff ms)
          (font-codes-string-width-with-eol text ff ms))      
        (make-point (+ (dialog-item-width-correction dialog-item) string-width)
                    (* nlines (font-codes-line-height ff ms)))))))
|#

(defmethod view-default-size ((dialog-item static-text-dialog-item))
  (multiple-value-bind (ff ms)(view-font-codes dialog-item)
    (let* ((text (dialog-item-text dialog-item)))
      (multiple-value-bind (string-width nlines)
                           (font-codes-string-width-with-eol text ff ms)
        (make-point (+ (dialog-item-width-correction dialog-item) string-width)
                    (* nlines (font-codes-line-height ff ms)))))))

#+IGNORE
(defun stupid-theme-font-codes (ff ms)
  ;(declare (ignore ff))
  (let ((stupid (if (> (logand ms #xffff) 10) #$kthemesystemfont
                    (if (eq (ash (logand ff #xffff) -8) 1) ;; aka bold
                      #$kThemeSmallemphasizedSystemFont  ;; boy is that ugly
                      #$kThemeSmallSystemFont))))
    (rlet ((fontname :str255)
           (fontsize :unsigned-word)
           (fontface :byte))
      (#_getthemefont stupid *system-script* fontname fontsize fontface)
      
      (let ((spec (if (eq (%get-byte fontface) (cdr (assoc :bold *style-alist*)))
                    (list (%get-string fontname)(%get-word fontsize) :bold)
                    (list (%get-string fontname)(%get-word fontsize)))))
        ;(declare (dynamic-extent spec))
        (font-codes spec)))))

#|

; Can't use the smart sizer, because the ROM truncates at word boundaries.
(defmethod set-view-size ((item dialog-item) h &optional v)
  (invalidate-resized-view-border item (make-point h v))
  (call-next-method))
|#

(defmethod set-view-size ((item dialog-item) h &optional v)
  ;(declare (ignore h v))
  (unless (eql (make-point h v)(view-size item))
    (with-focused-dialog-item (item)
      (without-interrupts
       (let ((w (view-window item)))
         (when w
           (invalidate-view item t)
           #+ignore ;; both invalidate without erase and erase now seems to make more things happy
           (when (and (not (theme-background-p w))(slot-value w 'back-color))
             (multiple-value-bind (tl br)(view-corners item)          
               (with-back-color (slot-value w 'back-color)
                 (rlet ((rect :rect :topleft tl :botright br))          
                   (#_eraserect rect))))))
         (call-next-method)
         (invalidate-view item t))))))

(defmethod set-view-position ((item dialog-item) h &optional v)
  ;(declare (ignore h v))
  (unless (eql (make-point h v)(view-position item))
    (with-focused-dialog-item (item)
      (without-interrupts
       (let ((w (view-window item)))
         (when w
           (invalidate-view item t)
           #+ignore ; t above fixes moving 3d-button in backtrace window - next-method for simple-view does the erase
           (multiple-value-bind (tl br)(view-corners item)          
             (with-back-color (or (slot-value w 'back-color)
                                  (if (theme-background-p w) *tool-back-color*))
               (rlet ((rect :rect :topleft tl :botright br))          
                 (#_eraserect rect)))))
         (call-next-method)
         (invalidate-view item t))))))
              

(defmethod dialog-item-disable ((dialog-item dialog-item))
  (without-interrupts
   (when (dialog-item-enabled-p dialog-item)
     (setf (dialog-item-enabled-p dialog-item) nil)
     (invalidate-view dialog-item))))

(defmethod dialog-item-enable ((dialog-item dialog-item))
  (without-interrupts
   (unless (dialog-item-enabled-p dialog-item)
     (setf (dialog-item-enabled-p dialog-item) t)
     (invalidate-view dialog-item))))

(defmethod set-dialog-item-enabled-p ((item dialog-item) enabled-p)
  (unless (eq (not enabled-p)
              (not (dialog-item-enabled-p item)))
    (if enabled-p
      (dialog-item-enable  item)
      (dialog-item-disable item))))

(defmethod view-click-event-handler ((dialog-item dialog-item) where)
  (declare (ignore where))
  (dialog-item-action dialog-item))

;Maybe all views should do this..
(defmethod set-view-font :after ((dialog-item dialog-item) font-spec)
  (declare (ignore font-spec))
  (invalidate-view dialog-item))

;;;Control dialog items

(defmethod install-view-in-window :before ((dialog-item control-dialog-item) dialog)  
  (set-default-size-and-position dialog-item (view-container dialog-item))
  (when (not (typep dialog-item 'scroll-bar-dialog-item))  ;; done in after method
    (unless (dialog-item-handle dialog-item)  ;; some prior method may have already created it
      (with-pstrs ((sp (dialog-item-text dialog-item)))
        (with-item-rect (rect dialog-item)
          (setf (dialog-item-handle dialog-item)
                (#_NewControl 
                 (wptr dialog) 
                 rect 
                 sp
                 nil
                 0
                 0 
                 1
                 (control-dialog-item-procid dialog-item)             
                 0)))
        (let ((text (dialog-item-text dialog-item)))
          (if (not (7bit-ascii-p text))
            (set-control-title-cfstring dialog-item text)))
        (unless (slot-value dialog-item 'dialog-item-enabled-p)
          ;sync up what we believe with what the mac believes.
          (#_deactivatecontrol (dialog-item-handle dialog-item)) ;(#_HiliteControl (dialog-item-handle dialog-item) 255)))))
          )))))

(defmethod set-view-position ((item control-dialog-item) h &optional v
                              &aux (new-pos (make-point h v)))
  (unless (eql new-pos (view-position item))
    (without-interrupts
     (invalidate-view item t)
     (setf (slot-value item 'view-position) new-pos)
     (when (installed-item-p item)
       (with-focused-view (view-container item)
         (let* ((handle (dialog-item-handle item)))           
           (#_MoveControl handle (point-h new-pos) (point-v new-pos))
           (validate-control-dialog-item item)
           (invalidate-view item))))))
  new-pos)

(defmethod validate-control-dialog-item ((item control-dialog-item))
  (validate-corners item #@(0 0) (view-size item)))

; ROM redraw doesn't erase between the round-rect and the view borders
#-carbon-compat
(defmethod validate-control-dialog-item ((item button-dialog-item))
  (let ((wptr (wptr item))
        (container (view-container item))
        (handle (dialog-item-handle item)))
    (when (and wptr container)
      (with-focused-view (view-container item)
        (with-macptrs ((rgn (#_NewRgn))
                       (rgnSave (rref wptr :windowrecord.rgnSave)))
          (rset wptr :windowrecord.rgnSave (%null-ptr))
          (#_OpenRgn)
          (#_Draw1Control handle)
          (#_CloseRgn rgn)
          (rset wptr :windowrecord.rgnSave rgnSave)
          (validate-region container rgn)
          (#_DisposeRgn rgn))))))

#+carbon-compat
;; I dunno what rgnsave is - well it's a thing for #_openrgn, #_closergn  - below doesn't seem to work - pukes in validate-corners - better now
(defmethod validate-control-dialog-item ((item button-dialog-item))
  (when (and (wptr item)(view-container item)(view-size item))
    (call-next-method)))

(defmethod invalidate-view ((item button-dialog-item) &optional erase-p)
  (if erase-p
    (call-next-method)
    (without-interrupts
      (call-next-method item t)
      (validate-control-dialog-item item)
      (call-next-method))))
            
(defmethod set-view-size ((item control-dialog-item) h &optional v
                                 &aux
                                 (new-size (make-point h v)))
  (unless (eql new-size (view-size item))
    (without-interrupts
     (let ((size (view-size item)))
       (when (and size (view-position item))
         (invalidate-corners item #@(0 0) size)))
     (call-next-method)
     (when (installed-item-p item)
       (with-focused-view (view-container item)
         (let* ((handle (dialog-item-handle item)))
           (invalidate-view item t)           
           (#_SizeControl handle (point-h new-size)(point-v new-size))
           ;; (validate-control-dialog-item item)   ; remove erase region - no dont <<
           (invalidate-view item)
           )))))
  new-size)

(defmethod remove-view-from-window :after ((item control-dialog-item))
  (declare (special handle->dialog-item)) ; defined elsewhere
  (let ((my-dialog (view-window item)))
    (when my-dialog
      (let ((handle (dialog-item-handle item)))
        (when handle
          (with-focused-view (view-container item)
            (#_DisposeControl handle)
            (setf (dialog-item-handle item) nil)
            (when handle->dialog-item
              (remhash handle handle->dialog-item))))))))


(defmethod dialog-item-disable ((item control-dialog-item))
  (when (and (installed-item-p item) (dialog-item-enabled-p item))
    (with-focused-dialog-item (item)
      (#_deactivatecontrol (dialog-item-handle item)))) ;(#_HiliteControl (dialog-item-handle item) 255)))
  (setf (dialog-item-enabled-p item) nil))


        
(defmethod dialog-item-enable ((item control-dialog-item))
  (when (and (installed-item-p item) (not (dialog-item-enabled-p item)))
    (with-focused-dialog-item (item)
      (#_activatecontrol (dialog-item-handle item)))) ;(#_HiliteControl (dialog-item-handle item) 0)))
  (setf (dialog-item-enabled-p item) t))

(defmethod view-activate-event-handler ((item control-dialog-item))
  (when (and (wptr item) (dialog-item-enabled-p item))
    (when t ;(not (or (part-color item :body)(part-color item :text)))
      (#_activatecontrol (dialog-item-handle item)))
    (when  (or (part-color item :frame))
      (view-draw-contents item))))

(defmethod view-deactivate-event-handler ((item control-dialog-item))
  (when (and (wptr item))
    (when t ;(not (or (part-color item :body)(part-color item :text)))
      (#_deactivatecontrol (dialog-item-handle item)))))


(defmethod (setf dialog-item-enabled-p) (p (item button-dialog-item))
  (unless (if (prog1
                (dialog-item-enabled-p item)
                (call-next-method))
            p
            (not p))
    (maybe-draw-default-button-outline item))
  p)



(defmethod view-draw-contents ((item control-dialog-item))
  (when (installed-item-p item)
    (let ((handle (dialog-item-handle item)))
      (when handle
        (if (#_iscontrolvisible handle)
          (#_Draw1Control handle)
          (#_ShowControl handle))))))

(defmethod view-convert-coordinates-and-click ((item dialog-item) where container)
  (when (dialog-item-enabled-p item)
    (with-focused-dialog-item (item container)
      (view-click-event-handler item where))))

(defmethod view-click-event-handler ((item control-dialog-item) where
                                     &aux ok)
  (let ((handle (dialog-item-handle item)))
    (setq ok (#_TrackControl handle where (%null-ptr))))
  (if (neq ok 0) (dialog-item-action item)))

;;;Button dialog items
;;;default-button dialog-items

#|  ;; its in color-dialog-items
(defmethod view-click-event-handler ((item button-dialog-item) where
                                     &aux ok)
  (let ((handle (dialog-item-handle item)))
    (setq ok (#_TrackControl handle where (%null-ptr))))
  (when (dont-throb item)(maybe-draw-default-button-outline item))
  (if (neq ok 0) (dialog-item-action item)))
|#


#|
(defmethod view-corners ((item button-dialog-item))
  (if (osx-p)
    (let ((rgn ccl::*temp-rgn-3*))
      (#_getcontrolregion (ccl::dialog-item-handle item) #$kControlStructureMetaPart rgn)
      (multiple-value-bind (tl br) (ccl::get-region-bounds-tlbr rgn)        
        (values tl br)))
    (IF (default-button-p item)
      (multiple-value-call #'inset-corners #@(-4 -4) (call-next-method))
      (call-next-method))))
|#

(defmethod view-corners ((item button-dialog-item))
  (if t ;(osx-p)
    (multiple-value-call #'inset-corners #@(-1 -1) (call-next-method))
    (IF (default-button-p item)
      (multiple-value-call #'inset-corners #@(-4 -4) (call-next-method))
      (call-next-method))))



(defmethod initialize-instance ((item button-dialog-item) &key (border-p t))
  (call-next-method)
  (unless border-p
    (setf (view-get item 'no-border) t)))

(defmethod clip-inside-view ((item simple-view) &optional (h #@(1 1)) v)
  (let* ((p (make-point h v))
         (ul (view-position item))
         (size (view-size item))
         lr)
    (when (and ul size)
      (psetq ul (add-points ul p)
             lr (subtract-points (add-points ul size) p))
      (rlet ((rect :rect :topleft ul :bottomright lr))
        (#_ClipRect rect)))))

#| ; Clipping done now by call-with-focused-dialog-item
(defmethod view-click-event-handler ((item button-dialog-item) where)
  (declare (ignore where))
  (when (view-get item 'no-border)
    (clip-inside-view item 2 2))
  (call-next-method))
|#

(defmethod view-draw-contents :before ((item button-dialog-item))
  (when (and #|(osx-p)|# (default-button-p item)(neq (view-window item)(view-container item))) ;;<<<
    (let ((handle (dialog-item-handle item)))
      (when handle
        (let ((topLeft (convert-coordinates (view-position item)(view-container item)(view-window item)))
              (control-rect-position (get-control-bounds item)))
          (unless (eql control-rect-position topleft)         
            (#_MoveControl handle (point-h topLeft) (point-v topLeft))))))))

(defun get-control-bounds (x)
  (rlet ((rect :rect))
    (#_getcontrolbounds (dialog-item-handle x) rect)
    (values (pref rect :rect.topleft)
            (pref rect :rect.botright))))

(defmethod view-draw-contents ((item button-dialog-item))
  (let ((no-border (view-get item 'no-border)))
    (if no-border
      (with-item-rect (rect item)       
        (#_eraserect rect)
        (clip-inside-view item 2 2)  ; ??? maybe not
        (call-next-method))
      (progn
        (call-next-method)
        (maybe-draw-default-button-outline item)))))

(defun maybe-draw-default-button-outline (button)
  (let ((my-dialog (view-window button)))
    (when (and my-dialog (eq button (default-button my-dialog))
               (not (view-get button 'no-border)))
      (draw-default-button-outline button))))

(defmethod draw-default-button-outline ((item button-dialog-item))
  ;; under osx it throbs and pulsates vs having a border - ain't that just too gross
  (flet ((do-it (item)    
           (when (installed-item-p item)
             (with-focused-dialog-item (item)
               (let ((grayp (not (dialog-item-enabled-p item))))
                 (with-slots (color-list) item
                   (with-fore-color (or (getf color-list :frame nil)  *light-blue-color*) ;; how do we tell if user changed to "graphite"?
                     (without-interrupts
                      (with-item-rect (rect item)
                        (#_insetRect rect -4 -4)
                        (rlet ((ps :penstate))
                          (#_GetPenState ps)
                          (#_PenSize 3 3)
                          (when grayp
                            (#_PenPat *gray-pattern*))
                          (#_FrameRoundRect rect 16 16)
                          (#_SetPenState ps)))))))))))
    #-CARBON-COMPAT (DO-IT item)
    #+CARBON-COMPAT
    ;; horrid workaround for osx crock(s)
    (when (dont-throb item) ;(and (osx-p)(neq (view-window item)(view-container item)))
      (do-it item))))

(defun theme-color ()  ;; here is how - what a lousy interface
  (rlet ((what :ptr))
    (errchk (#_copythemeidentifier what))
    (let* ((cfstr-ptr (%get-ptr what))
           (str (get-cfstr cfstr-ptr)))
      (#_cfrelease cfstr-ptr) ; ??
      (if (or (string= str "com.apple.theme.appearance.platinum") ;; os-9
              (string= str "com.apple.theme.appearance.aqua.graphite")) ;; os-x
        :platinum
        :blue))))



(defmethod dont-throb ((item button-dialog-item))
  (and t ;(osx-p)       
       (or
        ;(neq (view-window item)(view-container item))
        (part-color item :text)
        (part-color item :body)        
        #+ignore ;; font seems to work - oops no it doesn't
        (and (default-button-p item)
             (or (neq (view-window item)(view-container item))
                 #+ignore
                 (multiple-value-bind (ff ms)(view-font-codes item)
                   (declare (ignore-if-unused ms))
                   (multiple-value-bind (sys-ff sys-ms)(sys-font-codes)
                     (declare (ignore-if-unused sys-ms))
                     (or (not (eql ff sys-ff))
                         #+ignore
                         (not (eql ms sys-ms)))))))
        )))
        

;;;Check Box dialog items

#|
(defmethod view-default-size ((item check-box-dialog-item))
  (let ((size (call-next-method)))
    ;; required h fudge seems to depend on length of dialog-item-text - maybe font too - maybe fixed now
    (make-point (+ (if (osx-p) 4 0)(point-h size)) (max 12 (+ (if (osx-p) 4 0)(point-v size))))))
|#

(defmethod view-default-size ((item check-box-dialog-item))
  (let ((size (call-next-method)))
    ;; required h fudge seems to depend on length of dialog-item-text - maybe font too - maybe fixed now
    (make-point (point-h size) (max 16 (point-v size)))))

(defmethod install-view-in-window :after ((item check-box-dialog-item) dialog)
  (declare (ignore dialog))
  (if (check-box-checked-p item) (check-box-check item)))

(defmethod dialog-item-action ((item check-box-dialog-item))
  (if (check-box-checked-p item)
      (check-box-uncheck item)
      (check-box-check item))
  (call-next-method))                   ; dispatch to user's dialog-item-action code

(defmethod check-box-check ((item check-box-dialog-item))
  (setf (check-box-checked-p item) t)
  (when (installed-item-p item)
    (with-focused-view (view-container item)
      (#_SetControlValue (dialog-item-handle item) 1))))

(defmethod check-box-uncheck ((item check-box-dialog-item))
  (setf (check-box-checked-p item) nil)
  (when (installed-item-p item)
    (with-focused-view (view-container item)
      (#_SetControlValue (dialog-item-handle item) 0))))

;;;Radio Button dialog items

(defmethod view-default-size ((item radio-button-dialog-item))
  (let ((size (call-next-method)))
    (make-point (point-h size) (max 16 (point-v size)))))

(defmethod install-view-in-window ((item radio-button-dialog-item) dialog
                               &aux (first t))
  (declare (ignore dialog))
  (without-interrupts
   (let ((cluster (radio-button-cluster item))
         (container (view-container item)))
     (do-dialog-items (other-item container 'radio-button-dialog-item)
       (if (and (neq item other-item)
                (eq cluster (radio-button-cluster other-item)))
         (return (setq first nil)))))
   (call-next-method) ;this is failing to do it upon return
   (if (or first (radio-button-pushed-p item)) (radio-button-push item))))

(defmethod dialog-item-action ((item radio-button-dialog-item))
  (radio-button-push item)
  (call-next-method))                   ; dispatch to user's dialog-item-action code.

(defmethod radio-button-push ((item radio-button-dialog-item)
                              &aux (cluster (radio-button-cluster item)))
  (let ((my-container (view-container item))
        (handle (dialog-item-handle item)))
    (when my-container
      (do-dialog-items (other-item my-container 'radio-button-dialog-item)
        (if (neq other-item item)
          (if (eq (radio-button-cluster other-item) cluster)
            (radio-button-unpush other-item))))
      (when (and handle (installed-item-p item))
        (with-focused-dialog-item (item my-container)
          (#_SetControlValue (dialog-item-handle item) 1))))
    (setf (radio-button-pushed-p item) t)))

(defmethod radio-button-unpush ((item radio-button-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (when (and handle (installed-item-p item))
      (with-focused-dialog-item (item)
        (#_SetControlValue (dialog-item-handle item) 0))))
  (setf (radio-button-pushed-p item) nil))

  ;;;Static Text dialog items

#|
(defmethod install-view-in-window :before ((item static-text-dialog-item) dialog)
  (declare (ignore dialog))
  ;(setf (dialog-item-handle item) (%str-to-handle (dialog-item-text item)))
  ;(setf (slot-value item 'dialog-item-text) nil)
  )
|#

#|
(defmethod remove-view-from-window :after ((item static-text-dialog-item))
  (let ((h (dialog-item-handle item)))       
    (when nil ; h
        (setf (slot-value item 'dialog-item-text)(dialog-item-text item)))
    (setf (dialog-item-handle item) nil)
    (when h (#_DisposeHandle :errchk h))))
|#

(defmethod set-dialog-item-text ((item static-text-dialog-item) text)
  (setq text (ensure-simple-string text))  
  (setf (slot-value item 'dialog-item-text) text)
  (invalidate-view item t)  
  text)

#|
; Otherwise, we get holes on double resize
(defmethod set-view-size ((item static-text-dialog-item) h &optional v
                          &aux (new-size (make-point h v)))
  (unless (eql (view-size item) new-size)
    (invalidate-view item t)
    (call-next-method)
    (invalidate-view item))
  new-size)
|#

(defmethod dialog-item-text ((item static-text-dialog-item))
  (let ((text (slot-value item 'dialog-item-text)))    
    text))

(defmethod view-activate-event-handler ((item static-text-dialog-item))
  (setf (dialog-item-enabled-p item) t)
  (invalidate-view item))

(defmethod view-deactivate-event-handler ((item static-text-dialog-item))
  (setf (dialog-item-enabled-p item) nil)
  (invalidate-view item))




#|
(defmethod view-draw-contents ((item static-text-dialog-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (let ((position (view-position item))
            (size (view-size item))
            (text-justification (slot-value item 'text-justification))
            (truncation (slot-value item 'text-truncation))
            (enabled-p (dialog-item-enabled-p item)))
        (rlet ((rect :rect :topleft position :botright (add-points position size) ))          
          (let ((back (part-color item :body))
                (fore (part-color item :text)))
            (with-fore-and-back-color fore back
              (when t (#_eraserect rect))  ;; was when back
              (draw-theme-text-box (dialog-item-text item) rect text-justification truncation enabled-p)))
          )))))
|#

(defmethod view-draw-contents ((item static-text-dialog-item))
  (when (installed-item-p item)
    (without-interrupts
     (with-focused-view (view-container item)
       (let ((position (view-position item))
             (size (view-size item))
             (text-justification (slot-value item 'text-justification))
             (truncation (slot-value item 'text-truncation))
             (enabled-p (dialog-item-enabled-p item))
             (compress-p (compress-text item))
             (old-state nil))
         (rlet ((rect :rect :topleft position :botright (add-points position size) ))
           (let* ((theme-back (theme-background-p item))
                  (back (or (part-color item :body)
                            (if (not theme-back) (slot-value (view-window item) 'back-color))))                          
                  (fore (if enabled-p (part-color item :text) *gray-color*)))
             (when (and (not back) theme-back) ; (not (dialog-item-enabled-p item)))  ;; sometimes background goes white??
               (rlet ((old-statep :ptr))
                 (#_getthemedrawingstate old-statep)
                 (setq old-state (%get-ptr old-statep)))
               (let* ((wptr (wptr item))
                      (depth (current-pixel-depth)))
                 (#_setthemebackground  #$kThemeBrushModelessDialogBackgroundActive depth (wptr-color-p wptr))))
             (with-back-color back
               (multiple-value-bind (ff ms)(view-font-codes item)
                 (when t (#_eraserect rect))  ;; or when back?
                 (draw-string-in-rect (dialog-item-text item) rect 
                                      :justification text-justification
                                      :compress-p compress-p
                                      :truncation truncation
                                      :ff ff :ms ms :color fore)))
             (if old-state (#_setthemedrawingstate old-state t))
             )))))))

#|
(setq *w* (make-instance 'window))

(setq foo (make-instance 'static-text-dialog-item 
            :dialog-item-text "asdf
qwerty
asdf
0
0"
            :text-justification :center
            :part-color-list `(:body ,*yellow-color*)
            :view-container *w*
            :view-size #@(53 120)))

(setq bar (make-instance 'ellipsized-text-dialog-item 
            :dialog-item-text "asdfqwert"
            :text-justification :left
            :view-container *w*
            :view-font '("geneva" 12 :italic)
            :view-size #@(53 120)))


|#

#|
(setq *w* (make-instance 'window))
(setq st (make-instance 'fred-dialog-item
           :dialog-item-text "Virus
disease"
           :view-container *w*
           :part-color-list `(:text ,*red-color* :body ,*yellow-color*)
           :view-font '("monaco" 12 :bold)
           :view-size #@(100 50)))
|#

;;;;;;;;;; 
;; draw-theme-text-box
 ;; moved from pop-up-menu.lisp

(defun current-pixel-depth ()
  (with-port-macptr port
    (with-macptrs ((portpixmap (#_getportpixmap port)))
      (href portpixmap :pixmap.pixelsize))))

(defun current-port-color-p ()
  (with-port-macptr port
    (#_isportcolor port)))


(export 'draw-theme-text-box :ccl)

(defun draw-theme-text-box (text rect &optional (text-justification :center) truncwhere (active-p t))
  ;; could add a truncate option and use TruncateThemeText
  (let ((start 0) 
        (end (length text)))
    (when (not (simple-string-p text))
      (multiple-value-setq (text start end)(string-start-end text start end)))
    (when (not (fixnump text-justification))
      (setq text-justification
            (case text-justification
              (:center #$tejustcenter)
              (:left #$tejustleft)
              (:right #$tejustright)
              (t #$tejustcenter))))
    (with-theme-state-preserved
      (when (not active-p)  ;; let it have it's own color if active
        (#_SetThemeTextColor #$kThemeTextColorDialogInactive
         (current-pixel-depth) (current-port-color-p)))
      (let ((len (- end start)))
        (%stack-block ((the-chars (%i+ len len)))
          (copy-string-to-ptr text start len the-chars)          
          (if (not truncwhere)
            (with-macptrs ((cfstr (#_CFStringCreatewithcharacters (%null-ptr) the-chars len))) 
              (#_Drawthemetextbox cfstr #$kThemeCurrentPortFont #$Kthemestateactive t rect text-justification (%null-ptr))
              (#_CFRelease cfstr))
            (progn
              (setq truncwhere
                    (case truncwhere
                      (:end #$truncend)
                      (:middle #$truncmiddle)
                      (t #$truncend)))              
              (with-macptrs ((cfstr (#_CFStringCreateMutable (%null-ptr) 0)))
                (#_CFStringAppendCharacters cfstr the-chars len)                
                (unwind-protect
                  (progn
                    (rlet ((foo :boolean))
                      (errchk (#_TruncateThemeText cfstr #$kThemeCurrentPortFont #$Kthemestateactive
                               (- (pref rect :rect.right)(pref rect :rect.left))
                               truncwhere
                               foo)))
                    (#_DrawThemetextbox cfstr #$kThemeCurrentPortFont #$Kthemestateactive t rect text-justification (%null-ptr)))
                  (#_cfrelease cfstr))))))))))



          
;;;Editable Text dialog items

;; fix for (make-instance 'fred-dialog-item :view-container w) - need frec etal before set-view-container
(defmethod initialize-instance :around ((item fred-dialog-item)  &rest args &key view-container )
  (declare (dynamic-extent args))
  (if (not view-container)
    (call-next-method)
    (progn
      (apply #'call-next-method item :view-container nil args)
      (set-view-container item view-container))))

(defmethod initialize-instance :after  ((item fred-dialog-item) &key 
                                buffer filename dialog-item-text (margin 1)
                                (view-font (view-default-font item)))
  (when view-font (set-view-font item view-font))
  (let ((color (part-color item :text)))
    (when color 
      (let ((ff-color (color->ff-index color)))
        (multiple-value-bind (ff ms)(view-font-codes item)
          (set-view-font-codes item (logior ff ff-color) ms)))))        
  (let ((frec (frec item)))
    (setf (fr.margin frec) margin            ; Just room for the selection box
          (fr.hpos frec) margin))
  (when (or (and (null buffer)(null filename)) dialog-item-text)
    (let* ((text (slot-value item 'dialog-item-text))
           (buf (fred-buffer item)))
      ;(buffer-delete buf (buffer-size buf) 0)
      (when text
        (buffer-insert-substring buf text 0 (length text)))))
  (setf (slot-value item 'dialog-item-text) nil))

#|
(defmethod install-view-in-window :before ((item basic-editable-text-dialog-item) dialog)
  (declare (ignore dialog))
  (multiple-value-bind (ff ms) (view-font-codes item)
    (multiple-value-bind (ascent descent widmax leading) 
                         (font-codes-info ff ms)
      (declare (ignore widmax))
      (setf (slot-value item 'line-height) (+ ascent descent leading)
            (slot-value item 'font-ascent) ascent))))
|#

(defmethod set-default-size-and-position ((item fred-dialog-item) &optional container)
  (declare (ignore container))
  (let ((size (view-size item)))    
    (call-next-method)
    (unless (eql size (setq size (view-size item)))
      (with-focused-view item
        (frec-set-size (frec item) size)))))

(defmethod install-view-in-window :after ((item key-handler-mixin) dialog)
  (add-key-handler item dialog))

(defmethod view-key-event-handler ((item simple-view) key)
  (declare (ignore key))
  (ed-beep))

(defmethod add-key-handler ((item simple-view) &optional (dialog (view-window item)))
  (let* ((items (%get-key-handler-list dialog)))
    (unless (memq item items)
      (setf (%get-key-handler-list dialog)
            (nconc items (list item)))))
  (when (key-handler-p item)
    (unless (current-key-handler dialog)
      (set-current-key-handler dialog item))))

(defmethod remove-view-from-window :before ((item key-handler-mixin))
  (remove-key-handler item))

(defmethod remove-key-handler ((item simple-view) &optional (dialog (view-window item)))
  (without-interrupts
   (when dialog
     (when (eq item (%get-current-key-handler dialog))
       (change-key-handler dialog)
       (when (eq item (%get-current-key-handler dialog)) ;still current, so only one
         (set-current-key-handler dialog nil)
         ;(setf (%get-current-key-handler dialog) nil)
         ))
     (setf (%get-key-handler-list dialog)
           (delq item (%get-key-handler-list dialog))))))

; It's ridiculous to change the buffer into a string for a fred-dialog-item
; some of these are going to be huge.
#|
(defmethod remove-view-from-window ((item fred-dialog-item))
  )
|#

(defmethod view-default-size ((item basic-editable-text-dialog-item)
                              &aux pt width)
  (setq pt (call-next-method))
  (setq width (point-h pt))
  (make-point (%i- (%ilsl 1 width) (%ilsr 1 width)) (point-v pt)))

#|
(defmethod set-view-font-codes :before ((item fred-dialog-item) ff ms &optional
                                        ff-mask ms-mask)
  (declare (ignore ff-mask ms-mask))
  (let* ((buf (fred-buffer item))
         (size (buffer-size buf)))
    (buffer-set-font-codes buf ff ms 0 size)   ; change the text
    (buffer-set-font-codes buf ff ms)))   ; change the insertion font
|#


(defmethod view-convert-coordinates-and-click ((item fred-dialog-item) where container)
  (view-click-event-handler item (convert-coordinates where container item)))

(defmacro with-text-colors (item &body body)
  (let ((item-var (gensym)))
    `(let ((,item-var ,item))
       (with-fore-and-back-color (part-color ,item-var :text)
                                 (or (part-color ,item-var :body) *white-color*)
         ,@body))))




(defmethod view-click-event-handler ((item fred-dialog-item) where)
  (declare (ignore where))
  (when (dialog-item-enabled-p item)
    (call-next-method)))
    
(defmethod view-activate-event-handler ((item fred-dialog-item))
  (when (eq item (current-key-handler (view-window item)))
    (call-next-method)))

; view-deactivate-event-handler for fred-dialog-item uses the one for fred-mixin.

(defmethod dialog-item-disable :before ((item basic-editable-text-dialog-item))
  (let ((my-dialog (view-window item)))
    (when my-dialog
      (when (eq item (current-key-handler my-dialog))
        (change-key-handler my-dialog))
      (when (eq item (current-key-handler my-dialog)) ;still current, so only one
        (set-selection-range item 0 0)
        (setf (%get-current-key-handler my-dialog) nil)))))

(defmethod dialog-item-disable :before ((item key-handler-mixin))
  (let ((my-dialog (view-window item)))
    (when my-dialog
      (when (eq item (current-key-handler my-dialog))
        (change-key-handler my-dialog))
      (when (eq item (current-key-handler my-dialog)) ;still current, so only one
        (setf (%get-current-key-handler my-dialog) nil)))))

(defmethod dialog-item-enable :after ((item key-handler-mixin)) ;; was basic-editable-text-dialog-item
  (let ((my-dialog (view-window item)))
    (when my-dialog
      (unless (current-key-handler my-dialog)
        (when (and (memq item (%get-key-handler-list my-dialog))
                   (key-handler-p item))
          (set-current-key-handler my-dialog item))))))

;; HUH?
(defmethod dialog-item-disable :before ((item fred-dialog-item))
  (when (dialog-item-enabled-p item)
    (set-selection-range item 0 0)
    (view-deactivate-event-handler item)))


#| ; if disabled, can't be current-key-handler - so let key-handler-mixin do it
(defmethod view-cursor ((item fred-dialog-item) where)
  (declare (ignore where))
  (if (dialog-item-enabled-p item)
    (call-next-method)
    *arrow-cursor*))
|#

; Is an around method to avoid the after method for dialog item
; which invalidates the border as well as the contents.

(defmethod set-dialog-item-text :around ((item fred-dialog-item) text)
  (setq text (ensure-simple-string text))
  (if (slot-value item 'dialog-item-text)
    (setf (slot-value item 'dialog-item-text) text)
    (let ((buf (fred-buffer item)))
      (buffer-delete buf (buffer-size buf) 0)
      (buffer-insert-substring buf text)))
  (let ((container (view-container item)))
    (when (and container (wptr item))
      (let ((pos (view-position item)))
        (invalidate-corners container pos (add-points pos (view-size item))))))
  text)
    
(defmethod dialog-item-text ((item fred-dialog-item))
  (or (slot-value item 'dialog-item-text)
      (let ((buf (fred-buffer item)))
        (buffer-substring buf (buffer-size buf) 0))))


(defmethod set-view-size ((item focus-rect-mixin) h &optional v)
  (let ((pt (make-point h v)))
    (unless (eql pt (view-size item))
      (with-focused-view (view-container item)
        (erase-focus-rect item)
        (call-next-method)
        (when (wptr item)(frame-key-handler item))))))

(defmethod erase-focus-rect ((item focus-rect-mixin))
  (when (wptr item)
    (let ((w (view-window item))
          (pos (view-position item)))
      (rlet ((rect :rect :topleft pos :bottomright (add-points pos (view-size item))))
        (draw-nil-theme-focus-rect w rect))
      )))

(defmethod set-view-position ((item focus-rect-mixin) h &optional v)
  (let ((pt (make-point h v)))
    (unless (eql pt (view-position item))
      (with-focused-view (view-container item)    
        (erase-focus-rect item)
        (call-next-method)
        (when (wptr item)
          (frame-key-handler item))))))


(defmethod view-activate-event-handler :after  ((item focus-rect-mixin))
  ;(if t (invalidate-view item))
  (frame-key-handler item))

(defmethod view-deactivate-event-handler :after ((item focus-rect-mixin))
  ;(if t (invalidate-view item))
  (frame-key-handler item))


(defmethod view-draw-contents ((item fred-dialog-item))
  (unless (view-quieted-p item)
    (let* ((enabled-p (dialog-item-enabled-p item))
           (colorp (color-or-gray-p item)))
      (with-focused-view item
        (with-fore-color (if (and colorp (not enabled-p))
                           *gray-color*
                           (part-color item :text))
          (with-back-color (part-color item :body)              
            (frec-draw-contents (frec item))
            ))))))


(defmethod part-color ((item fred-dialog-item) key)
  (or (getf (slot-value item 'color-list) key nil)
      (case key (:body *white-color*))))



; This is called by all the editor commands.
(defmethod fred-update ((item fred-dialog-item))
  (unless (or (view-quieted-p item) (not (wptr item)))
    (call-next-method))
  (when (wptr item)
    (let ((modcnt (buffer-modcnt (fred-buffer item))))
      (unless (eq modcnt (view-get item 'action-modcnt)) ; what is this
        ; formerly the action was invoked within with-focused-view - now it isn't - that may be bad
        (setf (view-get item 'action-modcnt) modcnt)
        (dialog-item-action item)))))

(defmethod set-selection-range :after ((item fred-dialog-item) &optional start end)
  (declare (ignore start end))
  (with-focused-view item
    (with-text-colors item
      (frec-update (frec item)))))
#|
(defmethod view-cursor ((item key-handler-mixin) point)
  (declare (ignore point))
  *i-beam-cursor*)
|#

(defmethod view-cursor ((item key-handler-mixin) point)
  (declare (ignore point))
  (let ((w (view-window item)))
    (if (and w (eq item (current-key-handler w))) 
      *i-beam-cursor*
      *arrow-cursor*)))

	  
(defmethod enter-key-handler ((item key-handler-mixin) last-key-handler)
  (declare (ignore last-key-handler))
  nil)

(defmethod exit-key-handler ((item key-handler-mixin) next-key-handler)
  (declare (ignore next-key-handler))
  t)

#|
;example of using exit and enter hook
(defclass quux (editable-text-dialog-item) ()
  (:default-initargs :dialog-item-text "quake"))

(defmethod exit-key-handler ((quux quux) next-item)
  (declare (ignore next-item))
  (unless (equalp (dialog-item-text quux) "quake")
    (message-dialog "you changed me"))
  t)

(defmethod enter-key-handler ((quux quux) old-text)
  (unless (equalp (dialog-item-text bar)
                  "Bar None")
    (set-current-key-handler (view-window quux) old-text)))

(setq foo (make-instance 'dialog))

(add-subviews foo (setq bar (make-instance 'editable-text-dialog-item
                                               :dialog-item-text "Bar None"))
                  (make-instance 'quux))

|#

;;;User Dialog items

;;;Table Dialog items

(pushnew :new-tables *features*)

(defclass table-dialog-item
  (dialog-item)
  (;(ldef-proc-handle :allocation :class)        ; kill-lisp-pointers needs this. Kill it when you merge.
   (width-correction :allocation :class :initform 50)
   (table-max-width :accessor table-max-width
                    :allocation :class
                    :initform 300)
   (table-max-height :accessor table-max-height
                     :allocation :class
                     :initform 300)
   (rows :accessor table-rows
         :initarg :rows
         :initform 0)
   (columns :accessor table-columns
            :initarg :columns
            :initform 0)
   (top-row :accessor table-top-row
            :initform 0)
   (left-column :accessor table-left-column
                :initform 0)
   (table-vscrollp :initarg :table-vscrollp
                   :initform :undetermined
                   :reader table-vscrollp :writer (setf table-vscrollp-slot))
   (table-hscrollp :initarg :table-hscrollp
                   :initform :undetermined
                   :reader table-hscrollp :writer (setf table-hscrollp-slot))
   (table-hscroll-bar :initform nil
                      :accessor table-hscroll-bar)
   (table-vscroll-bar :initform nil
                      :accessor table-vscroll-bar)
   (grow-icon-p :accessor table-grow-icon-p
                :initarg :grow-icon-p
                :initform nil)
   (cell-fonts :accessor table-cell-fonts
               :initform nil)
   (table-print-function :initarg :table-print-function
                         :initform #'princ
                         :accessor table-print-function)
   (cell-size :reader cell-size :writer (setf cell-size-slot)
              :initarg :cell-size
              :initform nil)
   (row-heights-hash :accessor row-heights-hash
                     :initform nil)
   (column-widths-hash :accessor column-widths-hash
                     :initform nil)
   (selection-type :accessor selection-type
                   :initarg :selection-type
                   :initform :single)
   (visible-dimensions :accessor visible-dimensions-slot
                       :initarg :visible-dimensions
                       :initform nil)
   (view-active-p :accessor view-active-p
                  :initform t)
   (selection-hash :accessor table-selection-hash
                   :initform nil)
   (first-selected-cell :accessor first-selected-cell-slot
                        :initform nil)
   (font-hash :accessor table-font-hash
              :initform nil)
   (selection-region :accessor table-selection-region
                     :initform nil)
   (outline-region :accessor table-outline-region
                   :initform nil)
   (track-thumb-p :reader scroll-bar-track-thumb-p
                  :initform t
                  :initarg :track-thumb-p)
   (separator-size :accessor separator-size
                   :initform #@(0 0)
                   :initarg :separator-size)
   (separator-visible-p :accessor separator-visible-p
                        :initform t
                        :initarg :separator-visible-p)
   (separator-color :accessor separator-color
                    :initform *gray-color*
                    :initarg :separator-color)
   (separator-pattern :reader separator-pattern-slot
                      :writer (setf separator-pattern)
                      :initform '*black-pattern*
                      :initarg :separator-pattern)
   (cell-colors :accessor cell-colors
               :initform :text
               :initarg :cell-colors)
   (cell-color-hash :accessor table-cell-color-hash
               :initform nil)))

(defmethod cell-contents-string ((item table-dialog-item) cell)
  (%cell-contents-string-new item cell nil))

(defparameter *default-cell-contents-string-combined-method*
  (find-1st-arg-combined-method
   #'cell-contents-string (class-prototype (find-class 'table-dialog-item))))

; These two methods make users of the old cell-contents-string
; and draw-table-cell continue to work.
(defmethod cell-contents-string-new :around ((item table-dialog-item) h &optional v)
  (let ((cm (find-1st-arg-combined-method #'cell-contents-string item)))
    (if (eq cm *default-cell-contents-string-combined-method*)
      (call-next-method)
      (funcall cm item (make-big-point h v)))))

(defmethod draw-table-cell ((item table-dialog-item) cell rect selectedp)
  (%draw-table-cell-new item (point-h cell) (point-v cell) rect selectedp))

(defvar *default-draw-table-cell-combined-method*
  (find-1st-arg-combined-method
   #'draw-table-cell (class-prototype (find-class 'table-dialog-item))))

;; why not call this draw-table-cell-h-v 
(defmethod draw-table-cell-new :around ((item table-dialog-item) h v rect selectedp)
  (let ((cm (find-1st-arg-combined-method #'draw-table-cell item)))
    (if (eq cm *default-draw-table-cell-combined-method*)
      (call-next-method)
      (funcall cm item (make-big-point h v) rect selectedp))))

(defmacro normalize-h&v (h v)
  `(unless ,v
     (setq ,v (point-v ,h)
           ,h (point-h ,h))))

(defmacro with-temp-rgns ((&rest rgn-vars) &body body)
  `(with-macptrs ,rgn-vars
     (unwind-protect
       (progn
         ,@(mapcar #'(lambda (var) `(%setf-macptr ,var (require-trap #_NewRgn))) rgn-vars)
         ,@body)
       ,@(mapcar #'(lambda (var) `(unless (%null-ptr-p ,var) (require-trap #_DisposeRgn ,var)))
                 rgn-vars))))

(defmacro with-hilite-mode (&body body)
  `(progn
     (let ((byte (require-trap #_lmgethilitemode)))
       (require-trap #_lmsethilitemode (%ilogand2 #x7f byte)))
     ,@body))

(eval-when (:compile-toplevel :execute :load-toplevel)
(defmacro with-clip-region (region &body body)
  (let ((rgn (gensym))
        (rgn2 (gensym)))
    `(with-temp-rgns (,rgn ,rgn2)
       (require-trap #_GetClip ,rgn)
       (require-trap #_sectrgn ,rgn ,region ,rgn2)
       (unwind-protect
         (progn
           (require-trap #_SetClip ,rgn2)
           ,@body)
         (require-trap #_SetClip ,rgn)))))
)

(defmethod initialize-instance ((item table-dialog-item)
                                    &rest initargs &key
                                    (selection-type :single)
                                    (cell-colors :text)
                                    table-dimensions                                   
                                    table-print-function
                                    cell-fonts)
  (declare (dynamic-extent initargs))
  (unless (memq selection-type '(:single :contiguous :disjoint))
    (report-bad-arg selection-type '(:single :contiguous :disjoint)))
  (unless (memq cell-colors '(:text :background))
    (report-bad-arg cell-colors '(member (:text :background))))
  (if table-dimensions
    (apply #'call-next-method
           item
           :rows (point-v table-dimensions)
           :columns (point-h table-dimensions)
           :table-print-function (or table-print-function #'princ)
           initargs)
    (call-next-method))
  (when cell-fonts
    (loop
      (when (null cell-fonts) (return))
      (let ((cell (pop cell-fonts))
            (font-spec (pop cell-fonts)))
        (set-cell-font item cell font-spec)))))

(defmethod view-default-size ((item table-dialog-item))
  (let* ((max-width (table-max-width item))
         (max-height (table-max-height item)) 
         (rows (table-rows item))
         (columns (table-columns item))
         (visible-dimensions (visible-dimensions-slot item))
         (visible-rows (if visible-dimensions 
                         (point-v visible-dimensions)
                         rows))
         (visible-columns (if visible-dimensions
                            (point-h visible-dimensions)
                            columns))
         (cell-size (cell-size item))
         (table-hscrollp (table-hscrollp item))
         (table-vscrollp (table-vscrollp item))
         (top-row (table-top-row item))
         (left-column (table-left-column item))
         (bottom-row (+ top-row visible-rows))
         (right-column (+ left-column visible-columns)))
    (let (width height cell-height cell-width)
      (unless cell-size
        (setf (cell-size-slot item)
              (setq cell-size (default-cell-size item))))
      (setq cell-width (point-h cell-size)
            cell-height (point-v cell-size)
            width (* cell-width visible-columns)
            height (* cell-height visible-rows)
            ;max-width (- max-width (mod max-width cell-width))
            ;max-height (- max-height (mod max-height cell-height))
            )
      (if (> max-width cell-width)
        (setq max-width (- max-width (mod max-width cell-width)))
        (setq max-width cell-width))
      (if (> max-height cell-height)
        (setq max-height (- max-height (mod max-height cell-height)))
        (setq max-height cell-height))
      (let ((row-heights-hash (row-heights-hash item)))
        (when row-heights-hash
          (flet ((mapper (row height)
                   (when (and (<= top-row row) (< row bottom-row))
                     (incf height (- height cell-height)))))
            (declare (dynamic-extent #'mapper))
            (maphash #'mapper row-heights-hash))))
      (let ((column-widths-hash (column-widths-hash item)))
        (when column-widths-hash
          (flet ((mapper (column width)
                   (when (and (<= left-column column) (< column right-column))
                     (incf width (- width cell-width)))))
            (declare (dynamic-extent #'mapper))
            (maphash #'mapper column-widths-hash))))
      (if (eq table-hscrollp :undetermined)
        (setq table-hscrollp 
              (or (> width max-width)
                  (> columns visible-columns))))
      (if (eq table-vscrollp :undetermined)  ; dont mess with the slot
        (setq table-vscrollp
              (or (> height max-height)
                  (> rows visible-rows))))
      (make-point (+ (min width max-width) (if table-vscrollp 15 0))
                  (+ (min height max-height) (if table-hscrollp 15 0))))))

(defmethod maybe-need-scroll-bars ((table table-dialog-item) &optional installing)
  (let ((size (view-size table)))
    (when size
      (let ((h (point-h size))
            (v (point-v size))
            (container (view-container table))
            (computed-cell-size nil)
            (vscrollp (table-vscrollp table))
            (hscrollp (table-hscrollp table))
            (changed nil))
        (declare (fixnum h v))
        (when (or (eq vscrollp :undetermined)
                  (eq hscrollp :undetermined))
          (flet ((compute-cell-size ()
                   (let ((columns (table-columns table)))
                     (setf (cell-size-slot table)
                           (default-cell-size
                             table
                             (truncate h
                                       (if (zerop columns)
                                         1
                                         columns))))
                     (setq computed-cell-size t))))
            (declare (dynamic-extent #'compute-cell-size))
            (unless (cell-size table) (compute-cell-size))
            (let (undetermined-vscrollp)
              (flet ((do-vscrollp (&optional (vsp vscrollp))
                       (when (eq vsp :undetermined)
                         (setq undetermined-vscrollp t)
                         (let ((rows (table-rows table))
                               (height 0))
                           (setq vscrollp
                                 (and (> rows 1)
                                      (progn (do-row-heights (table row-height) () (incf height row-height))
                                             (> height v))))
                           ))
                       (when vscrollp
                         (decf h 15)
                         (when computed-cell-size (compute-cell-size))))
                     (do-hscrollp ()
                       (when (eq hscrollp :undetermined)
                         (let ((cols (table-columns table))
                               (width 0))
                           (setq hscrollp
                                 (and (> cols 1)
                                      (progn (do-column-widths (table column-width) () (incf width column-width))
                                             (> width h))))
                           ))
                       (when hscrollp
                         (decf v 15))))
                (do-vscrollp)
                (do-hscrollp)
                (when (and undetermined-vscrollp (not vscrollp) hscrollp)
                  (do-vscrollp :undetermined))))))
        (let ((vbar (table-vscroll-bar table))
              (hbar (table-hscroll-bar table)))
          (if vscrollp
            (when (not vbar)
              (let ((bar (make-scroll-bar-for-table table :vertical)))
                (setq changed t)
                (setf (table-vscroll-bar table) bar)))
            (when vbar
              (set-view-container vbar nil)
              (setq changed t)
              (setf (table-vscroll-bar table) nil)))
          (if hscrollp
            (when (not hbar)
              (let ((bar (make-scroll-bar-for-table table :horizontal)))
                (setq changed t)
                (setf (table-hscroll-bar table) bar)))
            (when hbar  ; maybe its not cool to remove existing bars??
              (set-view-container hbar nil) 
              (setq changed t)
              (setf (table-hscroll-bar table) nil))))
        ;; fixup-scroll-bars only does something if table installed and visible-dimensions makes sense.
        ;; - get size and pos right before set container
        (when (and changed (not installing))
          (fixup-scroll-bars table)
          (when vscrollp
            (when container (set-view-container (table-vscroll-bar table) container)))
          (when hscrollp
            (when container (set-view-container (table-hscroll-bar table) container)))
          (maybe-fix-cell-size table))          
        ;(when changed (maybe-fix-cell-size table))
        changed
        ))))

(defmethod set-view-level :after ((item table-dialog-item) level)
  (let ((hscroll (table-hscroll-bar item))
        (vscroll (table-vscroll-bar item))
        (level+1 (1+ level))
        (container (view-container item)))
    (when (and container (< level+1 (length (view-subviews container))))
      (when hscroll (set-view-level hscroll level+1))
      (when vscroll (set-view-level vscroll level+1)))))

(defmethod set-view-container :after ((item table-dialog-item) container)
  (let ((hscroll (table-hscroll-bar item))
        (vscroll (table-vscroll-bar item)))
    (when hscroll (set-view-container hscroll container))
    (when vscroll (set-view-container vscroll container))))

(defmethod (setf separator-size) :around (new-size (item table-dialog-item))
  (let ((old-size (separator-size item)))
    (prog1 (call-next-method)
      (unless (= new-size old-size)
        (setf (visible-dimensions-slot item) nil)     ; clear cache
        (when (installed-item-p item)
          (compute-selection-regions item)
          (invalidate-view item t)
          (fixup-scroll-bars item))))))

(defmethod (setf separator-visible-p) :around (value (item table-dialog-item))
  (let ((old-visible-p (separator-visible-p item)))
    (prog1
      (call-next-method)
      (unless (eq (not (null value)) (not (null old-visible-p)))
        (invalidate-view item t)
        (fixup-scroll-bars item)))))

(defmethod (setf separator-color) :around (new-color (item table-dialog-item))
  (let ((old-color (separator-color item)))
    (prog1
      (call-next-method)
       (unless (equal new-color old-color)
         (invalidate-view item t)))))

(defmethod separator-pattern ((item table-dialog-item))
  (let ((pattern (separator-pattern-slot item)))
    (cond ((macptrp pattern) pattern)
          ((symbolp pattern) (and (boundp pattern) (symbol-value pattern)))
          ((functionp pattern) (funcall pattern))
          (t nil))))

(defmethod (setf separator-pattern) :around (new-pattern (item table-dialog-item))
  (let ((old-pattern (separator-pattern item)))
    (prog1
      (call-next-method)
      (unless (equal new-pattern old-pattern)
        (invalidate-view item t)))))

(defun string-width-for-focused-control (string ff ms)
  (let ((len (length string)))
    (setq string (ensure-simple-string string))
    (%stack-block ((sb (%i+ len len)))
      (copy-string-to-ptr string 0 len sb)
      (xtext-width sb len ff ms))))
  

(defmethod default-cell-size ((item table-dialog-item) &optional width)
  (let ((my-dialog (view-container item)))
    (with-focused-dialog-item (item my-dialog)
      (multiple-value-bind (ff ms)(view-font-codes item)
        (let ((table-max-width (table-max-width item)))
          (let ((rows (table-rows item))
                (columns (table-columns item))
                (dwidth width)
                height string )
            (rlet ((fp :fontinfo))
              (#_GetFontinfo fp)
              (setq height
                    (+ (rref fp fontinfo.ascent)
                       (rref fp fontinfo.descent)
                       (rref fp fontinfo.leading))))
            (unless dwidth
              (setq dwidth 1)
              (dotimes (h columns)
	        (declare (fixnum h))
                (dotimes (v rows)
	          (declare (fixnum v))
                  (setq string (cell-contents-string-new item h v))
                  (setq dwidth (max dwidth (string-width-for-focused-control string ff ms)))))
              (setq dwidth (min (+ dwidth 6) table-max-width)))
            (make-point (max 5 dwidth) (max 5 height))))))))

(defmethod cell-contents-string-new ((item table-dialog-item) h &optional v)
  (%cell-contents-string-new item h v))

(defun %cell-contents-string-new (item h v)
  (normalize-h&v h v)
  (let ((contents (cell-contents item h v))
        (print-function (slot-value item 'table-print-function)))
    (if (or (and (or (eq print-function #'princ)
                     (eq print-function #'write-string))
                 (or (stringp contents)
                     (and (symbolp contents)(setq contents (symbol-name contents))))))
      contents
      (progn
        (catch :truncate
          (funcall print-function contents %draw-cell-string-stream))
        (get-output-stream-string %draw-cell-string-stream)))))

(defmethod cell-contents ((item table-dialog-item) h &optional v)
  (declare (ignore h v))
  nil)

(defclass table-scroll-bar (scroll-bar-dialog-item) ())

(defvar *table-scroll-bar-tracked-part* nil)

(defmethod track-scroll-bar :around ((item table-scroll-bar) value part)
  (declare (ignore value))
  (let ((*table-scroll-bar-tracked-part* part))
    (call-next-method)))

(defmethod scroll-bar-page-size ((item table-scroll-bar))
  (let* ((table (scroll-bar-scrollee item))
         (vertical? (eq item (table-vscroll-bar table)))
         (dimensions (table-dimensions table))
         (inner-size (table-inner-size table)))
    (if vertical?
      (let ((size-v (point-v inner-size)))
        (if (eq *table-scroll-bar-tracked-part* :in-page-up)
          (table-visible-row-count table 
                                   :end-row (table-top-row table)
                                   :from-end t
                                   :size-v size-v)
          (table-visible-row-count table
                                   :start-row (table-top-row table)
                                   :end-row (point-v dimensions)
                                   :size-v size-v)))
      (let ((size-h (point-h inner-size)))
        (if (eq *table-scroll-bar-tracked-part* :in-page-up)
          (table-visible-column-count table
                                      :end-column (table-left-column table)
                                      :from-end t
                                      :size-h size-h)
          (table-visible-column-count table
                                      :start-column (table-left-column table)
                                      :end-column (point-h dimensions)
                                      :size-h size-h))))))

(defun table-visible-column-count (table &key
                                         (start-column 0)
                                         (end-column (point-h (table-dimensions table)))
                                         (from-end nil)
                                         (size-h (point-h (table-inner-size table))))
  (let ((col-count 0)
        (width 0))
    (do-column-widths (table w) (start-column end-column from-end)
      (incf width w)
      (when (> width size-h) (return))
      (incf col-count))
    col-count))

(defun table-visible-row-count (table &key
                                      (start-row 0)
                                      (end-row (point-v (table-dimensions table)))
                                      (from-end nil)
                                      (size-v (point-v (table-inner-size table))))
  (let ((row-count 0)
        (height 0))
    (do-row-heights (table h) (start-row end-row from-end)
      (incf height h)
      (when (> height size-v) (return))
      (incf row-count))
    row-count))

(defmethod install-view-in-window ((item table-dialog-item) dialog)
  (declare (ignore dialog))
  (without-interrupts                   ; still necessary?
   ;; (compute-selection-regions item)     ; moved up from below
   (call-next-method)
   (let* ((changed (maybe-need-scroll-bars item t))
          (item-size (table-inner-size item nil))
          (cell-size (cell-size item))
          (columns (table-columns item))
          (visible-dimensions (visible-dimensions-slot item))  ; huh
          )
     (unless cell-size
       (setf (cell-size-slot item)
             (setq cell-size 
                   (default-cell-size
                     item
                     (truncate (point-h item-size)
                               (if (zerop columns)
                                 1
                                 columns))))))
     (compute-selection-regions item)     ; moved here by wws guess
     (if visible-dimensions (set-visible-dimensions item visible-dimensions))
     (fixup-scroll-bars item)  ;; moved this
     (when changed
       (let ((container (view-container item)))
          (when (table-vscroll-bar item)            
            (set-view-container (table-vscroll-bar item) container))
          (when (table-hscroll-bar item)
           (set-view-container (table-hscroll-bar item) container))))
     ;(compute-selection-regions item)
     )))

;; CLIM adds a method for this
(defmethod make-scroll-bar-for-table ((table table-dialog-item) direction)
  (make-instance 'table-scroll-bar
                 :scrollee table
                 :view-position #@(-3000 -3000)  ; mAYBE no longer needed
                 :track-thumb-p (scroll-bar-track-thumb-p table)
                 :direction direction))
  
  

; These are only safe to use when the table is not in its window.
(defmethod (setf table-hscrollp) (value (item table-dialog-item))
  (unless value
    (let ((scroll-bar (table-hscroll-bar item)))
      (when scroll-bar
        (setf (table-hscroll-bar item) nil)
        (set-view-container scroll-bar nil))))
  (setf (table-hscrollp-slot item) (not (null value))))

(defmethod (setf table-vscrollp) (value (item table-dialog-item))
  (unless value
    (let ((scroll-bar (table-vscroll-bar item)))
      (when scroll-bar
        (setf (table-vscroll-bar item) nil)
        (set-view-container scroll-bar nil))))
  (setf (table-vscrollp-slot item) (not (null value))))

(defun fixup-scroll-bar-levels (item)
  (declare (ignore item)))

#|        
(defun fixup-scroll-bar-levels (item)
  (let ((level (view-level item)))
    (when level
      (incf level)
      (let ((hscroll (table-hscroll-bar item)))
        (when hscroll
          (set-view-level hscroll level)))
      (let ((vscroll (table-vscroll-bar item)))
        (when vscroll
          (set-view-level vscroll level))))))
|#

(defun wholly-visible-columns (table &optional
                                     (visible-dimensions (visible-dimensions table))
                                     (size-h (point-h (table-inner-size table))))
  (if (not visible-dimensions)
    0
    (let ((visible-columns (point-h visible-dimensions))
          (width 0))
      (do-column-widths (table w) (0 visible-columns) (incf width w))
      (if (> width size-h)
        (1- visible-columns)
        visible-columns))))

(defun wholly-visible-rows (table &optional
                                  (visible-dimensions (visible-dimensions table))
                                  (size-v (point-v (table-inner-size table))))
  (if (not visible-dimensions)
    0
    (let ((visible-rows (point-v visible-dimensions))
          (height 0))
      (do-row-heights (table h) (0 visible-rows) (incf height h))
      (if (> height size-v)
        (1- visible-rows)
        visible-rows))))

(defun fixup-scroll-bars (table)
  (when (installed-item-p table)
    (when (visible-dimensions table)
      (let* ((size (table-inner-size table))
             (size-h (point-h size))
             (size-v (point-v size))
             (grow-icon-p (table-grow-icon-p table))
             (position (view-position table))
             (pos-h (point-h position))
             (pos-v (point-v position))
             (hscroll (table-hscroll-bar table))
             (vscroll (table-vscroll-bar table))
             changed)
        (when hscroll
          (let* ((columns (table-columns table))
                 (visible-end-columns (table-visible-column-count
                                       table
                                       :end-column columns
                                       :from-end t)))
            (set-view-position hscroll (if (osx-p) pos-h  (1- pos-h)) (+ pos-v size-v))
            (set-view-size hscroll
                           (+ size-h (if (osx-p) 0 2) (if (and (not vscroll) grow-icon-p) -15 0))
                           16)
            (let ((old-max (scroll-bar-max hscroll))
                  (new-max (max 0 (- columns visible-end-columns))))
              (set-scroll-bar-max hscroll new-max)
              (when (not (eql new-max old-max))
                (setq changed t)))))
        (when vscroll
          (let* ((rows (table-rows table))
                 (visible-end-rows (table-visible-row-count
                                    table
                                    :end-row rows
                                    :from-end t)))
            (set-view-position vscroll (+ pos-h size-h) (if (osx-p) pos-v (1- pos-v)))
            (set-view-size vscroll 
                           16
                           (+ size-v (if (osx-p) 0 2) (if (and (not hscroll) grow-icon-p) -15 0)))
            (let ((old-max (scroll-bar-max vscroll))
                  (new-max (max 0 (- rows visible-end-rows))))
              (set-scroll-bar-max vscroll new-max)
              (when (not (eql new-max old-max))                
                (setq changed t)))))
        (when changed
          (scroll-bar-changed table t)
          (invalidate-view table)
          )))))


(defmethod remove-view-from-window :after ((item table-dialog-item))  
  (setf (visible-dimensions-slot item) nil)
  (dispose-selection-regions item))

; If the selection crosses a visible boundary right at a
; cell boundary, then the outline-region stops there and
; it appears that ² else is selected.
; Let them report it as a bug.
(defun compute-selection-regions (item &optional min-row max-row min-column max-column)
  (let ((rgn (table-selection-region item)))
    (if (and rgn (macptrp rgn))
      (unless min-row
        (#_SetEmptyRgn rgn))
      (setf (table-selection-region item) (#_NewRgn)
            min-row nil)))
  (let ((rgn (table-outline-region item)))
    (if (and rgn (macptrp rgn))
      (unless min-row
        (#_SetEmptyRgn rgn))
      (setf (table-outline-region item) (#_NewRgn)
            min-row nil)))
  (let* ((something-selected? nil)
         (mapper #'(lambda (item h v)
                     (when (or (null min-row)
                               (<= min-row v max-row)
                               (<= min-column h max-column))
                       (when (add-to-selection-region item t h v nil)
                         (setq something-selected? t))))))
    (declare (dynamic-extent mapper))
    (new-map-selected-cells item mapper)
    (when something-selected?
      (add-to-selection-region item t nil nil t))))

(defun dispose-selection-regions (item)
  (let ((rgn (table-selection-region item)))
    (when rgn
      (setf (table-selection-region item) nil)
      (#_DisposeRgn rgn)))
  (let ((rgn (table-outline-region item)))
    (when rgn
      (setf (table-outline-region item) nil)
      (#_DisposeRgn rgn))))

#|
(defun show-selection-region (&optional (table *tbl*) (pause nil))
  (with-focused-view (view-container table)
    (rlet ((rect :rect :topleft 0 :botright #@(300 300)))
      (#_eraserect rect)
      (#_INVERTRGN (table-selection-region table))
      ))
  (when pause
    (y-or-n-p "Continue? ")))
|#

(defmethod add-to-selection-region ((item table-dialog-item) selected-p h &optional v
                                    dont-compute-outline-region)
  (let ((selection-region (table-selection-region item))
        (visible-dimensions (visible-dimensions item)))
    (when visible-dimensions
      (prog1
        (when (and selection-region h)
          (normalize-h&v h v)
          (let* ((top-row (1- (table-top-row item)))
                 (left-column (1- (table-left-column item)))
                 ;(visible-dimensions (visible-dimensions item))
                 (bottom-row (+ top-row (point-v visible-dimensions) 2))
                 (right-column (+ left-column (point-h visible-dimensions) 2)))
            (when (and (<= top-row v bottom-row)
                       (<= left-column h right-column))
              (multiple-value-bind (ignore cell-size top-left) (cell-position item h v)
                (declare (ignore ignore))
                (when top-left
                  (let ((bottom-right (add-points top-left cell-size)))
                    (with-temp-rgns (rgn)
                      (#_SetRectRgn rgn (point-h top-left)(point-v top-left) (point-h bottom-right)(point-v bottom-right))
                      (if selected-p
                        (#_UnionRgn rgn selection-region selection-region)
                        (#_DiffRgn selection-region rgn selection-region))
                      t)))))))         ; did something
        (unless dont-compute-outline-region
          (let ((outline-region (table-outline-region item)))
            (#_CopyRgn selection-region outline-region)
            (#_InsetRgn outline-region 1 1)
            (#_XorRgn selection-region outline-region outline-region)))))))
   
(defun table-inner-size (table &optional size)
  (when (not size)(setq size (view-size table)))
  (if (null size)
    #@(0 0)
    (let ((h (point-h size))
          (v (point-v size)))      
      (declare (fixnum h v))
      (if (table-vscroll-bar table)
        (setq h (- h 15)))
      (if (table-hscroll-bar table)
        (setq v (- v 15)))
      (make-point h v))))



(defun map-column-widths (function item &optional start end from-end)
  (let ((column-width (point-h (cell-size item)))
        (hash (column-widths-hash item))
        (sep-width (point-h (separator-size item))))
    (unless start (setq start 0))
    (unless end
      (setq end (point-h (table-dimensions item))))
    (if from-end
      (let ((column (1- end)))
        (loop
          (when (< column start) (return column))
          (funcall function
                   (get-adjusted-size column hash column-width sep-width)
                   column)
          (decf column)))
      (let ((column start))
        (loop
          (when (>= column end) (return column))
          (funcall function
                   (get-adjusted-size column hash column-width sep-width)
                   column)
          (incf column))))))

(defun map-row-heights (function item &optional start end from-end)
  (let ((row-height (point-v (cell-size item)))
        (hash (row-heights-hash item))
        (sep-height (point-v (separator-size item))))
    (unless start (setq start 0))
    (unless end
      (setq end (point-v (table-dimensions item))))
    (if from-end
      (let ((row (1- end)))
        (loop
          (when (< row start) (return row))
          (funcall function
                   (get-adjusted-size row hash row-height sep-height)
                   row)
          (decf row)))
      (let ((row start))
        (loop
          (when (>= row end) (return row))
          (funcall function
                   (get-adjusted-size row hash row-height sep-height)
                   row)
          (incf row))))))

(defmethod visible-dimensions ((item table-dialog-item))
  (or (visible-dimensions-slot item)     ; cache
      (let ((size (view-size item))
            (cell-size (cell-size item)))
        (when (and size cell-size)
          (setf (visible-dimensions-slot item) 
                (let* ((size (table-inner-size item))
                       (width (point-h size) )
                       (height (point-v size)))
                  (make-point (if (column-widths-hash item)
                                (let ((left-column (table-left-column item))
                                      (h 0))
                                  (- (do-column-widths (item column-width column) (left-column)
                                       (incf h column-width)
                                       (when (>= h width) (return column)))
                                     left-column))
                                (floor width (point-h cell-size)))
                              (if (row-heights-hash item)
                                (let ((top-row (table-top-row item))
                                      (v 0))
                                  (- (do-row-heights (item row-height row) (top-row)
                                       (incf v row-height)
                                       (when (>= v height) (return row)))
                                     top-row))
                                (floor height (point-v cell-size))))))))))

(defmethod set-visible-dimensions ((item table-dialog-item) h &optional v)
  (let ((cell-size (cell-size item)))
    (when cell-size
      (normalize-h&v h v)
      (let* ((table-vscrollp (table-vscroll-bar item))
             (table-hscrollp (table-hscroll-bar item))
             (cell-width (point-h cell-size))
             (cell-height (point-v cell-size))
             (row (table-top-row item))
             (column (table-left-column item))
             (row-heights-hash (row-heights-hash item))
             (column-widths-hash (column-widths-hash item))
             (sep-width (point-h (separator-size item)))
             (sep-height (point-v (separator-size item)))
             (new-width (if (null column-widths-hash)
                          (* h (if (zerop cell-width) 0 (+ cell-width sep-width)))
                          (let ((width 0))
                            (dotimes (i h width)  ;; ret width
                              (incf width (get-adjusted-size column column-widths-hash cell-width sep-width))
                              (incf column)))))
             (new-height (if (null row-heights-hash)
                           (* v (if (zerop cell-height) 0 (+ cell-height sep-height)))
                           (let ((height 0))
                             (dotimes (i v height) ;; ret height
                               (incf height (get-adjusted-size column row-heights-hash cell-height sep-height))
                               (incf row))))))
        ;; is it really the right thing to mess with view-size?
        (set-view-size
         item
         (+ new-width (if table-vscrollp 15 0))
         (+ new-height (if table-hscrollp 15 0))))))
  (setf (slot-value item 'visible-dimensions) (make-point h v)))

(defmethod installed-item-p ((item table-dialog-item))
  (wptr item))

(defmethod set-view-position ((item table-dialog-item) h &optional v
                                 &aux (new-pos (make-point h v)))
  (let ((pos (view-position item)))
    (unless (eql pos new-pos)
      (without-interrupts
       (call-next-method)   ; just plain MCL bug - set new-pos before calling fixup-scroll-bars   
       (if pos
         (let ((diff (and pos (subtract-points new-pos pos)))
               (hscroll (table-hscroll-bar item))
               (vscroll (table-vscroll-bar item)))
           (when hscroll
             (set-view-position hscroll (add-points (view-position hscroll) diff)))
           (when vscroll
             (set-view-position vscroll (add-points (view-position vscroll) diff))))
         (fixup-scroll-bars item))
       ;(call-next-method)
       (when (wptr item)
         (compute-selection-regions item))))))

(defmethod maybe-fix-cell-size ((item table-dialog-item))
  (when (<= (point-h (table-dimensions item)) 1) ; or (sequence-order wrap-length)
    (when (and (view-size item)(cell-size item))
      (let ((inner-size (table-inner-size item)))
        (set-cell-size item
                       (make-point (max 1 (point-h inner-size))
                                   (max 1 (point-v (cell-size item)))))))))

(defmethod view-corners ((item table-dialog-item))
  (multiple-value-call #'inset-corners #@(-1 -1) (call-next-method)))

; try (test-tbl :dimensions #@(8 15) :cell-size #@(50 20))

(defvar *updating* nil)

; This was part of a broken experiment to paint
; the hilite color first when updating.
; The idea was to reduce flashing while scrolling
; and revealing selected cells.
#|
(defmethod window-update-event-handler :around ((window t))
  (let ((*updating* t))
    (call-next-method)))
|#

(defmethod table-row-height ((item table-dialog-item) row)
  (unless (integerp row)
    (setq row (require-type row 'integer)))
  (let ((row-heights-hash (row-heights-hash item)))
    (or (and row-heights-hash (gethash row row-heights-hash))
        (let ((cell-size (cell-size item)))
          (and cell-size (point-v cell-size))))))

(defmethod table-column-width ((item table-dialog-item) column)
  (unless (integerp column)
    (setq column (require-type column 'integer)))
  (let ((column-widths-hash (column-widths-hash item)))
    (or (and column-widths-hash (gethash column column-widths-hash))
        (let ((cell-size (cell-size item)))
          (and cell-size (point-h cell-size))))))

(defmethod (setf table-row-height) (value (item table-dialog-item) row)
  (unless (integerp row)
    (setq row (require-type row 'integer)))
  (unless (or (null value) (fixnump value))
    (setq value (require-type value '(or null fixnum))))
  (let ((hash (or (row-heights-hash item)
                  (and value (setf (row-heights-hash item) (make-hash-table :test 'eql))))))
    (if value
      (setf (gethash row hash) value)
      (when hash
        (remhash row hash)
        (when (eql 0 (hash-table-count hash))
          (setf (row-heights-hash item) nil)))))
  (setf (visible-dimensions-slot item) nil)     ; clear cache
  (when (installed-item-p item)
    (compute-selection-regions item)
    (invalidate-view item t))           ; optimize this to scroll appropriately and invalidate minimally
  (when (table-vscroll-bar item)
    ;(scroll-bar-changed item t)
    (fixup-scroll-bars item))
  value)

(defmethod (setf table-column-width) (value (item table-dialog-item) column)
  (unless (integerp column)
    (setq column (require-type column 'integer)))
  (unless (or (null value) (fixnump value))
    (setq value (require-type value '(or null fixnum))))
  (let ((hash (or (column-widths-hash item)
                  (and value (setf (column-widths-hash item) (make-hash-table :test 'eql))))))
    (if value
      (setf (gethash column hash) value)
      (when hash
        (remhash column hash)
        (when (eql 0 (hash-table-count hash))
          (setf (column-widths-hash item) nil)))))
  (setf (visible-dimensions-slot item) nil)     ; clear cache
  (when (installed-item-p item)
    (compute-selection-regions item)
    (invalidate-view item t))           ; optimize this to scroll appropriately and invalidate minimally
  (when (table-hscroll-bar item)
    ;(scroll-bar-changed item t)
    (fixup-scroll-bars item))
  value)

(defmethod view-draw-contents ((item table-dialog-item))
  (without-interrupts
   (let* ((my-dialog (view-container item))
          (wptr (and my-dialog (wptr my-dialog))))
     (when wptr
       (with-focused-dialog-item (item my-dialog)
         (let* ((dialog-item-enabled-p (dialog-item-enabled-p item))
               (color-p (and (not dialog-item-enabled-p)(color-or-gray-p item))) 
               (color-list (part-color-list item))
               (back-color (part-color item :body))
               (pos (view-position item))
               (inner-size (table-inner-size item)))
           (rlet ((rect :rect :topleft pos :botright (add-points pos inner-size)))
             (with-clip-rect-intersect rect
               (with-temp-rgns (rgn #+carbon-compat rgn3)
                 (#_getclip rgn)
                 (with-back-color back-color
                   (when back-color
                     (#_erasergn rgn)
                     #+ignore
                     (when (osx-p)
                       (with-fore-color back-color
                         (#_paintrgn rgn))))
                   (when (and *updating* dialog-item-enabled-p)
                     (let ((selection-rgn (if (view-active-p item)
                                            (table-selection-region item)
                                            (table-outline-region item))))
                       (with-hilite-mode
                         (#_InvertRgn selection-rgn))))                   
                   (let ()
                     (get-window-visrgn wptr rgn3)
                     (#_sectrgn rgn rgn3 rgn))
                   (let* ((row (table-top-row item))
                          (column (table-left-column item))
                          (rows (table-rows item))
                          (columns (table-columns item))
                          (first-column column)
                          (cell-size (cell-size item))
                          (column-width (point-h cell-size))
                          (row-height (point-v cell-size))
                          (column-widths-hash (column-widths-hash item))
                          (row-heights-hash (row-heights-hash item))
                          (separator-visible-p (separator-visible-p item))
                          (separator-size (separator-size item))
                          (separator-color (separator-color item))
                          (separator-pattern (separator-pattern item))
                          (might-draw-separator (and separator-visible-p
                                                     (not (eql separator-size #@(0 0)))
                                                     (macptrp separator-pattern)))
                          (draw-col-separator (and might-draw-separator (> columns 1))) ;nil)
                          (top-left (view-position item))
                          (bottom-right (add-points top-left (table-inner-size item)))
                          (top (point-v top-left))
                          (left (point-h top-left))
                          (right (point-h bottom-right))
                          (bottom (point-v bottom-right)))
                     (rlet ((rect :rect :topleft top-left :botright bottom-right))
                       (with-clip-rect-intersect rect
                         (loop
                           (let ((row-height (or (and row-heights-hash (gethash row row-heights-hash)) row-height)))
                             (when (plusp row-height)
                               (setf (pref rect :rect.bottom) (+ (pref rect :rect.top) row-height))
                               (setf (pref rect :rect.left) left)
                               (setq column first-column)
                               #|
                               (when (and might-draw-separator
                                          (or (>= row (1- rows))
                                              (>= (+ (pref rect :rect.bottom) row-height (point-v separator-size)) bottom)))
                                 (setf draw-col-separator t))|#

                               (loop
                                 (let ((column-width (or (and column-widths-hash (gethash column column-widths-hash))
                                                         column-width)))
                                   (setf (pref rect :rect.right) 
                                         (+ (pref rect :rect.left) column-width))
                                   (when (and (plusp column-width)
                                              (#_RectInRgn rect rgn))
                                     (unless (or (>= column columns) (>= row rows))
                                       (draw-table-cell-new item column row rect (cell-selected-p item column row))
                                       (when draw-col-separator
                                         ;; draw the column separator to the right of the current
                                         (with-fore-color separator-color
                                           (with-pen-saved-simple
                                             (#_PenSize (point-h separator-size) (point-v separator-size))
                                             (#_PenPat separator-pattern)
                                             (#_MoveTo (pref rect :rect.right) top)
                                             (#_LineTo (pref rect :rect.right) (pref rect :rect.bottom)))))))
                                   (incf column)
                                   (when (or (>= column columns)
                                             (>= (incf (pref rect :rect.left) 
                                                       (if (zerop column-width) 
                                                         0 
                                                         (+ column-width (point-h separator-size))))
                                                 right))
                                     (return))))
                               (when (and might-draw-separator (< row rows))
                                 ;; draw the row separator below the current row
                                 (with-fore-color separator-color
                                   (with-pen-saved-simple
                                     (#_PenSize (point-h separator-size)(point-h separator-size))
                                     (#_PenPat separator-pattern)
                                     (#_MoveTo left (pref rect :rect.bottom))
                                     (#_LineTo (pref rect :rect.right) (pref rect :rect.bottom))))))
                             (incf row)
                             (when (or (>= row rows)
                                       (>= (incf (pref rect :rect.top) 
                                                 (if (zerop row-height) 
                                                   0 
                                                   (+ row-height (point-v separator-size))))
                                           bottom))
                               (return)))))))))))
           (with-item-rect (r item)
             (with-fore-color (getf color-list :frame nil)               
               (#_insetRect r -1 -1)
               (#_FrameRect r))
             (when (and (not dialog-item-enabled-p) (not color-p))
               (rlet ((ps :penstate))
                 (#_GetPenState ps)
                 (#_PenPat *gray-pattern*)
                 (#_PenMode 11)
                 (#_PaintRect r)
                 (#_SetPenState  ps))))))))))

(defmethod scroll-bar-changed ((item table-dialog-item) scroll-bar)
  ;(declare (ignore scroll-bar))
  (let* ((hscroll (table-hscroll-bar item))
         (vscroll (table-vscroll-bar item))
         (hscroll-setting (if hscroll (scroll-bar-setting hscroll) 0))
         (vscroll-setting (if vscroll (scroll-bar-setting vscroll) 0)))
    (scroll-to-cell item hscroll-setting vscroll-setting)
    (when (and (wptr item) (neq scroll-bar t))  
      ;; dont bother (FROM FIXUP-SCROLL-BARS), it does invalidate view after this and further
      ;; when doing list-definitions-dialog the grafport-back-color is wrong at this point
      ;; because the dialog-item-action for the editable-text-dialog-item is called
      ;; within the scope of with-text-colors. (phooey). That once mattered because
      ;; set-table-dimensions was invalidating (with erase) some stuff outside the table.
      ;; That bug is fixed now but there is still no need to call window-update-event-handler.
      (window-update-event-handler (view-window item)))))

(defmethod scroll-to-cell ((item table-dialog-item) h &optional v)
  (normalize-h&v h v)
  (let* ((old-top-row (table-top-row item))
         (old-left-column (table-left-column item))
         (rows (table-rows item))
         (columns (table-columns item))
         (visible-end-rows (table-visible-row-count
                            item
                            :end-row rows
                            :from-end t))
         (visible-end-columns (table-visible-column-count
                               item
                               :end-column columns
                               :from-end t))
         (new-top-row (max 0 (min v (- rows visible-end-rows))))
         (new-left-column (max 0 (min h (- columns visible-end-columns))))
         (hscroll (table-hscroll-bar item))
         (vscroll (table-vscroll-bar item))
         (wptr (wptr item)))
    (setf (table-top-row item) new-top-row
          (table-left-column item) new-left-column)
    (when hscroll
      (setf (scroll-bar-setting hscroll) new-left-column))
    (when vscroll
      (setf (scroll-bar-setting vscroll) new-top-row))
    (setf (visible-dimensions-slot item) nil)
    (when wptr
      (with-focused-dialog-item (item)
        (let* ((pos (view-position item))
               (inner-size (table-inner-size item))
               (cell-size (cell-size item))
               (separator-size (separator-size item))
               (cell-size-h (+ (point-h cell-size) (point-h separator-size)))
               (cell-size-v (+ (point-v cell-size) (point-v separator-size)))
               (delta-rows (- old-top-row new-top-row))
               (delta-columns (- old-left-column new-left-column))
               (delta-v 0)
               (delta-h 0))
          (if (row-heights-hash item)
            (cond ((< old-top-row new-top-row)
                   (do-row-heights (item row-height) (old-top-row new-top-row)
                     (decf delta-v row-height)))
                  ((< new-top-row old-top-row)
                   (do-row-heights (item row-height) (new-top-row old-top-row)
                     (incf delta-v row-height))))
            (setq delta-v (* delta-rows cell-size-v)))
          (if (column-widths-hash item)
            (cond ((< old-left-column new-left-column)
                   (do-column-widths (item column-width) (old-left-column new-left-column)
                     (decf delta-h column-width)))
                  ((< new-left-column old-left-column)
                   (do-column-widths (item column-width) (new-left-column old-left-column)
                     (incf delta-h column-width))))
            (setq delta-h (* delta-columns cell-size-h)))
          (rlet ((rect :rect :topleft pos :botright (add-points pos inner-size)))
            (without-interrupts
             (let ((container (view-container item)))
               (with-temp-rgns (update-rgn)
                 (get-window-updatergn wptr update-rgn)
                 (unless (#_EmptyRgn update-rgn)
                   (let* ((container-origin (subtract-points (view-origin container) (view-position (view-window container)))))
                     (with-temp-rgns (new-update-rgn item-rgn)
                       (#_CopyRgn update-rgn new-update-rgn)
                       (#_CopyRgn (view-clip-region item) item-rgn)
                       ; Work in the container's coordinate system, since we're already focused on it.
                       ; The windowrecord.updatergn is in global coordinates
                       (#_OffsetRgn new-update-rgn (point-h container-origin) (point-v container-origin))
                       (#_OffsetRgn item-rgn (point-h pos) (point-v pos))
                       (#_SectRgn new-update-rgn item-rgn new-update-rgn)
                       (unless (#_EmptyRgn new-update-rgn)
                         (validate-region container new-update-rgn)
                         (#_OffsetRgn new-update-rgn delta-h delta-v)
                         (#_SectRgn new-update-rgn item-rgn new-update-rgn)
                         (invalidate-region container new-update-rgn))))))
               (if (or (> (abs delta-h) #x7fff)(> (abs delta-v) #x7fff))  ;; actually only needed if osx-p
                 (invalidate-view item)
                 (with-temp-rgns (invalid-rgn)
                   (with-back-color (part-color item :body)  ;; << added
                     (#_ScrollRect rect delta-h delta-v invalid-rgn)
                     (Invalidate-region container invalid-rgn))
                   )))))
          ; Could just call compute-selection-regions here, but that makes
          ; scrolling take a long time if there's a large selection.
          ; This code does incremental selection region calculation.
          (let ((selection-region (table-selection-region item))
                (outline-region (table-outline-region item))
                (pos-h (point-h pos))
                (pos-v (point-v pos))
                (inner-size-h (point-h inner-size))
                (inner-size-v (point-v inner-size)))
            (when selection-region
              (#_OffsetRgn selection-region delta-h delta-v)
              (#_OffsetRgn outline-region delta-h delta-v)
              (with-temp-rgns (rgn)
                (#_SetRectRgn rgn
                 (- pos-h cell-size-h)
                 (- pos-v cell-size-v)
                 (+ pos-h inner-size-h cell-size-h)
                 (+ pos-v inner-size-v cell-size-v))
                (#_SectRgn selection-region rgn selection-region)
                (#_SectRgn outline-region rgn outline-region))))
          (let* ((min-column (1- (table-left-column item)))
                 (left-column (table-left-column item))
                 (visible-columns (table-visible-column-count item :start-column left-column :end-column columns))
                 (max-column (+ min-column visible-columns 2))
                 (top-row (table-top-row item))
                 (visible-rows (table-visible-row-count item :start-row top-row :end-row rows))
                 (min-row (1- (table-top-row item)))
                 (max-row (+ min-row visible-rows 2)))
            (if (< delta-rows 0)
              (setq min-row (+ max-row delta-rows))
              (setq max-row (+ min-row delta-rows)))
            (if (< delta-columns 0)
              (setq min-column (+ max-column delta-columns))
              (setq max-column (+ min-column delta-columns)))
            (compute-selection-regions item min-row max-row min-column max-column)))))))

(defmethod scroll-position ((item table-dialog-item))
  (make-big-point (table-left-column item) (table-top-row item)))

(defmethod draw-table-cell-new ((item table-dialog-item) h v rect selectedp)
  (%draw-table-cell-new item h v rect selectedp))

;;; draw gray if not enabled and color-p
(defun %draw-table-cell-new (item h v rect selectedp)
  (when (wptr item)
    (let* ((container (view-container item))
           (enabled-p (dialog-item-enabled-p item))
           (color-p (if (not enabled-p)(color-or-gray-p item))))
      (with-focused-view container
        (let ((cell-fonts (table-cell-fonts item)))
          (multiple-value-bind (ff ms) (view-font-codes item)
            (let* ((top (pref rect rect.top))
                   (key (cons h v))
                   (back-color-p (eq (cell-colors item) :background))
                   (cell-color (part-color-h-v item h v)))
              (declare (ignore-if-unused top))
              (declare (dynamic-extent key))
              (without-interrupts
               (let* ((font (and cell-fonts
                                 (gethash key cell-fonts)))
                      (back-color (or (and back-color-p cell-color)
                                      (part-color item :body)))
                      (fore-color (if (and (not enabled-p) color-p)
                                    *gray-color*
                                    (or (and (not back-color-p) cell-color)
                                        (part-color item :text)
                                        *table-fore-color*)))
                      (pos (view-position item))
                      (botright (add-points pos (table-inner-size item))))
                 (setq ff (or (car font) ff)
                       ms (or (cdr font) ms))
                 (rlet ((table-inner-rect :rect :topleft pos :botright botright))
                   (with-clip-rect-intersect table-inner-rect
                     (progn ;with-clip-rect-intersect rect - draw-string-in-rect does it
                       (with-back-color back-color
                         (#_eraserect rect)  ;;  change scope -weird?? - from Gilles Bisson  UNDO change
                         (rlet ((my-rect :rect))
                           (copy-record rect :rect my-rect)
                           (incf (pref my-rect :rect.left) 3)  ;; ok to clobber rect? - not if multiple columns
                           (let ((string (cell-contents-string-new item h v)))
                             (draw-string-in-rect string my-rect :truncation :end :ff ff :ms ms :color fore-color)))
                         (when (and selectedp (not *updating*) enabled-p)
                           (with-hilite-mode
                             (#_InvertRgn (if (view-active-p item)
                                            (table-selection-region item)
                                            (table-outline-region item))))))))))))))))))

(defmethod cell-selected-p ((item table-dialog-item) h &optional v)
  (when (wptr item)
    (normalize-h&v h v)
    (let ((hash (table-selection-hash item)))
      (when hash
        (let ((key (cons h v)))
          (declare (dynamic-extent key))
          (gethash key hash))))))

(defmethod cell-select ((item table-dialog-item) h &optional v)
  (normalize-h&v h v)
  (let ((hash (table-selection-hash item))
        (key (cons h v)))
    (unless (and hash (gethash key hash))
      (unless hash
        (setq hash (setf (table-selection-hash item)
                         (make-hash-table :test 'equal))))
      (if (eql 0 (hash-table-count hash))
        (setf (first-selected-cell-slot item) (make-big-point h v))
        (let ((first-slot (first-selected-cell-slot item)))
          (when (and first-slot
                     (or (< h (point-h first-slot))
                         (< v (point-v first-slot))))
            (setf (first-selected-cell-slot item) nil))))
      (setf (gethash key hash) t)
      (invert-cell-selection item h v t))))

(defmethod cell-deselect ((item table-dialog-item) h &optional v)
  (normalize-h&v h v)
  (let ((hash (table-selection-hash item))
        (key (cons h v)))
    (declare (dynamic-extent key))
    (when (and hash (gethash key hash))
      (remhash key hash)
      (when (or (eql 0 (hash-table-count hash))
                (let ((first (first-selected-cell-slot item)))
                  (and first (eql (point-h first) h)(eql (point-v first) v))))                  
        (setf (first-selected-cell-slot item) nil))
      (invert-cell-selection item h v nil))))

(defmethod first-selected-cell ((item table-dialog-item))
  (or (first-selected-cell-slot item)
      (let ((hash (table-selection-hash item)))
        (when (and hash (neq 0 (hash-table-count hash)))
          (let ((min-h most-positive-fixnum)
                (min-v most-positive-fixnum))
            ; find min row in min column
            (let ((f #'(lambda (key val)
                         (declare (ignore val))
                         (let ((ph (car key))
                               (pv (cdr key)))
                           (if (eql ph min-h)
                               (setq min-v (min min-v pv))
                               (if (< ph min-h)
                                 (progn                               
                                   (setq min-h ph min-v pv))))))))
              (declare (dynamic-extent f))              
              (maphash f hash)                                         
              (setf (first-selected-cell-slot item)(make-big-point min-h min-v))))))))



(defun invert-cell-selection (item h v selected-p)
  (when (wptr item)
    (with-focused-dialog-item (item)
      (with-back-color (or (and (eq (cell-colors item) :background)
                                (part-color-h-v item h v))
                           (part-color item :body))
        (let* ((rgn (if (view-active-p item)
                      (table-selection-region item)
                      (table-outline-region item)))
               (pos (view-position item))
               (botright (add-points pos (table-inner-size item))))
          (with-temp-rgns (temp-rgn)
            (#_SetRectRgn temp-rgn (point-h pos) (point-v pos) (point-h botright) (point-v botright))
            (with-clip-region temp-rgn
              (#_CopyRgn rgn temp-rgn)
              (add-to-selection-region item selected-p h v)
              (#_XorRgn rgn temp-rgn temp-rgn)
              (with-hilite-mode (#_InvertRgn temp-rgn)))))))))


(defun invalidate-cell (item h &optional v)
  (when (wptr item)
    (normalize-h&v h v)
    (with-focused-dialog-item (item)
      (let* ((item-pos (view-position item))
             (item-size (table-inner-size item)))
        (rlet ((item-rect :rect :topleft item-pos :botright (add-points item-pos item-size))) 
          (multiple-value-bind (viz cell-size top-left) (cell-position item h v)
            (when viz
              (rlet ((cell-rect :rect :topleft top-left :botright (add-points top-left cell-size)))
                (#_sectrect cell-rect item-rect cell-rect)
                ;(with-fore-color *black-color* (#_paintrect cell-rect))
                (#_invalwindowrect (wptr item) cell-rect)
                ))))))))
  

(defun cell-position-possibly-invisible (item h &optional v)
  (normalize-h&v h v)
  (let* ((cell-size (cell-size item))
         (cell-size-h (point-h cell-size))
         (cell-size-v (point-v cell-size))
         (sep-width (point-h (separator-size item)))
         (sep-height (point-v (separator-size item)))
         (top-row (table-top-row item))
         (left-column (table-left-column item))
         (pos (view-position item)))
    (values
     (make-big-point (+ (point-h pos)
                        (if (column-widths-hash item)
                          (let ((width 0))
                            (do-column-widths (item column-width) (left-column h)
                                              (incf width column-width))
                            width)
                          (* (- h left-column) (if (zerop cell-size-h) 0 (+ cell-size-h sep-width)))))
                     (+ (point-v pos)
                        (if (row-heights-hash item)
                          (let ((height 0))
                            (do-row-heights (item row-height) (top-row v)
                                            (incf height row-height))
                            height)
                          (* (- v top-row) (if (zerop cell-size-v) 0 (+ cell-size-v sep-height))))))
     (make-point (table-column-width item h)
                 (table-row-height item v)))))

(defmethod cell-position ((item table-dialog-item) h &optional v)
  (normalize-h&v h v)
  (let* ((pos (view-position item))
         (pos-h (point-h pos))
         (pos-v (point-v pos))
         (inner-size (table-inner-size item)))
    (multiple-value-bind (res cell-size)
                         (cell-position-possibly-invisible item h v)
      (values
       (and (<= pos-h (point-h res) (1- (+ pos-h (point-h inner-size))))
            (<= pos-v (point-v res) (1- (+ pos-v (point-v inner-size))))
            res)
       cell-size
       res))))

(defmethod selected-cells ((item table-dialog-item) &aux ret)
  (let ((f #'(lambda (item h v)
               (declare (ignore item))
               (push (make-big-point h v) ret))))
    (declare (dynamic-extent f))
    (new-map-selected-cells item f))
  ret)

#|
(defmethod draw-cell-contents ((item table-dialog-item) h &optional v)
  (normalize-h&v h v)
  (let* ((max-width (- (table-column-width item h) 3)))
    (draw-string-crop (cell-contents-string-new item h v) max-width)))
|#

#+ignore
(defun string-roman-p (string)
  (dotimes (i (length string) t)
    (let ((char (%schar string i)))
      (if (neq #$kcfstringencodingmacroman (find-encoding-for-uchar char)) (return nil)))))

;; not used
#+ignore
(defmethod draw-cell-contents ((item table-dialog-item) h &optional v rect)
  (let* ((string (cell-contents-string-new item h v)))
    (draw-string-in-rect string rect :truncation :end)))
           
  
(defmethod new-map-selected-cells ((item table-dialog-item) f)
  (let ((hash (table-selection-hash item)))
    (when hash
      (let ((mapper #'(lambda (key value)
                        (declare (ignore value))
                        (funcall f item (car key) (cdr key)))))
        (declare (dynamic-extent mapper))
        (maphash mapper hash)))))

; backward compatibility
(defmethod map-selected-cells ((item table-dialog-item) f)
  (let ((hash (table-selection-hash item)))
    (when hash
      (let ((mapper #'(lambda (key value)
                        (declare (ignore value))
                        (funcall f item (make-big-point (car key) (cdr key))))))
        (declare (dynamic-extent mapper))
        (maphash mapper hash)))))

(defvar *table-fore-color* nil)

(defmethod view-activate-event-handler ((item table-dialog-item))
  (unless (view-active-p item)
    (setf (view-active-p item) t)
    (when (and (wptr item) (dialog-item-enabled-p item))
      (toggle-cell-outlining item))))

(defmethod view-deactivate-event-handler ((item table-dialog-item))
  (when (view-active-p item)
    (setf (view-active-p item) nil)
    (when (and (wptr item) (dialog-item-enabled-p item))
      (toggle-cell-outlining item))))

; Toggle between selection & outline mode in all but the update region.
; The update region will get drawn by view-draw-contents.
(defun toggle-cell-outlining (item)
  (with-focused-dialog-item (item)
    (let ((body-color (part-color item :body)))
      (with-back-color body-color
        (with-temp-rgns (rgn clip-rgn update-rgn)
          (#_GetClip clip-rgn)          
          (get-window-updatergn (wptr item) update-rgn)
          (let ((off (subtract-points #@(0 0) (view-position (view-window item)))))
            (#_OffsetRgn update-rgn (point-h off)(point-v off)))
          (let ((off (view-origin (view-container item))))
            (#_OffsetRgn  update-rgn (point-h off)(point-v off)))
          (#_DiffRgn clip-rgn update-rgn clip-rgn)
          (let ((pos (view-position item))
                (size (table-inner-size item)))
            (let ((br (add-points pos size)))
              (#_SetRectRgn rgn (point-h pos)(point-v pos) (point-h br)(point-v br)))
            (#_SectRgn clip-rgn rgn clip-rgn))
          (with-clip-region clip-rgn
            (let ((selection-region (table-selection-region item))
                  (outline-region (table-outline-region item)))
              (#_CopyRgn selection-region rgn)
              (#_XorRgn outline-region rgn rgn)
              (if (not (colored-cells-p  item))
                (with-hilite-mode
                  (#_InvertRgn rgn))
                (with-temp-rgns (cell-rgn)  ; << do colored cells 1 by 1
                  (let ((hash (table-selection-hash item)))
                    (when hash
                      (let ((f #'(lambda (key value)
                                   (declare (ignore value))
                                   (let ((h (car key))(v (cdr key)))
                                     (multiple-value-bind (pos size)
                                                          (cell-position item h v)
                                       (when pos
                                         (with-back-color (or (part-color-h-v item h v) body-color)
                                           (let ((br (add-points pos size)))
                                             (#_setrectrgn cell-rgn (point-h pos)(point-v pos)(point-h br)(point-v br)))  ; coords?
                                           (#_sectrgn cell-rgn clip-rgn cell-rgn)
                                           (#_sectrgn cell-rgn rgn cell-rgn)                                     
                                           (with-hilite-mode (#_invertrgn cell-rgn)))))))))
                        (declare (dynamic-extent f))
                        (maphash f hash)))))))))))))


#|
(defmethod part-color ((item table-dialog-item) key)
  (part-color-internal item key))

(defun part-color-internal (item key)
  (let ((color (if (or (symbolp key)(fixnump key))
                 (getf (part-color-list item) key)
                 (if (integerp key)
                   (let ((key (cons (point-h key) (point-v key))))
                     (declare (dynamic-extent key))
                     (part-color-internal item key))
                   (getf-test (part-color-list item) key 'equal)))))
    (or color
        (case key (:body *white-color*)))))
|#


(defmethod part-color ((item table-dialog-item) key)
  (if (or (integerp key)(consp key))
    (part-color-h-v item (point-h key)(point-v key))
    (let ((color (if (symbolp key)
                   (getf (part-color-list item) key))))
      (or color
          (case key (:body *white-color*))))))

#|
(defmethod install-view-in-window :after ((item table-dialog-item) window)
  (when (and (null (part-color item :body))(theme-background window))
    (set-part-color item :body *white-color*)))
|#
  


#|
(defmethod set-part-color ((d table-dialog-item) part new-color)
  (without-interrupts
   (IF (fixnump part)
     (progn 
       (setf (getf (part-color-list d) part) new-color)
       (redraw-cell d part))
     (if (or (integerp part)(consp part))
       ; Change the color of one cell
       (let ((key (cons (point-h part) (point-v part))))
         (if new-color
           (setf (getf-test (slot-value d 'color-list) key 'equal) new-color)
           (remf-test (slot-value d 'color-list) key 'equal))
         (redraw-cell d part))
       ; Change some other color attribute
       (progn
         (call-next-method)
         (let ((hscroll (table-hscroll-bar d))
               (vscroll (table-vscroll-bar d)))
           (when hscroll
             (set-part-color hscroll part new-color))
           (when vscroll
             (set-part-color vscroll part new-color)))
         (invalidate-view d))))))
|#

(defmethod set-part-color-h-v ((item table-dialog-item) h v new-color)
  (let ((hash (table-cell-color-hash item)))
    (when (null hash)
      (setq hash (make-hash-table :test #'equal))
      (setf (table-cell-color-hash item) hash))    
    (let ((key (if (not (fixnum-point-p h v))
                 (cons h v)
                 (make-point h v))))
      (if new-color
        (setf (gethash key hash) new-color)
        (remhash key hash))
      ;(redraw-cell item h v)
      (invalidate-cell item h v))))


(defmethod set-part-color ((d table-dialog-item) part new-color)
  (without-interrupts   
   (if (or (integerp part)(consp part))
     ; Change the color of one cell
     (set-part-color-h-v d (point-h part)(point-v part) new-color)     
     ; Change some other color attribute
     (progn
       (call-next-method)
       (let ((hscroll (table-hscroll-bar d))
             (vscroll (table-vscroll-bar d)))
         (when hscroll
           (set-part-color hscroll part new-color))
         (when vscroll
           (set-part-color vscroll part new-color)))
       (invalidate-view d)))))


; Need to add auto scrolling.
#|
(defmethod view-click-event-handler ((item table-dialog-item) where)
  (progn ;without-interrupts
  (let* ((pos (view-position item))
         (botright (add-points pos (table-inner-size item))))
    (if (not (point<= where botright))
      (if (> (point-h where) (point-h botright))
        (let ((vscroll (table-vscroll-bar item)))
          (when vscroll
            (view-click-event-handler vscroll where)))
        (let ((hscroll (table-hscroll-bar item)))
          (when hscroll
            (view-click-event-handler hscroll where))))
      (let* ((type (selection-type item))
             (shift-key-p (shift-key-p))
             (command-key-p (command-key-p))
             (container (view-container item))
             (top-row (table-top-row item))
             (left-column (table-left-column item))
             (rows (table-rows item))
             (bottom-row (+ top-row rows))
             (columns (table-columns item))
             (right-column (+ left-column columns))
             (left (point-h pos))
             (top (point-v pos))
             (right (point-h botright))
             (bottom (point-v botright))
             h v where-h where-v start-selected-p now-in-range last-h last-v)
        (with-focused-dialog-item (item)
          (with-back-color (part-color item :body)
            (progn ;without-interrupts
             (multiple-value-bind (start-h start-v start-in-range) (find-clicked-cell item where)
               (if start-in-range
                 (setq start-selected-p (cell-selected-p item start-h start-v))
                 (deselect-cells item))
               (loop
                 (without-interrupts
                  (setq where-h (point-h where)
                        where-v (point-v where))
                  (multiple-value-setq (h v now-in-range) (find-clicked-cell item where))
                  (multiple-value-setq (left-column top-row)
                    (do-auto-scroll item left-column top-row columns rows where-h where-v left top right bottom))
                  (if (and (not now-in-range)(not start-in-range)(not command-key-p)) ;(not shift-key-p))
                    (deselect-cells item)
                    (when (and now-in-range
                               (<= left-column h)
                               (< h right-column)
                               (<= top-row v)
                               (< v bottom-row)
                               (not (and (eql h last-h) (eql v last-v))))
                      (setq last-h h last-v v)
                      (cond ((and (eq type :disjoint)
                                  (or shift-key-p command-key-p)                                 
                                  (eql h start-h)(eql v start-v))
                             (if shift-key-p
                               (cell-select item h v)
                               (if start-selected-p
                                 (cell-deselect item h v)
                                 (cell-select item h v))))
                            ((and (eq type :disjoint)
                                  command-key-p
                                  start-selected-p)
                             (deselect-cells-between item start-h start-v h v))
                            ((or (eq type :single)
                                 (and (not shift-key-p)
                                      (or ;(eq type :contiguous)
                                       (not command-key-p))))
                             (let* ((hash (table-selection-hash item))
                                    (colored-cells-p (colored-cells-p item)))
                               (with-temp-rgns (rgn)
                                 (#_SetRectRgn rgn (point-h pos)(point-v pos) (point-h botright)(point-v botright))
                                 (with-clip-region rgn
                                   (with-hilite-mode
                                     (if (cell-selected-p item h v)
                                       (if (eq type :single)
                                         (cell-select item h v)
                                         (when hash
                                           (when colored-cells-p
                                             (let ((f #'(lambda (k val)
                                                          (declare (ignore val))
                                                          (unless (and (eql (car k) h)
                                                                       (eql (cdr k) v))
                                                            (cell-deselect item k)))))
                                               (declare (dynamic-extent f))
                                               (maphash f hash)))
                                           (clrhash hash)
                                           (setf (gethash (cons h v) hash) t)
                                           (setf (first-selected-cell-slot item) (make-big-point h v))                                          
                                           (with-temp-rgns (invert-region)
                                             (let ((selection-region
                                                    (if (view-active-p item)
                                                      (table-selection-region item)
                                                      (table-outline-region item))))
                                               (#_CopyRgn selection-region invert-region)
                                               (compute-selection-regions item)
                                               (when (not colored-cells-p)
                                                 (#_DiffRgn invert-region selection-region invert-region)
                                                 (#_InvertRgn invert-region))
                                               (cell-select item h v)))))  ; << fixes bengtsons double click thing
                                       (progn 
                                         (when hash
                                           (when colored-cells-p  ; <<
                                             (deselect-cells item))
                                           (clrhash hash)
                                           (setf (first-selected-cell-slot item) nil)
                                           (when (not colored-cells-p) ; <<
                                             (#_InvertRgn (if (view-active-p item)
                                                            (table-selection-region item)
                                                            (table-outline-region item))))
                                           (compute-selection-regions item))
                                         (cell-select item h v))))))))
                            ((and (eq type :contiguous)
                                  command-key-p
                                  (eql h start-h)(eql v start-v))                          
                             (deselect-cells item)
                             (when (not start-selected-p)(cell-select item h v)))
                            ((and (eq type :contiguous)
                                  shift-key-p
                                  (cell-selected-p item h v))
                             (deselect-cells-above item h v))                           
                            (t #|(or (and moved
                                         (or shift-key command-key)
                                         (or contiguous disjoint))
                                    (and contiguous shift-key (not selected)))
                                |#
                               (let* ((p (if (eq type :contiguous)(first-selected-cell item)))
                                      (first-h (if p (point-h p) start-h))
                                      (first-v (if p (point-v p) start-v)))
                                 (if (and (eq type :contiguous)  ; don't know bout this
                                          shift-key-p
                                          (neq 1 (point-h (table-dimensions item)))
                                          ;(not (cell-selected-p item h v)) ; always true
                                          )
                                   (multiple-value-bind (max-h max-v)(max-selected-h&v item)
                                     (select-cells-between item
                                                           (min first-h h)
                                                           (min first-v v)
                                                           (max first-h h max-h)
                                                           (max first-v v max-v)))
                                   (select-cells-between item first-h first-v h v))
                                 #+ignore
                                 (when (and (eq type :contiguous) 
                                            (neq 1 (point-h (table-dimensions item))))
                                   (deselect-cells-above item  h v))))))))
                                
                 (unless (mouse-down-p) (return))
                 (%run-masked-periodic-tasks) 
                 (setq where (view-mouse-position container))))))
            (dialog-item-action item)))))))
|#


(defmethod view-click-event-handler ((item table-dialog-item) where)
  (progn ;without-interrupts
  (let* ((pos (view-position item))
         (botright (add-points pos (table-inner-size item))))
    (if (not (point<= where botright))
      (if (> (point-h where) (point-h botright))
        (let ((vscroll (table-vscroll-bar item)))
          (when vscroll
            (view-click-event-handler vscroll where)))
        (let ((hscroll (table-hscroll-bar item)))
          (when hscroll
            (view-click-event-handler hscroll where))))
      (let* ((type (selection-type item))
             (shift-key-p (shift-key-p))
             (command-key-p (command-key-p))
             (container (view-container item))
             (top-row (table-top-row item))
             (left-column (table-left-column item))
             (rows (table-rows item))
             (bottom-row (+ top-row rows))
             (columns (table-columns item))
             (right-column (+ left-column columns))
             (left (point-h pos))
             (top (point-v pos))
             (right (point-h botright))
             (bottom (point-v botright))
             h v where-h where-v start-selected-p now-in-range last-h last-v)
        (with-focused-dialog-item (item)
          (with-back-color (part-color item :body)
            (with-timer ;without-interrupts ;; <<
             (multiple-value-bind (start-h start-v start-in-range) (find-clicked-cell item where)
               (if start-in-range
                 (setq start-selected-p (cell-selected-p item start-h start-v))
                 (deselect-cells item))
               (loop
                 (without-interrupts
                  (setq where-h (point-h where)
                        where-v (point-v where))
                  (multiple-value-setq (h v now-in-range) (find-clicked-cell item where))
                  (multiple-value-setq (left-column top-row)
                    (do-auto-scroll item left-column top-row columns rows where-h where-v left top right bottom))
                  (if (and (not now-in-range)(not start-in-range)(not command-key-p)) ;(not shift-key-p))
                    (deselect-cells item)
                    (when (and now-in-range
                               (<= left-column h)
                               (< h right-column)
                               (<= top-row v)
                               (< v bottom-row)
                               (not (and (eql h last-h) (eql v last-v))))
                      (setq last-h h last-v v)
                      (cond ((and (eq type :disjoint)
                                  (or shift-key-p command-key-p)                                 
                                  (eql h start-h)(eql v start-v))
                             (if shift-key-p
                               (cell-select item h v)
                               (if start-selected-p
                                 (cell-deselect item h v)
                                 (cell-select item h v))))
                            ((and (eq type :disjoint)
                                  command-key-p
                                  start-selected-p)
                             (deselect-cells-between item start-h start-v h v))
                            ((or (eq type :single)
                                 (and (not shift-key-p)
                                      (or ;(eq type :contiguous)
                                       (not command-key-p))))
                             (let* ((hash (table-selection-hash item))
                                    (colored-cells-p (colored-cells-p item)))
                               (with-temp-rgns (rgn)
                                 (#_SetRectRgn rgn (point-h pos)(point-v pos) (point-h botright)(point-v botright))
                                 (with-clip-region rgn
                                   (with-hilite-mode
                                     (if (cell-selected-p item h v)
                                       (if (eq type :single)
                                         (cell-select item h v)
                                         (when hash
                                           (when colored-cells-p
                                             (let ((f #'(lambda (k val)
                                                          (declare (ignore val))
                                                          (unless (and (eql (car k) h)
                                                                       (eql (cdr k) v))
                                                            (cell-deselect item k)))))
                                               (declare (dynamic-extent f))
                                               (maphash f hash)))
                                           (clrhash hash)
                                           (setf (gethash (cons h v) hash) t)
                                           (setf (first-selected-cell-slot item) (make-big-point h v))                                          
                                           (with-temp-rgns (invert-region)
                                             (let ((selection-region
                                                    (if (view-active-p item)
                                                      (table-selection-region item)
                                                      (table-outline-region item))))
                                               (#_CopyRgn selection-region invert-region)
                                               (compute-selection-regions item)
                                               (when (not colored-cells-p)
                                                 (#_DiffRgn invert-region selection-region invert-region)
                                                 (#_InvertRgn invert-region))
                                               (cell-select item h v)))))  ; << fixes bengtsons double click thing
                                       (progn 
                                         (when hash
                                           (when colored-cells-p  ; <<
                                             (deselect-cells item))
                                           (clrhash hash)
                                           (setf (first-selected-cell-slot item) nil)
                                           (when (not colored-cells-p) ; <<
                                             (#_InvertRgn (if (view-active-p item)
                                                            (table-selection-region item)
                                                            (table-outline-region item))))
                                           (compute-selection-regions item))
                                         (cell-select item h v))))))))
                            ((and (eq type :contiguous)
                                  command-key-p
                                  (eql h start-h)(eql v start-v))                          
                             (deselect-cells item)
                             (when (not start-selected-p)(cell-select item h v)))
                            ((and (eq type :contiguous)
                                  shift-key-p
                                  (cell-selected-p item h v))
                             (deselect-cells-above item h v))                           
                            (t #|(or (and moved
                                         (or shift-key command-key)
                                         (or contiguous disjoint))
                                    (and contiguous shift-key (not selected)))
                                |#
                               (let* ((p (if (eq type :contiguous)(first-selected-cell item)))
                                      (first-h (if p (point-h p) start-h))
                                      (first-v (if p (point-v p) start-v)))
                                 (if (and (eq type :contiguous)  ; don't know bout this
                                          shift-key-p
                                          (neq 1 (point-h (table-dimensions item)))
                                          ;(not (cell-selected-p item h v)) ; always true
                                          )
                                   (multiple-value-bind (max-h max-v)(max-selected-h&v item)
                                     (select-cells-between item
                                                           (min first-h h)
                                                           (min first-v v)
                                                           (max first-h h max-h)
                                                           (max first-v v max-v)))
                                   (select-cells-between item first-h first-v h v))
                                 #+ignore
                                 (when (and (eq type :contiguous) 
                                            (neq 1 (point-h (table-dimensions item))))
                                   (deselect-cells-above item  h v))))))))
                 (when (not (#_stilldown))(return))
                 (if (eql where (%get-local-mouse-position))                   
                   (unless (wait-mouse-up-or-moved) (return)))
                 (setq where (view-mouse-position container)) 
                 ;(%run-masked-periodic-tasks) ;; is this of any use?
                 ))))
            (dialog-item-action item)))))))

(defun get-local-mouse-position ()
  (rlet ((pt :point))
    (#_GetMouse pt)
    (%get-point pt)))

(defmethod deselect-cells-between ((item table-dialog-item) first-h first-v h v)
  (when (< h first-h)
    (rotatef h first-h))
  (when (< v first-v)
    (rotatef v first-v))
  (loop for i from first-h to h
        do
        (loop for j from first-v to v
              do
              (cell-deselect item i j))))

(defmethod select-cells-between ((item table-dialog-item) first-h first-v h v)
  (when (< h first-h)
    (rotatef h first-h))
  (when (< v first-v)
    (rotatef v first-v))
  (loop for i from first-h to h
        do
        (loop for j from first-v to v
              do
              (cell-select item i j))))

(defmethod deselect-cells-above ((item table-dialog-item) h v)
  (let ((hash (table-selection-hash item)))
    (when hash
      (let ((f #'(lambda (k val)
                   (declare (ignore val))
                   (when (or (> (car k) h)
                             (> (cdr k) v))
                     (cell-deselect item k)))))
        (declare (dynamic-extent f))
        (maphash f hash)))))

(defmethod max-selected-h&v ((item table-dialog-item))
  (let* ((hash (table-selection-hash item))
         (max-h -1)
         (max-v -1))    
    (when hash        
      (let ((f #'(lambda (k val)
                   (declare (ignore val))
                   (setq max-h (max max-h (car k)))
                   (setq max-v (max max-v (cdr k))))))
        (declare (dynamic-extent f))
        (maphash f hash)))
    (values max-h max-v)))

(defmethod deselect-cells ((item table-dialog-item))
  (let ((hash (table-selection-hash item)))
    (when hash
      (let ((f #'(lambda (k v)
                   (declare (ignore v))
                   (cell-deselect item k))))
        (declare (dynamic-extent f))
        (maphash f hash)))))
  

#| ; unused and wrong
(defmethod last-selected-cell ((item table-dialog-item))
  (let ((hash (table-selection-hash item)))
    (when (and hash (neq 0 (hash-table-count hash)))
      (let ((max-h 0)
            (max-v 0))
        (maphash #'(lambda (key val)
                     (declare (ignore val))
                     (setq max-h (max max-h (car key)))
                     (setq max-v (max max-v (cdr key))))
                 hash)
        (make-point max-h max-v)))))
|#


#|
(defun colored-cells-p (item)
  (and (eq (cell-colors item) :background)
       (or (table-cell-color-hash item)
           (let ((pclist (part-color-list item)))
             (do* ((x pclist (cddr x)))
                  ((null x) nil)
               (let ((key (car x)))
                 (when (and (or (integerp key)(consp key))(cadr x))
                   (return t))))))))
|#

(defmethod colored-cells-p ((item table-dialog-item))
  (and (eq (cell-colors item) :background)
       (let ((hash (table-cell-color-hash item)))
         (and hash (neq 0 (hash-table-count hash))))))
  

(defvar *last-auto-scroll-time* 0)
(defparameter *auto-scroll-period* 6)    ; minimum 1/10 second between auto-scrolls

(defun do-auto-scroll (item left-column top-row columns rows where-h where-v left top right bottom)
  (declare (fixnum where-h where-v left top right bottom))
  (unless (or (and (<= left where-h) (< where-h right)
                   (<= top where-v) (< where-v bottom))
              (> *auto-scroll-period*
                 (%tick-difference (get-tick-count) *last-auto-scroll-time*)))
    (setq *last-auto-scroll-time* (get-tick-count))
    (let* ((cell-size (cell-size item))
           (cell-size-h (point-h cell-size))
           (cell-size-v (point-v cell-size)))
      (cond ((< where-h left)
             (decf left-column (ceiling (- left where-h) cell-size-h))
             (when (< left-column 0)
               (setq left-column 0)))
            ((>= where-h right)
             (let ((delta-columns (floor (- where-h right) cell-size-h)))
               (declare (fixnum delta-columns))
               (unless (< (- where-h (* delta-columns cell-size-h)) right)
                 (incf delta-columns))
               (incf left-column delta-columns)
               (let ((visible-columns (floor (- right left) cell-size-h)))
                 (declare (fixnum visible-columns))
                 (when (> (+ left-column visible-columns) columns)
                   (setq left-column (- columns visible-columns)))))))
      (cond ((< where-v top)
             (decf top-row (ceiling (- top where-v) cell-size-v))
             (when (< top-row 0)
               (setq top-row 0)))
            ((>= where-v bottom)
             (let ((delta-rows (floor (- where-v bottom) cell-size-v)))
               (declare (fixnum delta-rows))
               (unless (< (- where-v (* delta-rows cell-size-v)) bottom)
                 (incf delta-rows))
               (incf top-row delta-rows)
               (let ((visible-rows (floor (- bottom top) cell-size-v)))
                 (declare (fixnum visible-rows))
                 (when (> (+ top-row visible-rows) rows)
                   (setq top-row (- rows visible-rows))))))))
    (scroll-to-cell item left-column top-row)
    (window-update-event-handler (view-window item)))
  (values left-column top-row))

(defmethod find-clicked-cell ((item table-dialog-item) where)
  (setq where (convert-coordinates where (view-container item) item))  
  (let* ((top-row (table-top-row item))
         (left-column (table-left-column item))
         (cell-size (cell-size item))
         (sep-width (point-h (separator-size item)))
         (sep-height (point-v (separator-size item)))
         (where-h (point-h where))
         (where-v (point-v where))
         (column (if (column-widths-hash item)
                   (let ((width 0))
                     (do-column-widths (item column-width column) (left-column)
                       (when (> (incf width column-width) where-h)
                         (return column))))
                   (+ left-column 
                      (if (zerop (point-h cell-size))
                        0
                        (floor where-h (+ (point-h cell-size) sep-width))))))
         (row (if (row-heights-hash item)
                (let ((height 0))
                  (do-row-heights (item row-height row) (top-row)
                    (when (> ( incf height row-height) where-v)
                      (return row))))
                (+ top-row 
                   (if (zerop (point-v cell-size))
                     0
                     (floor where-v (+ (point-v cell-size) sep-height)))))))
    (let* ((table-cols (table-columns item))
           (table-rows (table-rows item)))
      (values (max 0 (min (1- table-cols) column))
              (max 0 (min (1- table-rows) row))
              (and (<= 0 column (1- table-cols))
                   (<= 0 row (1- table-rows)))))))


(defmethod redraw-cell ((item table-dialog-item) h &optional v)
    "redraws a single cell.  Avoids having to redraw a whole table"
    (when (wptr item)
      (normalize-h&v h v)
      (let* ((cell-pos (cell-position item h v))
             (cell-width (table-column-width item h))
             (cell-height (table-row-height item v)))
        (when cell-pos
          (with-focused-view (view-container item)
            (progn #|with-back-color (or (and (eq (cell-colors item) :background)
                                      (part-color-h-v item h v))
                                 (part-color item :body))|#
              (rlet ((cell-rect :rect
                                :topleft cell-pos
                                :bottomright (add-points cell-pos (make-point cell-width cell-height))))
                #+ignore
                (let* ((pos (view-position item))
                       (botright (add-points pos (table-inner-size item))))                  
                  (with-temp-rgns (temp-rgn)
                     (#_SetRectRgn temp-rgn (point-h pos) (point-v pos) (point-h botright) (point-v botright))
                     (with-clip-region temp-rgn
                       (#_EraseRect cell-rect)  ;; draw-table-cell does this
                       )))
                (%draw-table-cell-new item h v cell-rect (cell-selected-p item h v)))))))))

;; does make-point h,v fit in a fixnum
(defun fixnum-point-p (h v)
  (macrolet ((signed-byte-16-p (x)
               `(and (fixnump ,x)
                     (locally (declare (fixnum ,x))
                       (and (<= ,x #x7fff)
                            (>= ,x #x-8000))))))
    (and (signed-byte-16-p h)
         (<= v (ash #x7fff (- ppc::fixnum-shift)))
         (>= v (ash #x-8000 (- ppc::fixnum-shift))))))

(defmethod part-color-h-v ((item table-dialog-item) h v)  
  (let ((hash (table-cell-color-hash item)))
    (when hash
      (if (not (fixnum-point-p h v))
        (let ((key (cons h v)))
          (declare (dynamic-extent key)) 
          (gethash key hash))
        (let ((key (make-point h v)))
          (gethash key hash))))))

#|
(defmethod part-color-h-v ((item table-dialog-item) h v)
  (macrolet ((signed-byte-16-p (x)
               `(and (fixnump ,x)
                     (locally (declare (fixnum ,x))
                       (and (<= ,x #x7fff)
                            (>= ,x #x-8000))))))
    (if (or (not (signed-byte-16-p h))
            (> v (ash #x7fff (- ppc::fixnum-shift)))
            (< v (ash #x-8000 (- ppc::fixnum-shift))))
            
      (let ((key (cons h v)))
        (declare (dynamic-extent key))
        (part-color item key))
      (part-color item (make-point h v)))))
|#

(defmethod point-to-cell ((item table-dialog-item) h &optional v)
  (when (installed-item-p item)
    (normalize-h&v h v)
    (let* ((cell-size (cell-size item))
           (cell-size-h (point-h cell-size))
           (cell-size-v (point-v cell-size))
           (sep-width (point-h (separator-size item)))
           (sep-height (point-v (separator-size item)))
           (top-row (table-top-row item))
           (left-column (table-left-column item))
           (pos (view-position item))
           (pos-h (point-h pos))
           (pos-v (point-v pos))
           (inner-size (table-inner-size item))
           (inner-h (point-h inner-size))
           (inner-v (point-v inner-size)))
      (when (and (<= pos-h h (+ pos-h inner-h))
                 (<= pos-v v (+ pos-v inner-v)))
        (decf h pos-h)
        (decf v pos-v)
        (let ((cell-h (if (column-widths-hash item)
                                 (let ((width 0))
                                   (do-column-widths (item column-width column) (left-column)
                                                     (when (> (incf width column-width) h)
                                                       (return column))))
                                 (+ left-column
                                    (if (eql cell-size-h 0)
                                      0
                                      (floor h (+ cell-size-h sep-width))))))
              (cell-v (if (row-heights-hash item)
                                 (let ((height 0))
                                   (do-row-heights (item row-height row) (top-row)
                                                   (when (> (incf height row-height) v)
                                                     (return row))))
                                 (+ top-row
                                    (if (eql cell-size-v 0)
                                      0
                                      (floor v (+ cell-size-v sep-height)))))))
          (when (and (< cell-h (table-columns item))
                     (< cell-v (table-rows item)))
            (make-big-point cell-h cell-v)))))))

(defmethod set-table-dimensions ((item table-dialog-item) h &optional v 
                                     &aux (pt (make-big-point h v)))
  (let* ((h (point-h pt))
         (v (point-v pt)))
    (when (installed-item-p item)
      (with-focused-dialog-item (item)
        (let* ((old-dims (table-dimensions item))
               (old-dims-greater? (or (%i> (point-h old-dims) h) (%i> (point-v old-dims) v)))
               #+(or :ccl-4 :ccl-3.1)
               (old-bottom-right (cell-position-possibly-invisible item old-dims)))
          (when old-dims-greater?
            (let* ((sh (table-left-column item))
                   (sv (table-top-row item)))
              (if (or (>= sh h)(>= sv v))                
                (let ((vis-dims (visible-dimensions item)))
                  (scroll-to-cell item 
                                  (max 0 (- h (point-h vis-dims)))
                                  (max 0 (- v (point-v vis-dims)))))))
            (flet ((mapper (item sh sv)
                     (if (or (>= sh h)(>= sv v))
                       (cell-deselect item sh sv))))
              (declare (dynamic-extent #'mapper))
              (new-map-selected-cells item #'mapper)))
          #+(or ccl-4 :ccl-3.1)
          (let* ((pos (view-position item))
                 (size (add-points (table-inner-size item) pos))
                 (pos-h (point-h pos))
                 (pos-v (point-v pos))
                 (size-h (point-h size))
                 (size-v (point-v size))
                 (new-bottom-right (cell-position-possibly-invisible item pt))
                 (old-br-h (min (point-h old-bottom-right) size-h))
                 (old-br-v (min (point-v old-bottom-right) size-v))
                 (new-br-h (min (point-h new-bottom-right) size-h))
                 (new-br-v (min (point-v new-bottom-right) size-v))
                 (parent (view-container item)))
            (setq old-bottom-right (make-point old-br-h old-br-v))
            (setq new-bottom-right (make-point new-br-h new-br-v))
            ;; this was invalidating the wrong stuff - 0 vs pos-v etc
            (cond ((< old-br-h new-br-h)
                   (invalidate-corners parent (make-point old-br-h pos-v) new-bottom-right nil))
                  ((< new-br-h old-br-h)
                   (invalidate-corners parent (make-point new-br-h pos-v) old-bottom-right t)))
            (cond ((< old-br-v new-br-v)
                   (invalidate-corners parent (make-point pos-h old-br-v) new-bottom-right nil))
                  ((< new-br-v old-br-v)
                   (invalidate-corners parent (make-point pos-h new-br-v) old-bottom-right t))))
          #-(or :ccl-4 :ccl-3.1)        ; 3.0 & 3.9 table users expect a total invalidation
          (invalidate-view item))))
    (setf (table-rows item) v
          (table-columns item) h))
  (fixup-scroll-bars item)
  pt)

(defmethod table-dimensions ((item table-dialog-item))
  (make-big-point (table-columns item) (table-rows item)))

; This still has a bug that it validates more than it should.
(defmethod set-cell-size ((item table-dialog-item) h &optional v
                          &aux (new-size (make-point h v)))
  (unless (and (> (point-h new-size) 0)
               (> (point-v new-size) 0))
    (report-bad-arg new-size 'unsigned-byte))   ; Screw: not the right type, really.
  (let ((old-cell-size (cell-size item)))
    (setf (slot-value item 'visible-dimensions) nil)
    (setf (slot-value item 'cell-size) new-size)
    (when (installed-item-p item)
      (if (eql (point-v new-size) (point-v old-cell-size))
        (let ((inner-size (table-inner-size item)))
          (invalidate-all-but-left-column item inner-size inner-size))
        (invalidate-view item t))
      (fixup-scroll-bars item))))

(defmethod set-cell-font ((item table-dialog-item) cell font-spec)
  (let ((cell-fonts (table-cell-fonts item))
        (key (cons (point-h cell) (point-v cell))))
    (if font-spec
      (multiple-value-bind (one two)
                           (multiple-value-bind (ff ms) (view-font-codes item)
                             (font-codes font-spec ff ms))
        (unless cell-fonts
          (setq cell-fonts
                (setf (table-cell-fonts item) (make-hash-table :test 'equal))))
        (setf (gethash key cell-fonts) (cons one two)))
      (when cell-fonts
        (remhash key cell-fonts))))
  (let* ((container (view-container item))
         (pos (and container (cell-position item cell))))
    (when pos
      (invalidate-corners
       container pos
       (add-points pos
                   (make-point (table-column-width item (point-h cell))
                               (table-row-height item (point-v cell)))))))
  font-spec)

(defmethod cell-font ((item table-dialog-item) h &optional v)
  (normalize-h&v h v)
  (let ((cell-fonts (table-cell-fonts item))
        (key (cons h v)))
    (declare (dynamic-extent key))
    (when cell-fonts
      (let ((one.two (gethash key cell-fonts)))
        (and one.two
             (font-spec (car one.two) (cdr one.two)))))))

(defun invalidate-all-but-left-column (item old-inner-size inner-size)
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (let* ((pos (view-position item))                  
             (2-chars-wide (multiple-value-bind (a d w) (font-info) a d (* 2 w))))
        (let ((isize (if (< (point-h inner-size)(point-h old-inner-size))
                       inner-size
                       old-inner-size)))
          (invalidate-corners 
           *current-view*
           (add-points pos (make-point (- (point-h isize) 2-chars-wide) 0))
           (add-points pos (view-size item))   ;; was isize
           t))))))

(defmethod set-view-size ((item table-dialog-item) h &optional v &aux
                             (new-size (make-point h v))
                             (inner-size (table-inner-size item new-size))
                             (old-size (view-size item))
                             (visible-dimensions (visible-dimensions item)))
                             
  (unless (eql new-size old-size)
    (without-interrupts
     (setf (slot-value item 'visible-dimensions) nil)     
     (if (installed-item-p item)
       (progn
         (let ((old-inner-size (table-inner-size item)))
           (call-next-method)
           (when t ;(osx-p)  ;; << workaround for resize turds - the real bug is elsewhere, but where?
             (let ((w (view-window item)))
               (when (and (not (window-theme-background w))(slot-value w 'back-color))
                 (with-focused-view w
                   (window-update-event-handler w)))))           
           (maybe-need-scroll-bars item)
           (setq inner-size (table-inner-size item new-size))  ; may have changed
           (cond ((<= (point-h (table-dimensions item)) 1)    ; or (sequence-order wrap-length)
                  (set-cell-size item
                                 (make-point (max 1 (point-h inner-size))
                                             (max 1 (point-v (cell-size item))))))
                 (t (fixup-scroll-bars item)))
           ;; was this wrong in original??
           (invalidate-all-but-left-column item  old-inner-size inner-size)))
       (call-next-method))     
     (let* ((left-column (table-left-column item))
            (top-row (table-top-row item)))       
       (when (installed-item-p item)
         (scroll-to-cell item left-column top-row)
         (let* ((new-left-column (table-left-column item))
                (new-top-row (table-top-row item))
                (old-dims-v (point-v visible-dimensions))
                (old-dims-h (point-h visible-dimensions)))
           (unless (and (eql left-column new-left-column)
                        (eql top-row new-top-row))
             (with-focused-dialog-item (item)
               (let ((2-chars-wide (multiple-value-bind (a d w) (font-info) a d (* 2 w)))
                     (top-left (cell-position item left-column top-row)))
                 (when top-left
                   (validate-corners (view-container item)
                                     top-left
                                     (add-points top-left
                                                 (make-point (- (if (column-widths-hash item)
                                                                  (let ((width 0))
                                                                    (do-column-widths (item column-width)
                                                                                      (left-column (+ left-column old-dims-h))
                                                                      (incf width column-width))
                                                                    width)
                                                                  (* (point-h (cell-size item)) old-dims-h))
                                                                2-chars-wide)
                                                             (if (row-heights-hash item)
                                                               (let ((height 0))
                                                                 (do-row-heights (item row-height)
                                                                                 (top-row (+ top-row old-dims-v))
                                                                   (incf height row-height))
                                                                 height)
                                                               (* (point-v (cell-size item)) old-dims-v))))))))))))
     (compute-selection-regions item)
     ))
  new-size)

(defun toggle-selection-region (item)
  (with-focused-dialog-item (item)
    (let ((selection-rgn (if (view-active-p item)
                           (table-selection-region item)
                           (table-outline-region item))))
      (with-hilite-mode
        (#_InvertRgn selection-rgn)))))

(defmethod dialog-item-disable ((item table-dialog-item))
  (when (dialog-item-enabled-p item)
    (setf (dialog-item-enabled-p item) nil)
    (let ((hscroll (table-hscroll-bar item))
          (vscroll (table-vscroll-bar item)))
      (when hscroll
        (dialog-item-disable hscroll))
      (when vscroll
        (dialog-item-disable vscroll)))
    (when (installed-item-p item)
      (invalidate-view item))))

(defmethod dialog-item-enable ((item table-dialog-item))
  (unless (dialog-item-enabled-p item)
    (setf (dialog-item-enabled-p item) t)
    (let ((hscroll (table-hscroll-bar item))
          (vscroll (table-vscroll-bar item)))
      (when hscroll
        (dialog-item-enable hscroll))
      (when vscroll
        (dialog-item-enable vscroll)))
    (when (installed-item-p item)
      (invalidate-view item))))

;; not used?
(defun highlight-rect-frame (rect)
  (with-macptrs ((rgn  (#_newrgn))  ; temp regions already in use  
                 (rgn2 (#_newrgn)))
    (unwind-protect
      (progn
        (#_RectRgn rgn rect)
        (#_insetrect  rect 1 1)
        (#_rectrgn rgn2 rect)
        (#_DiffRgn  rgn rgn2 rgn)     
        (#_LMSetHiliteMode (%ilogand2 (%ilognot (ash 1 #$hiliteBit)) (#_LMGetHiliteMode)))
        (#_InvertRgn rgn))
      (when (and rgn (not (%null-ptr-p rgn)))
        (#_disposergn rgn))
      (when (and rgn2 (not (%null-ptr-p rgn2)))
        (#_disposergn rgn2)))))

(defun two-byte-script-p (script)
  (not (logbitp #$smsfSingByte (#_getscriptvariable script #$smscriptflags))))



;; disp-string is 7bit-ascii-p
;; not used today
#+ignore
(defun draw-string-crop (disp-string max-width)
  (with-pstr (p-string disp-string 0 (min 255 (length disp-string)))    
    (progn
      (#_truncstring max-width p-string #$truncEnd)
      (#_drawstring p-string))))

;; assumes focused and caller has done the correct #_moveto for #_drawtext
#|
(defun draw-string-crop-in-rect (disp-string max-width rect)
  (if (7bit-ascii-p disp-string)
    (draw-string-crop disp-string max-width)
    (let* ((len (length disp-string))
           (font-id (ash (grafport-font-codes) -16))
           (encoding (font-to-encoding-no-error font-id)))
      (if (and (memq encoding *script-list*)
               (neq encoding #$kcfstringEncodingMacCentralEurRoman)  ;; all for the sake of 1/4 etal
               (not (memq font-id *weird-fonts*)))
        (%stack-block ((ustr-buf (+ len len))
                       (out-buf (ash len 2)))
          (copy-string-to-ptr disp-string 0 len ustr-buf)        
          (with-macptrs ((cfstr (#_CFstringCreateWithCharacters (%null-ptr)
                                 ustr-buf len)))
            (rlet ((used-len :signed-long))
              (cfstringGetBytes cfstr 0 len encoding #xff nil out-buf (ash len 2) used-len)      
              (let ((to-len (%get-signed-long used-len)))
                (rlet ((rlength :signed-integer to-len))
                  (#_cfrelease cfstr)
                  (#_trunctext max-width out-buf rlength #$truncEnd)
                  (#_drawtext out-buf 0 (%get-signed-word rlength)))))))
        (draw-theme-text-box disp-string rect :left :end)))))
|#

(defun grafport-font-codes-with-color ()
  (multiple-value-bind (ff ms)(grafport-font-codes)
    (let* ((foo (grafport-fore-color))) ;; 0 is black is 0    
      (if (neq foo 0)(setq ff (logior (logand ff (lognot #xff)) (fred-palette-closest-entry foo))))
      (values ff ms))))

(defun color->ff-index (color)
   (if (and color (neq color *black-color*))
     (fred-palette-closest-entry color)
     0))



(export 'draw-string-in-rect :ccl)

;  *    oLineBreak:
;  *      On return, the value specifies the soft line break as
;  *      determined by ATSUBreakLine. If the value returned is the same
;  *      value as specified in iLineStart , you have made an input
;  *      parameter error. In this case, check to make sure that the line
;  *      width specified in iLineWidth is big enough for ATSUBreakLine
;  *      to perform line breaking. ATSUBreakLine does not return an
;  *      error in this case.

;; don't errchk - may get -8808 

;; (defconstant #$kATSULineBreakInWord -8808)       ;     This is not an error code but is returned by ATSUBreakLine to 
;     indicate that the returned offset is within a word since there was
;     only less than one word that could fit the requested width.

(defun atsu-line-break-given-layout (layout start width)
  (rlet ((outoff :ptr))
    (#_atsubreakline layout start (#_long2fix width) t outoff)
    (let ((res (%get-unsigned-long outoff)))
      (if (eql res start)(error "phooey"))
      res)))

;; do multiple lines
;; use macro
(defun draw-string-in-rect (string rect &key
                                   truncation justification compress-p
                                   (start 0)(end (length string))
                                   ff ms color)
  (when (not (and ff ms))(multiple-value-setq (ff ms)(grafport-font-codes-with-color)))
  (when color
    (setq ff (logior (logand ff (lognot #xff)) (color->ff-index color))))
  (when (not (simple-string-p string))
    (multiple-value-setq (string start end)(string-start-end string start end)))
  (multiple-value-bind (line-ascent descent width leading)(font-codes-info ff ms)
    (declare (ignore width))
    (with-clip-rect-intersect rect ;; can we assume callers have done this? - nah let callers assume done here
      (let* ((numchars (- end start))
             (hpos (pref rect :rect.left))
             (vpos (pref rect :rect.top))
             (max-width (- (pref rect :rect.right) hpos)))
        (unless (eq numchars 0)
          (%stack-block ((ubuff (%i+ numchars numchars)))
            (copy-string-to-ptr string start numchars ubuff)
            (with-atsu-layout (layout ubuff numchars ff ms)
              (when (and truncation (neq truncation :none))
                (set-layout-line-truncation-given-layout layout truncation (null compress-p))) ;; aha need no-squash-p                
              (set-layout-line-width-given-layout layout max-width)
              (when justification  ;; doesnt work - fixed now
                (set-layout-line-justification-given-layout layout justification))
              (cond
               ((and truncation (neq truncation :none))
                (errchk (#_atsudrawtext layout 0 numchars
                         (#_long2fix hpos)
                         (#_long2fix (%i+ vpos line-ascent)))))
               (t
                (let* ((line-height (%i+ line-ascent descent leading))
                       (rect-height (- (pref rect :rect.bottom) vpos))
                       (now-height 0)
                       (my-start 0))                      
                  (loop
                    (let ((next (atsu-line-break-given-layout layout my-start max-width)))
                      ;(cerror "g" "h ~a ~a ~A ~a" my-start numchars next (- next my-start))
                      (errchk (#_atsudrawtext layout my-start (- next my-start)
                               (#_long2fix hpos)
                               (#_long2fix (%i+ vpos line-ascent))))
                      (setq my-start next)
                      (when (%i>= my-start numchars)(return))
                      (setq now-height (%i+ now-height line-height))
                      (when (%i>= now-height rect-height)(return))
                      (setq vpos (%i+ vpos line-height))))))))))))
    nil))

;;; Sequence Dialog items
(defclass sequence-dialog-item (table-dialog-item)
  ((default-table-sequence :allocation :class :initform '(0 1 2))  ; this is realy stupid
    (table-sequence :initarg :table-sequence)
    (sequence-order :initarg :sequence-order)
    (sequence-wrap-length :initarg :sequence-wrap-length))
  (:default-initargs 
    :sequence-order :vertical 
    :sequence-wrap-length most-positive-fixnum)
)

(defmethod initialize-instance ((item sequence-dialog-item) &rest rest
                                &key
                                (table-sequence nil sequencep) table-dimensions 
                                sequence-order sequence-wrap-length
                                &aux sequence-length)
  (declare (dynamic-extent rest))
  (when (null sequencep)
    (setq table-sequence (slot-value item 'default-table-sequence)))
  (setq sequence-length (length table-sequence))
  (when (null table-dimensions)
    (setq table-dimensions
          (let* ((dimen-prime 1)
                 (dimen-aux 1))
            (if (<= sequence-length sequence-wrap-length)
              (setq dimen-prime sequence-length)
              (setq dimen-prime sequence-wrap-length
                    dimen-aux (ceiling sequence-length sequence-wrap-length)))
            (case sequence-order
              (:vertical
               (make-big-point dimen-aux dimen-prime))
              (:horizontal
               (make-big-point dimen-prime dimen-aux))
              (otherwise
               (report-bad-arg sequence-order '(member :horizontal :vertical)))))))
  (apply #'call-next-method
         item 
         :table-sequence table-sequence
         :sequence-order sequence-order
         :sequence-wrap-length sequence-wrap-length
         :table-dimensions table-dimensions
         rest)
  (set-table-sequence item table-sequence))

#|
(defmethod table-add-sub ((item sequence-dialog-item) new-cell)
  (when new-cell
    (if (neq 1 (point-h (table-dimensions item)))
      (call-next-method)
      (let* ((old-cells (selected-cells item)))
        (if (null old-cells)
          (cell-select item new-cell)
          (let* ((new-idx (cell-to-index item new-cell)))
            (when new-idx ; sigh
              (let* ((imax (cell-to-index item (car old-cells)))
                     (last-cell (car (last old-cells)))
                     (imin (cell-to-index item last-cell)))
                ;(print (list new-idx imin imax))
                (if (< new-idx imin)
                  (dotimes (i (- imin new-idx))
                    (cell-select item (index-to-cell item (+ new-idx i))))
                  (if (> new-idx imax)
                    (dotimes (i (- new-idx imax))
                      (cell-select item (index-to-cell item (+ imax i 1))))
                    (dotimes (i (- imax new-idx))
                      (cell-deselect item (index-to-cell item (+ 1 new-idx i))))))))))))))
|#

(defmethod table-sequence ((item sequence-dialog-item))
  (slot-value item 'table-sequence))

(defmethod (setf table-sequence) (value (item sequence-dialog-item))
  (set-table-sequence item value))

(defmethod set-table-sequence ((item sequence-dialog-item) new-seq)
  (let ((sequence-wrap-length (slot-value item 'sequence-wrap-length))
        (sequence-order (slot-value item 'sequence-order)))
    (let* ((old-seq (table-sequence item))
           (old-dims (table-dimensions item))
           (length (length new-seq))
           (prim (min length sequence-wrap-length))
           (sec (if (= prim 0) 0 (ceiling length prim)))
           new-dims)
      (let* (;(handle (dialog-item-handle item))
             ;(active-p (and handle (href handle :ListRec.lactive)))
             (f #'(lambda (item h v)
                    (let ((index (cell-to-index item h v)))
                      (when (and index (>= index length))
                        (cell-deselect item h v))))))
        (new-map-selected-cells item f))
      (without-interrupts
       (setf (slot-value item 'table-sequence) new-seq)
       (set-table-dimensions 
        item
        (setq new-dims
              (if (eq sequence-order :horizontal)
                (make-big-point prim sec)
                (make-big-point sec prim)))))
      (unless (and (equal old-dims new-dims)
                   (or (eq old-seq new-seq)
                       (every #'eq old-seq new-seq)))
        (when (installed-item-p item)
          (maybe-need-scroll-bars item)
          (invalidate-corners item #@(0 0) (table-inner-size item) nil)))
      new-seq)))

(defmethod cell-to-index ((item sequence-dialog-item) h &optional v
                             &aux index)
  "Returns nil if there is no index corresponding to cell"
  (let ((table-dimensions (table-dimensions item))
        (table-sequence (table-sequence item))
        (sequence-order (slot-value item 'sequence-order)))
    (normalize-h&v h v)
    (setq index
          (if (eq sequence-order :horizontal)
            (+ (* (point-h table-dimensions) v) h)
            (+ (* (point-v table-dimensions) h) v)))
    (if (< index (length table-sequence)) index nil)))

(defmethod index-to-cell ((item sequence-dialog-item) index)
  (let ((sequence-order (slot-value item 'sequence-order))
        (table-dimensions (table-dimensions item)))
    (if (eq sequence-order :horizontal)
      (multiple-value-bind (ind-1 ind-2)
                           (floor index (point-h table-dimensions))
        (make-big-point ind-2 ind-1))
      (multiple-value-call #'make-big-point
                           (floor index (point-v table-dimensions))))))

(defmethod cell-to-index ((item table-dialog-item) h &optional v)
  (when (null v)
    (setq v (point-v h) h (point-h h)))
  (let* ((dims (table-dimensions item))
         (h-dim (point-h dims))
         (v-dim (point-v dims)))
    (if (and (< v v-dim)(< h h-dim))
      (+ h (* v h-dim)))))

(defmethod cell-contents ((item sequence-dialog-item) h &optional v
                          &aux index)
  (if (setq index (cell-to-index item h v))
      (elt (slot-value item 'table-sequence) index)
      nil))

(defmethod window-can-do-operation ((table sequence-dialog-item) op &optional item)
  (declare (ignore item))
  (and (eq op 'copy) (first-selected-cell table)))

;; put-scrap a lisp object and a textual representation thereof
(defun put-scraps (value text)
  (put-scrap :lisp value)
  (let ((mactext text))
    (when (not (7bit-ascii-p text))
      (setq mactext (convert-string text #$kcfstringencodingunicode #$kcfstringencodingmacroman)))
    (put-scrap-flavor :text mactext)
    (when (neq mactext text)  ;; unicode text preferred
      (put-scrap-flavor :|utxt| text))))

(defmethod copy ((table sequence-dialog-item))
  (let ((cells (selected-cells table)))
    (when cells      
      (cond ((null (cdr cells))
             (let ((cell (car cells)))
               (put-scraps (cell-contents table cell) (cell-contents-string table cell))))
            (t (let* ((vals nil)
                      (string (with-output-to-string (stream)
                                (setq vals (mapcar #'(lambda (cell)
                                                       (format stream "~A~%" (cell-contents-string table cell))
                                                       (cell-contents table cell))
                                                   cells)))))
                 (put-scraps vals string)))))))

#|
;;car-dialog-item takes a sequence of lists
;;it displays only the car of each list
;;this is used in the defs-in-buffer dialog
(defclass car-dialog-item (sequence-dialog-item) ())

(defmethod cell-contents ((item car-dialog-item) h &optional v)
  (declare (ignore h v))
  (car (call-next-method)))

(defmethod cell-value ((item car-dialog-item) cell &aux (index (point-v cell)))
  (elt (slot-value item 'table-sequence) index))
|#

;;;Specific Dialogs

(defclass keystroke-action-dialog (dialog) ())

(defmethod view-key-event-handler ((dialog keystroke-action-dialog) char
                                   &aux item)
  (if (or (eq char #\return) (eq char #\enter)(EQ CHAR #\ESC))
    (call-next-method)
    (when (setq item 
                (find char (dialog-items dialog 'dialog-item t)
                      :test #'(lambda (char item &aux text)
                                (and (dialog-item-enabled-p item)
                                     (dialog-item-action-p item)
                                     (%i> (length (setq text (dialog-item-text item)))
                                          0)
                                     (char-equal char (char text 0))))))
      (dialog-item-action item))))
                                           

(defparameter yorn-dlg-size #@(350 160))

#| ;; old one
(defun y-or-n-dialog (message &key (size yorn-dlg-size)
                           (position (list :top (+ 22 *menubar-bottom*)))
                           (yes-text "Yes")
                           (no-text "No")
                           (cancel-text "Cancel")
                           help-spec
                           (back-color *tool-back-color*)
                           window-type
                           (window-title ""))
  (modal-dialog
   (make-instance 'keystroke-action-dialog
          :window-type (or window-type :movable-dialog) ;:double-edge-box
          :view-size size
          :view-position position
          :window-show nil
          :window-title window-title
          :content-color back-color
          :back-color back-color
          :help-spec (getf help-spec :dialog)
          :view-subviews
          `(
            ,(make-dialog-item 'static-text-dialog-item
               #@(20 12) (subtract-points size #@(38 72))
               message nil :help-spec (getf help-spec :dialog))
            ,(make-dialog-item 'default-button-dialog-item               
              (subtract-points size #@(102 27))
               #@(74 18) (or yes-text "OK")  ; ????
               #'(lambda (item) 
                   (declare (ignore item))
                   (return-from-modal-dialog t))
               :help-spec (getf help-spec :yes-text))
            ;; make this be first non-default
            ,@(if cancel-text
                (list (make-dialog-item 'button-dialog-item                                        
                                        (make-point 25 (- (point-v size) 27))
                                        #@(74 18) cancel-text
                                        #'(lambda (item)
                                            (declare (ignore item)) 
                                            (return-from-modal-dialog :cancel))
                                        :help-spec (getf help-spec :cancel-text))))
            ,@(if no-text
                (list (make-dialog-item 'button-dialog-item
                                        (subtract-points size #@(102 53))
                                        #@(74 18) no-text
                                        #'(lambda (item)
                                            (declare (ignore item))
                                            (return-from-modal-dialog nil))
                                        :help-spec (getf help-spec :no-text))))))))
|#

#|
(y-or-n-dialog "fpp" :yes-text "sure enuf"
               :no-text "maybe later"
               :cancel-text "nah hate it")
|#
 ;; a version that lets the text be longer - what a concept
(defun y-or-n-dialog (message &key (size yorn-dlg-size)
                           (position (list :top (+ 22 *menubar-bottom*)))
                           (yes-text "Yes")
                           (no-text "No")
                           (cancel-text "Cancel")
                           help-spec
                           (back-color *tool-back-color*)
                           (theme-background t)
                           window-type
                           (window-title "" window-title-supp))
  (cond 
   ((and #|(osx-p)|# (not window-title-supp))
    (standard-alert-dialog message :position :main-screen :yes-text yes-text :no-text no-text :cancel-text cancel-text))
   (t
    (let ((the-dialog
           (make-instance 'keystroke-action-dialog
             :window-type (or window-type :movable-dialog) ;:double-edge-box
             :view-size size
             :view-position position
             :window-show nil
             :window-title window-title
             ;:content-color back-color
             :back-color back-color
             :theme-background theme-background
             :window-show nil
             :help-spec (getf help-spec :dialog))))
      (multiple-value-bind (ff ms)(view-font-codes the-dialog)
        (let* ((fudge (if (osx-p) 16 10))
               (button-hsize (max 74
                                  ;(if cancel-text (font-codes-string-width cancel-text ff ms) 0)
                                  (if yes-text (+ fudge (font-codes-string-width-for-control yes-text ff ms)) 0)
                                  (if no-text (+ fudge (font-codes-string-width-for-control no-text ff ms)) 0)))
               (button-vsize (max 18 (+ 2 (font-codes-line-height ff ms))))
               (cb-hsize (max 74 (if cancel-text (+ fudge (font-codes-string-width-for-control cancel-text ff ms)) 0)))
               )
          (APPLY 'add-subviews the-dialog 
                 `(,(make-dialog-item 'static-text-dialog-item
                                      #@(20 12) (subtract-points size #@(38 72))
                                      message nil :help-spec (getf help-spec :dialog))
                   ,(make-dialog-item 'default-button-dialog-item               
                                      (subtract-points size (make-point (+ button-hsize 20) (+ button-vsize 9)))  ;; position
                                      (make-point button-hsize button-vsize)  ;; size
                                      (or yes-text "OK")  ; ????
                                      #'(lambda (item) 
                                          (declare (ignore item))
                                          (return-from-modal-dialog t))
                                      :help-spec (getf help-spec :yes-text))
                   ,@(if cancel-text
                       (list (make-dialog-item 'button-dialog-item                                        
                                               (subtract-points size (make-point (+ button-hsize button-hsize 60)(+ button-vsize 9))) ; (- (point-v size) (+ button-vsize 9)))  ;; POSITION
                                               (make-point cb-hsize button-vsize) cancel-text
                                               #'(lambda (item)
                                                   (declare (ignore item)) 
                                                   (return-from-modal-dialog :cancel))
                                               :cancel-button t
                                               :help-spec (getf help-spec :cancel-text))))
                   ,@(if no-text
                       (list (make-dialog-item 'button-dialog-item
                                               (subtract-points size (make-point (+ button-hsize 20) (+ (* 2 button-vsize) 17))) ;#@(102 53))  ;;  POSITION
                                               (make-point button-hsize button-vsize) no-text
                                               #'(lambda (item)
                                                   (declare (ignore item))
                                                   (return-from-modal-dialog nil))
                                               :help-spec (getf help-spec :no-text))))))
          
          (modal-dialog the-dialog)
          ))))))

(defparameter *alert-types* '((:stop . #.#$kalertStopAlert)
                              (:note . #.#$kalertNoteAlert)
                              (:caution . #.#$kalertCautionAlert)
                              (:plain . #.#$kalertPlainAlert)))
(defun get-alert-type (type)
  (cond ((cdr (assq type *alert-types*)))
        ((and (fixnump type)(rassoc type *alert-types*))
         type)        
        (t (error  "Unknown alert type ~S" type))))


(defvar *cancel-char*)
(defvar *yes-char*)
(defvar *no-char*)

(add-pascal-upp-alist-macho 'modal-key-handler-proc "NewModalFilterUPP")


(defpascal modal-key-handler-proc (:ptr targetref :ptr eventrecord :ptr index :word)
  (declare (ignore-if-unused targetref index))
  (let ((res #$false))
    (when (eq (pref eventrecord :eventrecord.what) #$keydown)
      (when (eq 0 (logand (pref eventrecord :eventrecord.modifiers)
                          (logior #$cmdKey #$controlKey #$rightControlKey)))
        (let* ((char-code (logand (pref eventrecord :eventrecord.message) #$charcodemask))
               (char (code-char char-code)))
          (declare (fixnum char-code))
          (when (> char-code #x7f)  ;; not perfect but better than nothing for e.g. Finnish keyboard or option-something
            (setq char (convert-char-to-unicode char (get-key-script))))
          (cond ((and *no-char* (char-equal char *no-char*))
                 (%put-word index #$kAlertStdAlertOtherButton) 
                 (setq res -1))  ;; aka #$true
                ((and *yes-char* (or (eq char #\return)(eq char #\enter)(char-equal char *yes-char*)))
                 (%put-word index #$kAlertStdAlertOKButton)
                 (setq res -1))
                ((and *cancel-char* (or (eq char #\escape)(char-equal char *cancel-char*))) 
                 (%put-word index #$kAlertStdAlertCancelButton)
                 (setq res -1))))))
    res))

;; other options #$kWindowstaggerparentwindow #$kWindowStaggerMainScreen


(defun standard-alert-dialog (message &key (position :front-window)
                                      (yes-text "Yes")
                                      (no-text "No")
                                      (cancel-text "Cancel")
                                      (alert-type #$kalertcautionalert alert-type-p)
                                      explanation-text
                                      action-function
                                      help)
  (when  (not (fixnump position))
    (setq position
          (case position
            (:front-window #.#$kWindowAlertPositionParentWindow)
            (:center-front-window #.#$kWindowCenterParentWindow)
            (:main-screen #.#$kWindowAlertPositionMainScreen)
            (:center-main-screen #.#$kWindowCenterMainScreen)  ;; lower
            (t #.#$kWindowDefaultPosition))))  
  (when (not (or (stringp message)(encoded-stringp message)))
    (setq message (coerce message 'string)))
  (when (and explanation-text (not (or (stringp explanation-text)(encoded-stringp explanation-text))))
    (setq explanation-text (coerce explanation-text 'string)))
  (let ()
    (if alert-type-p
      (setq alert-type (get-alert-type alert-type)))
    (rlet ((params :AlertStdCFStringAlertParamRec)
           (the-alert-ptr :ptr)
           (alert-res :sint16))
      (#_GetStandardAlertDefaultParams params #$kStdCFStringAlertVersionOne)
      (with-cfstrs-hairy ((message-str message)(yes-str yes-text)(no-str no-text)(cancel-str cancel-text) (explanation-str explanation-text))
        (when cancel-text
          (setf (pref params :AlertStdCFStringAlertParamRec.cancelText) cancel-str)
          (setf (pref params :AlertStdCFStringAlertParamRec.cancelbutton) #$kAlertStdAlertCancelButton)) ;; make esc key work!
        (when no-text
          (setf (pref params :AlertStdCFStringAlertParamRec.otherText) no-str))
        (when yes-text
          (setf (pref params :AlertStdCFStringAlertParamRec.defaultText) yes-str))
        (if help
          (setf (pref params :AlertStdCFStringAlertParamRec.helpButton) T))
        ;; #+ignore  ;; dont know how to set the actual on screen position - now we know some options        
        (setf (pref params :AlertStdCFStringAlertParamRec.position) position)
        (flet ((first-char (text)(if (characterp text) text (char text 0))))
          (let ((*yes-char* (and yes-text (char-downcase (first-char yes-text))))
                (*no-char* (and no-text (char-downcase (first-char no-text))))
                (*cancel-char* (and cancel-text (char-downcase (first-char cancel-text)))))
            (let ((result (#_CreateStandardAlert
                           alert-type
                           message-str
                           (if explanation-text explanation-str *null-ptr*)  ;; some other string
                           params                         
                           the-alert-ptr)))
              (when (neq result #$noerr)(throw-cancel :cancel))
              ;; doesn't draw fully when called from Listener if more than 17 windows or so and timer is enabled
              (let () ;(*event-loop-initial-fire-time* 0.4d0))  ;; this helps but why?? - just change initial-fire-time
                (with-foreign-window 
                  (setq result (#_RunStandardAlert (%get-ptr the-alert-ptr) modal-key-handler-proc alert-res))))
              (WHEN (neq result #$noerr) (throw-cancel :cancel))
              (let ((action (%get-signed-word alert-res)))
                (if action-function
                  (funcall action-function action)
                  (case action 
                    (#.#$kAlertStdAlertOKButton t)
                    (#.#$kAlertStdAlertOtherButton nil)
                    (t (throw-cancel :cancel))))))))))))

;;;Search Dialog

(defvar *search-default* "")
(defvar *replace-default* "")
(defclass search-dialog (string-dialog) ())
;(defvar *search-dialog* nil)
(defvar *search-dialog-pos* '(:bottom 130))

(defun search-window-dialog (&aux (search-dialog (front-window :class 'search-dialog)))
  #-bccl (require 'fred-misc)
  (unless search-dialog
    (setq search-dialog
          (make-instance 'search-dialog
                         :window-title "String Search"
                         :view-position *search-dialog-pos*
                         :back-color *tool-back-color*
                         :theme-background t
                         :allow-empty-strings '(replace-text-item)
                         :view-size #@(374 108)
                         :help-spec 12081
                         :window-show nil))
    (add-subviews
     search-dialog
     (make-dialog-item 'default-button-dialog-item
                       #@(7 59) #@(114 18) "Search"                       
                       #'(lambda (item) (do-search (view-container item) :forward))
                       :help-spec 12084)
     (make-dialog-item 'button-dialog-item
                       #@(131 59)  #@(114 18) "Reverse"
                       #'(lambda (item) (do-search (view-container item) :reverse))
                       :view-nick-name 'reverse-search
                       :help-spec 12085)
     (make-dialog-item 'button-dialog-item
                       #@(255 59) #@(114 18) "From Top"
                       #'(lambda (item) (do-search (view-container item) :from-top))
                       :help-spec 12086)
     (make-dialog-item 'button-dialog-item
                       #@(7 84)  #@(114 18) "Replace"
                       #'(lambda (item) (do-replace (view-container item)))
                       :help-spec 12087
                       :view-nick-name 'replace-button)
     (make-dialog-item 'button-dialog-item
                       #@(131 84) #@(114 18) "Replace/Search"
                       #'(lambda (item)
                           (let ((my-dialog (view-container item)))
                             (do-replace my-dialog)
                             (do-search my-dialog :forward)))
                       :help-spec 12088
                       :view-nick-name 'replace/find-button)
     (make-dialog-item 'button-dialog-item
                       #@(255 84) #@(114 18) "Replace All"
                       #'(lambda (item)
                           (do-replace-all (view-container item)))
                       :view-nick-name 'replace-all
                       :help-spec 12089)
     (make-dialog-item 'static-text-dialog-item
                       #@(10 8) #@(94 16) "Search For:" nil :help-spec 12081)
     (make-dialog-item 'editable-text-dialog-item
                       #@(107 8) #@(251 16) *search-default* nil
                       :view-nick-name 'search-text-item
                       :help-spec 12082)
     (make-dialog-item 'static-text-dialog-item
                       #@(10 34) #@(94 16)  "Replace With:" nil
                       :help-spec 12081)
     (make-dialog-item 'editable-text-dialog-item
                       #@(107 34) #@(251 16) *replace-default* nil
                       :view-nick-name 'replace-text-item
                       :help-spec 12083)))
  (window-select search-dialog))

(defmethod update-default-button ((d search-dialog))
  (call-next-method)
  (set-dialog-item-enabled-p (view-named 'reverse-search d)
                             (dialog-item-enabled-p (default-button d)))
  (set-dialog-item-enabled-p (view-named 'replace-all d)
                             (dialog-item-enabled-p (default-button d))))

(defun do-search (w search-type)
  (let ((text (dialog-item-text (view-named 'search-text-item w)))
        (sw (target)))
    (when (eq search-type :from-top)
      (window-top sw))
    (window-search sw text (eq search-type :reverse)))
  (enable-replace w))

(defun do-replace (w)
  (let ((text (dialog-item-text (view-named 'replace-text-item w)))
        (sw (target)))
    (window-replace sw text))
  (enable-replace w))

(defun do-replace-all (w &aux
                         (search-text  (dialog-item-text (view-named 'search-text-item  w)))
                         (replace-text (dialog-item-text (view-named 'replace-text-item w)))
                         (search-win (target)))
  (when (and search-win 
             (> (length search-text) 0))
    (window-replace-all search-win search-text replace-text 0)
    (enable-replace w)))

(defmethod window-close :before ((w search-dialog))
  (setq *search-default*    (dialog-item-text (view-named 'search-text-item w))
        *replace-default*   (dialog-item-text (view-named 'replace-text-item w))
        *search-dialog-pos* (view-position w)
        ;*search-dialog* nil)
        ))

(defun enable-replace (w)
  (let ((sw (target))
        (b 0)
        (e 0))
    (when (and sw (method-exists-p 'selection-range sw))
      (multiple-value-setq (b e) (selection-range sw)))
    (let ((enable-p (neq b e)))
      (dolist (name '(replace-button replace-all replace/find-button))
        (set-dialog-item-enabled-p (view-named name w) enable-p)))))

(defmethod view-activate-event-handler :after ((w search-dialog))
  (let ((text (view-named 'search-text-item w)))
    (set-current-key-handler w text)
    (set-selection-range text 0 32000)
    (update-default-button w)
    (let ((enable-p (> (dialog-item-text-length text) 0)))
      (dolist (name '(replace-button  replace/find-button))
        (dialog-item-disable (view-named name w)))
      (set-dialog-item-enabled-p (view-named 'replace-all w) enable-p))))

#|
; Default's for search stuff, pass through to key-handler
(defun funcall-key-handler (window gf beep-p &rest args)
  (declare (dynamic-extent args))
  (apply #'funcall-if-method-exists 
         gf (and beep-p #'ed-beep) (current-key-handler window) args))
|#


; This should really be merged with window-do-operation
(defun maybe-apply-to-key-handler (window gf &rest args)
  (declare (dynamic-extent args))
  (let ((thing (current-key-handler window)))
    (if (or (not thing)
            (or (not gf) (not (apply 'method-exists-p gf thing args))))
      (progn (ed-beep) (cancel))
      (apply gf thing args))))

(defmethod window-top ((w window))
  (maybe-apply-to-key-handler w 'window-top))

(defmethod window-search ((w window) text &optional reverse-p silent-p)
  (maybe-apply-to-key-handler w 'window-search text reverse-p silent-p))

(defmethod selection-range ((w window))
  (selection-range (current-key-handler w)))

(defmethod window-replace ((w window) text)
  (maybe-apply-to-key-handler w 'window-replace text))

(defmethod window-replace-all ((w window) search-text replace-text &optional start)
  (maybe-apply-to-key-handler w 'window-replace-all search-text replace-text start))

#| ; testing
(defun t1 ()
  (let* ((w (make-instance 'window :WINDOW-TITLE "DISJOINT"))
        (d (make-instance 'sequence-dialog-item :selection-type :disjoint
                          :view-size #@(40 100)
                          :view-position #@(40 30)
                          :table-vscrollp t :table-hscrollp nil
                          :table-sequence '(asdf qwer qwer poias adsfa zzz
                                            789 poi hoi qwep ie hogty)
                          :view-container w)))))

(defun t2 ()
  (let* ((w (make-instance 'window :WINDOW-TITLE "CONTIG"
                           :back-color *light-gray-color*))
        (d (make-instance 'sequence-dialog-item :selection-type :contiguous
                          :view-size #@(50 100)
                          :table-vscrollp t :table-hscrollp nil
                          :table-sequence '(asdf qwer qwer poias adsfa zzz
                                            789 poi hoi qwep ie hogty)
                          :view-container w)))))

(defun t4 ()
  (let* ((w (make-instance 'window :WINDOW-TITLE "contig"
                           :back-color *light-gray-color*))
        (d (make-instance 'sequence-dialog-item :selection-type :contiguous
                          :view-size #@(200 100)
                          :table-vscrollp t :table-hscrollp nil
                          :table-sequence '(asdf qwer qwer poias adsfa zzz
                                            789 poi hoi qwep ie hogty)
                          :table-dimensions #@(2 6)
                          :sequence-wrap-length 6
                          :view-container w)))))

(defun t3 ()
  (let* ((w (make-instance 'window :WINDOW-TITLE "single" :theme-background t))
        (d (make-instance 'sequence-dialog-item :selection-type :single
                          :view-size #@(40 100)
                          :table-vscrollp t :table-hscrollp nil
                          :table-sequence '(asdf qwer qwer poias adsfa zzz)
                          :view-container w)))))
|#




(provide 'dialogs)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
