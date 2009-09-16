;;;  -*- Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 7/4/97   akh  see below
;;  17 1/22/97 akh  front-window returns first found rather than groveling whole window lis
;;  12 5/20/96 akh  windows - (find-class 'window) if arg is 'window
;;  11 4/24/96 akh  bill's fix for view-mouse-position
;;  8 3/9/96   akh  fixes for call-with-focused-view and call-with-port
;;  5 12/1/95  akh  %i+
;;  4 11/9/95  akh  add inverse-style-arg fix
;;  2 10/17/95 akh  merge patches
;;  11 6/6/95  akh  window-title and set-window-title deal with system script
;;  9 5/1/95   akh  remove misleading extended-character-p from do keydown-event
;;  8 4/28/95  akh  fix def-ccl-pointers fonts to be explicit about script
;;                  add a comment re: do-key-down-event is broken
;;  7 4/28/95  akh  probably no change
;;  3 4/10/95  akh  content-color initarg
;;  13 3/22/95 akh  fix stream-force-output for window
;;  12 3/20/95 akh  fix brain dead stream-force-output for window
;;  11 3/20/95 akh  dont remember
;;  10 3/14/95 akh  dont remember
;;  9 2/24/95  slh  window autopositioning!
;;  8 2/17/95  akh  change *window-object-alist* to a hash table
;;  7 2/9/95   akh  probably no change
;;  6 1/30/95  akh  incorporate kalmans patch to call-with-focused-view
;;  4 1/25/95  akh  windows get back-color initarg
;;  3 1/17/95  akh  use without-event-processing
;;  (do not edit before this line!!)

;; L1-windows.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2000 Digitool, Inc.

;; Modification History
;
; $Log: l1-windows.lisp,v $
; Revision 1.78  2006/04/03 00:06:45  alice
; ;; script-to-font-simple - dont do anything re arabic, grafport-write-unicode passes ff and ms to experimental-draw-text
;
; Revision 1.77  2006/03/21 20:20:15  alice
; ;; simplify grafport-write-unicode
;
; Revision 1.76  2006/03/13 00:31:04  alice
; ;;; pop-up-path-menu uses truename vs logical path
;; window-event knows about click in part #$inproxyIcon
;; ----- 5.2b1
;
; Revision 1.75  2006/02/03 03:17:39  alice
; ;; remove-view-from-window for simple view does nothing (so I can evaluate this file without messing up the world)
;
; Revision 1.74  2005/12/02 20:55:47  alice
; ;; don't say #$rdocproc
;
; Revision 1.73  2005/11/12 21:11:32  alice
; ;; Get-Osx-Font-List - Values Somewhat Different
;
; Revision 1.72  2005/09/10 09:44:24  alice
; ;; window-update-event-handler - assure wp non NIL before QDFlushPortBuffer
;
; Revision 1.71  2005/08/07 03:33:09  alice
; ;; window-preferred-screen-bounds - dont overlap dock
;
; Revision 1.70  2005/05/22 03:58:50  alice
; ;; ignore redundant install-collapse-handler in window-make-parts
;
;
; Revision 1.69  2005/05/07 08:41:33  alice
; ;; :window-type :overlay-window will work if OSX
;; add window-type slot to class window, use window-type in new-new-window, forget #_getwfrefcon stuff
;; funcall-with-foreign-window does with-cursor outside with-timer rather than inside
;
; Revision 1.68  2005/04/13 20:28:32  alice
; ;; simplify funcall-with-foreign-window
;
; Revision 1.67  2005/03/20 01:26:16  alice
; ;; use with-periodic-task-mask in window-drag-sub
;
; Revision 1.66  2005/03/12 04:34:31  alice
; ; reverse *script-list*
;
; Revision 1.65  2005/03/08 06:59:27  alice
; ; small changes to grafport-write-unicode
;
; Revision 1.64  2005/03/04 01:15:20  alice
; ; grafport-write-unicode somewhat more efficient
; script-to-font-simple does arabic song and dance or punts to system font
;
; Revision 1.63  2005/02/18 05:09:15  alice
; ; 02/08/05 forget about da-windows. fix ellipsis thing in window-menu-item
;
; Revision 1.62  2005/02/07 03:35:18  alice
; ; 02/03/05 set-window-title and grafport-write-string unicode savvy
;
; Revision 1.61  2004/12/20 21:57:20  alice
; ; 12/10/04 eol stuff
;
; Revision 1.60  2004/11/24 03:51:45  alice
; ; window-type :no-border-box is overlaywindow if (osx-p) and *use-overlay-window* true
;; ----- 5.1 final
;
; Revision 1.59  2004/11/05 20:06:21  alice
; ; window-live-grow does #_disable/enableScreenUpdates - thanks Alex R.
; funcall-with-foreign-window does (with-port %original-temp-port% - fixes 2 nav-services display bugs
;
; Revision 1.58  2004/10/19 01:02:07  alice
; ; window-live-grow behaves more sensibly when mouse goes inside minimum-size
;
; Revision 1.57  2004/10/11 02:20:25  alice
; ; window-live-grow does allow-view-draw-contents
;
; Revision 1.56  2004/10/03 06:23:11  alice
; ; export allow-view-draw-contents and mixin
; fix usage of wait-mouse-up-or-moved in window-live-grow
;
; Revision 1.55  2004/09/19 01:14:59  alice
; ; count mouse up events when timer is active - does this ever happen? - yep
;
; Revision 1.54  2004/09/15 04:35:22  alice
; ; define allow-view-draw-contents for NIL to do nothing
; make close and zoom bubbles work in allow-vdc windows
;
; Revision 1.53  2004/09/11 03:55:14  alice
; ; undo change to funcall-with-foreign-window - twas bad
;
; Revision 1.52  2004/09/07 01:33:09  alice
;  window-drag-sub does allow-view-draw-contents
; disable periodic-task in funcall-with-foreign-window
; maybe fix for collapse, zoom, close buttons misbehavior when timer is installed, disable periodic-task then
;
; Revision 1.51  2004/09/01 20:29:47  alice
; ; window-close-internal - move woi up
;
; Revision 1.50  2004/08/28 03:31:33  alice
; ; new-new-window - no shadow for single-edge-box, no-border-box. change wptr-dialog-p
;
; Revision 1.49  2004/08/11 03:57:37  alice
; ; tweak window-live-grow for minimum-size
;
; Revision 1.48  2004/08/03 01:48:40  alice
; tweak to window-live-grow
;
; Revision 1.47  2004/07/28 00:28:52  alice
; ;; also if new-control-dialog-item in a subview
;
; Revision 1.46  2004/07/22 21:21:39  alice
; ; put back second view-draw-contents in window-live-grow if default-button and ...
;
; Revision 1.45  2004/07/15 20:11:14  alice
; ;; window-mimimum-size -> view-minimum-size which already existed, remove woi in window-live-grow
;
; Revision 1.44  2004/07/14 15:25:28  alice
; ; add method window-minimum-size less than which window-live-grow will not go - default #@(40 40)
; window-live-grow - remove second view-draw-contents - seems OK now
;
; Revision 1.43  2004/07/10 03:56:18  alice
; ; find-window uses window-title
;
; Revision 1.42  2004/07/08 22:15:28  alice
; ; enable live resize on OS9
;
; Revision 1.41  2004/07/06 20:42:01  alice
; ; window gets another slot - window-prior-theme-drawing-state
;
; Revision 1.40  2004/07/04 08:19:41  alice
; ; don't need erase-anonymous-.. if theme-background
;
; Revision 1.39  2004/06/30 19:32:58  alice
; ; window-live-grow weirdness
;
; Revision 1.38  2004/06/27 23:49:53  alice
; ; window-live-grow does window-update-event-handler vs. view-draw-contents
;
; Revision 1.37  2004/06/26 16:40:13  alice
; ; woi in part of window-live-grow
;
; Revision 1.36  2004/06/26 02:57:30  alice
; ; add *live-resize-all-windows* - initially T but maybe NIL for release?
; window-grow-event-handler supports window live resize. flashy in some cases.
;
; Revision 1.35  2004/06/21 21:07:39  alice
;  ; invalidate-grow-icon does nothing, and don't call it, remove old stuff from window-send-behind
;
; Revision 1.34  2004/06/14 23:23:41  alice
;  ; fix window-grow-event-handler for metal window and resizing smaller
;
; Revision 1.33  2004/06/11 22:31:00  alice
; ; window-draw-grow-icon does nothing, remove some calls
;
; Revision 1.32  2004/06/04 05:09:13  alice
; ; initialize-instance for window passes view-font to window-make-parts and initialize-window
;; -------- 5.1b2
;
; Revision 1.31  2004/05/03 19:39:16  alice
; ; 05/02/04 initialize-instance for window, move view-font weirdness till later
;
; Revision 1.30  2004/05/02 01:27:06  alice
; ; 04/30/04 window no longer instance-initialize-mixin, but initialize-instance of window still has &allow-other-keys
;
; Revision 1.29  2004/04/26 04:05:21  alice
; ; now window has the misfortune of being instance-initialize-mixin because view isn't
; 04/25/04 instance-initialize -> initialize-instance in some cases
;
; Revision 1.28  2004/03/25 08:23:08  alice
; ; 03/24/04 defgeneric window-make-parts and initialize-window
;
; Revision 1.27  2004/03/21 23:06:32  alice
; ; 03/20/04 funcall-with-foreign-window binds *interrupt-level* to 0 so timer will fire
;
; Revision 1.26  2004/03/01 00:04:15  alice
; theme-background is a slot in window
;
; Revision 1.25  2004/02/23 18:39:17  alice
; ; 02/21/04 lose some window-drag-rect stuff - the slot is no longer used
;
; Revision 1.24  2004/01/21 04:03:34  alice
; ; 01/15/04 window-close during update waits till update is finished so view-draw-contents doesn't get null wptrs
; 12/11/03 akh add stuff so timer will run when mouse down in collapse bubble - OSX only
;12/10/03 class window has another slot for attributes such as #$Kwindowmetalattribute  - default is 0
;
; Revision 1.23  2003/12/08 08:41:27  gtbyers
; WITH-SLOTS, not WITH-SLOT-VALUES.  No more  DEF-AUX-INIT-FUNCTIONS.


;; maybe-fix-proxy does less - leave to window-save
;; simplify window-live-grow a little bit
;; put back binding *periodic-task-mask* in with-foreign-window - ??
;; with-slots is silly
;; ------ 5.2b6
;; window-live-grow does qdflushportbuffer
;; add function map-windows-simple
;; maybe-fix-proxy uses set-window-filename-simple
;; pop-up-path-menu does probe-file rather than truename
;; window-proxyicon-event-handler - make sure proxy icon up to date
;; ------ 5.2b5
;; add grafport-write-char - use instead of #_drawchar
;; grafport-write-unicode - string may not be simple-string, string may be multiple lines
;; grafport-write-unicode - don't error if eolp therein - inspector cares
;; macro grafport-write-string - always call grafport-write-unicode, grafport-write-unicode takes optional ff and ms
;; ----- 5.2b4
;; window-proxyicon-event-handler and window-drag-event-handler behave in "standard" way if *do-standard-proxy-drag-action*  is T
;; ------ 5.2b3
;; script-to-font-simple - dont do anything re arabic, grafport-write-unicode passes ff and ms to experimental-draw-text
;; simplify grafport-write-unicode
;; pop-up-path-menu uses truename vs logical path
;; window-event knows about click in part #$inproxyIcon
;; ----- 5.2b1
;; remove-view-from-window for simple view does nothing (so I can evaluate this file without messing up the world)
;; don't say #$rdocproc
;; Get-Osx-Font-List - Values Somewhat Different
;; Window-Update-Event-Handler - Assure Wp Non Nil Before Qdflushportbuffer
;; window-preferred-screen-bounds - dont overlap dock
;; ignore redundant install-collapse-handler in window-make-parts
;; :window-type :overlay-window will work if OSX
;; add window-type slot to class window, use window-type in new-new-window, forget #_getwfrefcon stuff
;; funcall-with-foreign-window does with-cursor outside with-timer rather than inside
;; simplify funcall-with-foreign-window
;; use with-periodic-task-mask in window-drag-sub
; reverse *script-list*
; small changes to grafport-write-unicode
; grafport-write-unicode somewhat more efficient
; script-to-font-simple does arabic song and dance or punts to system font
; 02/08/05 forget about da-windows. fix ellipsis thing in window-menu-item
; 02/03/05 set-window-title and grafport-write-string unicode savvy
; 12/10/04 eol stuff
; window-type :no-border-box is overlaywindow if (osx-p) and *use-overlay-window* true
;; ----- 5.1 final
; window-live-grow does #_disable/enableScreenUpdates - thanks Alex R.
; funcall-with-foreign-window does (with-port %original-temp-port% - fixes 2 nav-services display bugs
; --------- 5.1b4
; window-live-grow behaves more sensibly when mouse goes inside minimum-size
; window-live-grow does allow-view-draw-contents
; export allow-view-draw-contents and mixin
; fix usage of wait-mouse-up-or-moved in window-live-grow
; -------- 5.1b3
; count mouse up events when timer is active - does this ever happen? - yep
; define allow-view-draw-contents for NIL to do nothing
; make close and zoom bubbles work in allow-vdc windows
; undo change to funcall-with-foreign-window - twas bad
; window-drag-sub does allow-view-draw-contents
; disable periodic-task in funcall-with-foreign-window
; maybe fix for collapse, zoom, close buttons misbehavior when timer is installed, disable periodic-task then
; window-close-internal - move woi up, add class allow-view-draw-contents-mixin
; new-new-window - no shadow for single-edge-box, no-border-box. change wptr-dialog-p
; add method allow-view-draw-contents
; tweak window-live-grow for minimum-size
; put back second view-draw-contents in window-live-grow if default-button and ...
;; window-mimimum-size -> view-minimum-size which already existed, remove woi in window-live-grow
; add method window-minimum-size less than which window-live-grow will not go - default #@(40 40)
; window-live-grow - remove second view-draw-contents - seems OK now
; find-window uses window-title
; enable live resize on OS9
; window gets another slot - window-prior-theme-drawing-state
; don't need erase-anonymous-.. if theme-background
; window-live-grow weirdness
; window-live-grow does window-update-event-handler vs. view-draw-contents
; woi in part of window-live-grow
; add *live-resize-all-windows* - initially T but maybe NIL for release?
; window-grow-event-handler supports window live resize. flashy in some cases.
; invalidate-grow-icon does nothing, and don't call it, remove old stuff from window-send-behind
; fix window-grow-event-handler for metal window and resizing smaller
; window-draw-grow-icon does nothing, remove some calls
; initialize-instance for window passes view-font to window-make-parts and initialize-window
;; -------- 5.1b2
; 05/02/04 initialize-instance for window, move view-font weirdness till later
; 04/30/04 window no longer instance-initialize-mixin, but initialize-instance of window still has &allow-other-keys
; now window has the misfortune of being instance-initialize-mixin because view isn't
; 04/25/04 instance-initialize -> initialize-instance in some cases
; 03/24/04 defgeneric window-make-parts and initialize-window
; 03/20/04 funcall-with-foreign-window binds *interrupt-level* to 0 so timer will fire
; 02/28/04 add fn install-collapse-handler, collapse-begin-proc binds *interrupt-level* to 0 so timer will fire
; 02/21/04 lose some window-drag-rect stuff - the slot is no longer used
;; -------- 5.1b1
; 01/15/04 window-close during update waits till update is finished so view-draw-contents doesn't get null wptrs
; 12/11/03 akh add stuff so timer will run when mouse down in collapse bubble - OSX only
;12/10/03 class window has another slot for attributes such as #$Kwindowmetalattribute  - default is 0
; 12/02/03 timer stuff
; 11/23/03 use new-with-pointer
; 10/28/03 theme-background doesn't require osx-p
; window-drag-sub - use %null-ptr vs window-drag-rect which is fouled up in many situations.
; fix below method
; add (defmethod set-window-title ((w window)(new-title encoded-string)) ...
; *disable-bubbles... save-doc-string
;  get-the-current-window-drag-rect does (get-current-screen-size), arg is optional
; *disable-bubbles... initial value is NIL
; another osx-p kludge re view-position of windoid in window-make-parts
; window-make-parts assures that a windoid ain't modal - also os9 kludge for double-edge-box windoid
; add stuff for modified dot in close bubble - osx requires godawful kludge - thank you Takehiko Abe!
; -------- 5.0b5 or 6
; view-deactivate-event-handler ((w window)) - don't clear bubbles if collapsed
; akh new-new-window deals with equivalents of :tool and :no-border-box - from Walker Sigismund
; --------- 5.0b4
; 12-24-2002 ss window-event: don't flash window to front when a behind window's close bubble is clicked in OSX.
;               Ignore *disable-bubbles-on-inactive-windows* in view-activate-event-handler to ensure frontmost
;               bubbles are always active even if user changes *disable-bubbles-on-inactive-windows* mid-session.
; akh export *disable-bubbles...
; ----- 5.0b3
; collapse-bubble enabled in some cases when grow-icon-p is nil and close-box-p is true(??)
; add some stuff for close, collapse, and zoom bubbles - disable bubbles when window inactive
;  if you dont like it set ccl::*disable-bubbles-on-inactive-windows* to nil
; front-window may deem collapsed same as invisible
; wptr-color-p is real rather than always true
; view-mouse-position nil uses #_getglobalmouse rather than messing with %original-temp-port%
; %temp-port% and %original-temp-port% are at 0,0 vs 10,10 - don't ask me
; use get-osx-font-list always if carbon
; ------- 4.4b5
; window-update-event-handler from Shannon Spires
;; -------- 4.4b4
; 05/31/02 add theme-background to window-make-parts
; 05/20/02 fix set-window-layer for modal-dialog in presence of windoid. From Brendan Burns
; 04/13/02 view-deactivate-event-handler :before for OSX
;------------ 4.4b3
; 03/03/02 window-make-parts - setwindowclass always, not just if drag-receiver (fer OSX)
; 02/15/02 fix sys-font-spec to not cons in usual case
; 02/14/02 better end test in get-osx-font-list
; 12/07/01 fix new-new-window for $dboxproc
;;------------ 4.4b2
; 09/02/01 akh another osx-p fix in window-bring-to-front, use new-new-window from John M. if osx-p
; 09/01/01 akh use showwindow/hidewindow vs. showhide if osx-p
; 08/06/01 akh more crap in window-make-parts for IFT
; 07/23/01 akh initialize *script-list* in def-ccl-pointers fonts
; 06/06/01 akh much better *font-list* for OSX
; 05/15/01 akh funcall-with-foreign-window does set-cursor if osx-p
; 05/09/01 window-close-internal disposes window NOW if osx-p - maybe fix window whose in front problem?
; 05/09/01 see %new-window for disgusting OSX crock
; 04/15/01 akh valid-window-rect was wrong
; 04/11/01 akh set-view-font-codes for carbon
; 04/09/01 akh see get-the-current-window-drag-rect
; 03/31/01 akh see set-wptr-font-codes call to with-port - which is really supposed to be a wptr
; 01/15/01 akh window-close da-window does #_disposewindow (for Console that is busted anyway)
; akh window-make-parts no longer errors if window aint windoid, does change-class instead
; akh ignore-errors in print-object window
; 08/02/00 akh see window-make-parts for carbon
; 04/28/00 akh  window-select different for carbon. Fixes very weird behavior when windoids exist.
; ... #_SendBehind and some others (e.g. #_NewCWindow) have a concept of "classes" and should only specify windows
; ... of the same class. See also window-show-internal, window-send-behind.
; lots more carbon-compat for refs to windowrecord.xxx
; carbon-compat in %new-window
; carbon accessor-calls junk
; ----------- 4.3.1b1 ??
; 02/01/99 akh window-drag-event-handler - don't do getwmgrport if carbon
; 12/18/99 akh pop-up-path-menu actually does something - choose-file-dialog
; 07/20/99 akh window-under deal with no wptr
; ---------- 4.3f1c1
; 05/15/99 akh window-make-parts allows non windoid types for windoid - e.g. gc-thermometer
; --------------- 4.3b2
; 03/14/99 akh window-drag-event-handler mods for horizontal or vertical only from Toomas Altosaar
; 03/14/99 akh window-drag-event-handler deals with possible screen resolution change - request from Toomas Altosaar.
; 03/14/99 akh window-make-parts errors if windoid and window-type is not a windoid type
; 03/14/99 akh window-default-zoom-position and size - use true values for borders
; --------------- 4.3b1
; 02/14/99 akh edit-select-file deals with possible list from choose-file-dialog
; 11/18/98 akh windoid title defaults to ""
; 11/o6/98 akh set-view-font-codes - forget %ilogior etal
; 10/25/98 akh funcall-with-foreign-window - deactivate the loathsome windoids too - NOPE
; 10/12/98 *window-type-procid-alist* etc know about windoids as does window-make-parts - no more home grown windoids
; 09/28/98 akh def-ccl-pointers - set *sys-font-codes* to nil
; 07/26/98 akh window-title-height tells the truth as best it can
; 01/23/97 bill %new-window uses new add-points-16 instead of add-points to
;               prevent overflowing the range representable by a 32-bit integer.
; ------------- 4.0
; 12/08/96 akh  front-window returns first found rather than groveling whole window list
;  9/11/96 slh  window-save method (see comment)
; 08/27/96 bill funcall-with-foreign-window
; ------------- 4.0b1
; 07/30/96 gb   typo in (window-close (da-window).  Pass update events
;               to #_SystemEvent, since something else didn't.
; 05/17/96 bill (method view-activate-event-handler (window)) doesn't deactivate
;               any (transitive) container of the current-key-handler.
; ------------- MCL-PPC 3.9
; 03/28/96 bill (require-trap #_LM...) in do-wptrs & menubar-height
; 03/26/96  gb  lowmem accessors.
; 01/09/96 bill  %new-window passes the window-type value, not :window-type, to report-bad-arg
; 12/13/95 slh   pop-up-path-menu: use %local-to-global
; 12/11/95 slh   find-window: CmpString -> IUMagIDPString
; 11/08/95 bill  #_getenvirons -> #_GetScriptManagerVariable
;  5/19/95 slh   windoid show-on-resume-p slot
;  4/26/95 slh   call-with-focused-view, set-gworld, window-show: use ok-wptr
;                try Bill's window-close patch (kill process earlier)
;  4/21/95 slh   window-bring-to-front: check (and w wptr) - can go nil unexpectedly
;  4/20/95 slh   window-close: send whostate "Closed"
;  4/03/95 slh   moved windoid methods to windoid module; moved get-window-event-handler,
;                window-under here
;-------------- 3.0d18
;  2/24/95 slh   window class :auto-position initarg & autoposition method; menubar-height macro
;-------------- 3.0d17
; 01/13/95 alice set-window-layer check wptr and be woi
;  forget limiting menu-item title length in *windows-menu* -  cf  window-menu-item
;  find-window somewhat closer to documentation - still unreliable xabc = abc, works for fat strings
;  in/validate-control not used or exported
;  limit menu-item title length in *windows-menu* since window-title no longer limited - nah
;  window-draw-controls and window-invalidate-controls also dead code
;  define color-or-gray-p (view), window-activate/deactivate-controls are dead code
;  control-key in drag brings all windows of class of w near top
;--------------
;07/16/93 bill  do-keydown-event now handles 2-byte characters
;-------------- 3.0d11
;06/24/93 alice sys-font-spec does not cons when system font is constant.
;		Should be used for menu & item titles and window titles from pathnames.
;06/19/93 alice pop-up-path-menu uses sysfont not chicago 12
;05/05/93 bill  in pop-up-path-menu - make-menu-item takes two args
;04/29/93 bill  window-close-kills-process-p
;04/23/93 bill  map-windows now works independently of how the user
;               function rearranges the windows.
;04/21/93 bill  no args to event-dispatch - new *idle* handling
;04/15/93 bill  get rid of flashing caused by window-send-behind in
;               System 7. This still needs to be tested in System 6.
;04/06/93 bill  in window-send-behind: do nothing if the window is already where
;               it belongs. This eliminates inappropriate erasure in the
;               (new) front window when a modal dialog closes and there is a windoid
;               on the screen.
;-------------- 2.1d5
;04/17/93 alice added a path "menu" when command-click in title of window having a window-filename
;-------------- 2.1d4
;03/21/93 alice view-activate-event-handler (window) deactivates non-current-key-handlers
;02/21/93 alice new zoom size and position from Oliver (Thanks Oliver)
;02/15/93 alice window-select use (edit-menu) not *edit-menu*
;02/06/93 alice style-arg can be a number too
;02/04/93 alice instance-initialize for simple-view - set font before calling view-default-size
;01/28/93 alice added view-font-line-height cause view-font conses
;10/15/92 alice window-close-event-handler - CONTROL not COMMAND hides because
;		this is now called by the menu-item and command-w
;10/08/92 alice - let command key thru to view-key-event-handler;
; 03/24/93 bill killing of window-process moved to (method window-close :around (window))
;               so that the window will be completely closed if the call happens
;               in the window's process
; 03/23/93 bill (method call-with-focused-view :around (t t)) calls
;               window-process-enqueue-with-abort to ensure that the
;               *event-processor* never gets stuck waiting for a lock.
; 02/11/93 bill invalidate-grow-icon is now a generic function, and its
;               third argument is no more. validate-grow-icon is no more; it
;               had no callers.
; 02/04/93 bill window-event passes keydwn & autokey events to
;               *application* if the window is not active.
; 02/03/93 bill window-close-internal doesn't kill the *event-processor*
; 01/12/93 bill window-close-internal kills the window-process
; 01/08/93 bill window-lock
; 12/14/92 bill (method windoid-p (window)) -> (method windoid-p (t))
; 12/08/92 bill (method window-menu-item (window)) enables the menu
;               for the front window if it is not window-active-p
; 11/23/92 bill call window-size-parts later in the initialization sequence
;               (just before window-show)
; 11/12/92 bill add :movable-dialog to *window-type-procid-alist* and *window-type-foos*
; 11/11/92 bill The :COLOR-P initarg for the WINDOW class defaults to T.
; 09/14/92 bill windoid :window-type defaults to :windoid.
; 09/10/92 bill window-close-internal comes out of line from
;               (method window-close (window)).
; 09/08/92 bill (method instance-initialize :after (window)) now calls
;               window-show instead of window-select so that the :window-layer
;               initarg will work.
;               (method window-show-internal (window t)) is more likely to call
;               window-select.
;               (method set-window-layer (windoid t)) correctly handles a layer
;               of 0 for an invisible windoid.
;               New gf:  default-window-layer
; 09/03/92 bill window-event no longer sends mouse up, key up, null, or
;               key down events to inactive windows.
; 09/02/92 bill reselect-windows no longer calls view-activate-event-handler
;               on windows that are already active-p
; 09/01/92 bill clicking in a deactivated front window now reactivates it.
;               Before it simply called view-click-event-handler
; 08/24/92 bill in window-close-event-handler: window-close -> window-close-nicely
; 05/01/92 bill call-with-focused-view becomes a generic funtion for Engber.
; 11/20/92 gb   Don't say "'WINDOID" (tree shaker.)  Do say "process, lock".
;-------------- 2.0
; 03/15/92 bill Move the default VIEW-SIZE of the WINDOID class from
;               a default initarg of the class to a VIEW-DEFAULT-SIZE method.
;               This makes user VIEW-DEFAULT-SIZE methods be called.
;-------------- 2.0f3
; 02/24/92 bill (style-arg '(:bold)) no longer returns (%ilogior nil 1)
; 01/07/92 gb   don't require RECORDS.
; 12/27/91 bill (method set-view-font-codes (window)) now returns the
;               font codes instead of NIL.
; ------------- 2.0b4
; 11/08/91 gb   revert TARGET, fix compiler.
; 10/30/91 bill remove -iv on the end of slot names
; 10/28/91 bill %new-window detects %null-ptr-p values from #_NewWindow
; 10/24/91 bill In window-draw-event-handler, don't change the port before
;               calling SET-VIEW-POSITION.
; 10/21/91 bill stop TARGET from consing.
; 10/15/91 bill eradicate window-font & set-window-font
;               :erase-anonymous-invalidations initarg to the WINDOW class.
;               Remove consing from (in)validate-control, window-draw-grow-icon,
;               window-drag-event-handler
; 10/29/91 alice def-load-pointers => def-ccl-pointers
; 09/23/91 bill #'(setf view-nick-name) -> #'set-view-nick-name
; 09/13/91 bill with-focused-font-view -> with-font-focused-view
; 09/09/91 bill #_SelectWindow -> window-bring-to-front
;               Add #_ActivatePalette to window-select
; 09/21/91 bills fix to stream-write-string ((v simple-view)
;---------- 2.0b3
; 09/03/91 bill Startup initialization of *setgworld-available?*.  Rest is in l1;sysutils.lisp
;               fix (method initialize-instance (da-window))
; 08/30/91 alice window-select does (menu-update *edit-menu*)
; 08/26/91 bill to support sheet-view: view-window becomes generic, set-gworld, get-gworld, call-with-port
;               Unbogosify (method stream-force-output (window))
; 08/24/91 gb   use new trap syntax.
; 08/06/91 bill call-with-focused-view no longer defaults the font-view parameter
; 07/26/91 bill call view-default-size & view-default-position for views
;               other than windows and dialog-items.
; 07/25/91 bill prevent memory leak in (method initialize-instance (da-window))
;               Add window-invalid-region to make back patterns function correctly
; 07/21/91 gb   use DYNAMIC-EXTENT vice evil DOWNWARD-FUNCTION.
; 07/05/91 bill *last-null-event-time* checking moves to do-event
; 06/17/91 bill *current-font-view* handled by call-with-focused-view
;               focus-view takes a new optional font-view parameter.
;               call-with-focused-view's function takes one arg, the view.
;               *grow-bm* is no longer used.
;               set-view-size of a window sets the 'view-size slot too.
; 06/07/91 bill simple-view takes a :help-spec initarg
;-------------- 2.0b2
; 05/13/91 bill sort *font-list*
; 03/29/91 bill clear *last-mouse-click-window* in window-close
; 03/25/91 bill option-click on a window's title bar now sends it to the back
;               whether or not it was in the front.
; 03/22/91 bill window-draw-grow-icon calls _DrawGrowIcon
; 03/05/91 bill handle mac windows not in *window-object-alist* a bit better
; 02/07/91 bill (method window-filename (window)) => (method window-filename (stream))
;03/05/91 alice report-bad-arg gets 2 (args that is)
;----------- 2.0b1
; 01/29/91 bill fix window-make-parts & window-event to allow a window with
;               a zoom box, but no grow box.  I inadvertently removed this
;               possibility on 12/13.
; 01/18/91 bill set-view-container-slot => (setf view-container-slot)
;               set-wptr => (setf wptr-slot)
;               Both due to reversal of args in :writer methods.
; 01/16/91 bill (slot-value w 'window-grow-rect) -> (window-grow-rect w)
; 01/10/91 gb   window-null-event-handler - force-output iff *terminal-io* is a stream
; 01/03/91 bill remove :parent keyword from map-windows, windows, front-window
; 12/13/90 bill in window-make-parts: window-type & grow-icon-p need to interact
; 12/12/90 bill (slot-value w 'grow-icon-p) -> (window-grow-icon-p w)
; 12/07/90 bill option-click in close box closes only windows of the same
;               class as the one clicked on vice all windows that inherit from
;               that class.
; 11/05/90 bill gcable-wptr-p.  Do not allocate a clip-region or erase-region
;               for DA-WINDOW's
;               Process menu key events in DO-EVENT vice WINDOW-EVENT
;               Only call window-null-event once a tick to speed up
;               real-time stuff
;               In window-update-event-handler: Erase visrgn if back-color not white.
;               Fix window-zoom-event-handler
; 11/01/90 bill view-default-font
; 10/30/90 bill window-title uses slot-value-if-bound to avoid errors
;               during window creation (before WPTR is bound)
; 10/25/90 bill color-green, color-blue, color-red for bootstrapping.
; 10/23/90 bill set-view-container-slot, remove (defun wptr ...), replace with reader.
;10/18/90 bill If a default-button closed a window before it was activated,
;              The null wptr was sometimes referenced by the
;              view-activate-event-handler code.
;10/04/90 bill window-update-event-handler binds *processing-events* true.
;10/03/90 bill %class-cpl -> %inited-class-cpl
;09/21/90 bill add new-window-title to window-make-parts
;09/20/90 bill da-window's default view-font is NIL: let the DA decide.
;10/16/90 gb   no more %str-length.
;08/29/90 joe  added *window-default-position*, *window-default-size*
;              *window-default-zoom-position*, *window-default-zoom-size*
;              and window-default-zoom-size, window-default-zoom-position methods.
;              Removed the slots for above & changed def-load-pointers,
;              view-default-position & size to reflect above.
;              window-zoom-event-handler now uses window-zoom-size correctly
;              window-drag-event-handler now uses drag-rect correctly
;08/20/90 bill Add :class in windows, map-windows, front-window
;08/13/90 bill (method stream-force-output (window))
;08/10/90 bill Hide windows when user <Command>-clicks close box.
;              display-in-windows-menu to decide whether to display hidden windows.
;08/09/90 bill store window font-codes in the alist.  If they are stored only
;              in the wptr, then we sometimes see with-font-codes values.
;08/03/90 bill new view-valid slot.
;08/01/90 bill set-view-size-internal no longer invalidates controls.
;07/24/90 bill in window-event: ignore command keys that have no menu item.
;07/23/90 bill Eliminate duplicate fonts in *font-list*
;07/06/90 bill Remove color-window-mixin from window-color-p
;07/05/90 bill map-windows, windows, & front-window take keyword args now.
;              nix wptr-if-bound & color-window-mixin.
;06/25/90 bill add :procid keyword to window-make-parts
;06/22/90 bill :window-font -> :view-font
;              def-aux-init-functions for window class.
;06/21/90 bill ed-select-file calls #'fred instead of make-instance directly.
;06/19/90 bill (set-view-position window :centered) now works.
;06/13/90 bill windoid built on lisp-wdef-mixin
;06/07/90 gb   print-unreadable-object :identity vice :id.
;06/05/90 bill call-with-focused-view
;05/30/90 gb   use print-unreadable-object.
;05/29/90 bill Move %temp-port% def & initialization from sysutils.
;05/24/90 bill window-(de)activate-event-handler -> view-(de)activate-event-handler
;              window-draw-contents -> view-draw-contents
;              window-click-event-handler -> view-click-event-handler
;              window-position -> view-position, window-size -> view-size
;              Move *color-available* test to inside of %new-window
;05/23/90 bill (with-focused-font-view v ...) -> (with-focused-font-view (v v) ...)
;05/05/90 bill new scrap handler.
;05/04/90 bill window-draw-grow-icon: draw outline when window not highlighted.
;05/03/90 bill window-activate-event-handler does nothing if Lisp is in background.
;04/30/90 gb   Still in late April: use downward functions.  Set the wayback
;              machine for the late 20th century.  %iasr.
;04/24/90 bill view-window looks up the view hierarchy if it can't find the
;              window in the *window-alist*
;04/23/90 bill window-zoom-position & window-zoom-size now look in
;              view-alist first.  set-xxx puts value there.
;              Add invalidate-view to window-zoom-event-handler
;04/19/90 bill grow-icon-corners, and erase-p arg to invalidate-grow-icon & use it.
;04/18/90 bill grafport-write-string
;04/17/90 bill wptr-font-codes, set-wptr-font-codes.
;04/16/90 bill remove consing from stream-line-length.
;04/13/90 bill stream-tyo, stream-write-string, view-terpri now specialize
;              on simple-view instead on window.
;04/10/90 bill set-window-font returns the font. steam-write-string for window
;04/10/90  gz  view fonts.
;04/07/90 bill view-put doesn't add a property for a vlaue of NIL
;03/20/90 bill initialize-instance => instance-initialize
;03/15/90  gz  Do more stuff in the interim focus-view, otherwise fred-window
;              window-update breaks in various subtle ways in a level-1 lisp.
;              Made WPTR and #'(SETF WPTR) be smarter.
;03/13/90 bill in window-close: don't _DisposWindow %temp-port%,
;              window-type, window-color-p
;05/06/90 bill view-get & friends specialize on simple-view not window.
;03/05/90 bill stream-tyo passed too many args to window-terpri.
;              center-window bombed if position arg was malformed.
;              window-key-event-handler => view-key-event-handler.
;02/28/90 bill Add color-p initarg to window: call _NewCWindow in %new-window
;02/26/90 bill without-interrupts is now implicit in with-port.
;02/23/90 bill No without-interrupts around window-update-event-handler
;02/21/90 bill Make window-show deactivate *selected-window* before showing
;              a modal dialog.
;02/20/90 bill window-hide before removing subviews in window-close
;02/15/90 bill window-get & friends => view-get & friends.
;01/26/90 bill Add window-alist, window-get, window-put, window-remprop
;01/04/90 bill Add windoids.
;12/26/89 bill map-windows added, used for windows, front-window, find-window.
;12/23/89 bill Clicking inDrag with the command key down does NOT select the window,
;              moves it in its layer.
;11/13/89 bill Add optional first arg to edit-select-file.
;10/4/89  gz NEW-install-window-object -> install-window-object.
;09/27/89 gb simple-string -> ensure-simple-string.
;09/16/89 bill Removed the last vestiges of object-lisp windows.
;09/13/89 bill Make edit-select-file create a CLOS fred-window if it can
;09/12/89 bill Make window-make-parts use set-window-title to set the title.
;              Fred depends on this.
;              Remove the title from %new-window & initialize-window
;09/12/89 bill Add window-title initarg to window-make-parts
;09/06/89 bill add print-object for window.
;              window-title (window): prevent error if wptr slot unbound.
;09/05/89 bill window-close-event-handler: update to work with option key again
;09/05/89 bill Make initialize-instance for window a primary method instead
;              of an :after method. Some user's of it needed this.
;08/30/89 blll window-event: (_ask nil ...) as some dialog functions are now both
;              obfuns and methods (kluge, kluge)
;08/25/89 bill window-menu-item: change to CLOS menus.
;08/25/89 bill (defmethod clos-window-update-cursor ...) & (def_obfun window-update-cursor ...)
;          ==> (defmethod window-update-cursor ...) & (def_obfun window-object-update-cursor ...)
;07/18/89 bill window-title: add comments.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#|
(in-package :traps)
;; in newest c interfaces for 1.1d12 but not here yet - HERE NOW
(eval-when (:compile-toplevel :execute) 
(deftrap-inline "_SetWindowClass" 
      ((a (:pointer :windowrecord)) (v  :unsigned-long) )
  :osstatus
   () ))
|#

(in-package :ccl)
#|
(eval-when (:compile-toplevel :execute)
  ;; somebody seems to be confused about boolean
  (deftrap-inline "_SetWindowModified" 
      ((window (:pointer :opaquewindowptr)) (modified :uint8)) 
  :osstatus
   () ))
|#



;; use this if you want to say t or nil
(defun set-wptr-modified (wptr what)
  (#_setwindowmodified wptr what))

#|
;; modified/not modified is indicated on OS9 by dimming/undimming this frob in the title bar
(#_SetWindowProxyCreatorAndType (wptr (target)) :|CCL2| :|TEXT| #$kOnSystemDisk)
|#



#+carbon-compat
(defun getwindowclass (wptr)
  (rlet ((cls :unsigned-long))
    (#_getwindowclass wptr cls)
    (%get-unsigned-long cls)))

;To do: Change window-object to just search all objects if not found in alist.


(defvar *font-list* ())
;(defvar *big-rgn* nil)
;(defvar *big-rect* nil)
;(defvar *grow-bm* nil)
(defvar %temp-port%)
(defvar %original-temp-port%)
;(defvar *grow-icon-rgn*)
(export '(inval-window-rect valid-window-rect valid-window-rgn inval-window-rgn)
        (find-package :ccl))

(defun inval-window-rect (wptr rect)
  (declare (ignore-if-unused wptr))
  (declare (optimize (speed 3)(safety 0))) 
  (#_invalwindowrect wptr rect)) 

(defun valid-window-rect (wptr rect)
  (declare (ignore-if-unused wptr))
  (declare (optimize (speed 3)(safety 0)))  
  (#_validwindowrect wptr rect))

(defun valid-window-rgn (wptr rgn)
  (declare (ignore-if-unused wptr))
  (declare (optimize (speed 3)(safety 0)))  
  (#_validwindowrgn wptr rgn))

(defun inval-window-rgn (wptr rgn)
  (declare (ignore-if-unused wptr))
  (declare (optimize (speed 3)(safety 0)))  
  (#_invalwindowrgn wptr rgn))

#+carbon-compat
(progn 
;; this one appears to have problems
(defun get-window-updatergn (wptr rgn)
  (#_getwindowregion wptr #$kWindowUpdateRgn rgn)
  rgn)

(defun get-window-strucrgn (wptr rgn)
  (#_getwindowregion wptr #$kWindowStructureRgn rgn)
  rgn)


#| ;; NO SUCH THING
(defun set-window-strucrgn (wptr rgn)
  (#_setwindowregion wptr #$kWindowStructureRgn rgn)
  rgn)
|#

(defun get-window-contrgn (wptr rgn)
  (#_getwindowregion wptr #$kWindowContentRgn rgn)
  rgn)



(defun get-window-visrgn (wptr rgn)
  (with-macptrs ((port (#_getwindowport wptr))) ;; its really just wptr today    
    (#_getportvisibleregion port rgn)
    rgn))

(defun get-window-cliprgn (wptr rgn)
  (if (#_isvalidwindowptr wptr)
    (with-macptrs ((port (#_getwindowport wptr)))
      (#_getportclipregion port rgn))
    (#_getportclipregion wptr rgn))
    rgn)

(defun set-window-cliprgn (wptr rgn)
  (if (#_isvalidwindowptr wptr)
    (with-macptrs ((port (#_getwindowport wptr)))
      (#_setportclipregion port rgn))
    (#_setportclipregion wptr rgn))
    rgn)

(defun set-window-visrgn (wptr rgn)
  (with-macptrs ((port (#_getwindowport wptr)))
    (#_setportvisibleregion port rgn)
    rgn))

(defun get-window-pnloc (wptr)
  (with-macptrs ((port (#_getwindowport wptr)))
    (rlet ((point :point))
      (#_getportpenlocation port point)
      (%get-long point))))  
  

(defun get-port-visrgn (port rgn)
  (#_getportvisibleRegion port rgn)
  rgn)
)

#+ignore
(defun simple-string< (a b)
  (let ((la (length a))
        (lb (length b)))
    (dotimes (i (min la lb) (< la lb))
      (let ((ca (%scharcode a i))
            (cb (%scharcode b i)))
      (if (< ca cb)(return t)
          (if (/= ca cb) (return nil)))))))

#+ignore
(defun simple-string= (a b)
  (let ((la (length a)))
    (when (= la (length b))
      (dotimes (i la t)
        (when (/= (%scharcode a i)(%scharcode b i))
          (return nil))))))


#+carbon-compat
(defmethod dummy-menu-install ((menu menu))
  (unless (slot-value menu 'menu-handle)
    ;(dbg 16)
    (init-menu-id menu)
    (with-pstrs ((tp (slot-value menu 'title)))
      (#_InsertMenu  ;; whats that do 
       (setf (slot-value menu 'menu-handle)
             (#_NewMenu (slot-value menu 'menu-id) tp))
       -1))))

#+carbon-compat
(defun nuke-menu (menu &aux mh md)
  (when (setq md (slot-value menu 'menu-id))
    (deallocate-menu-id md)
    (setf (slot-value menu 'menu-id) nil))
  (when (setq mh (slot-value menu 'menu-handle))
    (#_DeleteMenu md)
    (#_DisposeMenu mh)
    (setf (slot-value menu 'menu-handle) nil)))

(defun script-to-font-simple (script)
  (if (not (memq script *script-list*))
    ;; seems like cyrillic can also draw arabic - sort of anyway - no
    (if nil ;(and (eq script #$kcfstringencodingmacArabic)(memq #$kCFStringEncodingMacCyrillic *script-list*))
      (get-script #$kcfstringencodingMacCyrillic #$smScriptAppFond)
      (ash (sys-font-codes) -16))
    (#_getscriptvariable script #$smScriptAppFond)))

(defvar *font-name-number-alist* nil)

(defparameter *script-font-alist* nil)
#+carbon-compat
(defun get-osx-font-list ()  
  (let* ((menu (make-instance 'menu))
         (res nil)
         (res2 nil))
    (dummy-menu-install menu)
    (let ((handle (menu-handle menu)))
      (rlet ((foo :unsigned-long))
        ;; what a load of fonts
        (let ((err (#_CreateStandardFontMenu handle 0 0 0 foo)))
          (declare (ignore err))
          ;(setq poop (%get-long foo)) ;; what isit
          ))
      (let ((itemnum 1)
            (nitems (#_CountMenuItems handle))) 
        (loop
          (rlet ((fam :signed-integer)
                 (style :signed-integer))
            (when (> itemnum nitems) (return))
            (let ((err (#_GetFontFamilyFromMenuSelection handle itemnum fam style)))
              (if (or (eq err #$menuItemNotFoundErr)(eq err #$paramerr)) ;; what the hell is the end test??
                (return)
                (let ((family (%get-signed-word fam))
                      (uname)
                      (name))
                  (without-interrupts
                   (let* ((script (#_FontToScript family)))
                     (when (not (memq script *script-list*))
                       (let ((flag (#_getscriptmanagervariable #$smdefault)))
                         (when (eq flag 0) (push script *script-list*))))))
                  (rlet ((cfstr :pointer))
                    (let ((err (#_copyMenuItemTextAsCFString handle itemnum cfstr)))
                      (when (neq err #$noerr)(error "phooey")))
                    (setq uname (get-cfstr (%get-ptr cfstr)))
                    (#_cfrelease (%get-ptr cfstr)))
                  (%stack-block ((str 256))
                    (#_getfontname family str)
                    (setq name (%get-string str)))
                  (push (cons uname family) res2)
                  (push (list name uname family) res))))
                  (incf itemnum))))
        (setq *script-list* (nreverse *script-list*))
        (setq *script-font-alist*
              (mapcar #'(lambda (x) (cons x (script-to-font-simple x))) *script-list*))
        (setq *font-name-number-alist* (nreverse res2))
        (nuke-menu menu)
        (nreverse res))))

(def-ccl-pointers fonts ()  
  (rlet ((r :rect :topleft  #@(0 0) 
            :bottomright #@(100 100))
         (tp (:string 2)))
    (%put-word tp #x0120) ;; vs random junk ?? 
    (setq %temp-port%
          (#_NewCWindow 
           (%null-ptr)
           r                            ; bounds
           tp                           ; blank title
           nil                          ; invisible
           4                            ; procid: document
           #-carbon-compat
           (%int-to-ptr -1)             ; behind
           #+carbon-compat
           (%null-ptr)
           nil                          ; no goAwayFlag
           4                            ; refCon
           )))
  (setq %original-temp-port% %temp-port%)
  (setq *sys-font-codes* nil *sys-font-spec* nil)
  (let* ((script (#_GetScriptManagerVariable  #$smSysScript)))
    (setq *script-list* (list script))
    ;(setq *grow-icon-rgn*  (#_NewRgn))
    (setq
     *font-list*       
     ;; there is some other hairy assed way to find the fonts under OSX
     (get-osx-font-list))
    ;(setq *big-rgn* (#_NewRgn))
    ;(#_SetRectRgn *big-rgn* -32768 -32768 32767 32767)    
    ))
  


(eval-when (:execute :compile-toplevel)
  ; :noAutoCenter must be first (see autoposition)
  (defconstant autopos-constraints
    `((:noAutoCenter . (nil nil #.#$kWindowNoPosition))
      (:centerMainScreen . (:center :main-screen #.#$kWindowCenterMainScreen))
      (:alertPositionMainScreen . (:alert-pos :main-screen #.#$kWindowAlertPositionMainScreen))
      (:staggerMainScreen . (:stagger :main-screen #.#$kWindowStaggerMainScreen))
      (:centerParentWindow . (:center :parent-window #.#$kWindowCenterParentWindow))
      (:alertPositionParentWindow . (:alert-pos :parent-window #.#$kWindowalertPositionParentWindow))
      (:staggerParentWindow . (:stagger :parent-window #.#$kWindowStaggerParentWindow))
      (:centerParentWindowScreen . (:center :parent-window-screen #.#$kWIndowCenterParentWindowScreen))
      (:alertPositionParentWindowScreen . (:alert-pos :parent-window-screen #.#$kWindowAlertPositionParentWindowScreen))
      (:staggerParentWindowScreen . (:stagger :parent-window-screen #.#$kwindowStaggerParentWindowScreen))))
  
  (defmacro autopos-placement (key)
    `(cadr (assoc ,key autopos-constraints)))
  
  (defmacro autopos-bounds (key)
    `(caddr (assoc ,key autopos-constraints)))
  
  (defmacro autopos-id (key)
    `(cadddr (assoc ,key autopos-constraints))))



#+carbon-compat
(defmacro do-wptrs (wptr &body body)
  (let ((next-wptr (gensym)))
    `(with-macptrs ((,wptr (require-trap #_GetWindowList))
                    ,next-wptr)
       (do () ((%null-ptr-p ,wptr))
         (%setf-macptr ,next-wptr (require-trap #_getnextwindow ,wptr))
         ,@body
         (%setf-macptr ,wptr ,next-wptr)))))

(defmacro do-all-windows (w &body body)
  (let ((wptr (gensym)))
    `(do-wptrs ,wptr
      (let ((,w (window-object ,wptr)))
        (when ,w
          ,@body)))))

(defmacro menubar-height ()
  `(require-trap #_GetMBarHeight))

(defun class-inherit-from-p (class parent-class)
  (flet ((get-class (value)
           (if (symbolp value) (find-class value nil) value)))
    (let ((pclass (get-class parent-class)))
      (memq pclass
            (%inited-class-cpl (get-class class))))))

(defun windows (&key class include-invisibles include-windoids)
  (cond ((eq class 'window)
         (setq class nil))
        ((and class (symbolp class))
         (setq class (find-class class))))
  (when (and class (class-inherit-from-p class (find-class 'windoid)))
    (setq include-windoids t))
  (let ((windows nil))
    (without-interrupts
     (do-wptrs wptr
       (let ((wob (window-object wptr)))
         (when (and wob
                    (or include-windoids
                        (not (windoid-p wob)))
                    (or (not class)(inherit-from-p wob class))
                    (or include-invisibles #-carbon-compat (rref wptr windowrecord.visible)
                                           #+carbon-compat (#_iswindowvisible wptr)))
           (setq windows (cheap-cons wob windows))))))
    (nreverse windows)))

(defun map-windows (function &key class include-invisibles include-windoids)
  (let ((windows (windows :class class
                          :include-invisibles include-invisibles
                          :include-windoids include-windoids)))
    (unwind-protect
      (dolist (w windows)
        (funcall function w))
      (cheap-free-list windows))
    nil))

(defun map-windows-simple (function &optional class)
  (if (and class (symbolp class))(setq class (find-class class)))
  (dolist (x *window-object-alist*)
    (let ((win (%cdr x)))
      (when (or (not class) (inherit-from-p win class))
        (funcall function win)))))

(defun front-window (&key class include-invisibles include-windoids)
  (when class 
    (when (symbolp class)(setq class (find-class class))) 
    (when (class-inherit-from-p class (find-class 'windoid))
      (setq include-windoids t)))
  (do-wptrs wptr
    (let ((wob (window-object wptr)))
      (and wob
           (or include-windoids
               (not (windoid-p wob)))
           (or (not class)(inherit-from-p wob class))
           
           (or include-invisibles 
               #-carbon-compat (rref wptr windowrecord.visible) 
               #+carbon-compat (and (#_iswindowvisible wptr)(or ;(not (osx-p)) ;; or always ?
                                                                (not (#_iswindowcollapsed wptr)))))
           (return wob)))))


(defun target ()
  (let* ((first? nil)
         (temp #'(lambda (w)
                   (if first?
                     (return-from target w)
                     (setq first? t)))))
    (declare (dynamic-extent temp))
    (map-windows temp)))


(defun find-window (title &optional class)  
  (let* ((mapper #'(lambda (w)
                     (if (string-equal (window-title w) title)
                       (return-from find-window w)))))
    (declare (dynamic-extent mapper))
    (map-windows mapper
                 :class class
                 :include-windoids t)))

(defun hilite-wptr (wptr hilite?)
  (when wptr                            ; may have disappeared.
    (unless (eq hilite?  (#_iswindowhilited wptr))
      (#_HiliteWindow wptr hilite?)
      t)))

; Nobody actually calls this, but it shows how to maintain the
; state of the window hiliting and activation correctly.
(defun fix-windows ()
  (if (da-or-modal-dialog-on-top-p)
    (unselect-windows t)
    (reselect-windows)))

(defun da-or-modal-dialog-on-top-p ()
  (or *modal-dialog-on-top* (typep *selected-window* 'da-window)))

; Unhilite & deactivate all the windows.
; Leave the first one alone if skip-first? is true
(defun unselect-windows (&optional skip-first?)
  (with-macptrs ((wptr (#_GetWindowList)))
    (when skip-first?
      (unless (%null-ptr-p wptr)
        (setq wptr  (#_getnextwindow wptr))))
    (until (%null-ptr-p wptr)
      (when  (#_iswindowvisible wptr)
        (let ((wob (window-object wptr)))
          (if (and wob (typep (wptr wob) 'macptr))
            (view-deactivate-event-handler wob)
            (hilite-wptr wptr nil))))
      (%setf-macptr wptr (#_getnextwindow wptr)))))

(defvar *last-windoid* nil)

; Hilite & activate the windows.
; Move windoids to the front.
; If *selected-window* is a DA, pick a non-DA to select.
; If *selected-window* is nil, leave it that way.
; Update *last-windoid* and *windoid-count*
(defun reselect-windows ()
  (let ((selected *selected-window*)
        last-windoid
        found-non-windoid?
        (da-before-selected? :maybe)
        (windoid-count 0))
    (if (typep selected 'da-window)
      (setq selected nil))
    (do-wptrs wptr
      (when  (#_iswindowvisible wptr)
        (let ((wob (window-object wptr)))
          (cond ((or (null wob) (not (typep (wptr wob) 'macptr)))
                 (hilite-wptr wptr nil))
                ((windoid-p wob)
                 (if found-non-windoid?
                   (if last-windoid
                     (window-send-behind wptr (wptr last-windoid) t)
                     (window-bring-to-front wob wptr)))
                 (setq last-windoid wob)
                 (unless (window-active-p wob)
                   (view-activate-event-handler wob))
                 (setq windoid-count (%i+ windoid-count 1)))
                (t
                 (setq found-non-windoid? t)
                 (if (typep wob 'da-window) 
                   (if (eq :maybe da-before-selected?)
                     (setq da-before-selected? t))
                   (if (and (eq wob (or selected (setq selected wob)))
                            (eq :maybe da-before-selected?))
                     (setq da-before-selected? nil))))))))
    (setq *windoid-count* windoid-count
          *last-windoid* last-windoid)
    (when *selected-window*           ; maybe nobody is selected
      (setq *selected-window* selected)
      (when (eq t da-before-selected?)
        (if last-windoid
          (window-send-behind (wptr selected) (wptr last-windoid) t)
          (window-bring-to-front selected)))
      (unless (window-active-p selected)
        (view-activate-event-handler selected)))))

(defun fix-window-hiliting ()
  (let* ((first-window? nil)
         (temp #'(lambda (w)
                   (let ((wptr (wptr w)))
                     (if (typep w 'windoid)
                       (hilite-wptr wptr t)
                       (if first-window?
                         (hilite-wptr wptr nil)
                         (progn
                           (hilite-wptr wptr t)
                           (setq first-window? t))))))))
    (declare (dynamic-extent temp))   
    (map-windows
     temp
     ;:class 'window
     :include-invisibles nil
     :include-windoids t)))

(defun edit-select-file (&optional w &aux (name (choose-file-dialog
                                                :mac-file-type "TEXT")))
  (declare (ignore w))                  ; called from a comtab sometimes.
  (when name
    (fred (if (consp name)(car name) name))))

(defun style-arg (arg &aux val (ret 0))
  (if (symbolp arg)
    (if (setq ret (%cdr (assq arg *style-alist*)))
      ret
      (%err-disp $err-bad-input arg))
    (dolist (sym arg ret)
      (if (setq val (%cdr (assq sym *style-alist*)))
        (setq ret (%ilogior2 ret val))
        (%err-disp $err-bad-input sym)))))

(defun inverse-style-arg (arg)  
  (if (eq 0 arg)
    (dolist (e *style-alist* nil)
      (if (eq 0 (cdr e))(return (car e))))
    (let ((val))
      (dotimes (i 7)
        (when (logbitp i arg)
          (let* ((n (ash 1 i))
                 (it (dolist (e *style-alist* nil)
                       (if (eq n (cdr e))(return (car e))))))
            (when it (if (consp val)
                       (push it val)
                       (if val
                         (setq val (list it val))
                         (setq val it)))))))
      (or val
          (%err-disp $err-bad-input arg)))))
      

(defun make-style (num &aux ret)
 (dolist (elt *style-alist* ret)
  (if (eq num (%cdr elt)) (return-from make-style (%car elt)))
  (if (neq 0 (%ilogand2 num (%cdr elt))) (setq ret (cons (%car elt) ret)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              view                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Note: Most of the view code is in lib;views.lisp: not in level 1.

; a simple-view is used for dialog-items.  It cannot have subviews.
(defclass simple-view (output-stream)
  ((view-container :initform nil 
                   :reader view-container)
   (wptr :initarg :wptr :initform nil :reader wptr)
   (view-position :initform #@(0 0) :initarg :view-position :reader view-position)
   (view-size :initform #@(100 100) :initarg :view-size :reader view-size)
   (view-nick-name :initform nil :initarg :view-nick-name :reader view-nick-name)
   (view-alist :initform nil :accessor view-alist)
   ))

(defmethod view-default-size ((view simple-view)) #@(100 100))
(defmethod view-default-position ((view simple-view)) #@(0 0))

(defmethod set-view-container-slot ((view simple-view) value)
  (setf (slot-value view 'view-container) value))

(defmethod set-wptr ((view simple-view) value)
  (setf (slot-value view 'wptr) value))

(defmethod set-view-nick-name ((view simple-view) new-name)
  (setf (slot-value view 'view-nick-name) new-name))

(defclass view (simple-view)
  ((view-valid :initform nil :accessor view-valid)   ; for lazy clip-region updating.
   (view-scroll-position :initform #@(0 0) :initarg :view-scroll-position
                         :accessor view-scroll-position)
   (view-origin :initform #@(0 0) :accessor view-origin-slot)
   (view-subviews :initform (make-array 1 :adjustable t :fill-pointer 0)
                  :reader view-subviews)
   (view-clip-region :initform nil :accessor view-clip-region-slot)))

(defmethod (setf wptr) (wptr (v simple-view))
  (setf (slot-value v 'wptr) (and wptr (require-type wptr 'macptr))))

#|
(defmethod initialize-instance ((view simple-view) &rest initargs &key
                                (view-font (view-default-font view)))
  (declare (dynamic-extent initargs))
  (apply #'call-next-method
         view
         :view-font view-font
         initargs))

(defmethod instance-initialize :after ((view simple-view) &key
                                       view-container view-font help-spec
                                       (view-size nil vsp)
                                       (view-position nil vpp))
  (declare (ignore view-size view-position))
  (when (and view-font (not (typep view 'window)))
    (set-initial-view-font view view-font))
  (when help-spec
    (setf (view-get view :help-spec) help-spec))
  (unless vsp (setf (slot-value view 'view-size) (view-default-size view)))
  (unless vpp (setf (slot-value view 'view-position)(view-default-position view)))
  (when view-container
    (set-view-container view view-container)))
|#

(defmethod initialize-instance ((view simple-view) ;&rest initargs
                                &key
                                (view-font (view-default-font view))
                                view-container help-spec ignore
                                (view-size nil vsp)
                                (view-position nil vpp))
  (declare (dynamic-extent initargs))
  (declare (ignore view-size view-position ignore initargs))
  #+ignore ;; the next method could care less about view-font - its for output-stream
  (apply #'call-next-method
         view
         :view-font view-font
         initargs)
  (call-next-method)
  (when (and view-font (not (typep view 'window)))
    (set-initial-view-font view view-font))
  (when help-spec
    (setf (view-get view :help-spec) help-spec))
  (unless vsp (setf (slot-value view 'view-size) (view-default-size view)))
  (unless vpp (setf (slot-value view 'view-position)(view-default-position view)))
  (when view-container
    (set-view-container view view-container)))


(defmethod initialize-instance :after ((v view) &key view-subviews)
  (dolist (subview view-subviews)
    (set-view-container subview v)))

(defmethod view-contains-p ((view view) contained-view)
  (let ((container (view-container contained-view)))
    (while container
      (if (eq container view)
        (return-from view-contains-p t))
      (setq container (view-container container)))))

(defmethod view-contains-p ((view null) contained-view)
  (declare (ignore contained-view))
  nil)

(defmethod view-font ((view simple-view))
  (multiple-value-bind (ff ms) (view-font-codes view)
    (font-spec ff ms)))


(defmethod view-font-line-height ((view simple-view))
  (multiple-value-bind (a d w l) (view-font-codes-info view)
    (declare (ignore w))
    (%i+ a d l)))

(defmethod view-font-codes-info ((view simple-view))
  (multiple-value-call #'font-codes-info (view-font-codes view)))

(defmethod set-view-font ((view simple-view) font-spec)
  (multiple-value-bind (ff ms) (view-font-codes view)
    (multiple-value-bind (ff ms) (font-codes font-spec ff ms)
      (set-view-font-codes view ff ms)))
  font-spec)

(defmethod set-initial-view-font ((view simple-view) font-spec)
  (set-view-font view font-spec))

(defmethod view-font-codes ((view simple-view))
  (let ((codes (view-get view 'view-font-codes)))
    (if codes
      (values (car codes) (%cdr codes))
      (let ((container (view-container view)))
        (and container (view-font-codes container))))))

(defmethod set-view-font-codes ((view simple-view) ff ms &optional ff-mask ms-mask)
  (let ((codes (view-get view 'view-font-codes)))
    (if codes
      (let ((old-ff (car codes))
            (old-ms (%cdr codes)))
        (if ff-mask
          (setq ff (logior (logand ff ff-mask) 
                           (logand old-ff (lognot ff-mask)))))
        (if ms-mask
          (setq ms (logior (logand ms ms-mask) 
                           (logand old-ms (lognot ms-mask)))))
        (%rplacd (rplaca codes ff) ms))
      (view-put view 'view-font-codes (cons ff ms)))
    (values ff ms)))

(defvar *quieted-view* nil)

(defmacro with-quieted-view-if (view predicate &body body)
  (let ((view-var (gensym)))
  `(let* ((,view-var ,view)             ; make sure we eval the view form
          (*quieted-view* *quieted-view*))
     (when (and ,predicate (not (view-contains-p *quieted-view* ,view-var)))
       (setq *quieted-view* ,view-var))
     ,@body)))

(defmacro with-quieted-view (view &body body)
  `(with-quieted-view-if ,view t ,@body))

(defun view-quieted-p (view)
  (let ((qv *quieted-view*))
    (and qv (or (eq view qv) (view-contains-p qv view)))))

; Toggle blinkers is so that user windoid code can make fred-dialog-items blink
; at the proper time.
(defmethod toggle-blinkers ((item simple-view) on-p)
  (declare (ignore on-p)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             window                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass window (view)
  ((window-cursor :allocation :class :reader window-cursor :initform *arrow-cursor*)
   (window-grow-rect :allocation :class :reader window-grow-rect)
   (window-drag-rect :allocation :class :reader window-drag-rect)

   (color-list :initform nil :reader window-color-list)  ;; apparently unused
   (back-color :initform nil)
   (object-name :initform nil)
   (my-item :initform nil)
   (grow-icon-p :initform nil :reader window-grow-icon-p)
   (window-do-first-click :initform nil :accessor window-do-first-click
                          :initarg :window-do-first-click)
   (window-other-attributes :initform 0 :accessor window-other-attributes
                            :initarg :window-other-attributes) 
   (window-active-p :initform nil :accessor window-active-p)
   (window-erase-region :initform (#_NewRgn) :accessor window-erase-region)
   (window-invalid-region :initform nil :accessor window-invalid-region)
   (process :initform nil :initarg :process :accessor window-process)
   (queue :initform (make-process-queue "Window") :reader window-process-queue)
   (auto-position :initarg :auto-position :initform :noAutoCenter)
   ;; names ?? 
   (window-theme-background :initform nil :initarg :theme-background 
                            :accessor window-theme-background :accessor theme-background)
   (window-prior-theme-drawing-state :initform nil :accessor window-prior-theme-drawing-state)
   (window-type :initform :document-with-zoom :accessor mcl-window-type)
   ))

#|
;; cool actually - can drag by borders again
;; needs some theme-background else grow makes a mess
(setq w (make-instance 'window :window-other-attributes
                       #$kWindowMetalAttribute :theme-background #$kThemeBrushDocumentWindowBackground))  ;; aka white
|#

#|
(defmethod initialize-instance ((w window) &rest initargs &key auto-position)
  (declare (dynamic-extent initargs))
  (if (and auto-position
           (null (assq auto-position autopos-constraints)))
    (error "~S must be one of ~S" auto-position
           (mapcar #'car (cdr autopos-constraints)))
    (apply #'call-next-method w :auto-position auto-position initargs)))
|#

(defmethod initialize-instance ((window window) &rest initargs &key ;auto-position 
                                (erase-anonymous-invalidations t)
                                theme-background
                                ;(window-show t)
                                (view-font (view-default-font window))
                                &allow-other-keys)
  (declare (dynamic-extent initargs))
  ;(declare (ignore erase-anonymous-invalidations))
  #+ignore ;; causes boot failure - put check somewhere else - besides, the next-method could care less about auto-position
  (if (and auto-position
           (null (assq auto-position autopos-constraints)))
    (error "~S must be one of ~S" auto-position
           (mapcar #'car (cdr autopos-constraints)))
    (apply #'call-next-method window :auto-position auto-position initargs))
  (call-next-method)
  ;; contents of previous instance-initialize
  (setf (view-valid window) (list nil))
  ;(when view-font (set-initial-view-font window view-font))
  (view-allocate-clip-region window)
  (when (and erase-anonymous-invalidations (not theme-background)) ;; only needed for non-theme color background
    (setf (window-invalid-region window) (#_newrgn)))    
  (without-interrupts
   (let* ((wptr (wptr window)))
     (unwind-protect
       (progn
         (apply #'window-make-parts window :view-font view-font initargs)
         (install-window-object window)
         (apply #'initialize-window window :view-font view-font initargs)
         (setq wptr t))
       (if (null wptr)
         (window-close window)))))
  (window-size-parts window)  ;; didn't initialize-window do this?
  ;(when view-font (set-initial-view-font window view-font)) ;; what?? - can crash without this
  #+ignore ;; wait for subviews
  (when window-show
    (window-show window)))

(defmethod initialize-instance :after ((window window) &key (window-show t))
  (when window-show
    (window-show window)))

(defmethod windoid-p (w)
  (declare (ignore w))
  nil)

(defmethod view-default-font ((window window))
  *fred-default-font-spec*)

(defmethod view-default-font ((view simple-view))
  nil)

(defmethod window-zoom-position ((w window))
  (or (view-get w 'window-zoom-position)
      (window-default-zoom-position w)))

(defmethod set-window-zoom-position ((w window) h &optional v)
  (if h
    (setf (view-get w 'window-zoom-position) (make-point h v))
    (view-remprop w 'window-zoom-position)))

(defmethod window-zoom-size ((w window))
  (or (view-get w 'window-zoom-size)
      (window-default-zoom-size w)))

(defmethod set-window-zoom-size ((w window) h &optional v)
  (if h
    (setf (view-get w 'window-zoom-size) (make-point h v))
    (view-remprop w 'window-zoom-size)))
#|
(defmethod window-default-zoom-position ((w window))
  *window-default-zoom-position*)

(defmethod window-default-zoom-size ((w window))
  *window-default-zoom-size*)
|#

(defconstant $window-zoom-border 2 "Leave this much border around the zoomed window.")

(defun get-struc-and-cont-rects (wptr strucrect contrect)
  (declare (ignore-if-unused wptr strucrect contrect))
    #+carbon-compat
    (progn
      (#_getwindowbounds wptr #$kwindowstructurergn strucrect) ;; its defined but not found in libs
      (#_getwindowbounds wptr #$kwindowcontentrgn contrect))
    #-carbon-compat
    (error "shouldn't"))

(defun get-cont-rect (wptr contrect)
  (declare (ignore-if-unused wptr contrect))
  #+carbon-compat
  (progn    
    (#_getwindowbounds wptr #$kwindowcontentrgn contrect))
  #-carbon-compat
  (error "shouldn't"))

;(add-pascal-upp-alist 'collapse-begin-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

(add-pascal-upp-alist-macho 'collapse-begin-proc "NewEventHandlerUPP")

;(add-pascal-upp-alist 'collapse-end-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))




(defpascal collapse-begin-proc (:ptr targetref :ptr eventref :word)
  (let ((w (find-view-containing-point nil (get-mouse-position) nil t)))    
    (with-periodic-task-mask ($ptask_event-dispatch-flag t)
      (when w (window-select w))
      (with-timer
        (let ((*interrupt-level* 0)) ;; defpascal binds to -1
          (errchk (#_CallNextEventHandler targetref eventref))))) 
    #$noerr))


(defmethod window-title-height ((window window))
  (let ((wptr (wptr window)))
    (if (not (window-shown-p window))
      (window-type-title-height (window-type window))
        #+carbon-compat
        (rlet ((strucrect :rect)
               (contrect :rect))
          (get-struc-and-cont-rects wptr strucrect contrect)
          (- (pref contrect :rect.top)(pref strucrect :rect.top)))
        #-carbon-compat
        (with-macptrs ((struc (pref wptr windowrecord.strucrgn))
                       (cont (pref wptr windowrecord.contrgn)))
          (- (href cont region.rgnbbox.top)(href struc region.rgnbbox.top))))))

(defmethod window-border-width ((window window))
  (let ((wptr (wptr window)))
    (if (not (window-shown-p window))
      (window-type-border-width (window-type window))
        #+carbon-compat
        (rlet ((strucrect :rect)
               (contrect :rect))
          (get-struc-and-cont-rects wptr strucrect contrect)
          (- (pref contrect :rect.left)(pref strucrect :rect.left)))
        #-carbon-compat
        (with-macptrs ((struc (pref wptr windowrecord.strucrgn))
                       (cont (pref wptr windowrecord.contrgn)))
          (- (href cont region.rgnbbox.left)(href struc region.rgnbbox.left))))))

(defmethod window-right-border-width ((window window))
  (let ((wptr (wptr window)))
    (if (not (window-shown-p window))
      (window-type-border-width (window-type window))
        #+carbon-compat
        (rlet ((strucrect :rect)
               (contrect :rect))
          (get-struc-and-cont-rects wptr strucrect contrect)
          (- (pref strucrect :rect.right)(pref contrect :rect.right)))
        #-carbon-compat
        (with-macptrs ((struc (pref wptr windowrecord.strucrgn))
                       (cont (pref wptr windowrecord.contrgn)))
          (- (href struc region.rgnbbox.right)(href cont region.rgnbbox.right))))))

(defmethod window-bottom-border-width ((window window))
  (let ((wptr (wptr window)))
    (if (not (window-shown-p window))
      (window-type-border-width (window-type window))
        #+carbon-compat
        (rlet ((strucrect :rect)
               (contrect :rect))
          (get-struc-and-cont-rects wptr strucrect contrect)
          (- (pref strucrect :rect.bottom)(pref contrect :rect.bottom)))
        #-carbon-compat
        (with-macptrs ((struc (pref wptr windowrecord.strucrgn))
                       (cont (pref wptr windowrecord.contrgn)))
          (- (href struc region.rgnbbox.bottom)(href cont region.rgnbbox.bottom))))))

(defun window-type-border-width (type)
  (case type
    ((:shadow-edge-box :single-edge-box) 1)
    (:double-edge-box 8)
    (t 6)))
  

(defun window-type-title-height (type)
  (case type
    ((:shadow-edge-box :single-edge-box) 1)
    (:double-edge-box 8)
    (:movable-dialog 23)
    (t 22)))
    

;; Find the screen that overlaps most of the window (or the main screen, if the
;; window doesn't overlap any screens), and return the bounds of the part of that
;; screen that is usable.  This is the entire screen bounds, unless the screen
;; is the main screen, in which case the top portion is consumed by the menubar.
#|
(defun window-preferred-screen-bounds (window &aux (mbar-height (menubar-height)))
  (if *color-available*
    (rlet ((rect :rect :topLeft #@(0 0) :bottomRight (view-size window)))
      (#_OffsetRect :pointer rect :longint (view-position window))
      (let* ((main (#_GetMainDevice))
             (best -1)
             st sl sb sr)
        (flet ((set-to-device-bounds (devicePtr main-device-p)
                 (setf sl (pref devicePtr GDevice.gdRect.left)
                       st (+ (pref devicePtr GDevice.gdRect.top)
                             (if main-device-p mbar-height 0))
                       sr (pref devicePtr GDevice.gdRect.right)
                       sb (pref devicePtr GDevice.gdRect.bottom))))
          (do ((device (#_GetDeviceList) (#_GetNextDevice device)))
              ((%null-ptr-p device))
            (with-dereferenced-handles ((devicePtr device))
              (rlet ((intersection :rect))
                (#_SectRect rect (pref devicePtr GDevice.gdRect) intersection)
                (let ((area (* (- (pref intersection rect.bottom) (pref intersection rect.top))
                               (- (pref intersection rect.right) (pref intersection rect.left)))))
                  (when (> area best)
                    (setf best area)
                    (set-to-device-bounds devicePtr (eql device main)))))))
          (unless sl
            (with-dereferenced-handles ((devicePtr main))
              (set-to-device-bounds devicePtr t))))
        (values sl st sr sb)))
    (values 0 mbar-height *screen-width* *screen-height*)))
|#

;; dont include dockling
(defun window-preferred-screen-bounds (window)
  (if *color-available*
    (let ((window-pos (view-position window))
          (best -1)
          st sl sb sr)
      (rlet ((rect :rect :topLeft window-pos :bottomRight (add-points window-pos (view-size window)))
             (avail-rect :rect))        
        (flet ((set-to-device-bounds (rect)
                 (setf sl (pref rect Rect.left)
                       st (pref rect Rect.top)
                       sr (pref rect Rect.right)
                       sb (pref rect Rect.bottom))))
          (do ((device (#_GetDeviceList) (#_GetNextDevice device)))
              ((%null-ptr-p device))            
            (#_GetAvailableWindowPositioningBounds device avail-rect)
            (rlet ((intersection :rect))
              (#_SectRect rect avail-rect intersection)
              (let ((area (* (- (pref intersection rect.bottom) (pref intersection rect.top))
                             (- (pref intersection rect.right) (pref intersection rect.left)))))
                (when (> area best)
                  (setf best area)
                  (set-to-device-bounds avail-rect)))))
          (unless sl
            (#_GetAvailableWindowPositioningBounds (#_GetMainDevice) avail-rect)
            (set-to-device-bounds avail-rect)))
        (values sl st sr sb)))
    (values 0 (menubar-height) *screen-width* *screen-height*)))


;; The window's new position.  If its origin remains on the same screen, and its
;; old position and new size allow it to fit entirely on that screen, leave it
;; where it is, otherwise move it.
#|
(defmethod window-default-zoom-position ((window window))
  (multiple-value-bind (sl st sr sb) (window-preferred-screen-bounds window)
    (let* ((pos (view-position window))
           (current-h (point-h pos))
           (current-v (point-v pos))
           (size (window-default-zoom-size window))
           (new-width (point-h size))
           (new-height (point-v size))
           (moved-h (+ sl $window-zoom-border))
           (moved-v (+ st $window-zoom-border (window-title-height window))))
      ;; If origin of the window is still on the same screen...
      (if (and (<= sl current-h (1- sr))
               (<= st current-v (1- sb)))
        ;; ...then keep the same coordinates where they allow the window to remain
        ;; wholly on the screen, and use the new ones where the old ones don't...
        (make-point (if (< (+ current-h new-width $window-zoom-border) sr) current-h moved-h)
                    (if (< (+ current-v new-height $window-zoom-border) sb) current-v moved-v))
        ;; otherwise go ahead and move the window.
        (make-point moved-h moved-v)))))
|#

(defmethod window-default-zoom-position ((window window))
  (multiple-value-bind (sl st sr sb) (window-preferred-screen-bounds window)
    (let* ((pos (view-position window))
           (current-h (point-h pos))
           (current-v (point-v pos))
           (size (window-default-zoom-size window))
           (new-width (point-h size))
           (new-height (point-v size))
           (left-border (window-border-width window))
           ;(bottom-border (window-bottom-border-width window))
           (moved-h (+ sl left-border 1))
           (moved-v (+ st 2 (window-title-height window))))
      ;; If origin of the window is still on the same screen...
      (if (and (<= sl current-h (1- sr))
               (<= st current-v (1- sb)))
        ;; ...then keep the same coordinates where they allow the window to remain
        ;; wholly on the screen, and use the new ones where the old ones don't...
        (make-point (if (< (+ current-h new-width left-border 1) sr) current-h moved-h)
                    (if (< (+ current-v new-height 2) sb) current-v moved-v))
        ;; otherwise go ahead and move the window.
        (make-point moved-h moved-v)))))


;; The minimum of the window's preferred size and the usable window area
;; of the window's preferred screen.
#|
(defmethod window-default-zoom-size ((window window))
  (multiple-value-bind (sl st sr sb) (window-preferred-screen-bounds window)
    (let* ((psize (view-preferred-size window))
           (ph (min (point-h psize) (- sr sl
                                       $window-zoom-border $window-zoom-border)))
           (pv (min (point-v psize) (- sb st (window-title-height window)
                                       $window-zoom-border $window-zoom-border))))
      (make-point ph pv))))
|#

(defmethod window-default-zoom-size ((window window))
  (multiple-value-bind (sl st sr sb) (window-preferred-screen-bounds window)
    (let* ((left-border (window-border-width window))
           (right-border (window-right-border-width window))
           (bottom-border (window-bottom-border-width window))
           (psize (view-preferred-size window))
           (ph (min (point-h psize) (- sr sl
                                       left-border right-border 1)))
           (pv (min (point-v psize) (- sb st (window-title-height window)
                                       bottom-border 2)))) ;; huh?
      (make-point ph pv))))

(defmethod view-preferred-size ((w window))
  #@(3000 3000))
  

(defmethod view-valid-p ((view simple-view)) t)

(defmethod view-valid-p ((view view))
  (not (memq nil (view-valid view))))

(defmethod make-view-valid ((view simple-view) &optional dont-inval-subviews)
  (declare (ignore dont-inval-subviews))
  view)

(defmethod make-view-valid ((view view) &optional dont-inval-subviews)
  (let ((valid (view-valid view)))
    (unless (or (null valid) (car valid))
      (setf (%car valid) t)
      (unless dont-inval-subviews
        (dovector (subview (view-subviews view))
          (make-view-invalid subview)))))
  view)

(defmethod make-view-invalid ((view simple-view)) view)

(defmethod make-view-invalid ((view view))
  (let ((valid (view-valid view)))
    (when (and valid (car valid))
      (setf (%car valid) nil)))
  view)

(defmethod view-allocate-clip-region ((view view))
  (let ((rgn (view-clip-region view)))
    (or rgn
        (setf (view-clip-region-slot view) (#_NewRgn)))))

(defmethod view-clip-region ((view view))
  (let ((rgn (view-clip-region-slot view)))
    (unless (or (null rgn) (view-valid-p view))
      (let ((container (view-container view)))
        (compute-view-origin view container)
        (make-view-valid view)
        (compute-view-region view rgn container)))
    rgn))

(defmethod compute-view-region ((view window) rgn container)
  (declare (ignore container))
  (when rgn
    (let* ((topleft (view-origin view))
           (botright (add-points topleft (view-size view))))
      (#_SetRectRgn rgn (point-h topleft) (point-v topleft) (point-h botright) (point-v botright))))
  rgn)

(defmethod compute-view-origin ((view view) container)
  (setf (view-origin-slot view)
        (if container
          (add-points (subtract-points (view-scroll-position view)
                                       (view-position view))
                      (view-origin container))
          (view-scroll-position view))))

(defmethod view-origin ((view view))
  (if (view-valid-p view)
    (view-origin-slot view)
    (let ((container (view-container view)))
      (prog1
        (compute-view-origin view container)
        (make-view-valid view)
        (compute-view-region view (view-clip-region-slot view) container)))))
  
(defmethod window-event-handler ((w window))
  w)

; what if there are no windows
(defmethod window-event-handler (( w t))())

(defmethod toggle-blinkers ((w window) on-p)
  (let ((key-handler (current-key-handler w)))
    (when key-handler
      (toggle-blinkers key-handler on-p))))


(defclass da-window (window)
  ())

(defmethod view-default-font ((window da-window))
  nil)

; This class is here to remove the lisp wdef from a window's wptr on window-close.
; _DisposWindow calls the wdef from inside the GC, so it can't be in Lisp at that time.
#+ignore
(defclass lisp-wdef-mixin () ())  ;; we dont need this today

(defclass windoid (window) ; lisp-wdef-mixin) 
  ((show-on-resume-p :initform nil))
  (:default-initargs
    :window-title ""
    :window-do-first-click t
    :window-type :windoid))

(defun get-window-event-handler ()
  (window-event-handler (front-window :include-windoids t)))

(defvar *windoid-count* 0)

(def-ccl-pointers clos-window ()
  (let ((window (find-class 'window)))
    (set-class-slot-value window 'window-cursor *arrow-cursor*)
    (let ((rect (#_NewPtr 8)))
      (#_SetRect rect 32 32 32767 32767)
      (set-class-slot-value window 'window-grow-rect rect))
    ;; not really used
    (set-class-slot-value window 'window-drag-rect (%null-ptr)))
  ; Initialized for real in sysutils
  (setq *setgworld-available?* nil *screen-gdevice* nil))

;; often result is nonsense
#|
(defun get-the-current-window-drag-rect (&optional w)  
  (let* ((window (find-class 'window)))
    (when (not w)(setq w (class-prototype window)))
    (let ((now-rect (window-drag-rect w)))
      (get-current-screen-size)  ;; assume already done?
      (with-macptrs ((rect (#_newptr 8)))
        #-carbon-compat
        (#_BlockMoveData (rref (%getport) grafport.portbits.bounds) rect 8)
        #+carbon-compat
        (with-port-macptr port  ;; and what port might that be?
          (with-macptrs ((pixmap (#_getportpixmap port)))
            (setf (pref rect :rect.topleft) (href pixmap :pixmap.bounds.topleft))
            (setf (pref rect :rect.botright)(href pixmap :pixmap.bounds.botright))))
        (#_insetrect rect 4 4)
        (if (or (not (eql (pref now-rect :rect.botright) (pref rect :rect.botright)))
                (not (eql (pref now-rect :rect.topleft)(pref rect :rect.topleft))))
          (let ((new-rect (#_newptr 8)))
            (#_blockmovedata rect new-rect 8)
            (set-class-slot-value window 'window-drag-rect new-rect)
            ;(get-current-screen-size)  ;; move this up
            new-rect)
          now-rect)))))
|#

;; not really used now
(defun get-the-current-window-drag-rect (&optional w)
  (declare (ignore w))
  #+ignore
  (set-class-slot-value (find-class 'window) 'window-drag-rect (%null-ptr)))



    
    

(defmethod print-object ((w window) stream)
  (print-unreadable-object (w stream :identity t)
    (format stream "~a ~s"
            (class-name (class-of w)) 
            (ignore-errors (window-title w)))))

(defmethod view-get ((w simple-view) key &optional default)
  (let ((cell (assq key (view-alist w))))
    (if cell
      (cdr cell)
      default)))

(defmethod view-put ((w simple-view) key value)
  (let ((cell (assq key (view-alist w))))
    (if cell
      (setf (cdr cell) value)
      (unless (null value)
        (push (cons key value) (view-alist w))))
    value))

(defmethod (setf view-get) (value (w simple-view) key)
  (view-put w key value))

(defmethod view-remprop ((w simple-view) key)
  (setf (view-alist w)
        (delete key (view-alist w) :test #'(lambda (x y) (eq x (car y))))))

(defmethod set-view-container ((w window) container)
  (unless (null container)
    (error "Container must always be ~s for windows." nil)))


(defparameter *window-type-procid-alist*
 `((:document . ,#$nogrowdocproc)
   (:movable-dialog . ,#$movabledboxproc)
   (:document-with-grow . ,#$documentproc)
   (:document-with-zoom . ,#$zoomdocproc)
   (:document-with-zoom-no-grow . ,#$zoomnogrow)
   (:no-border-box . ,#$kWindowSimpleProc)
   ;(:tool . ,#$rdocproc)  ;; no such thing
   (:tool . ,#$plaindbox)   
   (:double-edge-box . ,#$dboxproc)
   (:single-edge-box . ,#$plaindbox)
   (:shadow-edge-box . ,#$altdboxproc)
   ;(:windoid . 32)  ;; huh
   (:windoid . ,#$floatProc)
   (:windoid-with-grow . ,#$floatGrowProc)
   (:windoid-with-zoom . ,#$floatZoomProc)
   (:windoid-with-zoom-grow . ,#$floatZoomGrowProc)
   (:windoid-side . ,#$floatSideProc)
   (:windoid-side-with-grow . ,#$floatSideGrowProc)
   (:windoid-side-with-zoom . ,#$floatSideZoomProc)
   (:windoid-side-with-zoom-grow . ,#$floatSideZoomGrowProc)))
   
;; just used for an error message
(defparameter *window-type-foos* 
  '(member :document :movable-dialog :document-with-grow :document-with-zoom :document-with-zoom-no-grow
    :tool :double-edge-box :single-edge-box :shadow-edge-box :no-border-box :windoid
    :windoid-with-grow
    :windoid-with-zoom
    :windoid-with-zoom-grow
    :windoid-side
    :windoid-side-with-grow
    :windoid-side-with-zoom
    :windoid-side-with-zoom-grow
    ))

#+ignore
(defparameter *grow-procids*
  (list #$documentProc #$zoomDocProc #$floatGrowProc #$floatZoomGrowProc #$floatSideGrowProc #$floatSideZoomGrowProc))

(defparameter *mcl-grow-window-types*
  (list :document-with-grow :document-with-zoom :windoid-with-grow :windoid-with-zoom-grow :windoid-side-with-grow :windoid-side-with-zoom-grow))  
  

#+ignore
(defparameter *dialog-procids*
  ;; i.e. :movable-dialog :tool :double-edge-box :single-edge-box :shadow-edge-box :no-border-box
  (list #$movabledboxproc  #$dboxproc #$plaindbox #$altdboxproc #$kWindowSimpleProc))

(defparameter *mcl-dialog-window-types*
  (list :movable-dialog :tool :double-edge-box :single-edge-box :shadow-edge-box :no-border-box))

(defparameter *mcl-no-close-box-types*
  (list :movable-dialog :tool :double-edge-box :single-edge-box :shadow-edge-box
        :no-border-box :overlay-window))


;; not used
#|
(defun wptr-dialog-p (wptr)
  (if (osx-p)
    (rlet ((outclass :pointer))
      (#_getwindowclass wptr outclass)
      (eql (%get-unsigned-long outclass) #$kalertwindowclass))
    (ignore-errors (not (null (member (#_getwrefcon wptr) *dialog-procids* :test #'eql ))))))
|#

(defparameter *windoid-types*
  '(:windoid
    :windoid-with-grow
    :windoid-with-zoom
    :windoid-with-zoom-grow
    :windoid-side
    :windoid-side-with-grow
    :windoid-side-with-zoom
    :windoid-side-with-zoom-grow))


(defgeneric window-make-parts (window &key &allow-other-keys))
(defmethod window-make-parts ((window window)
                              &key (view-position (view-default-position window) pos-p)
                              (view-size (view-default-size window) size-p)
                              (window-type :document-with-zoom wtype-p)
                              back-color
                              content-color
                              theme-background
                              procid
                              (window-title  "Untitled")
                              (close-box-p t)
                              (color-p t)
                              (grow-icon-p nil gip?))
  (unless (wptr window)
    (if procid (setq gip? nil grow-icon-p nil))
    (when gip?
      (if grow-icon-p
        (cond ((eq window-type :document) (setq window-type :document-with-grow))
              ((eq window-type :windoid) (setq window-type :windoid-with-grow))
              ((eq window-type :windoid-side)(setq window-type :windoid-side-with-grow))
              ((eq window-type :windoid-with-zoom)(setq window-type :windoid-with-zoom-grow))
              ((eq window-type :windoid-side-with-zoom)(setq window-type :windoid-side-with-zoom-grow))
              ((not (memq  window-type *mcl-grow-window-types*))
               (setq gip? nil grow-icon-p nil)))
        (cond ((eq window-type :document-with-grow) (setq window-type :document))
              ((eq window-type :document-with-zoom) (setq window-type :document-with-zoom-no-grow))
              ((eq window-type :windoid-with-grow) (setq window-type :windoid))
              ((eq window-type :windoid-side-with-grow)(setq window-type :windoid-side))
              ((eq window-type :windoid-side-with-zoom-grow)(setq window-type :windoid-side-with-zoom))
              ;; this is wrong?
              ((not (memq window-type '(:document :document-with-zoom)))
               (setq gip? nil grow-icon-p nil)))))
    (when wtype-p
      (when (and (not (typep window 'windoid)) (or (memq window-type *windoid-types*)(eq window-type :overlay-window)))
        ;(error "Need to make a windoid for window-type ~s." window-type)
        (change-class window 'windoid)        
        (when (not pos-p)(setq view-position (view-default-position window)))
        (when (not size-p)(setq view-size (view-default-size window)))
        )
      (when (and (typep window 'windoid)(not (memq window-type *windoid-types*)))
        (when (memq window-type '(:double-edge-box))(SETQ WINDOW-TYPE :single-edge-box))  ;; weird works on OS9 but not on OSX - why does gc thermo work?
        ;(report-bad-arg window-type (cons 'member *windoid-types*))
        ))
    (when (and Procid #|(osx-p)|#) ;; does anybody do this?
      (when (fixnump procid)
        (LET ((FOO (car (rassoc procid *window-type-procid-alist*))))
          (when (null foo)(error "illegal procid ~d" procid))
          (setq procid nil)
          (setq window-type foo))))
    (setf (mcl-window-type window) window-type)
    (let* ((wptr (%new-window (or procid window-type)
                              view-position
                              view-size
                              close-box-p
                              nil
                              color-p
                              (window-other-attributes window)))
           #+ignore
           (procid #-carbon-compat (rref wptr windowrecord.refCon) #+carbon-compat (#_getwrefcon wptr)))   ; %new-window leaves it there
      (setf (wptr window) wptr)
      #+ignore ;; - too slow
      (when (and nil (not pos-p) (eql view-position *window-default-position*))
        (set-view-position window #@(-3000 -3000))
        (window-show window)
        (let ((left-border (window-border-width window))
              (title-height (window-title-height window)))
          (window-hide window)
          (set-view-position window (make-point (max (1+ left-border)(point-h view-position))
                                                (max (+ title-height 2 (menubar-height)) (point-v view-position))))))
      (progn 
        (set-window-title window window-title)  ;; somehow window-title louses up position of windoid by 4 pixels vertically - dunno why
        (if (and #|(osx-p)|# (typep window 'windoid)(integerp view-position))(set-view-position window view-position)))
      (setf (slot-value window 'grow-icon-p)
            (if gip? grow-icon-p (memq (mcl-window-type window) *mcl-grow-window-types*))) ; (memq procid  *grow-procids*)))
      (when content-color  ;; is this used for anything? - redundancy ??
        (when (not theme-background)
          (set-part-color window :content content-color)
          ;(set-part-color window :title-bar *white-color*) doesnt help
          (when (not back-color)(setq back-color content-color)) ; back-color wins if both
          ))
      (when back-color
        (setf (slot-value window 'back-color) back-color)  ; <<
        (set-back-color window back-color))
      (when (and theme-background) ; (osx-p))  ;; and theme-background overrules both      
        (when (eq theme-background t) 
          (setq theme-background #$kThemeBrushModelessDialogBackgroundActive)
          (setf (slot-value window 'window-theme-background) theme-background))
        (#_SetThemeWindowBackground wptr theme-background t))
      #+ignore
      (when (and (osx-p)
                 close-box-p
                 (not (typep window 'windoid))
                 (not (slot-value window 'grow-icon-p))
                 (not (memq window-type *mcl-dialog-window-types*)))
        ;; do we need this??
        (when (neq 0 (logand (get-bubble-attributes window) #$kWindowCollapseBoxAttribute))
          (Set-bubble-attributes window #$kWindowCollapseBoxAttribute)
          (install-collapse-handler wptr)))      
      (if (typep window 'windoid)
        (progn 
          (when (not (memq window-type *windoid-types*))
            (if (neq window-type :overlay-window)(#_setwindowclass wptr #$kFloatingWindowClass )) ;; huh - needed for no-border-box, single-edge-box ...
            (setwindowmodality wptr #$kwindowmodalitynone)))
        (when (and (memq window-type *mcl-dialog-window-types*)) ; (wptr-dialog-p wptr)) ;(find-class 'drag-receiver-dialog nil)(typep window 'drag-receiver-dialog))
          ; make it non-modal till actually used modally - for IFT or for everybody
          (#_setwindowclass wptr #$kDocumentWindowClass )  ;; do we really need both of these?
          (setwindowmodality wptr #$kWindowModalityNone)
          )))))


(defun setwindowmodality (wptr mode)
  (rlet ((dumdum :ptr))
    (#_SetWindowModality wptr mode dumdum)))

(defun getwindowmodality (wptr)
  (rlet ((dumdum :ptr)
         (mode :ptr))
    (#_getwindowmodality wptr mode dumdum)
    (%get-long mode)))
         

(defmethod view-default-position ((w window))
  *window-default-position*)

(defmethod view-default-size ((w window))
  *window-default-size*)

; Same as add-points, but limits the resulting dimensions
; to (signed-byte 16) range, similar to what the old add-points used to do.
(defun add-points-16 (pt1 pt2)
  (let ((h (+ (point-h pt1) (point-h pt2))) (v (+ (point-v pt1) (point-v pt2))))
    (make-point
     (min (max h -32768) 32767)
     (min (max v -32768) 32767))))
#|
(defconstant $kFirstWindowOfClass -1)
(defconstant $kLastWindowOfClass 0)
|#


(defun install-collapse-handler (wptr)
  (rlet ((spec :eventtypespec 
               :eventclass #$kEventClassWindow
               :eventkind #$kEventWindowClickCollapseRgn))
    (#_InstallEventHandler (#_GetWindowEventTarget wptr) collapse-begin-proc 1 spec
     (%null-ptr)(%null-ptr))))


(defun new-new-window (mcl-type position size close-box-p visible-p &optional (other-attributes 0))  
  
  (let ((wclass nil) (wattrs 0) (the-window nil) (err nil))    
    (case mcl-type
      ((:document-with-grow :tool) 
       (setf wclass #$kDocumentWindowClass
             wattrs (logior #$kWindowResizableAttribute #$kWindowCollapseBoxAttribute )))
      (:double-edge-box
       (setf wclass #$kAlertWindowClass
             wattrs 0)) 
      (:single-edge-box
       (setf wclass #$kPlainWindowClass
             wattrs #$kWindowNoShadowAttribute))
      (:no-border-box            ;; :no-border-box - weird
       (setf wclass #$kAlertWindowClass 
             wattrs #$kWindowNoShadowAttribute))
      (:overlay-window  ;; osx only
       ;(setq close-box-p nil) ;; done below
       (setf wclass #$kOverlaywindowclass
             wattrs 0))           
      (:shadow-edge-box   
       (setf wclass #$kplainWindowClass
             wattrs 0))
      (:document
       (setf wclass #$kDocumentWindowClass
             wattrs 0))
      (:movable-dialog   
       (setf wclass #$kMovableAlertWindowClass ; doesn't work - err -5601 see fix below
             wattrs 0))
      (:document-with-zoom 
       (setf wclass #$kDocumentWindowClass
             wattrs (logior #$kWindowResizableAttribute
                            #$kWindowCollapseBoxAttribute
                            #$kWindowFullZoomAttribute)))
      (:document-with-zoom-no-grow
       (setf wclass #$kDocumentWindowClass
             wattrs #$kWindowFullZoomAttribute))
      (:windoid
       (setf wclass #$kFloatingWindowClass
             wattrs 0))
      (:windoid-with-grow
       (setf wclass #$kFloatingWindowClass
             wattrs #$kWindowResizableAttribute))
      (:windoid-with-zoom
       (setf wclass #$kFloatingWindowClass
             wattrs #$kWindowFullZoomAttribute))
      (:windoid-with-zoom-grow
       (setf wclass #$kFloatingWindowClass
             wattrs (logior #$kWindowResizableAttribute
                            #$kWindowFullZoomAttribute)))
      (:windoid-side
       (setf wclass #$kFloatingWindowClass
             wattrs #$kWindowSideTitlebarAttribute))
      (:windoid-side-with-grow
       (setf wclass #$kFloatingWindowClass
             wattrs (logior #$kWindowSideTitlebarAttribute
                            #$kWindowResizableAttribute)))
      (:windoid-side-with-zoom
       (setf wclass #$kFloatingWindowClass
             wattrs (logior #$kWindowSideTitlebarAttribute
                            #$kWindowFullZoomAttribute)))
      (:windoid-side-with-zoom-grow
       (setf wclass #$kFloatingWindowClass
             wattrs (logior #$kWindowSideTitlebarAttribute
                            #$kWindowResizableAttribute
                            #$kWindowFullZoomAttribute)))          
      )
    (when (and close-box-p 
               (not (memq mcl-type *mcl-no-close-box-types*)))
      (setf wattrs (logior wattrs #$kWindowCloseBoxAttribute)))
    (when (null wclass)
      (error "unknown window type ~D" mcl-type))   
    (rlet ((wrect :rect :topleft 0 :bottomright size)
           (low-window :Ptr))     
      ;; create the window
      (setf err (#_CreateNewWindow wclass (logior wattrs other-attributes) wrect low-window))
      (unless (zerop err)
        (error "error ~D creating window" err))
      
      (setf the-window (%get-ptr low-window))     
      ;; set onscreen position
      (#_MoveWindow the-window (point-h position) (point-v position) #$false)
      
      ;; show, if needed - I think visible-p is always nil
      (when visible-p
        (#_ShowWindow the-window)
        (#_SelectWindow the-window)))
    (set-wptr-modified the-window nil)
    #+ignore
    (#_SetWRefCon the-window type)
    ;; sometimes we add the collapse bubble later than this ??
    (when (neq 0 (logand wattrs #$kWindowCollapseBoxAttribute))
      (install-collapse-handler the-window))    
    the-window))

(defun %new-window (type position size close-box-p visible-p color-p &optional (other-attributes 0))
  (declare (ignore-if-unused color-p))
  ;Leaves the procid in RefCon. NOT ANY MORE
  (setq position (center-window size position))
  (if nil ;(not (osx-p))
    (let ((refcon (if (fixnump type) type
                      (or (cdr (assoc type *window-type-procid-alist*))
                          (report-bad-arg type *window-type-foos*)))))
      (rlet ((wrect :rect :topleft position :bottomright (add-points-16 position size))
             (tp (:string 2)))
        (%put-word tp #x0120)
        (let ((res (if (and color-p *color-available*)
                     (#_NewCWindow 
                      (%null-ptr)
                      wrect                            ; bounds
                      tp                               ; blank title
                      visible-p                        ; visible
                      refcon                             ; procid
                      #-carbon-compat  ;; i dont think this is necessary - well if window isn't going to be shown it is, and elsewise doesn't hurt
                      (%int-to-ptr -1)                 ; behind  -1 means firstwindowofclass, 0 aka null-ptr means last
                      #+carbon-compat                  
                      (%null-ptr)
                      close-box-p                      ; goAwayFlag
                      refcon                             ; refCon
                      )
                     (#_NewWindow
                      (%null-ptr) 
                      wrect                            ; bounds
                      tp                               ; blank title
                      visible-p                        ; visible
                      refcon                             ; procid
                      #-carbon-compat
                      (%int-to-ptr -1)                 ; behind
                      #+carbon-compat
                      (%null-ptr)
                      close-box-p                      ; goAwayFlag
                      refcon                             ; refCon
                      ))))
          (if (%null-ptr-p res)
            (%err-disp #$MemFullErr)
            (progn (set-wptr-modified res nil)
                   res)))))
    (new-new-window type position size close-box-p visible-p other-attributes)
    
    ))

#|
(setq zit (make-instance 'fred-dialog-item :dialog-item-text "asdf"))
(setq poop (make-instance 'window :window-type :overlay-window
                            :view-subviews (list zit)))
|#
  

(defmethod default-window-layer ((w window))
  *windoid-count*)

(defgeneric initialize-window (window &key &allow-other-keys))

;This is invoked with window already created but still invisible.
(defmethod initialize-window ((window window) &key view-font window-layer)
  (when view-font
    (set-initial-view-font window view-font))
  (set-window-layer window (or window-layer (default-window-layer window)))
  (window-size-parts window))

;;;(def-aux-init-functions window #'initialize-window #'window-make-parts)

; Get back the :window-type initarg - well now we saved it thank you!
; Doesn't work for windoids. - well sometimes it does
(defmethod window-type ((window window))
  (if t ;(osx-p)
    (mcl-window-type window)    
    (if (wptr window)
      (let ((procid #-carbon-compat (rref (wptr window) :windowrecord.refcon) #+carbon-compat (#_getwrefcon (wptr window))))
        (dolist (pair *window-type-procid-alist* procid)
          (if (eq procid (cdr pair))
            (return (car pair)))))
      ;; punt
      :document)))

;; only called by vdc of pop-up-menu and then only after calling color-or-gray-p of menu
;; also called by ift
(defmethod window-color-p ((window window))
  (or (wptr-color-p (wptr window))))


;; only called by window-color-p - see above
(defun wptr-color-p (wptr)
  (#_IsPortColor (#_getwindowport wptr)))


(defun color-or-gray-p (view)
  (when *color-available*
    (let* ((w (view-window view))
           (pos (view-position view))
           (c (view-container view)))
      (when c
        (setq pos (add-points (view-position w) (convert-coordinates pos c w))))
      (with-macptrs (ptr) (find-screen pos ptr)
        (when (not (%null-ptr-p ptr))
          (> (screen-bits ptr) 1))))))

(defmethod window-menu-item ((w window) &aux (name (window-title w)))
  (when (null (slot-value w 'my-item))
    (setf (slot-value w 'my-item) 
          (make-instance 'windows-menu-menu-item :window w)))
  (let* ((enable (and (window-shown-p w)
                      (or (neq w (front-window))
                          (not (window-active-p w))))))
    (let ((my-item (slot-value w 'my-item)))
      (when (not (typep name 'encoded-string))
        (when (> (length name) 60) ; chosen at random sort of - doesnt send it left on powerbook
          (setq name (%str-cat (%substr name 0 60) #.(string (code-char #x2026))))))  ;aka  #\É
      (set-menu-item-title my-item name)
      (if enable (menu-item-enable my-item) (menu-item-disable my-item))
      my-item)))

#+ignore
(defmethod window-menu-item ((w da-window))
  nil)

(defun center-window (size position)
  (if (numberp position)
    position
    (let* ((pos-h (%iasr 1 (%i- *screen-width*
                                (point-h size))))
           (pos-v (%iasr 1 (%i- *screen-height*
                                (point-v size)))))
      (cond ((eq position :centered)
             (make-point pos-h pos-v))
             (t (let* ((constraint (pop position))
                      (amount (or (pop position) 0)))
                 (case constraint
                   (:top
                    (make-point pos-h amount))
                   (:bottom
                    (make-point pos-h (- (- *screen-height*
                                            amount)
                                         (point-v size))))
                   (:left
                    (make-point amount pos-v))
                   (:right
                    (make-point (- (- *screen-width*
                                      amount)
                                   (point-h size))
                                pos-v))
                   (otherwise
                    (report-bad-arg constraint '(member :top :bottom :left :right))))))))))

; Method for general views is in lib;views.lisp
(defmethod remove-view-from-window ((view simple-view))
  )

(defvar *last-mouse-click-window* nil)

(defmethod window-close ((w window))
  (window-close-internal w))

(defmethod window-close :around ((w window))
  ; Killing the process may attempt to output on its window.
  ; This prevents deadlock due to the *event-processor* holding
  ; the window-process-queue during window-close.
  (setf (slot-value w 'queue) nil)
  (let ((p (window-process w)))
    (cond ((or (null p)
               (not (window-close-kills-process-p w p)))
           (if *window-update-wptr*
             (process-wait  "finish update" #'(lambda nil (null *window-update-wptr*))))
           (call-next-method))
          (t (setf (window-process w) nil)
             (cond ((eq p *current-process*)
                    (process-interrupt *initial-process* #'finish-window-close w p)
                    (suspend-current-process))
                   (t (process-kill-and-wait p)
                      (call-next-method)))))))

(defun finish-window-close (w p)
  (process-kill-and-wait p)
  (window-close w))

#| trying Bill's version above
;(defmethod window-close :around ((w window))
  (call-next-method)
  ; Killing the process may attempt to output on its window.
  ; This prevents deadlock due to the *event-processor* holding
  ; the window-process-queue during window-close.
  (setf (slot-value w 'queue) nil)
  (let ((p (window-process w)))
    (when p
      (setf (window-process w) nil)
      (cond ((not (window-close-kills-process-p w p)))
            ((eq p *current-process*)
             (process-interrupt *initial-process* #'process-kill-and-wait p)
             (suspend-current-process "Closed"))
            (t (process-kill-and-wait p))))))
|#

(defmethod window-close-kills-process-p :around ((window window) process)
  (and process
       (neq process *event-processor*)
       (neq process *initial-process*)
       (call-next-method)))

(defmethod window-close-kills-process-p ((window window) process)
  (declare (ignore process))
  t)

(defun window-close-internal (w)
  (without-interrupts
   (let ((wptr (wptr w)))
     (when (eq w *last-mouse-click-window*)
       (setq *last-mouse-click-window* nil))
     (when wptr
       (window-hide w)       
       (when (eq w *current-view*)
         (focus-view nil))
       (when (eq w *selected-window*)
         (setq *selected-window* nil))
       (remove-window-object wptr)
       (remove-view-from-window w)
       (let ((rgn (window-erase-region w)))
         (when rgn
           (setf (window-erase-region w) nil)
           (#_DisposeRgn rgn)))     
       (let ((rgn (window-invalid-region w)))
         (when rgn
           (setf (window-invalid-region w) nil)
           (#_DisposeRgn rgn)))
       (unless (%ptr-eql wptr %temp-port%)
         (with-port wptr         
           (rlet ((rect :rect))
             (#_validWindowRect wptr (#_getwindowportbounds wptr rect)))))
       ; _DisposeWindow is done by the GC. 
       #+carbon-compat ;; I dunno why
       ;; screw the gc if osx-p - maybe fixes SendBehind failures - nope
       (when t ;(or (osx-p)(typep w 'windoid))
         (set-macptr-flags wptr $flags_Normal)
         (#_disposewindow wptr))
       (when (null *selected-window*)
         (window-select (front-window))))))
  nil)



(defmethod view-size ((w window) &aux (wptr (wptr w)))
  (rlet ((rect :rect))
    (#_getwindowportbounds wptr rect)
    (subtract-points (pref rect :rect.botright)(pref rect :rect.topleft))))
    

; Overwritten by lib;views.lisp
(when (NOT (fboundp 'window-size-parts))
  (defmethod window-size-parts ((w window)) ()))

; Real version in views.lisp
(when (not (fboundp 'set-view-size))
  (defmethod set-view-size ((w window) h &optional v)
    (set-view-size-internal w h v)))

(defmethod set-view-size-internal ((w window) h &optional v &aux
                                     (wptr (wptr w)))
  (setq h (make-point h v))
  (without-interrupts
   (with-focused-view w
     #+ignore
     (invalidate-grow-icon w t)
     (#_SizeWindow wptr (point-h h) (point-v h) t)
     (setf (slot-value w 'view-size) h)
     (window-size-parts w)
     #+ignore
     (invalidate-grow-icon w)))
  h)

(defmethod view-window ((view simple-view))
  (or
   (let ((wptr (wptr view)))
     (and wptr (window-object wptr)))
   ; During initialize-instance the window may not be on the *window-alist*
   (let ((w view))
     (loop
       (if (or (null w) (typep w 'window))
         (return w)
         (setq w (view-container w)))))))

(defmethod window-zoom-event-handler ((w window) msgw &aux
                                      (wptr (wptr w)))
  (without-interrupts   
   (let* ((zoom-position (window-zoom-position w))
          (br (add-points zoom-position (window-zoom-size w))))
     (rlet ((rect :rect :topleft zoom-position :botright br))
       (#_setwindowstandardstate wptr rect)))
   (with-port wptr      
     (rlet ((rect :rect))
       (#_getwindowportbounds wptr rect)
       (#_eraserect rect))
     (#_ZoomWindow wptr msgw nil))
   (compute-view-region w (view-clip-region-slot w) nil)
   (window-size-parts w)
   nil))

#|
(defmethod window-drag-event-handler ((w window) where)
  (#_DragWindow (wptr w) where (window-drag-rect w))
  (set-view-position w (view-position w)))
|#


#|
(defun window-drag-sub (w where)
  #+carbon-compat
    (progn
      ;; we lose some features here
      (#_DragWindow (wptr w) where (%null-ptr))
      (set-view-position w (view-position w)))
    #-carbon-compat
    (progn
      (let ((wp (wptr w))
            result rgn)
        (when (#_WaitMouseUp)
          (with-macptrs ((wm (#_LMGetWMgrPort))
                         (grayrgn (#_GetGrayRgn)))
            (with-port wm
              (#_SetClip grayrgn)
              (#_ClipAbove wp)
              (setq rgn *grow-icon-rgn*)
              (#_CopyRgn (rref wp windowrecord.strucRgn) rgn)
              (let ((drag-rect (get-the-current-window-drag-rect w))
                    (code (cond ((command-key-p) 1) ; horizontal drag only
                                ((shift-key-p) 2) ; vertical drag only
                                (t 0))))
                (setq result (#_DragGrayRgn rgn where drag-rect drag-rect code (%null-ptr)))))
            (when (neq -32768 (point-h result))
              (set-view-position
               w
               (add-points result (view-position w)))))))))
|#

(export '(allow-view-draw-contents allow-view-draw-contents-mixin) :ccl)



;; fixes drag on OSX - no hope on OS9
(defun window-drag-sub (w where)
  (if t ;(osx-p)
    (with-timer
      (allow-view-draw-contents w)
      (with-periodic-task-mask ($ptask_event-dispatch-flag t)
        (#_DragWindow (wptr w) where (%null-ptr))))
    (#_DragWindow (wptr w) where (%null-ptr)))
  (set-view-position w (view-position w)))

      
#|   
(defmethod window-proxyicon-event-handler ((w window) where)
  (window-drag-event-handler w where t))
|#

(defmethod window-fsref ((w window)) ;; fred-window not defined yet
  (view-get w :fsref))

(defmethod (setf window-fsref) (fsref (w window))
  (view-put w :fsref fsref))

(defparameter *do-standard-proxy-drag-action* t)   ;; some of us might prefer navchoose over leaping to finder - 

(defmethod window-proxyicon-event-handler ((w window) where)
  (if *do-standard-proxy-drag-action*
    (let ((wptr (wptr w)))
      (if (#_IsWindowPathSelectClick wptr *current-event*)  ;; i.e. command-key-p
        (progn 
          (maybe-fix-proxy w)
          (#_WindowPathSelect wptr (%null-ptr) (%null-ptr)))
        (let ((res (with-timer
                     (with-periodic-task-mask ($ptask_event-dispatch-flag t)
                       (#_TrackWindowProxyDrag wptr where) ; drag/copy content someplace else - only works if not modified 
                       )))) 
          (case res 
            (#.#$noerr (let ((fsref-path (window-filename-from-fsref w)))
                         (if fsref-path (set-window-filename w (pathname fsref-path))) ;(back-translate-pathname fsref-path))))
                         ;(set-wptr-modified wptr nil)
                         (window-set-not-modified w)))  ;; actually moved it? - textedit makes alias, we actually move the file - how to just make alias????
            (#.#$erruserwantstodragwindow (window-drag-sub w where)) ; if some sort of magic mouse movement - what is the magic? - very speedy
            ))))
    (window-drag-event-handler w where t)))

(defun pathname-really= (p1 p2)
  (and (pathnamep p1)
       (pathnamep p2)
       (equal (%pathname-name p1)(%pathname-name p2))
       (equal (%pathname-type p1)(%pathname-type p2))
       (equal (%pathname-directory p1)(%pathname-directory p2))
       (equal (pathname-host p1)(pathname-host p2))
       (equal (pathname-version p1)(pathname-version p2))))       
       

;; expensive - dont really understand why needed - without it #_windowpathselect does nothing if file has moved
;; doesnt work if file has moved from original to new then back to original - sometimes OK, sometimes not
#|
(defun maybe-fix-proxy (window)
  (let ((fsref (window-fsref window)))
    (when fsref
      (let ((fsref-path (window-filename-from-fsref window)))
        (when fsref-path 
          (let ((window-path (window-filename window)))
            (cond 
             ((equalp fsref-path window-path)
              ;; maybe case changed - this is a silly waste of time!
              (when (not (pathname-really= fsref-path window-path))
                (set-window-filename-simple window fsref-path)
                ;(setf (slot-value (window-key-handler window) 'my-file-name) fsref-path)
                ;(set-window-title window (application-pathname-to-window-title *application* window fsref-path))
                ))
             (t
              (standard-alert-dialog (format nil  "File has been moved or renamed from \"~A\" to \"~A\""
                                             (back-translate-pathname window-path)
                                             (back-translate-pathname fsref-path))                           
                                     :yes-text "OK" :no-text nil :cancel-text nil)
              (setf (window-fsref window) nil)
              (#_removewindowproxy (wptr window))
              ;(add-window-proxy-icon window fsref-path) ; set-window-filename does it
              (#_disposeptr fsref)            
              (let* ((notmod (not (window-needs-saving-p window)))
                     (marker (fred-title-marker window)))
                (set-window-filename window fsref-path)  ;; makes new proxy icon
                (set-saved-title-marker window marker)
                ;; fixup the marker in the title
                (set-window-title window (window-title window))
                (when notmod 
                  (set-wptr-modified (wptr window) nil)
                  (set-window-doesnt-need-saving (window-key-handler window)))))))))
      )))
|#

(defun maybe-fix-proxy (window)
  (let ((fsref (window-fsref window)))
    (when fsref
      (let ((fsref-path (window-filename-from-fsref window)))
        (when fsref-path 
          (let ((window-path (window-filename window)))
            (cond 
             ((equalp fsref-path window-path)
              ;; maybe case changed - this is a silly waste of time!
              (when (not (pathname-really= fsref-path window-path))
                (set-window-filename-simple window fsref-path)
                ))
             (window-path  ;; some user puts an icon in a window with no window-filename ??
              (standard-alert-dialog (format nil  "File has been moved or renamed from \"~A\" to \"~A\""
                                             (back-translate-pathname window-path)
                                             (back-translate-pathname fsref-path))                           
                                     :yes-text "OK" :no-text nil :cancel-text nil)
              #|  ;; let user decide at window-save time
              (setf (window-fsref window) nil)
              (#_disposeptr fsref)
              (#_removewindowproxy (wptr window))
              (add-window-proxy-icon window fsref-path)
              (set-window-filename-simple window fsref-path)
              |#
              ))))))))


(defmethod window-drag-event-handler ((w window) where &optional in-proxy)
  (cond
   ((and *do-standard-proxy-drag-action* (#_iswindowpathselectclick (wptr w) *current-event*))  ;; i.e command-key-p
    (progn 
      (maybe-fix-proxy w)
      (#_WindowPathSelect (wptr w) (%null-ptr) (%null-ptr))))
    (t    
     (if (and (command-key-p) (pop-up-path-menu w where in-proxy))
       nil
       (if (option-key-p)
         (if (windoid-p w)
           (set-window-layer w (1- *windoid-count*))
           (set-window-layer w 9999))
         (progn
           (window-drag-sub w where)
           (when (control-key-p)
             (let* ((windows (windows :class (class-of w)))
                    (n 1))
               (dolist (win windows)
                 (when (neq win w)(set-window-layer win n)(incf n)))))))))))
            

(defparameter *sys-font-codes* nil)
(defparameter *sys-font-spec* nil)

(defun sys-font-spec ()
  (let* ((font (#_LMGetSysFontFam))
         (ms (#_LMGetSysFontSize)))
    (when (zerop ms)(setq ms 12))
    (if (not *sys-font-codes*)
      (let ((ff (ash font 16)))
        (setq *sys-font-codes* (cons ff ms) *sys-font-spec* (font-spec ff ms)))
      (if (and (eql (ash  (car *sys-font-codes*)  -16) font)
               (eql (cdr *sys-font-codes*) ms))
        *sys-font-spec*
        (progn
          (let ((ff (ash font 16)))
            (rplacd (rplaca *sys-font-codes* ff) ms)
            (setq *sys-font-spec* (font-spec ff ms))))))))


(defun sys-font-codes ()
  (sys-font-spec)  ;; assure inited and currently valid
  (values (car *sys-font-codes*) (cdr *sys-font-codes*)))


(defun pop-up-path-menu (w where &optional in-proxy)
  (let* ((file (window-filename w))
         (local-where (%global-to-local (wptr w) where))
         (x (point-h local-where)))
    (when (and file (setq file (probe-file file)))
      (let* ((title (window-title w))
             (sys-font (sys-font-spec))
             (twidth (+ 16 (string-width title sys-font)))
             (wwidth (point-h (view-size w)))
             (xtra (max 26 (floor (- wwidth twidth) 2)))
             (title-max (min (- wwidth 26) (+ xtra twidth))))
        (when (or in-proxy (< xtra x title-max))
          (let* (;(file (pathname (truename file)))  ;; do truename today
                 (dir (cons (file-namestring file)
                            (reverse (cdr (pathname-directory file)))))
                 (host (pathname-host file)))
            (when (and host (neq host :unspecific))
              (setq dir (nconc dir (list host))))
            (let ((menu (make-instance 'pull-down-menu
                          :menu-title ""
                          :view-size #@(0 0)
                          :view-container w 
                          :view-font sys-font
                          :view-position (make-point x -16) ;local-where ; (make-point (- xtra 5) -16)
                          :menu-items (mapcar #'make-menu-item dir))))
              (let* ((n 0))
                (dolist (item (cdr (menu-items menu))) 
                  (incf n)                  
                  (let ((item-dir
                         (make-pathname :host host :directory (butlast (pathname-directory file) (1- n))
                                        :defaults nil)))
                    (set-menu-item-action-function
                     item 
                     #'(lambda ()(let ((res (catch-cancel (choose-file-dialog 
                                                           :directory item-dir
                                                           :mac-file-type "TEXT"))))
                                   (when (neq res :cancel)(fred res))))))))
              (menu-select menu 0)
              t)))))))
      


;; fixes grow on OSX - no hope on os9
#|
(defmethod window-grow-event-handler ((w window) where)
  (let ((new-size))
    (if (osx-p)
      (with-timer
        (setq new-size (#_GrowWindow (wptr w) where (window-grow-rect w)))
        (if (and (neq new-size 0)
                 (neq 0 (logand (window-other-attributes w) #$kWindowMetalAttribute))
                 ;(neq new-size (view-size w)) ;; isn't that what new-size neq 0 is supposed to say
                 (point<=  new-size (view-size w)))
          ;; IMHO this is needed because of an OSX bug 10.3
          (progn
            ;; aint perfect but much better
            (rlet ((rect :rect :topleft (subtract-points new-size #@(16 16)) :botright new-size))
              (#_fillrect rect *white-pattern*)
              #+ignore
              (with-port-macptr port
                (#_QDFlushPortBuffer port *null-ptr*))))))
      (setq new-size (#_GrowWindow (wptr w) where (window-grow-rect w))))  
    (unless (%izerop new-size)
      (set-view-size w new-size))))
|#

(defparameter *live-resize-all-windows* t)

(defmethod window-grow-event-handler ((w window) where)
  (let ((new-size))
    (if t ;(osx-p)
      (with-timer
        (if (or *live-resize-all-windows* 
                (neq 0 (logand #$kwindowLiveResizeAttribute (window-other-attributes w))))
          (window-live-grow w where)
          (progn            
            (setq new-size (#_GrowWindow (wptr w) where (window-grow-rect w)))
            (metal-grow-fixit w new-size))))
      (setq new-size (#_GrowWindow (wptr w) where (window-grow-rect w))))  
    (unless (or (null new-size)(%izerop new-size))
      (without-interrupts  ;; does this help? - no we never get here
       (set-view-size w new-size)))))

(defmethod view-minimum-size ((w window))
  (make-point #@(45 45)))


#| ;; no longer needed
;; for the paranoid - of course not all new-control-dialog-items are animated
;; ugh stands for universal grow handler
(defun ugh-2 (window)
  (let ((default-button (default-button window)))
    (or (and default-button (neq (view-container default-button) window))
        (and (find-class 'new-control-dialog-item nil)
             (dovector (view (view-subviews window))
               (when (typep view 'view)
                 (if (any-animated-items-in-view view)
                   (return t))))))))

(defun any-animated-items-in-view (view)
  (dovector (sub (view-subviews view))
    (if (typep sub 'new-control-dialog-item)
      (progn (return t))
      (if (typep sub 'view)
        (if (any-animated-items-in-view sub) (return t))))))
|#


(defun window-live-grow (window where)
  (let* ((size (view-size window))
         (min-size (view-minimum-size window))
         (min-h (point-h min-size))
         (min-v (point-v min-size))
         (old-mouse where)
         new-size
         new-mouse)
    (if t (setq *processing-events* nil)) ; let newly exposed stuff if any be drawn on OS9
    (allow-view-draw-contents window)
    (loop
      (when (not (#_stilldown))(return))
      (setq new-mouse (%get-global-mouse-position))
      (when (eql new-mouse old-mouse)
        (if (not (wait-mouse-up-or-moved))(return))
        (setq new-mouse (%get-global-mouse-position)))
      (setq new-size (add-points size (subtract-points new-mouse old-mouse)))
      (setq old-mouse new-mouse)
      (when (and (not (eql new-size size))(%i>= (point-h new-size) min-h)(%i>= (point-v new-size) min-v))
        (without-interrupts
         (setq size new-size) 
         (#_disableScreenUpdates)
         (metal-grow-fixit window size)
         (set-view-size window size) 
         ;(if (typep window 'fred-window)(invalidate-view window))  ;; does this help - no
         (window-update-event-handler window) ;; get erasergn erased, then do view-draw-contents         
         (#_enableScreenUpdates) 
         (#_showcursor)  ;; sometimes gets wiped out
         (with-port-macptr port  ;; does this fix the partial last line problem??
           (#_qdflushportbuffer port (%null-ptr)))
         )))))    

(defun metal-grow-fixit (w new-size)
  (if (and (neq new-size 0)
           (neq 0 (logand (window-other-attributes w) #$kWindowMetalAttribute))
           ;(neq new-size (view-size w)) ;; isn't that what new-size neq 0 is supposed to say
           (point<=  new-size (view-size w)))
    ;; IMHO this is needed because of an OSX bug 10.3
    (progn
      ;; aint perfect but much better
      (rlet ((rect :rect :topleft (subtract-points new-size #@(16 16)) :botright new-size))
        (#_fillrect rect *white-pattern*)))))


(defmethod window-close-event-handler ((w window))
  (cond ((option-key-p)
         (let ((class (class-of w)))
           (dolist (w (nreverse (windows :class class :include-invisibles t)))
             (if (eq (class-of w) class)
               (window-close-nicely w)))))
        ((control-key-p)
         (view-put w :display-in-menu-when-hidden t)
         (window-hide w))
        (t (window-close w))))

(defmethod display-in-windows-menu ((w window))
  (or (window-shown-p w) (view-get w :display-in-menu-when-hidden)))

(defvar *da-window-on-top* nil)

;;old function was susceptible to abort between setting wptr and getting ff and ms;
;;would restore NIL instead of correct font codes
;;Also don't have to refocus if view is same and font-view is nil -- K‡lm‡n
(defmethod call-with-focused-view (view function &optional font-view)
  (let* ((old-view *current-view*)
         (old-font-view *current-font-view*)
         wptr ff ms old-fonts)
    (if (and (eq view old-view)
             (or (null font-view)
                 (eq font-view old-font-view)))
      (funcall function view)
      (unwind-protect
        (progn
          (when (and view (null old-font-view) font-view (setq wptr (wptr view)))
            (multiple-value-setq (ff ms) (wptr-font-codes wptr))
            (setq old-fonts t))
          (focus-view view font-view)
          (funcall function view))
        (when (and (ok-wptr wptr) old-fonts)
          (set-wptr-font-codes wptr ff ms))
        (focus-view old-view old-font-view)))))


;; a mixin for window classes that know what they are doing re allowing multiple processes to draw to a window
;; within with-focused-view

(defclass allow-view-draw-contents-mixin ()())

#|
(defmethod initialize-instance :after ((w allow-view-draw-contents-mixin) &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value w 'queue) nil))
|#

;; call this if want to undo window-locking consequences of call-with-focused-view in e.g. view-click-event-handler
;; so drawing can proceed if view-click-event-handler does something that takes awhile such as invoking a modal-dialog
(defmethod allow-view-draw-contents ((window allow-view-draw-contents-mixin))
  (let ((queue (window-process-queue window)))
    (when (and queue
               (eq (process-queue-locker queue)
                   *event-processor*))
      (process-dequeue queue *event-processor* nil))))

(defmethod allow-view-draw-contents ((window window))
)

(defmethod allow-view-draw-contents ((window (eql nil)))
)

(defmethod call-with-focused-view :around (view function &optional font-view)
  (declare (ignore function font-view)
           (dynamic-extent #'call-next-method))
  (let* ((window (and view (view-window view)))
         (queue (and window (window-process-queue window)))
         (*current-view* *current-view*)
         (*current-font-view* *current-font-view*))
    (if (and queue (neq *current-process* (process-queue-locker queue)))
      (if (eq *current-process* *event-processor*)
        (unwind-protect
          (progn 
            (unless (window-process-enqueue-with-abort *application* view queue)
              (error "Couldn't process-enqueue"))
            (call-next-method))
          (process-dequeue queue nil nil))
        (with-process-enqueued (queue nil nil nil)
          (call-next-method)))
      (call-next-method))))

; We need some way to allow the *event-processor* to usurp a window lock.
; Otherwise, if some process holds onto a window lock for too long,
; the machine will lock up.
; Every 15 ticks, we look for an abort event. If we find one,
; we attempt to abort the offending process. If that doesn't work, we
; usurp the lock.
; I don't know that it will ever be useful for someone to specialize
; these methods, though I can imagine that a debugged application
; would want to just process-enqueue with no abort.
(defmethod window-process-enqueue-with-abort (application view queue &optional
                                                (timeout 15))
  (let ((tried-abort-p nil))
    (loop
      (when (process-enqueue-with-timeout queue timeout)
        (return t))
      (let ((locker (process-queue-locker queue)))
        (when locker
          (when (eq tried-abort-p locker)
            (return (window-process-enqueue-usurping application view queue)))
          (when (abort-event-pending-p)
            (#_FlushEvents #x003F 0)
            (setq tried-abort-p locker)
            (interactive-abort-in-process locker)))))))        

(defmethod window-process-enqueue-usurping (application view queue)
  (declare (ignore application view))
  (process-enqueue-with-timeout queue :usurp))

; These two methods are redefined in "ccl:lib;views.lisp"

(when (not (fboundp 'focus-view))
  (defmethod focus-view ((view null) &optional font-view)
    (declare (ignore font-view))
    (set-gworld %temp-port%)
    (setq *current-view* nil))
  
  
  
  ;; this is replaced in views.lisp
  (defmethod focus-view ((view simple-view) &optional font-view)
    (declare (ignore font-view))
    (without-interrupts
     (let* ((wptr (wptr view)))
       (if wptr
         (progn
           (set-gworld wptr)
           (#_SetOrigin 0 0)
           #-carbon-compat
           (#_ClipRect (rref wptr windowrecord.portrect))
           #+carbon-compat
           (rlet ((rect :rect))
             (#_ClipRect(#_getwindowportbounds wptr rect)))
           (setq *current-view* view))
         (focus-view nil)))))
)





; Initialized in ccl:lib;views.lisp
(defvar *screen-gdevice* nil)
(defvar *setgworld-available?* nil)

; Destructively modifies the two macptr args
(defun get-gworld (port gdh)
  (if *setgworld-available?*
    (rlet ((portp :ptr)
           (gdhp :ptr))
      (#_GetGworld portp gdhp)
      (%setf-macptr port (%get-ptr portp))
      (%setf-macptr gdh (%get-ptr gdhp)))
    (%setf-macptr port (%getport))))

(defun set-gworld (port &optional (device *screen-gdevice*)) ;; - or fix get-current-screen-size to keep it up to date
  (when (ok-wptr port)
    (if *setgworld-available?*
      (#_SetGWorld port device)
      (#_setport port))))

(defun set-gworld-from-wptr (wptr &optional (device  *screen-gdevice*))
  #-carbon-compat
  (set-gworld wptr device)
  #+carbon-compat
  (with-macptrs ((port (#_getwindowport wptr)))
    (set-gworld port device)))

; WITH-PORT expands into a call to this function
(defun call-with-port (port thunk)
  (with-macptrs (saved-port saved-device)
    (without-interrupts
     (unwind-protect
       (let ((%temp-port% port)  ;; why do this?
             (*current-view* nil)
             (*current-font-view* nil))
         (get-gworld saved-port saved-device)
         (set-gworld-from-wptr port)  ;; is it a port or a window?
         (funcall thunk))
       (set-gworld saved-port saved-device)))))

(defmethod view-activate-event-handler ((v simple-view)))


(export '(*disable-bubbles-on-inactive-windows*) :ccl)

(defparameter *disable-bubbles-on-inactive-windows* nil
  "Controls whether close, minimize, and zoom
bubbles work in inactive windows. T for OS9
behavior, nil for OSX behavior. Takes
effect only after windows have been
deactivated.")


;; aargh - repeat in ccl-menus-lds.lisp?
(setf (documentation '*disable-bubbles-on-inactive-windows* 'variable)
                   "Controls whether close, minimize, and zoom
bubbles work in inactive windows. T for OS9
behavior, nil for OSX behavior. Takes
effect only after windows have been
deactivated.")
                   

(defmethod clear-bubble-attributes ((w window) &optional (attributes (logior #$kWindowCollapseBoxAttribute
                                                                             #$kWindowCloseBoxAttribute
                                                                             #$kWindowFullZoomAttribute)))
  (let ((wptr (wptr w)))
    (when wptr 
      (#_changewindowattributes wptr 0 attributes))))

(defmethod set-bubble-attributes ((w window) &optional (attributes (logior #$kWindowCollapseBoxAttribute
                                                                           #$kWindowCloseBoxAttribute
                                                                           #$kWindowFullZoomAttribute)))
  (let ((wptr (wptr w)))
    (when wptr 
      (#_changewindowattributes wptr attributes 0))))



(defmethod get-bubble-attributes ((w window))
  (let ((wptr (wptr w)))
    (when wptr
      (rlet ((fp :unsigned-long))
        (#_GETWINDOWATTRIBUTES wptr fp)
        (logand (%get-long fp) (logior #$kWindowCollapseBoxAttribute
                                       #$kWindowCloseBoxAttribute
                                       #$kWindowFullZoomAttribute))))))

          

; This is a :before method to make it unlikely to be user-shadowed.
(defmethod view-activate-event-handler :before ((w window))
  (view-remprop w :display-in-menu-when-hidden)
  #+ignore
  (when *foreground*
    (if (not (osx-p))(hilite-wptr (wptr w) t))
    #+ignore (window-draw-grow-icon w) ;; does nada
    ))

(defmethod view-activate-event-handler ((w window))
  (setq *da-window-on-top* nil)
  (unless (or (not *foreground*) (window-active-p w))
    (setf (window-active-p w) t)
    (when (and #|(osx-p)|# (not (typep w 'windoid)))
      (let ((attrs (view-get w 'bubble-attrs)))
        (when attrs
          (set-bubble-attributes w attrs))))
    (call-next-method)
    (let ((key (current-key-handler w)))
      (when key
        (dolist (v (key-handler-list w))
          (when (and (neq v key)
                     (not (view-contains-p v key)))
            (view-deactivate-event-handler v)))))))


(defmethod view-deactivate-event-handler ((v simple-view)))

; This is a :before method to make it unlikely to be user-shadowed.
#+ignore
(defmethod view-deactivate-event-handler :before ((w window))
  (let ((wptr (wptr w)))
    (when wptr
      (when (not (osx-p))(hilite-wptr wptr nil)) ; remove this reduces flashies on OSX ???
      ;(window-draw-grow-icon w) ;; does nada
      )))

(defmethod view-deactivate-event-handler ((w window))
  (let ((wptr (wptr w)))
    (when wptr
      (when (window-active-p w)
        (setf (window-active-p w) nil)
        (when (and #|(osx-p)|# (not (typep w 'windoid)) *disable-bubbles-on-inactive-windows*)
          (let ((attrs (get-bubble-attributes w)))
            (view-put w 'bubble-attrs attrs)
            ;; if is collapsed, leave bubble so will uncollapse
            (if (not (#_iswindowcollapsed wptr))
              (clear-bubble-attributes w))))
        (call-next-method)))))          ; deactivate subviews


#|
(defun funcall-with-foreign-window (thunk)
  (without-event-processing
    (let ((w *selected-window*)
          (loathsome-windoids nil))
      (when w
        (view-deactivate-event-handler w))
      (when (osx-p) (set-cursor *arrow-cursor*))
      ;(map-windows #'(lambda (w) (view-deactivate-event-handler w)(push w loathsome-windoids)) :class 'windoid) 
      (unwind-protect
        (funcall thunk)
        (when (setq w *selected-window*)
          (view-activate-event-handler w))
        (when loathsome-windoids (dolist (w loathsome-windoids) (view-activate-event-handler w)))))))
|#
(defglobal *in-foreign-window* nil)
#|
(defun funcall-with-foreign-window (thunk)
  (without-event-processing
    (let ((w *selected-window*))
      (when w
        (view-deactivate-event-handler w))
      (unwind-protect
        (progn 
          (setq *in-foreign-window* t)
          (if (osx-p)
            (with-cursor *arrow-cursor*
              (funcall thunk))
            (funcall thunk)))
        (setq *in-foreign-window* nil)
        (when (setq w *selected-window*)
          (view-activate-event-handler w))))))
|#

#|
(defun funcall-with-foreign-window (thunk)
  (progn ;with-periodic-task-mask ($ptask_event-dispatch-flag t) ;progn ;without-event-processing  ;; lose this?
    (let ((w *selected-window*))
      (when w
        (view-deactivate-event-handler w))      
      (unwind-protect
        (with-port %original-temp-port%
          (setq *interrupt-level* 0)          
          (cond ((not (osx-p))
                 (with-cursor *arrow-cursor*
                   (funcall thunk)))
                (t 
                 (when (and *in-foreign-window* (neq *in-foreign-window* *current-process*))
                   (process-wait "waiting" #'(lambda nil (not *in-foreign-window*))))                 
                 (let-globally ((*in-foreign-window* *current-process*))
                   (LET () ;(*INTERRUPT-LEVEL* 0))  ;; so timer will fire, why is it -1 here? - because of with-port in nav-choose etal - lose that?
                     ;; does weird things on OS9 if a choose-file-dialog appears when app is in background                     
                     (with-timer
                       (with-cursor *arrow-cursor*
                         (funcall thunk))))))))
        ;(if (eq *in-foreign-window* *current-process*)(setq *in-foreign-window* nil))
        (when (setq w *selected-window*)
          (view-activate-event-handler w))))))
|#

(defun funcall-with-foreign-window (thunk)
  (progn ;with-periodic-task-mask ($ptask_event-dispatch-flag t) ;progn ;without-event-processing  ;; lose this?
    (progn ;let ((w *selected-window*))
      #+ignore
      (when w
        (view-deactivate-event-handler w))      
      (progn ;unwind-protect
        (with-port %original-temp-port%
          (setq *interrupt-level* 0)          
          (cond (nil ;(not (osx-p))
                 (with-cursor *arrow-cursor*
                   (funcall thunk)))
                (t 
                 (when (and *in-foreign-window* (neq *in-foreign-window* *current-process*))
                   (process-wait "waiting" #'(lambda nil (not *in-foreign-window*))))                 
                 (let-globally ((*in-foreign-window* *current-process*))
                   (LET () ;(*INTERRUPT-LEVEL* 0))  ;; so timer will fire, why is it -1 here? - because of with-port in nav-choose etal - lose that?
                     ;; does weird things on OS9 if a choose-file-dialog appears when app is in background                      
                     (with-cursor *arrow-cursor*
                       (progn ;with-periodic-task-mask ($ptask_event-dispatch-flag t) ;; ??
                         (with-timer
                           (funcall thunk)))))))))
        ;(if (eq *in-foreign-window* *current-process*)(setq *in-foreign-window* nil))
        #+ignore
        (when (setq w *selected-window*)
          (view-activate-event-handler w))))))



(declaim (special *window-update-wptr*))

(unless (fboundp 'get-back-color)
  ; Overwritten by color.lisp
  (defmethod get-back-color ((w window)) nil))

(unless (fboundp 'set-back-color)
  ; Overwritten by color.lisp
  (defmethod set-back-color ((w window) c &optional d)(declare (ignore c d)) nil))

#+ignore
(defmethod window-update-event-handler ((w window) &aux (wp (wptr w)))
  (without-event-processing ;(let-globally ((*processing-events* *current-process*))       ; uninterruptable by events
    (with-focused-view w
      (let ((rgn (window-erase-region w))
            (invalid-rgn (window-invalid-region w)))
        (when rgn
          #-carbon-compat
          (#_InvalRgn rgn)
          #+carbon-compat
          (inval-window-rgn wp rgn))
        (when *window-update-wptr*
          (#_EndUpdate *window-update-wptr*)
          (setq *window-update-wptr* nil))
        (unwind-protect
          (progn
            (#_BeginUpdate wp)
            (setq *window-update-wptr* wp)
            #+ignore
            (when invalid-rgn
              #+carbon-compat
              (let ((rgn3 *temp-rgn-3*))
                (get-window-visrgn wp rgn3)
                (#_diffrgn rgn3 invalid-rgn invalid-rgn))
              #-carbon-compat
              (#_DiffRgn (rref wp :windowrecord.visRgn) invalid-rgn invalid-rgn)
              (if rgn
                (progn
                  (#_UnionRgn rgn invalid-rgn rgn)
                  (#_SetEmptyRgn invalid-rgn))
                (setq rgn invalid-rgn)))
            (when rgn 
              (#_EraseRgn rgn)
              (#_SetEmptyRgn rgn))
            (view-draw-contents w))
          (when (setq wp *window-update-wptr*)
            (setq *window-update-wptr* nil)
            (#_EndUpdate wp)))))))

; In MCL 4.4b3,
; I had some problems with errors that occurred when progress-step was called on a window
;   that was gone. I think it had to do with the time delay between when window-update-event-handler
;   grabbed the wp and the later time when with-focused-view finally called its queued update
;   function, at which time the window was already gone. This seems to fix the problem.


(defmethod window-update-event-handler ((w window) ) ;&aux (wp (wptr w)))
  (without-event-processing ;(let-globally ((*processing-events* *current-process*))       ; uninterruptable by events
    (with-focused-view w
      (let ((wp (wptr w)))
        (when wp
          (let ((rgn (window-erase-region w))
                (invalid-rgn (window-invalid-region w)))
            (when rgn              
              (#_invalwindowrgn wp rgn))
            (when *window-update-wptr*
              (#_EndUpdate *window-update-wptr*)
              (setq *window-update-wptr* nil))
            (unwind-protect
              (progn
                (#_BeginUpdate wp)
                (setq *window-update-wptr* wp)
                (when invalid-rgn                 
                  (let ((rgn3 *temp-rgn-3*))
                    (get-window-visrgn wp rgn3)
                    (#_diffrgn rgn3 invalid-rgn invalid-rgn))                  
                  (if rgn
                    (progn
                      (#_UnionRgn rgn invalid-rgn rgn)
                      (#_SetEmptyRgn invalid-rgn))
                    (setq rgn invalid-rgn)))
                (when rgn 
                  (#_EraseRgn rgn)
                  (#_SetEmptyRgn rgn))
                (view-draw-contents w))
              (when (setq wp *window-update-wptr*)
                (setq *window-update-wptr* nil)
                (#_EndUpdate wp)
                (when t ;(osx-p)  ;; on general principles
                  (#_QDFlushPortBuffer (#_getwindowport wp) (%null-ptr)))))))))))
  

#|
(defun get-rect (h)
  (multiple-value-bind (tl br)(get-region-bounds-tlbr h)
    (list (point-v tl)
          (point-h tl)
          (point-v br)
          (point-h br))))
|#

(defmethod view-draw-contents ((v simple-view)))


#+ignore
(defmethod view-draw-contents :before ((w window))
    (window-draw-grow-icon w))


; Overwritten by color.lisp
(when (not (fboundp 'color-green))
  (defun color-green (color)
    (declare (ignore color))
    0)
  
  (defun color-blue (color)
    (declare (ignore color))
    0)
  
  (defun color-red (color)
    (declare (ignore color))
    0))


; We don't draw anything at all now

#+carbon-compat
(defmethod window-draw-grow-icon ((w window))
  #+ignore ;; leave def for users including CLIM
  (let ((wptr (wptr window)))
    (when (and wptr (window-grow-icon-p w))
      (without-interrupts
       (let* ((cliprgn *temp-rgn-3*)
              (save-rgn *grow-icon-rgn*))
         (declare (dynamic-extent cliprgn)
                  (type macptr cliprgn))
         (multiple-value-bind (tl br) (grow-icon-corners w)
           (get-window-cliprgn wptr cliprgn) 
           (#_CopyRgn cliprgn save-rgn)
           (unwind-protect
             (progn
               (#_SetRectRgn cliprgn (point-h tl) (point-v tl) (point-h br) (point-v br))
               (set-window-cliprgn wptr cliprgn)
               (#_DrawGrowIcon wptr))
             (set-window-cliprgn wptr save-rgn))))))))



#|
(defun control-rect (control &optional (rect (make-record :rect)))
  (rset rect rect.topleft (rref control controlrecord.contrlrect.topleft))
  (rset rect rect.bottomright (rref control controlrecord.contrlrect.bottomright))
  rect)
|#

#|
;; Must surround this with a with-port or you will lose badly.
(defun invalidate-control (control &optional erase-p)
  (let* ((port (%getport))
        (w (window-object port)))
    (declare (dynamic-extent port))
    (if w
      (invalidate-corners w
                          (rref control :controlrecord.contrlrect.topleft)
                          (rref control :controlrecord.contrlrect.bottomright)
                          erase-p)
      (rlet ((rect :rect))
        (control-rect control rect)
        (if erase-p (#_EraseRect rect))
        (#_InvalRect rect)))))

; ditto
(defun validate-control (control)
  (let* ((port (%getport))
        (w (window-object port)))
    (declare (dynamic-extent port))
    (if w
      (validate-corners w 
                        (rref control :controlrecord.contrlrect.topleft)
                        (rref control :controlrecord.contrlrect.bottomright))
      (rlet ((rect :rect))
        (control-rect control rect)
        (#_ValidRect rect)))))
|#

; Overwritten by views.lisp
(when (not (fboundp 'invalidate-corners))
(defmethod invalidate-corners ((view simple-view) topleft bottomright &optional 
                               erase-p)
  (declare (ignore erase-p))
  (rlet ((rect :rect :topleft topleft :bottomright bottomright))
    (INVAL-WINDOW-RECT (WPTR VIEW) RECT))))

; Also overwritten
(when (not (fboundp 'validate-corners))
(defmethod validate-corners ((view simple-view) topleft bottomright)
  (rlet ((rect :rect :topleft topleft :bottomright bottomright))
    (valid-window-rect (wptr view) rect))))

#|
(defun grow-icon-rect (w &optional (rect (make-record :rect)))
  (multiple-value-bind (top-left bot-right) (grow-icon-corners w)
    (rset rect rect.bottomright bot-right)
    (rset rect rect.topleft top-left)
    rect))
|#

#+ignore
(defun grow-icon-corners (w)
  (let ((wptr (wptr w)))
    #-carbon-compat
    (let ((bot-right (rref wptr windowrecord.portrect.bottomright)))
      (values (subtract-points bot-right #@(15 15))
              bot-right))
    #+carbon-compat
    (rlet ((rect :rect))
      (#_getwindowportbounds wptr rect)
      (let ((bot-right (rref rect :rect.bottomright)))
        (values (subtract-points bot-right #@(15 15))
                bot-right)))))

(defmethod invalidate-grow-icon ((w window) &optional erase-p)
  (declare (ignore-if-unused erase-p))
  #+ignore
  (when (window-grow-icon-p w)
    (with-focused-view w
      (multiple-value-bind (topleft botright) (grow-icon-corners w)
        (invalidate-corners w topleft botright erase-p)))))

; overwritten by lib;dialogs.
(defmethod view-key-event-handler ((w window) char)
  (let ((w *top-listener*))
    (when w
      (view-key-event-handler *top-listener* char))))

(defmethod view-click-event-handler ((view simple-view) where)
  (declare (ignore where))
  view)

;; not real efficient
#|
(defun grafport-write-char (char &optional ff ms)
  (when (not (and ff ms))(multiple-value-setq (ff ms)(grafport-font-codes)))
  (grafport-write-string (string char) 0 1 ff ms))
|#

(export 'grafport-write-char :ccl)
;; do it at pen
(defun grafport-write-char (char &optional ff ms)
  (when (not (and ff ms)) (multiple-value-setq (ff ms) (grafport-font-codes-with-color)))  ;; grafport ff doesn't include color    
  (let* ((pen (%getpen)))
    (let ((hpos (grafport-write-char-at-point char pen ff ms)))
      (#_moveto hpos (point-v pen))
      hpos)))

;; do it where specified - from the "pen"/baseline point of view
(defun grafport-write-char-at-point (char point ff ms)
  (let* ((hpos (point-h point))
         (vpos (point-v point)))
    (declare (fixnum hpos vpos)) 
    (let ((ascent (font-codes-info ff ms)))
      (%stack-block ((ubuff 2))
        (%put-word ubuff (char-code char))
        (setq hpos (experimental-draw-text ubuff 1 hpos (%i- vpos ascent) ascent  nil ff ms))))))


#| 
(defmethod stream-tyo ((v simple-view) char)
  (if (char-eolp char)
    (view-terpri v)
    (with-font-focused-view v
      (#_DrawChar char))))
|#

(defmethod stream-tyo ((v simple-view) char)
  (if (char-eolp char)
    (view-terpri v)
    (with-font-focused-view v
      (multiple-value-bind (ff ms)(view-font-codes v)
        (grafport-write-char char ff ms)))))

;; not used today
#+ignore
(defun grafport-write-long-string (string start end)
  (let* ((chunk (if (extended-string-p string) 127 255))
         (n (ceiling (- end start) chunk)))
    (dotimes (i n)
      (with-pstr (pstr string start (min end (+ start chunk)))
        (#_drawstring pstr))
      (setq start (+ start chunk)))))


(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro grafport-write-string (string start end &optional ff ms color)  
    `(grafport-write-unicode ,string ,start ,end ,ff ,ms ,color))
  )



;; not used today
#+ignore
(defun grafport-write-ascii (string start end)
  (if (> (- end start) 255)
    (grafport-write-long-string string start end)
    (with-pstr (pstr string start end)
      (require-trap #_DrawString pstr))))
    
#+ignore
(defun grafport-write-unicode (string start end)
  (multiple-value-bind (ff ms) (grafport-font-codes)
    (let* ((pen (%getpen))
           (hpos (point-h pen))
           (vpos (point-v pen))
           (len (- end start))
           (lastidx 0)
           (last-encoding (font-to-encoding-no-error (ash ff -16)))
           roman-ff)
      (declare (fixnum len))
      (if (eq last-encoding #$kcfstringencodingmacroman)
        (setq roman-ff ff))
      (%stack-block ((ubuff (%i+ len len)))
        (dotimes (i len)
          (let* ((char (%schar string (%i+ start i)))
                 (this-encoding (find-encoding-for-uchar char)))
            (setf (%get-word ubuff (+ i i))(%char-code char))
            (if (char-eolp char)
              (error "didn't expect eol")              
              (if (neq this-encoding last-encoding)
                (cond 
                 ((and (<= (%char-code char) #x7f)(memq last-encoding *script-list*))
                  (setq this-encoding last-encoding))
                 (t                  
                  (when (neq i 0)                
                    (multiple-value-bind (ascent descent width leading) (font-codes-info ff ms)
                      (declare (ignore width))
                      (with-font-codes ff ms                   
                        (setq hpos (experimental-draw-text (%inc-ptr ubuff (%i+ lastidx lastidx)) (%i- i lastidx)
                                                           hpos (%i- vpos ascent) ascent (%i+ ascent descent leading) nil)))))                   
                  (setq ff (find-font-ff-for-uchar2 char this-encoding ff roman-ff))
                  (setq lastidx i)
                  (setq last-encoding this-encoding)))))))                  
        (multiple-value-bind (ascent descent width leading) (font-codes-info ff ms)
          (declare (ignore width))
          (with-font-codes ff ms            
            (setq hpos (experimental-draw-text (%inc-ptr ubuff (%i+ lastidx lastidx)) (%i- len lastidx)
                                    hpos (%i- vpos ascent) ascent (%i+ ascent descent leading) nil)))))
      ;; makes inspector happy
      (#_moveto hpos vpos))
  ))

;; aka %str-eol-member
(defun simple-string-eol-position (string start end)
  (declare (fixnum start end))
  (dotimes (i (%i- end start))
    (declare (fixnum i))
    (when (char-code-eolp (%scharcode string (%i+ start i)))
      (return (%i+ i start)))))



;; position oriented - not used today
(defun grafport-write-unicode-at-position (string start end position &optional ff ms)
  (if (not (and ff ms)) (multiple-value-setq (ff ms) (grafport-font-codes-with-color)))  ;; grafport ff doesn't include color
  (let* ((ascent (font-codes-info ff ms)))
    (#_moveto (point-h position)(+ (point-v position) ascent))
    (grafport-write-unicode string start end ff ms)))

;; pen oriented - and so is ATSUDrawText in the sense that vpos is where the "pen" should be to start drawing - i.e. baseline
(defun grafport-write-unicode (string start end &optional ff ms color)
  (if (not (and ff ms)) (multiple-value-setq (ff ms) (grafport-font-codes-with-color)))
  (if color
    (setq ff (logior (logand ff (lognot #xff)) (color->ff-index color))))
  (let* ((pen (%getpen))
         (hpos (point-h pen))
         (vpos (point-v pen)))
    (declare (fixnum hpos vpos)) 
    (when (not (simple-string-p string))(multiple-value-setq (string start end)(string-start-end string start end)))  ;; not always simple string - e.g. from CLIM
    (multiple-value-bind (ascent descent width leading) (font-codes-info ff ms)
      (declare (ignore width))
      (let ((eol-pos (simple-string-eol-position string start end))
            (line-height (%i+ ascent descent leading))
            (last-hpos hpos)
            len)
        (declare (fixnum line-height))
        (loop
          (setq len (- (or eol-pos end) start))
          (%stack-block ((ubuff (%i+ len len)))
            (copy-string-to-ptr string start len ubuff)
            (setq last-hpos (experimental-draw-text ubuff len hpos (%i- vpos ascent) ascent  nil ff ms)))          
          (when (or (not eol-pos)(eql eol-pos end))          
            (#_moveto last-hpos vpos)
            (return))
          (setq start (1+ eol-pos))
          (setq eol-pos (simple-string-eol-position string start end))
          (setq vpos (+ vpos line-height)))))))


#+ignore ;; not used ??
(defun find-font-ff-for-uchar2 (uchar encoding ff roman-ff)
  (declare (ignore-if-unused uchar))  
  (cond ((and roman-ff (eq encoding #$kcfstringencodingmacroman))
         roman-ff)
        ((memq encoding *script-list*)
         (find-fallback-font ff encoding))
        ((eq encoding #$kcfstringencodingmacdingbats) (font-codes '("Zapf Dingbats") ff 0))
        ((eq encoding #$kcfstringencodingmacsymbol) (font-codes '("Symbol") ff 0))
        (t (let ((script (if encoding (encoding-to-script encoding))))
             (if script (find-fallback-font ff script)
                 (error "Cant find font for encoding ~s" encoding))))))





(defmethod stream-write-string ((v simple-view) string start end)
  (multiple-value-bind (string offset) (array-data-and-offset string)
    (declare (fixnum offset))
    (let ((start (+ offset (require-type start 'fixnum)))
          (end (+ offset (require-type end 'fixnum)))
          middle)
      (declare (fixnum start end))
      (with-font-focused-view v
        (loop
          (setq middle (simple-string-eol-position string start end))
          (grafport-write-string string start (or middle end))
          (if middle
            (progn
              (view-terpri v)
              (setq start (1+ middle)))
            (return)))))))

(defmethod view-terpri ((v simple-view))
  "does the best it can at doing a generic carriage return"
  (with-focused-view v
    (multiple-value-bind (ff ms)(view-font-codes v)      
      (let* ((wptr (wptr v))
             (cur-pos #-carbon-compat (rref wptr windowrecord.pnloc) #+carbon-compat (get-window-pnloc wptr))) ;; where t.f. is that
        (#_Moveto 5 (+ (point-v cur-pos)(font-codes-line-height ff ms)))))))

(defmethod stream-force-output ((w window))
  (let ((key (current-key-handler w)))
    (when key (stream-force-output key))))

(defmethod view-mouse-position ((v simple-view))
  (with-focused-view v
    (%stack-block ((pt 4))
      (#_GetMouse pt)
      (%get-long pt))))

(defmethod view-mouse-position ((v null))  
  (%stack-block ((pt 4))
    (#_getglobalmouse pt)
    (%get-long pt)))
  
; double-click-patch.lisp
(defmethod window-select-event-handler ((w window))
  (unless (window-do-first-click w)
    (setq *last-mouse-down-time* 0))
  (window-select w))

(defmethod window-select ((w null))
  ; Sometimes (front-window) is nil
  (let ((w (front-window)))
    (if w
      (window-select w)
      (progn
        (setq w *selected-window*)
        (when w
          (view-deactivate-event-handler w)
          (setq *selected-window* nil))))))

(defmethod window-select ((w window))
  (setq *last-mouse-click-window* w)
  (if (eq w *selected-window*)
    (unless (window-active-p w)
      (view-activate-event-handler w))
    (let ((wptr (wptr w)))
      (when *selected-window*        
        (view-deactivate-event-handler *selected-window*)        
        )
      (autoposition-show w wptr)
      (setq *selected-window* nil)
      (reselect-windows)
      (if #-carbon-compat *last-windoid* #+carbon-compat nil
        (window-send-behind wptr (wptr *last-windoid*) t)
        (window-bring-to-front w))
      (setq *selected-window* w)
      (view-activate-event-handler w)
      (when (getf *environs* :color-quickdraw)
        (#_ActivatePalette wptr))       ; #_SelectWindow does this
      (menu-update (edit-menu)))))

#+ignore
(defmethod window-select ((w da-window))
  (let ((selected *selected-window*)
        (wptr (wptr w)))
    (unless (eq w selected)
      (autoposition-show w wptr)
      (setq *selected-window* w)
      (#_SelectWindow wptr)
      (unselect-windows t)))
  w)

(defun window-bring-to-front (w &optional (wptr (wptr w)))
  (when (and w wptr)
    (if t ; (or (osx-p)(typep (front-window :include-windoids t) 'da-window)) ;; added osx-p - fixes grow box and title bar in 5g15 seed
      (#_SelectWindow wptr)
      (#_BringToFront wptr))))
        
(defmethod window-layer ((w window) &optional include-invisibles)
  (without-interrupts
   (let* ((wp (wptr w)) (count 0))
     (when wp
       (do-wptrs w
         (when (%ptr-eql w wp) (return))
         (when (or include-invisibles #-carbon-compat (rref w windowrecord.visible) #+carbon-compat (#_iswindowvisible w))
           (setq count (%i+ count 1))))
       count))))

(defmethod set-window-layer ((w window) new-layer &optional include-invisibles)
  (without-interrupts
   (let* ((wptr (wptr w)))    
     (when wptr
      (let* ((visible? #-carbon-compat (rref wptr windowrecord.visible) #+carbon-compat (#_iswindowvisible wptr)))
        (if (<= new-layer 0)
          (with-macptrs ((fw #-carbon-compat (#_FrontWindow)
                             #+carbon-compat (#_FrontNonFloatingWindow)))   ; this is the modal dialog case  - was FrontWindow - fix from Brendan Burns
            (unless (%ptr-eql wptr fw)
              (window-bring-to-front w wptr)
              (when visible?
                (unselect-windows t)
                (setq *selected-window* w)
                (view-activate-event-handler w))))
          (let ((selected *selected-window*))
            (if (set-window-layer-internal 
                 w (max *windoid-count* new-layer) include-invisibles)
              (when (eq w selected)
                (let ((new-selected (front-window)))
                  (unless (eq w new-selected)
                    (view-deactivate-event-handler w)
                    (setq *selected-window* new-selected)
                    (view-activate-event-handler new-selected))))
              (unless (or (not visible?) (eq w selected))
                (view-deactivate-event-handler selected)
                (setq *selected-window* w)
                (view-activate-event-handler w))))))))))

; selects a da if it is briught in front of all non-windoids.
; This
#+ignore 
(defmethod set-window-layer ((w da-window) new-layer &optional include-invisibles)
  (if (and (<= new-layer *windoid-count*) (window-shown-p w))
    (progn (window-select w) 0)
    (progn
      (if (eq w *selected-window*)
        (reselect-windows))
      (set-window-layer-internal w new-layer include-invisibles)
      new-layer)))


; Will fail on trying to set the layer to 0.
; Returns nil unless this window was sent behind the selected-window
(defun set-window-layer-internal (w new-layer include-invisibles)
  (let ((layer 0)
        (wptr (wptr w))
        (closerp t)
        (selected-wptr (and *selected-window* (wptr *selected-window*)))
        behind-selected?)
    (with-macptrs ((wp #-carbon-compat (#_LMGetWindowList) #+carbon-compat (#_getwindowlist))
                   last-wp)
      (do () ((%null-ptr-p wp))
        (if (and selected-wptr (%ptr-eql wp selected-wptr))
          (setq behind-selected? t))
        (if (%ptr-eql wptr wp)
          (setq closerp nil)
          (progn
            (%setf-macptr last-wp wp)
            (when (or include-invisibles #-carbon-compat (rref wp windowrecord.visible) #+carbon-compat (#_iswindowvisible wp))
              (when (>= (incf layer) new-layer)
                (return)))))            ; return from do.
        (%setf-macptr wp #-carbon-compat (rref wp windowrecord.nextwindow) #+carbon-compat (#_getnextwindow wp)))
      (unless (or (%null-ptr-p last-wp)
                  (%ptr-eql wptr #-carbon-compat (rref last-wp windowrecord.nextwindow)
                                 #+carbon-compat (#_getnextwindow last-wp)))
        (window-send-behind wptr last-wp closerp)))
    behind-selected?))


(defun window-send-behind (wptr behind-wptr closerp &aux rgn)
  (declare (ignore-if-unused closerp rgn))
  (with-macptrs ((behind-behind-wptr  (#_getnextwindow behind-wptr)))
    (unless (eql wptr behind-behind-wptr)      
      (progn          
        (unless (AND (typep (window-object behind-wptr) 'windoid)
                     (not (typep (window-object wptr) 'windoid)))
          (#_SendBehind wptr behind-wptr)
          )))))


(defun autoposition-show (w wptr)
  (autoposition w)
  (if t ;(osx-p) 
    (progn (#_showwindow wptr))
    (#_ShowHide wptr t)))

(defmethod autoposition ((w window))
  (unless (window-shown-p w)
    (let* ((slotv (slot-value w 'auto-position))
           (info (cdr (assq slotv (cdr autopos-constraints)))))
      (when (and slotv (neq slotv :noAutoCenter)(null info))
        (error "~S must be one of ~S" slotv
           (mapcar #'car (cdr autopos-constraints))))
      (when info
        (let ((front-window (front-window)))
          (multiple-value-bind (parent-size parent-pos screen-p)
                               (case (second info)
                                 (:main-screen (values *screen-size* #@(0 0) t))
                                 (:parent-window (if front-window
                                                   (values (view-size front-window)
                                                           (view-position front-window))
                                                   (values *screen-size* #@(0 0))))
                                 (:parent-window-screen (if front-window
                                                          (let ((screen (window-screen front-window)))
                                                            (values (screen-size screen)
                                                                    (screen-position screen)
                                                                    t))
                                                          (values *screen-size* #@(0 0) t))))
            (let* ((our-size      (view-size w))
                   (our-height    (point-v our-size))
                   (parent-width  (point-h parent-size))
                   (parent-height (point-v parent-size))
                   (parent-h      (point-h parent-pos))
                   (parent-v      (point-v parent-pos))
                   (pos-h (max parent-h
                               (%i+ parent-h (%iasr 1 (%i- parent-width
                                                           (point-h our-size))))))
                   (pos-v (%i+ parent-v (%iasr 1 (%i- parent-height
                                                      our-height)))))
              (set-view-position
               w (case (first info)
                   (:stagger
                    (cond ((not screen-p)
                           (add-points #@(10 10) parent-pos))
                          ((and front-window
                                (memq (slot-value front-window 'auto-position)
                                      '(:staggerMainScreen
                                        :staggerParentWindow
                                        :staggerParentWindowScreen)))
                           (add-points #@(10 10) (view-position front-window)))
                          (t (add-points parent-pos
                                         (make-point 2 (%i+ (menubar-height)
                                                            (window-title-height w)))))))
                   
                   (:center
                    (make-point pos-h (max parent-v pos-v)))
                   (:alert-pos
                    (make-point pos-h
                                (max parent-v
                                     (%i+ parent-v
                                          (round (%i- parent-height our-height)
                                                 5))))))))))))))

(defmethod window-screen ((w window))
  (let ((position (view-position w)))
    (rlet ((rect :rect :topleft position
                 :bottomright (add-points position (view-size w))))
      (#_GetMaxDevice rect))))

(defmethod window-show ((w window))
  (let ((wptr (wptr w)))
    (when (and (ok-wptr wptr)
               (not  (#_iswindowvisible wptr)))
      (window-show-internal w wptr)))
  w)



(defmethod window-show-internal ((w window) wptr)
  (let ((selected *selected-window*))
    ;; windows are in a different order when carbon and windoid present    
    
    (cond     
     ((or (null selected) #+carbon-compat (> *WINDOID-COUNT* 0)
          (wptr-behind-p (wptr selected) wptr))  ;; IS SELECTED BEHIND THIS - WEIRD?
      (cond ((and (> *windoid-count* 0)                       
                  (do-wptrs w
                    (return (%ptr-eql w wptr))))
             ;(PUSH (LIST 'CASE1 W) barf)
             (unselect-windows t)
             (autoposition-show w wptr)
             (setq *selected-window* w)
             (view-activate-event-handler w))
            ;; seems like we want this case most of the time
            (t ;(PUSH (LIST 'CASE2 W) barf)
               (window-select w))))
     (t ;(PUSH (LIST 'CASE3 W) barf)
        (autoposition-show w wptr)))))

(defmethod window-hide ((w window))
  (if nil ;(not (osx-p))
    (#_ShowHide (wptr w) nil)
    (#_hidewindow (wptr w)))
  (when (eq w *selected-window*)
    (window-select (front-window))))

; True if wptr is behind behind
(defun wptr-behind-p (wptr behind)
  (with-macptrs ((w #-carbon-compat (rref behind windowrecord.nextwindow) #+carbon-compat (#_getnextwindow behind)))
    (do () ((%null-ptr-p w) nil)
      (if (%ptr-eql wptr w) (return t))
      (%setf-macptr w #-carbon-compat (rref w windowrecord.nextwindow) #+carbon-compat (#_getnextwindow w)))))

(defmethod window-shown-p ((w window) &aux wptr)
  (and (setq wptr (wptr w))
       (#_iswindowvisible wptr)))

(defmethod view-position ((w window) &aux (wptr (wptr w)))  
  (rlet ((rect :rect))
    (#_getwindowportbounds wptr rect)
    (%local-to-global wptr (pref rect :rect.topleft))))

(defmethod set-view-position ((w window) h &optional v)
  (cond ((numberp h)
         (setq h (make-point h v))
         (#_MoveWindow (wptr w) (point-h h) (point-v h) nil)
         h)
        (t (set-view-position w (center-window (view-size w) h)))))
#|
(defmethod window-title ((w window) &aux wptr)
;Note - the stuff below compares the window's Pascal title string with
;it's object-name slot.  If they are identical strings, it returns the 
;object-name string.  This avoids consing and makes the result of window-title
;eq to the object-name. Seems silly to me. 
  (or (and (setq wptr (slot-value-if-bound w 'wptr))
           (or 
            (let ((title (slot-value w 'object-name)))
              (and title
                   ; what if its in some weird script - fred-window method deals with script
                   (with-macptrs ((wtitle (pref wptr windowrecord.titlehandle)))
                     (let ((len (length title)))
                       (if (neq len (%hget-byte wtitle 0))
                         nil 
                         (dotimes (i len title)
                           (when (not (eql (%scharcode title i)(%hget-byte wtitle (+ 1 i))))
                             (return nil))))))))
            (rlet ((tp (:string 255)))
                 (#_GetWTitle  wptr tp)
                 (%get-string tp))))
      "<No title>"))
|#
; nearly same as for fred-window
(defmethod window-title ((w window)) ; &aux wptr nm)
  (or (slot-value w 'object-name)
      (error "Shouldn't")
      #+ignore
      (and (setq wptr (wptr w))
           (let* ()
             (%stack-block ((np 256))
               (#_getWTitle wptr np)
               (setq nm
                     (%str-from-ptr-in-script  (%inc-ptr np 1) (%get-byte np 0)))
               (setf (slot-value w 'object-name) nm))))
      "<No title>" ))

(defmethod set-window-title ((w window) new-title)
  (setq new-title (ensure-simple-string (string-arg new-title)))
  (let ((wptr (wptr w))
        (len (length new-title)))          
    (cond
     ((not (7bit-ascii-p new-title))
      (%stack-block ((sb (+ len len)))
        (copy-string-to-ptr new-title 0 len sb)
        (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) sb len)))
          (#_SetWindowTitleWithCFString wptr cfstr)
          (#_cfrelease cfstr))))
     (t
      (when (%i> len  255)
        (error "Title ~S too long"  new-title))
      (%stack-block ((np (+ len 1)))
        (dotimes (i len)
          (%put-byte np (%scharcode new-title i) (+ i 1)))
        (%put-byte np len 0)
        (#_SetWTitle wptr np))))
    (setf (slot-value w 'object-name) new-title)
    new-title))

;; for "Definitions in ...
(defmethod set-window-title ((w window)(new-title encoded-string))
  (let* ((string (the-string new-title))
         (enc (the-encoding new-title)))
    (when (neq enc #$kcfstringencodingunicode) (error "barf"))
    (set-window-title w string)))


#|
(defmethod view-font-codes ((w window))
  (wptr-font-codes (wptr w)))
|#

(defmethod set-view-font-codes ((w window) ff ms &optional ff-mask ms-mask)
  (declare (ignore ff ms ff-mask ms-mask))
  (multiple-value-bind (new-ff new-ms) (call-next-method)
    (let ((wptr (wptr w)))      
      (when wptr
        (set-wptr-font-codes wptr new-ff new-ms))
      )
    (values new-ff new-ms)))

(defun wptr-font-codes (wptr)  
  (with-macptrs ((port (#_getwindowport wptr)))
    (grafport-font-codes-from-port port)))

#+carbon-compat
(defun grafport-font-codes-from-port (port)
  (let ((font (#_getporttextfont port))
        (face (#_getporttextface port))
        (mode (#_getporttextmode port))
        (size (#_getporttextsize port)))
    (values (logior (ash font 16) (ash face 8))
            (logior (ash mode 16) size))))

(defun grafport-font-codes ()
  (with-port-macptr port    
    (grafport-font-codes-from-port port)))

;; assume wptr is windowrecord
(defun set-wptr-font-codes (wptr ff ms &optional ff-mask ms-mask)
  (when (or ff-mask ms-mask)    
    (multiple-value-bind (port-ff port-ms)(wptr-font-codes wptr)
      (if ff-mask
        (setq ff  (%ilogior2 (%ilogand2 ff ff-mask) 
                         (%ilogand2 port-ff (%ilognot ff-mask)))))
      (if ms-mask
        (setq ms (%ilogior2 (%ilogand2 ms ms-mask) 
                        (%ilogand2 port-ms (%ilognot ms-mask)))))))      
  
  ;; what?  this doesnt ref the port or anything - brain death
  ;; and wptr maybe a port or it may be a windowrecord
  (with-port wptr ;(#_getwindowport wptr) ; 03/31/01
    (progn
      (let ((font (ash ff -16))
            (face (logand (ash ff -8) #xff))
            (mode (ash ms -16))
            (size (logand ms #xffff)))
        (#_textfont font)
        (#_textface face)
        (#_textmode mode)
        (#_textsize size))))   
  (values ff ms))

#+carbon-compat
(defun get-port-ff (port)
  (logior (ash (#_getporttextfont port) 16)(ash (#_getporttextface port) 8)))

#+carbon-compat
(defun get-port-ms (port)
  (logior (ash (#_getporttextmode port) 16)(#_getporttextsize port)))
 
#+carbon-compat ;;  - assume port is set??
(defun set-port-font-codes (port ff ms &optional ff-mask ms-mask)
   (if ff-mask
    (setq ff  (%ilogior2 (%ilogand2 ff ff-mask) 
                         (%ilogand2 (get-port-ff port) (%ilognot ff-mask)))))
   (if ms-mask
    (setq ms (%ilogior2 (%ilogand2 ms ms-mask) 
                        (%ilogand2 (get-port-ms port) (%ilognot ms-mask)))))
   
  (progn
      (let ((font (ash ff -16))
            (face (logand (ash ff -8) #xff))
            (mode (ash ms -16))
            (size (logand ms #xffff)))
        (#_textfont font)
        (#_textface face)
        (#_textmode mode)
        (#_textsize size))))

#|
(deftrap-inline "_GetPortTextFont" 
      ((port (:pointer :cgrafport))) 
  :signed-integer
   () )
(deftrap-inline "_GetPortTextFace" 
      ((port (:pointer :cgrafport))) 
  :style
   () )
(deftrap-inline "_GetPortTextMode" 
      ((port (:pointer :cgrafport))) 
  :signed-integer
   () )
(deftrap-inline "_GetPortTextSize" 
      ((port (:pointer :cgrafport))) 
  :signed-integer
   () )
|#

(defun set-grafport-font-codes (ff ms &optional ff-mask ms-mask)
  (with-port-macptr wptr
    
    #-carbon-compat
    (set-wptr-font-codes wptr ff ms ff-mask ms-mask)
    #+carbon-compat
    (set-port-font-codes wptr ff ms ff-mask ms-mask)))

(defmethod stream-line-length ((v simple-view))
  (multiple-value-bind (ascent descent widmax)
                       (font-info (view-font v))
    (declare (ignore ascent descent))
    (floor (- (point-h (view-size v)) 20) ;always assumes that there is a 
                                        ;scroll bar. Not always correct
                                        ;but little harm done if there isn't
           widmax)))

(defmethod window-filename ((w stream)) (stream-filename w))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            DA-window                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+ignore
(defmethod initialize-instance ((w da-window) &key)
  (call-next-method)
  (let ((rgn (window-erase-region w)))
    (when rgn
      (setf (window-erase-region w) nil)
      (#_DisposeRgn rgn))
    (when (setq rgn (window-invalid-region w))
      (setf (window-invalid-region w) nil)
      (#_DisposeRgn rgn))))

(defmethod gcable-wptr-p ((w window))
  t)

#+ignore
(defmethod gcable-wptr-p ((w da-window))
  nil)
#+ignore
(defmethod view-clip-region ((w da-window))
  *big-rgn*)

#+ignore
(defmethod view-allocate-clip-region ((w da-window))
  *big-rgn*)

#-carbon-compat ;; no desk accessories in carbon??
(progn
(defmethod Undo ((w da-window))
  (#_SystemEdit 0))

(defmethod Cut ((w da-window))
  (#_SystemEdit 2))

(defmethod Copy ((w da-window))
  (#_SystemEdit 3))

(defmethod Paste ((w da-window))
  (put-external-scrap)
  (#_SystemEdit 4))

(defmethod Clear ((w da-window))
  (#_SystemEdit 5))
)

; since save-menu-item-update enables the item for any window with a
; key handler, all windows should delegate the command
(defmethod window-save ((w window))
  (let ((handler (window-key-handler w)))
    (when handler
      (window-save handler))))


#+ignore
(defmethod window-close ((w da-window) &aux refnum wptr)  
  (when (setq wptr (wptr w))    
    (setq refnum (#_getwindowkind wptr))
    (flet ((do-it (wptr w)
             (if (eq refnum (#_getwindowkind wptr))
               (progn
                 (remove-window-object wptr)
                 (setf (wptr w) nil)
                 (window-close w)))))             
    (without-interrupts ; oh puke
     (if  nil ;*window-object-hash*
       (maphash #'do-it *window-object-hash*)       
       (dolist (elt *window-object-alist*)
         (do-it (%car elt)(%cdr elt)))))
     #-carbon-compat ;; ???
     (#_CloseDeskAcc refnum)
     #+carbon-compat
     (#_DisposeWindow wptr))))

;;
#+ignore
(defmethod window-null-event-handler ((w da-window))
  (unless *da-window-on-top*
    (put-external-scrap)
    (setq *da-window-on-top* t))
  (let-globally ((*cursorhook* #'(lambda ())))
    (call-next-method))
  #-carbon-compat ;; ??
  (#_systemtask))

;;;;;;;;;;;;;;;;


;; for close and zoom bubbles - doesn't handle collapse/mimimze - done elsewhere
;; doesn't work on OS9
;; also fixes autokeyevt - but nextfiretime has to be quick - like 0.0d0

(defmethod window-event ((w window))
  ;Change part code to be an argument instead of stashing it away in the event record.
  (let* ((event *current-event*)
         (evtype (pref event eventrecord.what))
         (where (pref event eventrecord.where))
         (mods (pref event eventrecord.modifiers))
         (part (%get-word event $evtPartCode))
         (wptr (wptr w))
         (active-p (window-active-p w)))
    (when (typep wptr 'macptr)
      (with-focused-view w
        (with-font-codes nil nil         ; preserve the font codes.
          (cond
           ((eq evtype #$mouseDown)
            (setq *last-mouse-click-window* w)
            (when (or (and active-p
                           (or (%ptr-eql wptr (#_FrontWindow))
                               (eq w (front-window))))
                      (eq part #$inGoAway) ; never seems to happen in OS9 unless window is frontmost, so no need to check for OSX
                      (or (eq part #$inZoomIn) (eq part #$inZoomOut)) ; ditto
                      (eq part #$incollapsebox)  ;; never happens
                      (and (eq part #$inDrag)
                           (or (%ilogbitp #$cmdkeybit mods)
                               (%ilogbitp #$optionkeybit mods)))
                      (progn (window-select-event-handler w)
                             (window-do-first-click w)))
              (cond ((eq part #$inGoAway)
                     (when (if t ;(osx-p)
                             (with-periodic-task-mask ($ptask_event-dispatch-flag t)
                               (window-select w)
                               (if (typep w 'allow-view-draw-contents-mixin)
                                 (with-focused-view nil                                   
                                   (allow-view-draw-contents w)
                                   (with-timer (#_trackGoAway wptr where)))
                                 (with-timer (#_TrackGoAway wptr where))))
                             (#_trackgoaway wptr where)) ;; <<
                       (window-close-event-handler w)))
                    ((or (eq part #$inZoomIn) (eq part #$inZoomOut))
                     (when (if t ;(osx-p)
                             (with-periodic-task-mask ($ptask_event-dispatch-flag t)
                               (window-select w)
                               (if (typep w 'allow-view-draw-contents-mixin)
                                 (with-focused-view nil                                   
                                   (allow-view-draw-contents w)
                                   (with-timer (#_trackBox wptr where part)))
                                 (with-timer (#_TrackBox wptr where part))))
                             (#_TrackBox wptr where part)) ;; <<
                       (without-interrupts
                        (window-zoom-event-handler w part))))
                    ((and #|(osx-p)|# (eq part #$incollapsebox)) ;; never happens
                     (when (with-timer (#_trackbox wptr where part))
                       (#_collapsewindow wptr t)))
                    ((or (eq part #$inContent)
                         (and (eq part #$inGrow) (not (window-grow-icon-p w))))
                     (view-click-event-handler w (%global-to-local wptr where)))
                    ((eq part #$inDrag)
                     (window-drag-event-handler w where))
                    ((eq part #$inProxyIcon)
                     (window-proxyicon-event-handler w where))                     
                    ((eq part #$inGrow)
                     (window-grow-event-handler w where))
                    )))
           ((eq evtype #$UpdateEvt) (unless #-carbon-compat (#_SystemEvent event) #+carbon-compat nil (window-update-event-handler w)))
           (active-p
            (cond ((eq evtype #$nullEvent) (window-null-event-handler w))
                  ((eq evtype #$mouseup) (window-mouse-up-event-handler w))
                  ((eq evtype #$keyUp) (window-key-up-event-handler w))
                  ((eq evtype #$autokey) ;; <<
                   (with-timer (do-keydown-event w event mods)))
                  ((or (eq evtype #$KeyDown) (eq evtype #$AutoKey))
                   (do-keydown-event w event mods))))
           ((windoid-p w)
            (let ((window-under (window-under w nil nil)))
              (when window-under
                (window-event window-under))))
           ((eq evtype #$autoKey) ;; << 
            (with-timer (do-keydown-event *application* event mods))) 
           ((or (eq evtype #$keyDown) (eq evtype #$AutoKey))
            (do-keydown-event *application* event mods))))))))



(defun window-under (w &optional include-invisibles (include-inactives t))  
  (when (wptr w)
    (with-macptrs ((wptr (%null-ptr)))
      (%setf-macptr wptr (wptr w))
      (loop
        (%setf-macptr wptr (#_getnextwindow wptr))
        (when (%null-ptr-p wptr) (return nil))
        (when (or include-invisibles (#_iswindowvisible wptr))
          (let ((res (window-object wptr)))
            (when (and res (or include-inactives (window-active-p res)))
              (return res))))))))

(defvar *bufferred-char* nil)

(defun do-keydown-event (w event &optional mods) ;(mods (pref event :eventRecord.modifiers)))
  (declare (ignore mods))
  (let ((char (%get-byte event $evtMessage-b))
        (bc *bufferred-char*))
    (if bc
      (setq *bufferred-char* nil
            char (+ (ash bc 8) char))
      (progn ;unless (extended-character-p char)  ; this cant be right - itsa byte
        (let ((table (get-char-byte-table (get-key-script))))
          (when (and table (eql 1 (aref table char)))
            (setq *bufferred-char* char)
            (return-from do-keydown-event)))))
    (view-key-event-handler w (%code-char char))))
  
(defmethod window-null-event-handler ((w window))
  (update-cursor)
  ;;;;  _WaitNextEvent does _SystemTask for us
  ;(#_SystemTask)
  )

(defparameter *mouse-up-eaten* 0)
(defmethod window-mouse-up-event-handler ((w window))
 (when (> *timer-count* 0)
   (incf *mouse-up-eaten*)  ;; don't eat mouse up events - put it back? - nah
   ;(#_Posteventtoqueue (#_GetMainEventQueue) *a-mouse-up-event* #$kEventPriorityStandard)
   ))


(defmethod window-key-up-event-handler ((w window)) ())

(defmethod view-cursor ((w window) point)
  (declare (ignore point))
  (window-cursor w))

; Overwritten in views
(when (not (fboundp 'window-update-cursor))
  (defmethod window-update-cursor ((w window) point)
    (set-cursor (view-cursor w point)))
  
  (defmethod window-update-cursor ((w null) point)
    (declare (ignore point))
    (set-cursor *arrow-cursor*)))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
