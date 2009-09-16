;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 10/22/97 akh  see below
;;  5 8/25/97  akh  sleep wakeup stuff
;;  4 6/2/97   akh  see below
;;  3 4/1/97   akh  see below
;;  37 10/3/96 akh  declaim ftype map-windoids
;;  33 9/3/96  akh  dont make bignum of *gc-event-status-bits* on 68K
;;  28 7/18/96 akh  added get-dead-keys-state, preserve state when suspend/resume etc
;;  25 5/20/96 akh  window-object back to alist, now with cache
;;  23 3/27/96 akh  check *startup-aevents* before error in %event-dispatch
;;  20 3/9/96  akh  run-masked-periodic-tasks - dont bind *current-x-view*
;;  12 11/22/95 akh *hide-windoids-on-suspend* nil till windoids exist
;;  8 11/9/95  akh  fix update-menus to cdr down state list
;;  5 10/26/95 Alice Hartley %istruct
;;  3 10/17/95 akh  merge patch to menukey-modifiers-p
;;  2 10/13/95 bill ccl3.0x25
;;  14 5/22/95 akh  make command-option-, work in do-event
;;  11 5/19/95 akh  fix do-event (do get-byte vs event-keystroke when menukey) for *control-key-mapping* and command-shift-. etc
;;  8 5/4/95   akh  fix *control-key-mapping* (lost a fix). revert update-menus
;;  6 3/22/95  akh  in event-poll dont force-output when woi
;;  4 2/17/95  akh  *window-object-alist* => *window-object-hash*
;;  3 1/17/95  akh  new macros for with and without event processing - use them - set *processing-events* to the process vs t
;;  (do not edit before this line!!)

;; L1-events.lisp - Object oriented events
; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2001 Digitool, Inc.

; Modification History
;; *event-loop-initial-fire-time* 0.2d0 vs 0.1d0
;; set-cursor handles keywords for theme cursors from Terje N.
;; set-cursor doesn't #_loadresource, *gc-cursor* is ptr not handle
;; menu-begin-proc sets *periodic-task-mask*
;; add method print-object of periodic-task from Toomas Altosaar
;;-------- 5.2b6
;; my-timer-thing uses map-windows-simple
;; ------- 5.2b5
;; use add-pascal-upp-alist-cfm, use macho for timer-proc
;; redo defrecord ptaskstate here - twas wrong re ptaskstate.nexttick !
;; make sure ptaskstate.nexttick is a fixnum, don't say rref
;; %event-dispatch - exit loop if #$autokey, fixes stalled scheduling when fast repeat rate
;; lose redraw-window-frame stuff 
;; my-timer-thing doesn't if *no-scheduling* true
;; include foreground-application-p
;; -------- 5.1 final
;; my-timer-thing doesn't try to update an allow-view-draw-contents-mixin window whose update is in progress
;; add variable *event-loop-initial-fire-time*
;; activate-timer and deactivate-timer are woi
;; ------- 5.1b3
;; deactivate-timer - warn and lose timer vs error
;; 09/08/04 my-timer-thing does window-update-event-handler of allow-view-draw-contents-mixin windows if any
;; in my-timer-thing - do all the menu-dismiss stuff before enabling interrupts
;; really-install-timer resets timer-hit, timer-missed
;; add option to make menu be dismissed after some time elapses - see *lose-menu-ticks*
;; add command-key-now-p and friends
;; 03/20/04 export *timer-interval* and friends 
;; 03/13/04 my-timer-thing messes with *active-processes-tail*
;; 02/20/04 timer attempts to not subvert without-interrupts
;; 02/12/04 window-foo-proc check for null window-object - thanks to Takehiko Abe
;; ------------- 5.1b1
;; 12/18/03 back again to suspend/resume the old way on OS9 else get wedged if in choose-file-dialog when suspend
;; 12/02/03 timer stuff
;; with-cursor does not call handlep
;; 11/20/03 back to suspend/resume with carbon event on OS9 too - why did I change it?
; 11/07/03 fix sneaky-cmd-stuff - dont do for windoid
; do-event still handles suspend/resume if not osx
; application-resume-... sets cursor to arrow for obscure reasons
; use carbon-event for suspend/resume - works more reliably on OSX
; another way of dealing with the sneaky cmd-`
; *dont-bring-all-windows-front* - save docstring
; use get-tick-count in do-event, lose draghook
; see install-timer for a way to prevent things from coming to a screeching halt when mouse-down etc. 
; fix do-event for *control-key-mapping* - not good enuf
; fix dead-handler-proc 
; trying to deal with dead-keys nil on jaguar
;; ---------- 5.0 final
; akh - do-event tries to deal with cmd-` on OSX having happened behind our back
; ---------- 5.0b5
; revive old sleepq stuff if OSX
; export *dont-bring-all-windows-front*
; -------- 5.0b3
; akh 12/23/02 fix set-key-script from Takehiko Abe
; akh add fn am-i-front-process for fun and games
; akh (defparameter *repeat-command-keys* nil) - dont auto repeat command keys - set to T if you wish cmd keys to repeat
; 12/13/2002 ss allow shift key to invert behavior of *dont-bring-all-windows-front* temporarily.
;(defvar *dont-bring-all-windows-front* nil)  ;;  folks who don't like MCL's  default behavior on OSX may set to t
; --------- 4.4b5
; set-cursor no call pointerp on OSX - it conses
; --------- 4.4b4
; 06/19/02 akh another osx fix in application-resume-event-handler
; 01/16/02 akh application-resume-event-handler fix for osx from Shannon Spires
; ----- 4.4b2
; 05/10/01 use #_menuevent vs #_menukey if carbon for modified command keys
; 04/26/01 akh see cursorhook - very old bug caused OSX to barf
; 04/17/01 akh see update-menus-internal again
; 04/03/01 akh see update-menus-internal
; 04/29/00 AKH no balloon help if carbon
; see event-available-p
; application-suspend-event-handler doesn't do scrap stuff when carbon - they say we can't at suspend time so we do it all the time
; lose refs to windowrecord.windowdefproc for carbon
; failed attempt to compensate for loss of osevt in carbon, they say it's fixed so don't worry - well maybe - is fixed
; abort-event-pending-p etc no longer use getevqhdr when carbon because carbon aint got it. Pinheads rule.
; lmgetmenulist => getmenubar
; 02/19/00 akh lmgetticks => tickcount
; 06/28/99 akh with-cursor locks and unlocks handle if appropriate
;----------- 4.3b3
; 06/02/99 akh process-event gets eventhook from modal-dialog if appropriate
; ---------------- 4.3b2
; 04/20/99 akh update-cursor - don't funcall unbound symbol
;;------------------------- 4.3b1
; 02/04/99 akh do-event-queue uses #_GetEvqHdr
;10/22/97  akh *can-powermanager-dispatch* set along with other gestalt things for sleep-q
; 03/24/97 akh  all the guys who check boundp *current-event* also check for nil
;               process-abort-event and seek-abort-event bind *current-event* before calling interactive-abort
; 03/23/97 akh  do-event recognizes option-command-. (no longer necessary since bill fixed cmain)
; 02/26/97 bill %event-dispatch takes a new event-mask arg which it passes to get-next-event.
;               It also exits its loop if *startup-aevents* was true at function entry and
;               there is *deferred-appleevents* is non-null or *startup-aevents* is null.
; 02/25/97 bill cmain clears the $gc-allow-stack-overflows-bit bit in *gc-event-status-bits*
; 01/21/97 bill do-event does (#_BeginUpdate)(#_EndUpdate) for update
;               events on unknown windows (from a Dylan patch).
; ------------- 4.0
; 10/07/96 bill remove-window-object calls (new) remove-lisp-wdef
; 09/25/96 bill set-cursor no longer initializes *current-cursor*.
;               This is now done by (def-ccl-pointers qd ...) in "ccl:l1;l1-init.lisp".
; 09/23/96 bill stop set-cursor from consing
; ------------- 4.0b2
; 09/11/96 bill *dead-keys-state* initialized to T.
;               (method application-suspend-event-handler (application))
;                 enables dead keys if they are disabled.
;               (method application-resume-event-handler (application))
;                 disables dead keys if necessary.
;  9/04/96 slh  set-cursor sets *current-cursor*
; 08/23/96 bill If process-event is running in other than the *initial-process*
;               (i.e. the standin event processor), it executes *eventhook*
;               functions ignoring errors. This prevents the Lisp from being
;               wedged if an *eventhook* function signals an error.
; 08/20/96 bill If *startup-aevents* is true, %event-dispatch does its thing independent of
;               *current-process*.
; ------------- 4.0b1
; 08/05/96 bill %event-dispatch no longer signals a "Wrong process" bug.
;               Instead it does nothing if the *current-process* is not the *event-processor*.
; 07/27/96 gb   dbg -> bug.
; 07/26/96 bill %event-dispatch proceses the $gc-redraw-window-frames-bit of *gc-event-status-bits*
;               process-gc-event-status-bits comes out-of-line from %event-dispatch
; 06/26/96 bill The initial value for *inside-update-menus* is 0.
; 05/13/96 bill update-menus protects itself against recursive errors.
;               This allows you to debug a buggy menu or menu-item udpate function.
; 04/25/96 bill "...help-manager.fasl" => (merge-pathnames *.fasl-pathname* "ccl:library;help-manager")
; ------------- MCL-PPC 3.9
; 04/03/96 bill %run-masked-periodic-tasks uses new with-periodic-task-mask instead
;               of let binding *periodic-task-mask* & *gc-event-status-bits*.
;               cmain takes new, optional, no-event-dispatch arg. If true,
;               doesn't switch processes or do event dispatch.
;               %event-dispatch calls cmain with the new no-event-dispatch arg true
;               to ensure that we don't miss interrupts.
; 03/26/96  gb  lowmem accessors.
; 03/19/96 bill  with-cursor restores the cursor on its way out.
; 01/31/96 bill  event-poll does force output when woi, otherwise it never does.
; 01/04/96 bill  event-poll always does force-output if *single-process-p* is true.
; 12/27/95 gb    get-next-event maintains *cme-microseconds* on PPC
; 12/08/95 bill  (defpascal cmain ...) & friends move to ppc-trap-support
; 12/05/95 bill  (defpascal cmain ...) prints xp & pc if it doesn't recognize the trap
; 11/29/95 bill  with-error-reentry-detection moves here from l1-error-signal
; 11/22/95 bill  (defpascal %err-disp ...) called by "lisp-exceptions.c".
;                New: match-instr, RA-field, D-field, RS-field, codevec-header-p,
;                     *trap-lookup-tries*, scan-for-instr
;                (#_HMGetBalloons :boolean) -> (#_HMGetBalloons)
; 11/20/95 alice *hide-windoids-on-suspend* nil till windoids exist
; 11/14/95 bill draghook returns
; 11/10/95 bill remove installation of draghook for PPC until callbacks exist.
; 11/09/95 bill  #_getenvirons -> #_GetScriptManagerVariable
; 10/11/95 bill  event-poll calls event-dispatch if the current process is the event processor.
;  6/06/95 slh   Bill's fix to event-poll
;  5/19/95 slh   use window-hide-for-suspend, window-show-for-resume
;  5/12/95 slh   application-suspend/resume-event-handler; hide & show windoids
;  5/04/95 slh   update-menus: unwind *menubar-frozen* before draw-menubar-if
;  4/25/95 slh   maybe-get-ext-scrap on resume event (checking more often
;                overwrites fred scrap after file dialogs, etc)
;  4/20/95 slh   update-menus has update-menus-for-modal folded in
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 3/11/95 slh   use gestalt bitnum arg
;-------------- 3.0d17
; bill's fix ? to set-cursor
; do-event unhilites menus before action rather than after - like finder etal
; event-available-p not true when *processing-events*, event-poll uses abort-event-pending-p vs event-available-p
; Fixes a bug exposed by modal-dialog - if an event occurred during cleanup forms the
; cleanup forms never finished because the event process was alway ready to run
; (cause an event was available) but did nothing because *processing-events* was true.
; *processing-events* stayed true forever because setting it back to nil is
;  a cleanup form that never executed.
;---------------
;10/04/93 bill  *event-mask*
;-------------- 3.0d13
;06/22/93 bill  set-cursor no longer dispatches on handlep; its arg must be a handle or fixnum or *arrow-cursor*
;               This makes ROM-resident cursors work correctly on the new AV macs and on the PDM.
;-------------- 3.0d11
;06/06/93 alice shift-key-p more explicit - fixes frec-click
;05/20/93 bill  do-event swaps the keyboard script on suspend/resume events.
;-------------  3.0d8
;05/19/93 alice event-poll does event-dispatch if current-process is event-processor so we can
;		get out of event-processing run amok
;05/08/93 alice process-abort-event returns true if event was abort, nil otherwise
;		%event-dispatch uses this to avoid calling interactive-abort twice
;		when command-. is typed.
;--------------- 2.1d7
;04/29/93 bill  all-processes & friends -> *all-processes* & friends
;04/28/93 bill  (#_TickCount) -> (get-tick-count)
;04/22/93 bill  Call #_IdleUpdate on machines that support it when
;               we are not *idle*.
;-------------- 2.1d4
;03/22/93 alice command-key-p etal account for *control-key-mapping*
;10/22/92 alice menu-selected allows event-processing, moved *interrupt-level* 0
; 		from do-event to menu-selected - who cares if its 0 or 2 anyway? 
;10/08/92 alice do-event and menukey-modifiers-p for *emacs-mode* => *control-key-mapping*
;               now non-menu command keys get thru to fred but 
;		shift-modified menu commands are treated same as unmodified - maybe O.K.
;07/02/92 alice nuke binding standard-output, evalhook and applyhook in do-event 
; 03/24/93 bill  key-states-p, abort-event-pending-p, %abort-event-p
; 03/15/93 bill  in with-cursor: let -> let-globally
; 02/23/93 bill  in cmain: run periodic tasks with scheduling disabled. I think this
;                gets rid of a deadlock caused by the gc-thermometer
; 02/19/93 bill  %run-masked-periodic-tasks does not allow the scheduler to run.
;                This stops keystrokes from escaping from the choose-file-dialog
;                to MCL's front window.
; 02/17/93 bill  (method view-key-event-handler (application))
; 01/21/93 bill  cmain runs *event-dispatch-task* with interrupts enabled.
; 01/14/93 bill  wait-key-event now works with multiple processes
; 12/24/92 bill  cmain binds *in-scheduler* to prevent infinite loop
;                on PowerBooks in idle mode.
; 12/17/92 bill  event-dispatch can now be called by other than the *event-processor*
; 12/09/92 bill  kill *wait-next-event-calls*
; 08/24/92 bill  wrap *event-abort-restart* around do-deferred-appleevents
; 04/30/92 bill  in update-cursor. Don't ignore-errors while requiring the help-manager.
;                Instead, don't require it if no file exists.
; -------------- 2.0
; 01/07/92 gb    don't require RECORDS.
; 11/19/91 bill  Nuke %event-dispatch to save a symbol: Ralph hackers beware.
;                break process-event out from inside the loop in event-dispatch so that
;                appleevent-idle can call it.
; 11/13/91 bill  change *background-sleep-ticks* to 5 so that it agress with the manual.
;                Whether that number makes any more sense than nil or 10 is a matter of opinion.
; 11/08/91 gb    not sure if *background-event-ticks* should be 10, don't think it should be nil.
; 11/07/91 alice nuke reference to *terminal-io* in %event-dispatch?? (maybe in do-event too)
; 10/18/91 bill  -1 -> #$everyEvent as default value for the mask arg to get-next-event
; 10/17/91 bill  *periodic-task-mask*, draghook, %run-masked-periodic-tasks
; 10/22/91 alice add *alias-manager-present*
; 09/26/91 alice nuke menus-state
;------------------ 2.0b3
; 08/30/91 alice add menus-state, update-menus draws iff changed
; 08/21/91 bill redraw-window-frame
; 08/12/91 alice update-menus freezes menubar till done - much prettier
; 07/21/91 gb   add a few ms when dequeing time task.  #_DiBadMound
;               puts up a dialog; that's enough.
; 08/15/91 bill In set-cursor, don't call HELP-ON? unless *HELP-MANAGER-PRESENT*
; 08/09/91 bill Jeremy's code for *multi-click-count*
; 08/09/91 bill set-cursor deals properly with fixnum cursors and does LoadResource
; 07/09/91 bill autoloading of help-manager is inside update-cursor
; 07/05/91 bill check for *last-null-event-time* moves to do-event.
;               Call (window-null-event-handler nil) when no windows open.
; 07/01/91 bill Joe added do-defererred-appleevents to end of event-dispatch.
;               Don't do this unless *deferred-appleevents* is non-NIL.
; 06/20/91 bill get-next-event assures that MCL runs for (event-ticks).
;               Before, (event-ticks) was the time all applications got
;               to run between our calls to _WaitNextEvent
; 06/13/91 bill in get-next-event - $run_time is a double word
; 06/11/91 bill *allow-without-interrupts-abort* is history.
;               Don't be so eager to look for <Command>-. in event-dispatch.
; 06/08/91 bill make flags & privatedata optional in %install-periodic-task
; 06/07/91 bill funcall 'event-dispatch, not #'event-dispatch, so it can
;               be changed.
;------------ 2.0b2
; 05/20/91 gb   new periodic-tasks scheme.  Dequeue timer when calling _WaitNextEvent.
; 05/17/91 bill in cursorhook: with-port -> with-focused-view
; 03/29/91 bill system clicks set *last-mouse-click-window*.
;               do-event calls window-event on the front windoid for key & null events
; 03/23/90 joe  add do-event-queue macro (used again in appleevents) & change seek-abort-event
; 03/05/91 bill Firm up event handling of Mac windows not in *window-object-alist* and
;               Lisp windows with non-macptr WPTR's.
; 01/14/91 gb   Make get-next-event suspend/resume $run_time_task.  Always _WaitNextEvent,
;               so flush *use-wait-next-event*.
;------------ 2.0b1
; 12/31/90 gb   Nail some of this down.
; 12/13/90 bill 23 -> $kHighLevelEvent
; 12/13/90 joe  process $kHighLevelEvent in do-event
; 11/28/90 bill nuke menukey-event-p & %menu-key-p.
; 11/21/90 gb   bind *interrupt-level* when processing menu events.
; 11/05/90 bill GCABLE-WPTR-P decides if INSTALL-WINDOW-OBJECT will make a gcable-macptr
;               (used for DA-WINDOW instances)
;               Process menu key events in DO-EVENT vice WINDOW-EVENT so that they will
;               work if no windows are open.
; 10/23/90 bill process-abort-event calls interactive-abort vice abort
; 10/10/90 bill *event-abort-restart* is now named 'event-abort, not 'abort.
;               break-loop knows about it.
;               <Command><Option><Period> (C-M-.) does abort-break.
; 08/24/90 bill make *event-abort-restart* catch abort, not event-abort
; 08/21/90 bill (change-mouse-view nil) when we become background (just in case things
;               are real slow and we miss the leave it takes to get to the menubar).
; 08/02/90 gb   new gcable-macptr scheme in install-window-object.
; 07/30/90 bill update-cursor functions only if lisp is in the *foreground*
; 07/24/90 bill menukey-modifiers-p comes out of line from menukey-event-p
; 07/23/90 bill enable abort during event processing.
; 07/05/90 bill nix wptr-if-bound
; 05/31/90 bill install-window-object marks the MACPTR for _DisposWindow by GC.
; 05/15/90 gb   *event-abort-restart* : change restart name to "abort-events."
; 05/05/90 bill update for new scrap handler.
; 04/30/90 gb   One more slot in %make-restart call; never wait NIL ticks (most
;               unpleasant !); handle gc-deferred events.
; 03/16/90 bill abort events were missed sometimes.
;               New global *allow-without-interrupts-aborts*
; 03/05/90 bill xxxxground-event-ticks functions become *foreground-event-ticks*
;               and *background-event-ticks* variables.
; 02/23/90 bill check for wptr-if-bound before calling window-event
;               bind *processing-events* right after testing it.
; 02/15/90 bill any-modifier-keys-p
; 02/07/90 bill seek-abort-event
; 01/17/90  gz  Add a restart around do-event.
; 01/13/90  gz  Optional idle arg to event-dispatch.
; 01/10/90 bill Remove ignore-errors around do-event.
; 01/08/90 bill Ignore activate events (part of adding windoids)
; 12/28/89  gz  no more catch-error.
; 10/4/89   gz  install-window-object (back from l1-windows).
;               Allow for suspend/resume events with no windows present.
; 09/27/89  gb  more object-lisp removal.
; 09/16/89 bill Removed last vestiges of object-lisp
; 09/09/89 bill change window-object-(de)activate-event-handler to 
;               window-(de)activate-event-handler in do-event
; 09/03/89 as added foreground and background event ticks
; 7/20/89   gz clos menus.
; 5/19/89   gz Call event handlers for drag/grow/close events.
;              Update-cursor uses front window rather than current object.
;              default def for *cursorhook*.
; 18-mar-89 as menu-object moved to l1-menus
; 3/31/89   gz *inest-ptr* -> *interrupt-level*
; 3/18/89   gz window-foo -> window-object-foo.
; 3/17/89   gz didn't remove wait-key-event (just because WE don't use it...)
; 15-mar-89 as removed wait-key-event
;              *eventhook* is a list of hooks
; 9-mar-89  as suspend/resume events cause window deactivate/activate
; 12/16/88  gz Unbreak loop in remove-window-object.
;              window-object doesn't copy wptr, exist does.
;  11/19/88 gb dispatch on functionp or symbolp.
;  10/23/88 gb window-object copies wptr arg when creating a *da-window*.
; 10/19/88 jaj reorganized events.  non-window events handled by do-event,
;              evtMessage always contains wptr for window events, added 
;              evtPartCode to event record. got rid of window-disk-insert-eh
;              window-suspend-eh window-resume-eh.  Alien windows handled by
;              (window-event nil).  added *processing-events*, events are
;              always processed at interrupt level 0. removed *action-xx
;              and *event-object*
;  9/30/88 jaj window-event no longer calls window-control-click-event-handler
;  9/22/88 jaj do-event takes level as an arg, event-dispatch passes it
;  9/14/88 as  click in close-box closes all windows of class if option-key-p
;  8/26/88 jaj in event-dispatch: don't look at *multifinder*, the delay
;              for _WaitNextEvent is zero, use ilogbitp instead of zerop
;              to check for boolean return from _WaitNextEvent
;  10/18/88 gz moved zoom event handler to l1-windows.  Added wait-key-event.
;  9/1/88  gz  %signal-error -> %err-disp. added %menu-key-p.
;  8/02/88 gz  Bind *compiling-file* around event processing.
;  6/29/88 jaj added a catch-error around call to do-event
;  6/21/88 jaj catch :cancel -> catch-cancel. remove closed DAs from 
;              *window-object-alist*
;  5/29/88 as  click in title-bar calls set-window-position
;              <redundant, but needed for mini-buffer hook.  perhaps punt>
;  5/27/88 jaj window-select-event-handler calls window-select
;  5/23/88 jaj check for *multifinder* and *use-wait-next-event* before
;              calling _WaitNextEvent
;  5/19/88 as  punted *abort-character*
;  5/13/88 jaj click in title bar of non-front window calls window-select-e-h
;  5/11/88 jaj call _WaitNextEvent if *idle*
;  4/11/88 jaj removed call to window-size-parts in window-zoom-event-handler
;  4/07/88 as  with-cursor calls update-cursor, first thing
;  3/30/88 jaj kerwordified rlets
; 3/31/88   gz New macptr scheme. Flushed pre-1.0 edit history.
; 3/2/88    gz Eliminate compiler warnings
; 10/25/87 jaj one more fix to double-click-p
; 10/23/87 jaj _DIBadMound -> _DIBadMount
; 10/22/87 jaj check for *foreground* in abort processing, set it in
;              suspend/resume processing
; 10/21/87 jaj *grow-rect*, *drag-rect* -> window-grow-rect, window-drag-rect
; 10/19/87 jaj call abort instead of signal-error
; 10/15/87 jaj default window-select-event-handler zeros *last-mouse-down-time*
; 10/15/87 as window-event calls window-zoom-event-handler, instead of
;             trapping in-line.
;-----------------------------------release 1.0-----------------------------


(eval-when (:compile-toplevel :execute)
(DEFRECORD PTASKSTATE
           (NEXTTICK SIGNED-LONG)  ;; was unsigned - bad bad bad !!!
           (INTERVAL UNSIGNED-LONG)
           (PRIVATE POINTER)
           (FLAGS UNSIGNED-INTEGER))
)


(declaim (special *current-event*))
;(defvar *emacs-mode* nil)
(defvar *control-key-mapping* nil) ; can also be :command-shift or :command
(defvar *inhibit-abort* nil)
(defglobal *processing-events* nil)

(defparameter *event-abort-restart*
  (%make-restart 'event-abort nil "Abort event processing" () ()))

(eval-when (eval compile load)
  #-carbon-compat
  (defmacro do-event-queue (event &body body)
    ; event should be a variable
    (let ((evqp (gensym)))
      `(block nil
         (with-macptrs ((,evqp (%get-ptr #+ignore (%int-to-ptr $EventQueue) #-ignore (require-trap #_getevqhdr) 2))
                        ,event)
           (until (or (%null-ptr-p ,evqp) (%izerop (rref ,evqp EvQEl.evtQWhat)))
             (%setf-macptr ,event (%inc-ptr ,evqp (get-field-offset EvQEl.evtQWhat)))
             ,@body
             (%setf-macptr ,evqp (%get-ptr ,evqp)))))))

  ; instead of let-globally - maybe
  ; trying to avoid the following scenario
  ; 1) *processing-events* is NIL
  ; 2) process A remembers nil, sets to t (and he becomes interruptable at some point)
  ; 3) process B remembers t, sets to NIL
  ; 4) process A resets to nil
  ; 5) process B resets to T. and then we are wedged
  ; OR make *processing-events* true also imply without-interrupts
  ; OR *processing-events* if true should be a process and he is the only one allowed
  ;   to run (like this better)

  (defmacro without-event-processing (&body body)
    (let ((esym (gensym)))    
      `(let (,esym)
         (unwind-protect
           (progn 
             (setq ,esym *processing-events* *processing-events* *current-process*)
             ,@body)
           ; restore it unless some other dude has set it to nil.
           (when *processing-events* ; ??
             (setq *processing-events* ,esym))))))
  
  (defmacro with-event-processing-enabled (&body body)
    `(let ((*interrupt-level* 0))
       (setq *processing-events* nil)
       ,@body))
  
  )

; if *processing-events* and abort-event - do it
(defun seek-abort-event ()
  (declare (resident))
  (when (and *processing-events* (abort-event-pending-p))
    (#_FlushEvents #x003f 0)
    (let ((*current-event* nil)) ; hide outer binding if any - for option-key-p
      (interactive-abort))))

; if current-event is abort do it
(defun process-abort-event (event)
  (declare (resident))
  (when (%abort-event-p event)
    (#_FlushEvents #x003F 0) ;Flush typeahead
    (let ((*current-event* event)) ;  - for option-key-p
      (interactive-abort)
      t)))

(defun %abort-event-p (event)
  (and (eq #$KeyDown (pref event :eventrecord.what))
       (eq (%ilogand #x1300 (pref event :eventrecord.modifiers)) #x100)
       (let ((code (%get-byte event 5)))
         (or (eq code (char-code #\.))
             (eq code 179)))))          ; <option>-.

(defun %break-event-p (event)
  (and (eq #$KeyDown (pref event :eventrecord.what))
       (eq (%ilogand #x1300 (pref event eventrecord.modifiers)) #x100)
       (let ((code (%get-byte event 5)))
         (or (eq code (char-code #\,))
             (eq code 178)))))


(defun abort-event-pending-p ()
  (or
   #-carbon-compat
   (do-event-queue event
                   (when (%abort-event-p event)
                     (return t)))
   #+carbon-compat ;; this is here for the other p.o.s that has an eventQ but won't let you at it
   (progn
     #-maybe
     (rlet ((event :eventrecord))
       (let ((isit (#_EventAvail #$keydownmask event)))
         (when isit
           (or (%abort-event-p event)
               (key-states-p '(47                   ; period (".")
                               55                   ; command
                               (59)                 ; not control
                               (56)))))))
     #+maybe
     (let ((res (#_CheckEventQueueForUserCancel)))
       ;; nukes prior events and the cancel event - true if cmd-. or ESC which was not used previously
       ;; also true if cmd-ctrl-option-. Is it really faster?
       res))
               
               
   ; This is here for AU/X, which doesn't have an event queue
   #| Makes abort happen too often
   (key-states-p '(47                   ; period (".")
                   55                   ; command
                   (59)                 ; not control
                   (56)))               ; not shift
   |#
   ))

(defun break-event-pending-p ()
  (or
   #-carbon-compat
   (do-event-queue event
     (when (%break-event-p event)
       (return t)))
   #+carbon-compat
   (rlet ((event :eventrecord))
     (let ((isit (#_EventAvail #$keydownmask event)))
       (when isit
         (or (%break-event-p event)
             (key-states-p '(45                   ; comma (",") ????
                   55                   ; command
                   (59)                 ; not control
                   (56)))))))))
   


(defvar *event-mask* #$everyEvent)



#+ppc-target
;; it seems likely that fpr31 is occasionally clobbered under OSX classic - nearly always clobbered on OSX
(defppclapfunction fix-fpr31 ()
  (lwi imm0 #x43300000)  ;; dont know whether this is clobbered too, be paranoid - paranoia reigns - tis clobbered
  (stw imm0  -8 sp)
  (lwi imm0  #x80000000)
  (stw imm0 -4 sp)
  (lfd ppc::fp-s32conv -8 sp)
  (lwi imm0 0)
  (stw imm0 -4 sp)
  (lfs ppc::fp-zero -4 sp)
  (blr)
  )

#+ppc-target
(defppclapfunction test-fpr31 ()
  (stfd ppc::fp-zero -8 sp)
  (lwz imm0 -8 sp)
  (lwz imm1 -4 sp)
  (or imm0 imm0 imm1)
  (eq0->boolean arg_z imm0 imm1)  
  (blr))

#+ppc-target
(defppclapfunction test-fpr30 ()
  (stfd ppc::fp-s32conv -8 sp)  
  (lwz imm0 -8 sp)
  (lwi imm1 #x43300000)
  (cmpw imm0 imm1)
  (mr arg_z ppc::rnil)
  (bnelr)
  (lwz imm0 -4 sp)
  (lwi imm1 #X80000000)
  (cmpw imm0 imm1)
  (bnelr)
  (addi arg_z arg_z ppc::t-offset)
  (blr))


  

#+ignore
(progn
(defppclapfunction get-fpr31 ((val arg_z))
  (put-double-float ppc::fp-zero val)
  (blr))

(defppclapfunction get-fpr30 ((val arg_z))
  (put-double-float ppc::fp-s32conv val)
  (blr))

  

(require :number-macros)
(defun  poop ()
  (let ((val (%make-dfloat)))
    (get-fpr31 val)
    val))

(defun  poop2 ()
  (let ((val1 (%make-dfloat))
        (val2 (%make-dfloat)))
    (get-fpr31 val1)
    (get-fpr30 val2)
    (list val1 val2)))
)

#+ppc-target
(progn
(defloadvar *cme-microseconds* (make-record (:unsignedwide :clear t)))

#|
(defun get-next-event (event &optional (idle *idle*) (mask *event-mask*)
                             (sleep-ticks (wait-next-event-sleep-ticks idle)))
  (rlet ((before :unsignedwide)
         (after :unsignedwide))
    (#_MicroSeconds before)
    (unless (#_WaitNextEvent mask event sleep-ticks (%null-ptr))
      (rset event eventrecord.what #$nullEvent))
    (#_MicroSeconds after)
    (#_WideAdd *cme-microseconds* (#_WideSubtract after before))
    (let* ((task *event-dispatch-task*))
      (when task
        (let* ((state (ptask.state task)))
          (setf (pref state :ptaskState.nextTick)
                (+ (#_TickCount) (pref state :ptaskState.interval))))))
    event))
|#
(defvar *some-option-key-events* nil)
 ;; this may work - if it doesn't it will only screw up if *dead-keys-state* is nil and only on jaguar
(defun get-next-event (event &optional (idle *idle*) (mask *event-mask*)
                             (sleep-ticks (wait-next-event-sleep-ticks idle)))
  (rlet ((before :unsignedwide)
         (after :unsignedwide))
    (#_MicroSeconds before)
    (cond ((and (null *dead-keys-state*) (jaguar-p) *some-option-key-events*)
           (let ((now (pop *some-option-key-events*)))
             (copy-record now :eventrecord event)
             (#_disposeptr now)
             event))
          (t (unless (#_WaitNextEvent mask event sleep-ticks (%null-ptr))
               (setf (pref event eventrecord.what) #$nullEvent))))
    (#_MicroSeconds after)
    (#_WideAdd *cme-microseconds* (#_WideSubtract after before))
    (let* ((task *event-dispatch-task*))
      (when task
        (let* ((state (ptask.state task)))
          (setf (pref state :ptaskState.nextTick)
                (%tick-sum (get-tick-count)(pref state :ptaskState.interval))))))       ;(+ (#_TickCount) (pref state :ptaskState.interval))))))
    event))

;(add-pascal-upp-alist 'dead-handler-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

(add-pascal-upp-alist-macho 'dead-handler-proc "NewEventHandlerUPP")

#|
(defun mess-with-the-mod-bits (bits)
  (if (eq *control-key-mapping* :command)
    ;; lose the command bit and set the control bit
    
    (bitset #$controlkeybit (bitclr #$cmdkeybit bits) )
    bits))
|#
          
(defpascal dead-handler-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref))
  (let ((res #$eventNotHandledErr))
    (if (or (not (jaguar-p)) *dead-keys-state*)
      res        
      (RLET ((itsa-long :long))       
        (#_geteventparameter eventref #$keventparamkeymodifiers #$typeUint32
         (%null-ptr) 4 (%null-ptr) itsa-long)
        (let ((the-mod-bits (%get-unsigned-long itsa-long)))
          (declare (fixnum the-mod-bits))
          ;; we assume dead-keys are always option-something - dunno if thats true
          (if (and (or (logbitp #$optionkeybit the-mod-bits) 
                       (logbitp #$rightoptionkeybit the-mod-bits))  ;; there are also rightbits? not to be confused with writebits
                   (eq 0 (logand the-mod-bits
                                 #.(logior #$cmdkey
                                           #$controlkey
                                           #$rightcontrolkey))))
            (rlet ((event :eventrecord))
              (IF (#_converteventreftoeventrecord eventref event)  ;; nil if dead key?
                res
                (let ((new-event (make-record :eventrecord)))
                  (copy-record event :eventrecord new-event)
                  ;(print-record  new-event :eventrecord)
                  (setf (pref new-event :eventrecord.modifiers) the-mod-bits)
                  (rlet ((mess :unsigned-long))
                    (#_geteventparameter eventref #$keventparamKeyCode #$typeuint32 ;; random nonsense - maybe not
                     (%null-ptr) 4 (%null-ptr) mess)
                    (setf (pref new-event :eventrecord.message) (ash (%get-unsigned-long mess) 8))) ;; get keycode 8 bits up
                  (setf (pref new-event :eventrecord.what) #$keydown)
                  ;(print-record  new-event :eventrecord)
                  (without-interrupts
                   (setq *some-option-key-events* (nconc *some-option-key-events* (list new-event))))
                  ;(push new-event *some-option-key-events*)
                  #$noerr)))
            res))))))


(def-ccl-pointers deadkeystuff ()
  (when (jaguar-p)
    ;; what about rawkeyrepeat?
    (%stack-block ((stuff (* 2 (record-length :eventtypespec))))  ;; does it need to persist or is it copied? - must be copied
      (setf (pref stuff :eventtypespec.eventclass) #$keventclasskeyboard)
      (setf (pref stuff :eventtypespec.eventkind) #$keventrawkeydown)
      (let ((stuff2 (%inc-ptr stuff (record-length :eventtypespec))))
        (declare (dynamic-extent stuff2))
        (setf (pref stuff2 :eventtypespec.eventclass) #$keventclasskeyboard)
        (setf (pref stuff2 :eventtypespec.eventkind) #$keventrawkeyrepeat))      
      (#_installeventhandler (#_getapplicationeventtarget) dead-handler-proc 2 stuff        
       (%null-ptr) (%null-ptr)))))


)


(defloadvar *event-wakeup* nil) 

(defun event-available-p (&optional (mask *event-mask*)) ;;  should match get-next-event else we get stuck at startup time
  (or (prog1 *event-wakeup* (setq *event-wakeup* nil))
      (and 
       (rlet ((junk eventrecord))
         ; OSEventAvail does not do a Multi-Finder context switch. EventAvail does.
         ; The trap also returns D0.L = -1 when no events are available, D0.W = 0
         ; otherwise.  That's not how I read the documentation...  Look at
         ; event.what just to be sure ...
         #-carbon-compat ;; this excludes highlevel events which explains the abscence of a problem previously
         (and (#_OSEventAvail mask junk)
              (not (eql (pref junk :eventrecord.what) #$NullEvent)))
         #+carbon-compat         
         (and (#_EventAvail mask junk)
              (not (eql (pref junk :eventrecord.what) #$NullEvent))))
       (or (not *processing-events*)(abort-event-pending-p)))))

; maybe this works - dont switch if event-processor or the guy who set processing events
(defun event-poll ()
  (setq *event-wakeup* t)  
  (when *single-process-p*
    (unless *in-scheduler*
      (let* ((tio *terminal-io*)) ; gag puke
        (when (streamp tio) 
          (stream-force-output tio)))))
  (if (and (neq *event-processor* *current-process*)  ; if not event processor
           (or (not *processing-events*)              ; and not the guy who set *processing-events*
               (neq *current-process* *processing-events*)))
    (unless *in-scheduler*
      (unless *single-process-p*
        (when t  ; (%i>= *interrupt-level* 0)
          (let* ((tio *terminal-io*)) ; gag puke
            (when (streamp tio) (stream-force-output tio)))))
      (suspend-current-process))
    ; rearranged the and's and or's a little bit - used to do (or (and ..)(abort-event-pending-p)) 
    (when (and (eq *event-processor* *current-process*)
               (or (not *processing-events*)
                   (abort-event-pending-p)
                   ;; ??? - let us break in event-processor too
                   (break-event-pending-p)))          ; is event processor or is the guy who set processing-events
      (setq *processing-events* nil) ; maybe belongs elsewhere?
      (event-dispatch))))
#|
(defun maybe-abort ()
  (let ((abort-enabled-p 
          (and *foreground* (not *inhibit-abort*) (%i>= *interrupt-level* 0))))
    (when (and abort-enabled-p)
      (when (abort-event-pending-p)
        (#_FlushEvents #x003f 0)
        (interactive-abort)))))
|#

#| ; old one
(defun event-poll ()
  (setq *event-wakeup* t)  
  (if (neq *event-processor* *current-process*)
    (unless *processing-events*
      (progn
        (let* ((tio *terminal-io*)) ; gag puke
          (when (streamp tio) (stream-force-output tio)))
        (suspend-current-process)))
    (when (let ((*event-wakeup* nil))(event-available-p))(event-dispatch))))
|#

(defparameter *idle-sleep-ticks* 5)
(defparameter *foreground-sleep-ticks* 0)
(defparameter *background-sleep-ticks* 5)

(defun wait-next-event-sleep-ticks (&optional (idle *idle*))
  (declare (resident))
  (or
   (if (or *foreground* (null *background-sleep-ticks*))
     (if idle *idle-sleep-ticks* *foreground-sleep-ticks*)
     *background-sleep-ticks*)
   5))

(defun event-dispatch (&optional (idle *idle*) (level *interrupt-level*))
  (if (eq *current-process* *event-processor*)
    (%event-dispatch idle level)
    (event-poll)))

(defvar *sleep-wakeup-functions* nil)

(defun process-gc-event-status-bits ()
  (let ((gc-bits *gc-event-status-bits*))
    (declare (fixnum gc-bits))
    (setq *gc-event-status-bits* (logand gc-bits $gc-fixed-bits-mask))
    #+ignore
    (if (logbitp $gc-update-bit gc-bits)
      (do-all-windows w
        (redraw-window-frame w)        ; windoids need this
        (invalidate-view w t))
      ;  - don't know if this bit exists in 3.0? - it doesn't - windoid wdef sets it in 3.9
      (when (logbitp $gc-redraw-window-frames-bit gc-bits)
        (do-all-windows w
          (redraw-window-frame w))))
    ;; #-carbon-compat
    (when (and (logbitp $gc-sleep-wakeup-bit gc-bits) #|(osx-p)|#)
      (dolist (fn *sleep-wakeup-functions*)
        (funcall fn)))
    (when (logbitp $gc-suspend-or-resume-bit gc-bits)
      (if *foreground*
        (reselect-windows)
        (unselect-windows)))))

(defppclapfunction get-fp-zero ()
  (ref-global arg_z short-float-zero)
  (blr))

;(defvar barf nil)

(defvar fpr31-count 0)
(defun %event-dispatch (&optional (idle *idle*) (level *interrupt-level*) (event-mask *event-mask*))
  (declare (special *gc-event-status-bits*)
           (fixnum *gc-event-status-bits*)
           (resident))
  (when (and (eql 0 (logand (+ $ptask_event-dispatch-flag $ptask_draw-flag)
                            (the fixnum *periodic-task-mask*)))
             (or (eq *current-process* *event-processor*)
                 *startup-aevents*))
    (without-interrupts
     (unless idle
       (when *cpu-idle-p*
         (#_IdleUpdate))
       (setq *idle* t))
     (process-gc-event-status-bits)
     (let* ((*interrupt-level* *interrupt-level*)
            (*compiling-file* nil)
            (abort-enabled-p 
             (and *foreground* (not *inhibit-abort*) (%i>= level 0)))
            (startup-aevents *startup-aevents*))
       (declare (special *compiling-file*))
       ;; If we are merrily looping in the *event-processor* and type command-.,
       ;; then LEVEL (the value of *interrupt-level* on entry) appears to be -1 (WHY?)
       ;; which means that the guys who look for abort events won't do it,
       ;; and the command-. ends up being handled by the menu item. Weird.
       ;; This oddness is PPC specific.
       ;#+ignore ; - maybe workaround OSX/ Classic crock - no such luck
       ;#+ppc-target
       #+ignore ;; seems to be fixed in OSX 10.1
       (when (not (and (test-fpr31)(test-fpr30)))
         (incf fpr31-count)(fix-fpr31))
       (if *processing-events*
         (when abort-enabled-p
           (seek-abort-event))
         (without-event-processing
           (%stack-block ((event (+ (record-length :eventrecord) 2))) ;leave room for event record (16) plus part code (2)
             (loop
               (cmain t) ;(huh "loop4")
               (get-next-event event idle event-mask)
               (process-gc-event-status-bits)
               (when abort-enabled-p
                 (when (process-abort-event event)(return))
                 (seek-abort-event))               
               (case (process-event event)
                 ((#.#$nullEvent #.#$Autokey)(return))) ;; << added autokey
               ; Once we get an appleevent while starting up, get out of here
               ; so that we don't end up quitting before getting a chance to print.
               (when (and startup-aevents
                          (or *deferred-appleevents*
                              (not *startup-aevents*)))
                 (return))))))))
    (when *deferred-appleevents*
      (with-restart *event-abort-restart*
        (let ((*interrupt-level* 0))        ; make sure we can be interrupted
          (without-interrupts)              ; process any pending interrupts
          (do-deferred-appleevents))))))


(defvar *eventhooks-in-progress* nil)
(defglobal *modal-dialog-on-top* nil)

;; in case clim modal dialog method is loaded
(defun modal-dialog-eventhook (thing)
  (and thing (consp (cdr thing))
       (third thing)))

;; in case clim modal dialog method is loaded
(defun modal-dialog-process (thing)
  (when thing
    (let ((p (cdr thing)))
      (if (consp p) (car p) p))))

(defun process-event (event)
  (let ((e-code (pref event :eventrecord.what)))
    (when (eq e-code $MButDwnEvt) 
      (process-multi-clicks event) 
      ;; attempt to workaround OSX bug re leaking double-clicks - doesn't help.
      (if (and #|(osx-p)|# (%i> *multi-click-count* 1)) (#_FlushEvents #$mUpMask 0)))
    (let* ((*current-event* event))
      (declare (special *current-event* *processing-events*))
      (block foo
        (with-restart *event-abort-restart*
          (let ((eventhook (or (and *modal-dialog-on-top*
                                    (wptr (caar *modal-dialog-on-top*)) ;; blech
                                    (modal-dialog-eventhook (car *modal-dialog-on-top*)))
                             *eventhook*)))
            (unless (and eventhook
                         (flet ((process-eventhook (hook)
                                  (unless (memq hook *eventhooks-in-progress*)
                                    (let ((*eventhooks-in-progress*
                                           (cons hook *eventhooks-in-progress*)))
                                      (declare (dynamic-extent *eventhooks-in-progress*))
                                      (funcall hook)))))
                           (declare (inline process-eventhook))
                           (if (listp eventhook)
                             (dolist (item eventhook)
                               (when (process-eventhook item) (return t)))
                             (process-eventhook eventhook))))
              (return-from foo (catch-cancel (do-event)))))))
      e-code)))

#+ignore
(defun redraw-window-frame (window)
  (let* ((wptr (wptr window))
         (hilited #-carbon-compat (pref wptr :windowrecord.hilited) #+carbon-compat (#_iswindowhilited wptr)))
    ;; (setf (pref wptr :windowrecord.hilited) (not hilited))  ;; ?? WHAT
    (#_HiliteWindow wptr hilited)))    

(defvar *foreground-event-ticks* 20)
(defvar *background-event-ticks* 5)

(defvar *last-null-event-time* 0)

(defun get-environs (verb)
  (#_GetScriptManagerVariable verb))

(defun get-key-script ()
  (#_GetScriptManagerVariable #$smkeyscript))

#|
(defun set-key-script (code)
  ;; more modern? now get-key-script returns what we set, but OSX Japanese fonts still dont work
  (#_SetScriptManagerVariable #$smkeyscript code)
  ;(#_KeyScript code)
  )
|#

(defun set-key-script (script &optional (force-p t))
  (#_keyscript
   (if (and force-p (>= script 0))
     (logior script #$smKeyForceKeyScriptMask)
     script)))

(defun keyscript-sync-disabled-p ()
  (logbitp #$smfDisableKeyScriptSync
           (#_getscriptmanagervariable #$smgenflags)))

;; then perhaps change update-key-script-from-click to pass
; (not (keyscript-sync-disabled-p)) as the optional argument ?

(defvar *mcl-keyscript*)
(defvar *other-keyscript*)

(def-ccl-pointers *mcl-keyscript* ()
  (setq *mcl-keyscript* 
        (setq *other-keyscript*
              (get-key-script))))


(defparameter *repeat-command-keys* nil)

(defun do-event (&aux wob ecode (event *current-event*))
  (declare (resident))
  "If event doesn't apply to a window handles the event, otherwise finds appropriate
window object for the event then calls that object's window-event function"
  (setq ecode (pref event eventrecord.what))
  (with-macptrs (w)
    (cond ((eq #$mouseDown ecode)
           (let ((code (#_FindWindow (pref event :eventrecord.where)
                                     (%inc-ptr event $evtMessage))))
             (%put-word event code $evtPartCode)
             (when (eq code #$inDesk)
               (return-from do-event))
             (when (eq code #$inMenubar)
               (set-cursor *ARROW-CURSOR*)
               (setq *interrupt-level* 0)
               (update-menus)
               (let  ((ms (#_MenuSelect (pref event :eventrecord.where))))
                 (#_HiliteMenu 0)                        
                 (menu-selected ms))
               (return-from do-event))
             (%setf-macptr w (%get-ptr event $evtMessage))
             #+carbon-compat ;; maybe just for console window which is semi comatose due to lack of device driver
             (let ((wob (window-object w)))
                 (when (typep wob 'da-window)
                   (setq *last-mouse-click-window* nil)
                   (setq *selected-window* nil)
                   (#_selectwindow w)  ;; ???
                   (return-from do-event)))
             (when (eq code #$inSysWindow)
               #-carbon-compat
               (#_SystemClick event w)
               ;;If system click closed window, remove it from *window-object-alist*
               (with-macptrs ((win (#_FrontWindow)))
                 (if (%ptr-eql win w)
                   (progn
                     (setq wob (window-object w))
                     (setq *last-mouse-click-window* wob)
                     (unless (or (null wob) (eq wob *selected-window*))
                       (setq *selected-window* wob)
                       (unselect-windows t)))
                   (do () ((%null-ptr-p win)
                           (when (setq wob (window-object w))
                             (setf (wptr wob) nil))
                           (setq *last-mouse-click-window* nil)
                           (remove-window-object w)
                           (reselect-windows))
                     (when (%ptr-eql w win) (return))
                     (%setf-macptr win  (#_getnextwindow win)))))
               (return-from do-event))))
          ((eq ecode $diskInsertEvt)   ;; #$diskEvt Not sent in Carbon. See kEventClassVolume in CarbonEvents.h
           (unless (%izerop (%get-word event $evtMessage))
             #-carbon-compat
             (#_DIBadMount #@(100 100) (%get-long event $evtMessage)))           
           (return-from do-event))
          ((eq ecode #$ActivateEvt)      ; ignore these. We do it ourselves. And where might that be?
           (when t ;(osx-p)
             ;; did someone do cmd-`             
             (let ((wob (front-window))) ; dont consider windoids
               (when (and wob  (neq wob *selected-window*))
                 ;(print wob)
                 (window-select wob))))
           (Return-from do-event))
          ((eq ecode #$UpdateEvt)
           (%setf-macptr w (%get-ptr event $evtMessage)))
          ((and (or (eq ecode #$KeyDown) (eq ecode #$AutoKey))
                (menukey-modifiers-p (pref event :eventrecord.modifiers))
                (if (and (eq ecode #$AutoKey) (not *repeat-command-keys*)) (return-from do-event) t)
                (let* ((char (%get-byte event $evtMessage-b))
                        mi)
                  (if (eq char 178)  ; option-, - yuck
                    (setq char (char-code #\,)))
                  (if (eq char 179)  ; option-. - yuck - why do we ever get here? see comment in event-dispatch
                    (setq char (char-code #\.)))
                  (update-menus)
                  (if (%izerop (%ilogand2 -65536 (setq mi #+carbon-compat (if (eq *control-key-mapping* :command)  (#_menukey (code-char char))(#_MenuEvent event))
                                                       #-carbon-compat (#_MenuKey (code-char char)))))
                    nil
                    (progn 
                      (setq *interrupt-level* 0)
                      (#_HiliteMenu 0)
                      (menu-selected mi)
                      t))))
           (return-from do-event))
          ((%i<= ecode 8) ;null, keydwn, autokey, keyup, mbutup events
           (when (eq ecode #$nullEvent)
             (let ((time *last-null-event-time*))
               (when (eq time
                         (setq *last-null-event-time* (get-tick-count)))
                 (return-from do-event))))
           (with-macptrs ((win (#_frontwindow)))
             (if (%null-ptr-p win)
               (progn
                 (cond ((eq ecode #$nullEvent) (window-null-event-handler nil))
                       ((or (eq ecode #$KeyDown) (eq ecode #$AutoKey))
                        (let ((*interrupt-level* 0))
                          (do-keydown-event *application* event))))
                 (return-from do-event))
               (setq wob (window-object win)))))
          #+ignore
          ((and (eq ecode #$osEvt)(not (osx-p)))   ;; aka 15 aka #$osEvt NEVER HAPPENS carbon wise. They say it's fixed. - done with carbon event now
           (when (eq 1 (%get-byte event $evtMessage))   ; suspend or resume event
             (if (setq *foreground* (%ilogbitp 0 (%get-byte event $evtMessage-b)))
               (application-resume-event-handler  *application*)
               (application-suspend-event-handler *application*)))
           (return-from do-event))
          ((eq ecode #$kHighLevelEvent)
           (do-highlevel-event event)
           (return-from do-event))
          (t (return-from do-event)))
    (if (and ;(not (%null-ptr-p w)) 
               (or wob (setq wob (window-object w)))
               (wptr wob))     ; make sure not closed (redundant)
      (let* (;(*standard-output* *terminal-io*)
             ;(*evalhook* nil)
             ;(*applyhook* nil)
             (*interrupt-level* 0))     ;window-event always runs at level 0
        (window-event wob))
      (when (eq ecode #$UpdateEvt)
        ;; Update event on unknown window needs to be pretend-handled
        ;; or it will keep happening and we'll get stuck in a loop
        (#_BeginUpdate w)
        (#_EndUpdate w)))))

(defmethod view-key-event-handler ((a application) char)
  (declare (ignore char))
  (ed-beep))

; set to t when windoids exist
(defvar *hide-windoids-on-suspend* nil "Hide/show windoids on suspend/resume if true")
(defvar *dead-keys-state* t)

(eval-when (:execute :compile-toplevel)
  (declaim (ftype (function (&rest t) t) map-windoids)))


; by the time we get here dead-keys have already been clobbered.
; and guess what - with carbon we never get here at all. That's fixed in carbon now.
(defmethod application-suspend-event-handler ((app application))
  (unless *dead-keys-state*
    (set-dead-keys t)
    (setq *dead-keys-state* nil))
  (setq *mcl-keyscript* (get-key-script))
  (set-key-script *other-keyscript*)
  #-carbon-compat
  (put-external-scrap)
  ;(setq poo (am-i-front-process)) ;; the answer is NO on both OS9 and OSX
  (change-mouse-view nil)
  (set-event-ticks *background-event-ticks*)
  (unselect-windows)
  (when *hide-windoids-on-suspend*
    (map-windoids #'window-hide-for-suspend)))

#+ignore
(defun am-i-front-process ()
  (rlet ((psn1 :processSerialnumber)
         (psn2 :processSerialnumber))
    (#_getfrontprocess psn1)
    (#_getcurrentprocess psn2)
    (and (= (pref psn1 :processSerialnumber.highlongofpsn)
            (pref psn2 :processSerialnumber.highlongofpsn))
         (= (pref psn1 :processSerialnumber.lowlongofpsn)
            (pref psn2 :processSerialnumber.lowlongofpsn)))))

;; another version - more politically correct?
(defun foreground-application-p ()
   (rlet ((psn1 :processSerialNumber)
          (psn2 :processSerialNumber)
          (boolean :boolean))
     (#_getFrontProcess psn1)
     (#_getCurrentProcess psn2)
     (#_SameProcess psn1 psn2 boolean)
     (pref boolean :boolean)))

(defmethod application-resume-event-handler ((app application))
  (setq *other-keyscript* (get-key-script))
  (set-key-script *mcl-keyscript*)
  (set-event-ticks *foreground-event-ticks*)
  (unless *dead-keys-state*
    (set-dead-keys nil))
  (maybe-get-ext-scrap)
  (unless (typep *selected-window* 'da-window)
    (reselect-windows))
  (when *hide-windoids-on-suspend*
    (map-windoids #'window-show-for-resume t)))

#|
from Shannon Spires
Test case: ensure there are two windows open in MCL running native on OSX.
One can be the listener. Call them A and B. Bring A to the front.

Now select a different application's window, leaving A and B visible 
behind
it. Now click on B (the one behind A). MCL moves to the foreground and B
comes to the front. Now click on A. No effect. Somehow MCL doesn't realize
that A is no longer frontmost. The workaround is to click on B (the actual
frontmost window) and THEN you can click on A to bring it to the front.

This code fixes the problem. There's probably a more elegant solution that
uses a smaller hammer, but this seems to get the job done.
|#

(export '(*dont-bring-all-windows-front*) :ccl)

(defparameter *dont-bring-all-windows-front* nil
"Controls how windows behave when MCL is
selected. Set to T for normal OSX window
behavior, nil for OS9 window behavior.")  ;; for those folks who don't like MCL's  default behavior on OSX - set to t

;; aargh doesn't work here - repeat in ccl-menus-lds
(setf (documentation '*dont-bring-all-windows-front* 'variable)
                   "Controls how windows behave when MCL is
selected. Set to T for normal OSX window
behavior, nil for OS9 window behavior."
)
 
(defmethod application-resume-event-handler :after ((app application))
  (when t ; (and (osx-p))
    ;; brings all our windows frontwards, thank you
    (let ((shift (key-down-p 56))) ; (shift-key-p) doesn't work here - (shift-key-now-p) would
      (when (or (and (not *dont-bring-all-windows-front*) (not shift)) ; Need #'xor
                (and *dont-bring-all-windows-front* shift))
        (rlet ((psn :processSerialNumber
                    :highLongOfPSN 0
                    :lowLongOfPSN #$kCurrentProcess))
          (#_SetFrontProcess psn)))
      (set-cursor *arrow-cursor*) ;; ??
      (let ((front (front-window)))
        (when front
          (WINDOW-SELECT front)))
      )))

;(add-pascal-upp-alist 'activate-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))
;(add-pascal-upp-alist 'deactivate-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

(add-pascal-upp-alist-macho 'activate-proc "NewEventHandlerUPP")
(add-pascal-upp-alist-macho 'deactivate-proc "NewEventHandlerUPP")


(defpascal activate-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref eventref))
  (cond (nil ;(not (osx-p))
         #$eventNotHandledErr)
        (t
         (setq *foreground* t)
         (application-resume-event-handler *application*)
         #$noerr)))

(defpascal deactivate-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref eventref))
  (cond (nil ;(not (osx-p))
         #$eventNotHandledErr)
        (t
         (setq *foreground* nil)
         (application-suspend-event-handler *application*)
         #$noerr)))



(def-ccl-pointers suspend-resume-stuff ()
  (let ((target (#_getapplicationEventTarget)))
    (rlet ((act-spec :eventtypespec 
                     :eventclass #$kEventClassApplication
                     :eventkind #$kEventAppActivated)
           (deact-spec :eventtypespec 
                       :eventclass #$kEventClassApplication
                       :eventkind #$kEventAppDeActivated))
      (#_installeventhandler target
       activate-proc 1 act-spec (%null-ptr) (%null-ptr))  
      (#_installeventhandler target
       deactivate-proc 1 deact-spec (%null-ptr) (%null-ptr))
      )))


;(progn (sleep 5)(choose-file-dialog))




; Default method justs updates cursor
(defmethod window-null-event-handler (w)
  (declare (ignore w))
  (update-cursor))

; Redefined by lib;views.lisp
(defun change-mouse-view (to &optional from)
  (declare (ignore to from)))

; Bootstrapping, real version is in "ccl:lib;windoids.lisp"
(unless (fboundp 'windoid-wdef-handle-p)
  (%fhave 'windoid-wdef-handle-p
          #'(lambda (macptr)
              (declare (ignore macptr))
              nil)))

(defun lisp-wdef-handle-p (macptr)
  (or (windoid-wdef-handle-p macptr)
      ; In case someone conses a wdef "handle" themselves.
      (without-interrupts
       (with-macptrs ((callback (%get-ptr macptr)))
         (defpascal-callback-p callback)))))

#|
(defun remove-lisp-wdef (wptr)
  ;; I dont know how to get windowDefProc in carbon
  (when (and (macptrp wptr)
             (not (%null-ptr-p wptr)))          ; paranoia
    #-carbon-compat
    (with-macptrs ((wdef (pref wptr :windowRecord.windowDefProc)))
      (declare (ignore-if-unused wdef)) 
      (when (lisp-wdef-handle-p wdef)
        (setf (pref wptr :windowRecord.windowDefProc)
              (pref %temp-port% :windowrecord.WindowDefProc))))))
|#

; not redefined below - closures faster than specials? - or about the same
(let ((last-window nil))

  (defun window-object (wptr)
    (declare (resident))
    (let ()
      (when (and last-window (%ptr-eql wptr (%car last-window))) 
        (return-from window-object (%cdr last-window))))
    (dolist (a *window-object-alist*)
      (when (%ptr-eql wptr (%car a))
        (setq last-window a)
        (return-from window-object (%cdr a))))    
    (when (or (%i< #-carbon-compat (rref wptr windowrecord.windowKind) #+carbon-compat (#_getwindowkind wptr) 0)
              #+carbon-compat
              (> (#_getwindowkind wptr) 254))  ;;  for the console window          
      (make-instance 'DA-window :wptr wptr :window-show nil)))
  
  (defun set-window-object (wptr window)
    (setq last-window nil)    
    (progn
      (dolist (a *window-object-alist*)
        (when (%ptr-eql wptr (car a))
          (return-from set-window-object
            (prog1 (%cdr a) (%rplacd a window)))))
      (push (cons wptr window) *window-object-alist*)))
  
  (defun remove-window-object (wptr &aux list)
    (setq last-window nil) 
    ;(remove-lisp-wdef wptr)
    (when (setq list *window-object-alist*)
      (if (%ptr-eql wptr (caar list)) (setq *window-object-alist* (%cdr list))
          (while (%cdr list)
            (when (%ptr-eql wptr (caar (%cdr list)))
              (%rplacd list (%cddr list))
              (return-from remove-window-object))
            (setq list (%cdr list))))))
  )
  

#|
;(defun old-window-object (wptr)
  (declare (resident))
  (dolist (a *window-object-alist*)
    (when (%ptr-eql wptr (%car a)) (return-from old-window-object (%cdr a))))
  (when (%i< (rref wptr windowrecord.windowKind) 0)
    (make-instance 'DA-window :wptr wptr :window-show nil)))
|#
#|
(defvar *window-object-hash* nil)
(defun set-window-object (wptr window)
  (if *window-object-hash*
    (if (not window)
      (remhash wptr *window-object-hash*)
      (setf (gethash wptr *window-object-hash*) window))
    (progn
      (dolist (a *window-object-alist*)
        (when (%ptr-eql wptr (car a))
          (return-from set-window-object
            (prog1 (%cdr a) (%rplacd a window)))))
      (push (cons wptr window) *window-object-alist*))))
|#



#|
(queue-fixup

(setq *window-object-hash* (alist-hash-table *window-object-alist* :test #'eql))
;(setq *window-object-alist* nil)
; today hash is slower if 39 in list
(defun window-object (wptr)
  (or (gethash wptr *window-object-hash*)
      (when (%i< (rref wptr windowrecord.windowKind) 0)
        (make-instance 'DA-window :wptr wptr :window-show nil))))
)
|#


(defun install-window-object (window &aux (wptr (wptr window)))
  (setq wptr (require-type wptr 'macptr))  
  (setf (slot-value window 'wptr)
        ;Make sure wptr is not stack consed - Reasonable but I dont understand below
        (setq wptr (%setf-macptr (if (gcable-wptr-p window)
                                   (make-gcable-macptr $flags_DisposWindow)
                                   (%null-ptr))
                                 wptr)))
  (set-window-object wptr window)
  nil)

#|
; If you revert to this way of doing things, remember to call remove-lisp-wdef
(defun remove-window-object (wptr &aux list)
  (if *window-object-hash*
    (remhash wptr *window-object-hash*)
    (when (setq list *window-object-alist*)
      (if (%ptr-eql wptr (caar list)) (setq *window-object-alist* (%cdr list))
          (while (%cdr list)
            (when (%ptr-eql wptr (caar (%cdr list)))
              (%rplacd list (%cddr list))
              (return-from remove-window-object))
            (setq list (%cdr list)))))))
|#

(defparameter *multi-click-count* 0)

(defun process-multi-clicks (event)
  ;called by event-dispatch on mouse-down events
  (if (and (%i< (%i- (pref event :eventrecord.when) *last-mouse-down-time*)
                (#_GetDblTime))
           (double-click-spacing-p *last-mouse-down-position*
                                   (pref event :eventrecord.where)))
    (incf *multi-click-count*)
    (setf *last-mouse-down-position* (pref event :eventrecord.where)
          *multi-click-count* 1))
  (setq *last-mouse-down-time* (pref event :eventrecord.when)))
  
(defun double-click-p ()  
  (and (and (boundp '*current-event*) *current-event*)
       (eq $MButDwnEvt (pref *current-event* :eventrecord.what))
       (%i> *multi-click-count* 1)))

(defun double-click-spacing-p (point1 point2)
;This should take a window arg so it may be shadowed by particular window objects
  (and (%i< (%iabs (%i- (point-h point1) (point-h point2))) 4)
       (%i< (%iabs (%i- (point-v point1) (point-v point2))) 4)))

(defun shift-key-now-p ()
  (let ((*current-event* nil))
    (shift-key-p)))

(defun shift-key-p ()
  (if (and (boundp '*current-event*) *current-event*)
    (let ((mods (pref *current-event* :eventrecord.modifiers)))           
      (and (%ilogbitp #$ShiftKeyBit mods)
           (case *control-key-mapping*
             ((:command-shift :command)
              (not (%ilogbitp mods #$cmdkeyBit)))
             (t t))))
    (and (key-down-p 56)
         (case *control-key-mapping*
           ((:command-shift :command)
            (not (key-down-p 55)))
           (t t)))))

(defun command-key-now-p ()
  (let ((*current-event* nil))
    (command-key-p)))

(defun command-key-p ()
  (if (and (boundp '*current-event*) *current-event*)
    (%ilogbitp #$CmdKeyBit 
               (event-keystroke (pref *current-event* :eventrecord.message)
                                (pref *current-event* :eventrecord.modifiers)))
    (and (key-down-p 55)
         (case *control-key-mapping*
           (:command-shift ; command-shift is control, command is command
            (not (key-down-p 56)))
           (:command  ; command is control, command-shift is command
            (key-down-p 56))
           (t t)))))

(defun option-key-now-p ()
  (let ((*current-event* nil))
    (option-key-p)))

(defun option-key-p ()
  (if (and (boundp '*current-event*) *current-event*)
    (%ilogbitp #$OptionKeybit (event-keystroke (pref *current-event* :eventrecord.message)
                                               (pref *current-event* :eventrecord.modifiers)))
    (key-down-p 58)))


(defun caps-lock-key-now-p ()
  (let ((*current-event* nil))
    (caps-lock-key-p)))

(defun caps-lock-key-p ()
  (if (and (boundp '*current-event*) *current-event*)
    (%ilogbitp #$AlphaLockbit (pref *current-event* :eventrecord.modifiers))
    (key-down-p 57)))

(defun control-key-now-p ()
  (let ((*current-event* nil))
    (control-key-p)))

(defun control-key-p () ;E.g. on Mac II...
  (if (and (boundp '*current-event*) *current-event*)
    (%ilogbitp #$ControlKeybit (event-keystroke (pref *current-event* :eventrecord.message)
                                                (pref *current-event* :eventrecord.modifiers)))
    (or (key-down-p 59)
        (case *control-key-mapping*
          (:command-shift (and (key-down-p 55)(key-down-p 56)))
          (:command (and (key-down-p 55)(not (key-down-p 56))))))))

(defun key-down-p (key-code)
  (multiple-value-bind (byte bit) (truncate key-code 8)
    (%stack-block ((p 128))  ;; really only need 16
      (#_GetKeys p)
      (%ilogbitp bit (%get-byte p byte)))))

(defun key-states-p (key-codes)
  (%stack-block ((p 128))
    (#_GetKeys p)
    (dolist (code key-codes t)
      (let ((off-p (when (listp code)
                     (setq code (car (the list code))))))
        (multiple-value-bind (byte bit) (floor code 8)
          (let ((set (%ilogbitp bit (%get-byte p byte))))
            (if off-p
              (when set (return nil))
              (unless set (return nil)))))))))

(eval-when (eval compile)
  (defconstant *modifier-keys-event-mask*
    (logior #$shiftkey  #$CmdKey
             #$OptionKey #$ControlKey)))


(defun any-modifier-keys-p ()
  (if (and (boundp '*current-event*) *current-event*)
    (not (eql 0 (%ilogand *modifier-keys-event-mask*
                          (pref *current-event* :eventrecord.modifiers))))
    (%stack-block ((p 128))
      (#_GetKeys p)
      (or (not (eql 0 (%ilogand 13 (%get-byte p 7))))   ; magic, anyone?
          (%ilogbitp 7 (%get-byte p 6))))))

; This will fail miserably if called from inside the event processing process
; it isn't used or exported or documented - do we need it
(defun wait-key-event ()
  "Returns event message and modifiers or nil nil if mouse-click"
  (when (eq *current-process* *event-processor*)
    (error "~s called from ~s" 'wait-key-event '*event-processor*))
  (let* ((message nil)
         (modifiers nil)
         (flag-cell (list nil))
         (eventhook #'(lambda (&aux (ecode (pref *current-event* :eventrecord.what)))
                        (cond ((car flag-cell) nil)
                              ((or (eq ecode #$KeyDown) (eq ecode #$AutoKey))
                               (setf message (pref *current-event* :eventrecord.Message)
                                     modifiers (pref *current-event* :eventrecord.Modifiers)
                                     (car flag-cell) t))
                              ((eq ecode #$mouseDown)
                               (setf (car flag-cell) t))
                              (t nil)))))
    (declare (dynamic-extent eventhook flag-cell) (cons flag-cell))
    (unwind-protect
      (let-globally ((*eventhook* eventhook))
        (process-wait "Key Event" #'(lambda (flag-cell) (car flag-cell)) flag-cell)
        (values message modifiers)))))
#|
(defun menukey-modifiers-p (mods)
  (declare (resident))
  (eq (%ilogand *menukey-modifier-mask* mods)
      (if *emacs-mode*
        (%ilogior2 (%ilsl $shiftkey 1) *menukey-modifier-value*)
        (%ilogand2 (%ilognot (%ilsl $shiftkey 1)) *menukey-modifier-value*))))
|#

; before transformation
; do something reasonable when value is unrecognized
(defun menukey-modifiers-p (mods)
  (declare (resident))
  (if (null *control-key-mapping*)
    (%ilogbitp #$cmdkeyBit mods)
    (when (%ilogbitp #$cmdkeyBit mods)
      (case *control-key-mapping*
        (:command-shift (not (%ilogbitp #$shiftkeyBit mods)))
        (:command (%ilogbitp #$shiftkeyBit mods))
        (t t)))))



(defvar *inside-update-menus* 0)
(declaim (fixnum *inside-update-menus*))

#|
(defun update-menus-internal (what state was-inside-update-menus)
  (let ((oldstate nil)
        (changed nil))
    (let ((*menubar-frozen* t))
      ;; this is awful in more ways than one
      (with-macptrs ((mh (#_getmenubar)))
        (let ((offset (%hget-word mh))
              mob)
          (flet ((menu-update-for-modal (mob state)
                   (if was-inside-update-menus
                     (ignore-errors 
                      (menu-update-for-modal mob state))
                     (menu-update-for-modal mob state)))
                 (menu-update (menu)
                   (if was-inside-update-menus
                     (ignore-errors (menu-update menu))
                     (menu-update menu))))
            (declare (dynamic-extent #'menu-update-for-modal #'menu-update))
            (while (%i> offset 0)
              (when (setq mob (menu-object (%hget-word (%hget-ptr mh offset))))
                (let ((before (menu-enabled-p mob)))
                  (cond ((eq what :disable)
                         (push before oldstate)
                         (menu-update-for-modal mob :disable))
                        ((eq what :enable)
                         (menu-update-for-modal mob (if state
                                                      (if (car state) :enable :disable)
                                                      :enable))
                         (setq state (cdr state)))  ; << cdr folks
                        (*modal-dialog-on-top*
                         (menu-update-for-modal mob :disable))
                        (t (menu-update mob)))
                  (unless (eq before (menu-enabled-p mob))
                    (setq changed t))))
              (setq offset (%i- offset 6)))))))
    (when changed (draw-menubar-if))
    (when oldstate (nreverse oldstate))))
|#

;;; ??? - seems to be a good thing esp wrto OSX - does it boot - seems OK
(defun update-menus-internal (what state was-inside-update-menus)
  (let ((oldstate nil)
        (changed nil))
    (let ((*menubar-frozen* t))
      (let  ((mb %menubar))
        (dolist (mob mb)        
          (flet ((menu-update-for-modal (mob state)
                   (if was-inside-update-menus
                     (ignore-errors 
                      (menu-update-for-modal mob state))
                     (menu-update-for-modal mob state)))
                 (menu-update (menu)
                   (if was-inside-update-menus
                     (ignore-errors (menu-update menu))
                     (menu-update menu))))
            (declare (dynamic-extent #'menu-update-for-modal #'menu-update))            
            (let ((before (menu-enabled-p mob)))
              (cond ((eq what :disable)
                     (push before oldstate)
                     (menu-update-for-modal mob :disable))
                    ((eq what :enable)
                     (menu-update-for-modal mob (if state
                                                  (if (car state) :enable :disable)
                                                  :enable))
                     (setq state (cdr state)))  ; << cdr folks
                    (*modal-dialog-on-top*
                     (menu-update-for-modal mob :disable))
                    (t (menu-update mob)))
              (unless (eq before (menu-enabled-p mob))
                (setq changed t)))))))
    (when changed (draw-menubar-if))
    (when oldstate (nreverse oldstate))))


; If state is supplied, this is called in response to a modal dialog
; (before if :disable, after if :enable). If :disable, return a state
; list; if :enable, use the state list.
(defun update-menus (&optional what state)
  (let ((was-inside-update-menus (not (eql 0 *inside-update-menus*))))
    (unwind-protect
      (progn
        (incf *inside-update-menus*)
        (update-menus-internal what state was-inside-update-menus))
      (decf *inside-update-menus*))))



(defun menu-selected (mi &aux mob)
  (when (setq mob (menu-object (point-v mi)))
    (menu-select mob (point-h mi))))

; Enough of balloon-help to know when to autoload it.
(defvar *help-manager-present* nil)
(defvar *alias-manager-present* nil)
(defvar *cpu-idle-p* nil)               ; power manager will slow cpu
(defvar *can-powermanager-dispatch* nil)  ; can do sleep-q stuff

; If any bits in the *periodic-task-mask* are set in the ptaskstate.flags word of
; a periodic task, it will not be run
(defvar *periodic-task-mask* 0)

; A callback to store at $menuhook & $draghook to keep up the periodic tasks while the mouse is down.

#-carbon-compat
(defpascal draghook ()
  (%run-masked-periodic-tasks (+ $ptask_draw-flag $ptask_event-dispatch-flag)))

(def-ccl-pointers *help-manager-present* ()
  (setq *help-manager-present*  (gestalt #$gestaltHelpMgrAttr  #$gestaltHelpMgrPresent)
        *alias-manager-present* (gestalt #$gestaltAliasMgrAttr #$gestaltAliasMgrPresent)
        *cpu-idle-p*            (gestalt #$gestaltPowerMgrAttr #$gestaltPMgrCPUIdle)
        *can-powermanager-dispatch*  (if (osx-p) t (gestalt #$gestaltPowerMgrAttr #$gestaltPMgrDispatchExists)))
  #-carbon-compat
  (progn
    (#_LMSetMenuHook draghook)
    (#_LMSetDragHook draghook))
  #+carbon-compat ;; no such thing that we can find
  (progn
    nil))

;; maybe the initial value of *timer-interval* should be nil so
;; if the user doesn't care about this stuff it won't happen

(export '(*timer-interval* activate-timer deactivate-timer with-timer))
(defparameter *the-timer* nil)
(defparameter *timer-interval* nil)
;; set *timer-interval* to something like 0.2d0 if you wish scheduling to happen when mouse down etc.


;(add-pascal-upp-alist 'timer-proc #'(lambda (procptr)(#_neweventlooptimerupp procptr)))

(add-pascal-upp-alist-macho  'timer-proc "NewEventLoopTimerUPP")

(defpascal timer-proc (:ptr timerref :ptr userdata :word)
  (declare (ignore timerref userdata))
  (my-timer-thing)
  0)


;; for info only
(defparameter timer-missed 0)
(defparameter timer-hit 0)


(defun prior-interrupt-level ()
  (do-db-links (db var val)
    (when (eq var '*interrupt-level*)
      (return-from prior-interrupt-level val))))

(defvar *lose-menu-ticks* nil)  ;; set to e.g. 1800 - probably should reset menu-showing if mouse moves
(defvar *menu-showing* nil)
(defvar *current-mouse-position* nil)

(defun get-mouse-position ()
  (rlet ((pt :point))
    (#_GetGlobalMouse pt)
    (%get-point pt)))

(defun reset-menu-showing-counter-if-mouse-has-moved ()
  (let ((mp (get-mouse-position)))
    (when (or (not (eql mp *current-mouse-position*))(#_stilldown))  ;; or is down
      (setq *menu-showing* (get-tick-count))
      (setq *current-mouse-position* mp)))
  t)

;; same as saving-graphics-port in ppc-stack-groups.lisp
(defmacro with-port-saved (&body body)
  (let ((saved-port (gensym))
        (saved-device (gensym)))
    `(with-macptrs (,saved-port ,saved-device)
       (unwind-protect
         (progn
           (get-gworld ,saved-port ,saved-device)
           ,@body)
         (set-gworld ,saved-port ,saved-device)))))


(defun my-timer-thing ()
  (progn ;unless *no-scheduling*
    (let ((prior-level (prior-interrupt-level)))
      (cond ((%i>= prior-level 0)  ;;  - can it be NIL - I doubt it
             (incf timer-hit) ; (ed-beep) ;;are we winning?
             (when (and ;(osx-p)
                        *menu-showing*
                        (fixnump *lose-menu-ticks*)
                        (reset-menu-showing-counter-if-mouse-has-moved)
                        (> (%tick-difference (get-tick-count)(%tick-sum *lose-menu-ticks* *menu-showing*)) 0))  ;; maybe do always
               ;(setq *menu-showing* nil)
               (fake-menu-end))
             (when (null *active-processes-tail*)
               (setq *active-processes-tail* *active-processes*))  ;; allows priority 0 stuff to run - should it?
             (setq *processing-events* nil)
             (setq *interrupt-level* 0) 
             ;; do we need this ??
             (flet ((doit (w)
                      (when (neq (wptr w) *window-update-wptr*)
                        (with-port-saved
                          (window-update-event-handler w)))))
               (map-windows-simple #'doit 'allow-view-draw-contents-mixin))
             (cmain t)  ;; run periodic tasks??
             (suspend-current-process))
            (t (incf timer-missed)
               (#_SetEventLoopTimerNextFireTime (%get-ptr *the-timer*) 0.02d0))))))  ;; try again soon (/ *timer-interval* 10.0)?


(defvar *event-delay-forever* -1.0d0) ;;  means never do it #$keventdurationforever is wrong (= -1) in our current headers - fixed now
(def-ccl-pointers clear-timer () 
  (setq *the-timer* nil))

(defun really-install-timer ()
  (setq *the-timer* (#_newptr 4))
  (#_installeventlooptimer (#_getmaineventloop) *event-delay-forever* *timer-interval* timer-proc
   (%null-ptr) *the-timer*)
  (setq timer-hit 0 timer-missed 0 *timer-count* 0))

(defglobal *timer-count* 0)
(defun really-lose-timer (&optional (timer *the-timer*))
  (when timer
    (#_removeeventlooptimer (%get-ptr timer))
    (when (eq timer *the-timer*)
      (setq *timer-count* 0)
      (setq *the-timer* nil)
      (setq *timer-interval* nil)
      (#_disposeptr timer))))

(defvar *event-loop-initial-fire-time* 0.2d0)
(defun activate-timer (&optional (interval *timer-interval*))
  (declare (optimize (speed 3)(safety 0))) ;; no event chk please
  (without-interrupts
   (when (double-float-p interval)
     (when (not *the-timer*)
       (setq *the-timer* (#_newptr 4))
       (#_installeventlooptimer (#_getmaineventloop) *event-delay-forever* *timer-interval* timer-proc
        (%null-ptr) *the-timer*)
       (setq timer-hit 0 timer-missed 0 *timer-count* 0))     
     (setq  *timer-count* (%i+ 1 *timer-count*))
     (when (eq *timer-count* 1)
       (#_SetEventLoopTimerNextFireTime (%get-ptr *the-timer*) *event-loop-initial-fire-time*)))))

;; do #_SetEventLoopTimerNextFireTIme to the next decade
(defun deactivate-timer (&optional (timer *the-timer*))
  (declare (optimize (speed 3)(safety 0)))
  (when timer
    (without-interrupts
     (when (eq *timer-count* 1)
       (#_SetEventLoopTimerNextFireTIme (%get-ptr timer) *event-delay-forever*))
     (setq  *timer-count* (%i- *timer-count* 1))
     (when (%i< *timer-count* 0)
       (really-lose-timer)
       (warn "Timer error. Timer has been disabled.")))))


;(add-pascal-upp-alist 'menu-begin-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))
;(add-pascal-upp-alist 'menu-end-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

(add-pascal-upp-alist-macho 'menu-begin-proc "NewEventHandlerUPP")
(add-pascal-upp-alist-macho 'menu-end-proc "NewEventHandlerUPP")

(defparameter *menu-begin-task-mask* 0)

(defpascal menu-begin-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref))
  (progn 
    (rlet ((menu-context :uint32))
      (let ((myerr (#_geteventparameter eventref #$keventparammenucontext #$typeuint32 (%null-ptr) (record-length :uint32) (%null-ptr) menu-context)))
        (when (eq myerr #$noerr)
          (let ((what (%get-unsigned-long menu-context)))
            (when (neq 0 (logand what (logior #$kMenuContextMenuBar #$kMenuContextMenuBarTracking #$kMenuContextPopUpTracking)))
              (when t ;(osx-p)
                (when *lose-menu-ticks* 
                  (setq *menu-showing* (get-tick-count))
                  (setq *current-mouse-position* (get-mouse-position))))
              ;(ed-beep)
              (setq *menu-begin-task-mask* *periodic-task-mask*)
              (setq *periodic-task-mask* (logior *periodic-task-mask* $ptask_event-dispatch-flag))  ;; << dont eat mouse-up
              (activate-timer)))))))
  #$eventnothandlederr)

(defpascal menu-end-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref))
  (progn
    (rlet ((menu-context :uint32))
      (let ((myerr (#_geteventparameter eventref #$keventparammenucontext #$typeuint32 (%null-ptr) (record-length :uint32) (%null-ptr) menu-context)))
        (when (eq myerr #$noerr)
          (let ((what (%get-unsigned-long menu-context)))
            (when (neq 0 (logand what (logior #$kMenuContextMenuBar #$kMenuContextMenuBarTracking #$kMenuContextPopUpTracking)))
              (setq *menu-showing* nil)
              (setq *periodic-task-mask* *menu-begin-task-mask*)
              (deactivate-timer)))))))
  #$eventnothandlederr)

(def-ccl-pointers menu-begin ()
  (when t ;(jaguar-p)
    (#_installeventhandler (#_getapplicationEventTarget) menu-begin-proc 1
     (make-record :eventtypespec 
                  :eventclass #$kEventClassMenu
                  :eventkind #$kEventMenuBeginTracking)
     (%null-ptr) (%null-ptr))))

(def-ccl-pointers menu-end ()
  (when t ;(jaguar-p)
    (#_installeventhandler (#_getApplicationEventTarget) menu-end-proc 1
     (make-record :eventtypespec 
                  :eventclass #$kEventClassMenu
                  :eventkind #$kEventMenuEndTracking)
     (%null-ptr) (%null-ptr))))


#| ;; doesnt work
(defun make-menu-end-evt ()
  (rlet ((poo :pointer))
    (errchk (#_createevent (%null-ptr) 
             #$keventclassmenu
             #$kEventMenuClosed
             0.1d0
             0
             POO))
    (%get-ptr poo)))

(defvar *a-menu-end-event*)

(def-ccl-pointers a-menu-event ()
  (setq *a-menu-end-event* (make-menu-end-evt)))


(defun fake-menu-end ()
  (#_PostEventToQueue (#_GetMainEventQueue) *a-menu-end-event* #$kEventPriorityStandard))
|#

(defun make-mouse-down ()
  (rlet ((poo :pointer))
    (errchk (#_createevent (%null-ptr) 
             #$keventclassmouse
             #$kMouseTrackingMouseDown
             1.0d0
             0
             POO))
    (%get-ptr poo)))

(defun make-mouse-up ()
  (rlet ((poo :pointer))
    (errchk (#_createevent (%null-ptr) 
             #$keventclassmouse
             #$kMouseTrackingMouseUp
             1.0d0
             0
             POO))
    (%get-ptr poo)))

(defvar *a-mouse-up-event*)
(defvar *a-mouse-down-event*)

(def-ccl-pointers more-mouse-events ()
  (setq *a-mouse-up-event* (make-mouse-up))
  (setq *a-mouse-down-event* (make-mouse-down)))


#|
(defun fake-menu-end ()
  (fake-mouse-moved)
  (#_Posteventtoqueue (#_GetMainEventQueue) *a-mouse-down-event* #$kEventPriorityStandard)
  (#_Posteventtoqueue (#_GetMainEventQueue) *a-mouse-up-event* #$kEventPriorityStandard))
|#

(defparameter ugh 0)
(defun fake-menu-end ()
  (prog nil
    TOP    
    (fake-mouse-moved)
    (let ((err (#_Posteventtoqueue (#_GetMainEventQueue) *a-mouse-down-event* #$kEventPrioritystandard)))
      (WHEN (eq err #$eventAlreadyPostedErr)
        (#_flusheventqueue (#_getmaineventqueue))  ;; what??
        (incf ugh)
        (go top))))
  (#_Posteventtoqueue (#_GetMainEventQueue) *a-mouse-up-event* #$kEventPriorityStandard)
  )


  

;if went outside view then fake-mouse-moved to wake up mouse-down-p

(defun fake-mouse-moved ()
  (#_PostEventToQueue (#_GetMainEventQueue) *a-mouse-event* #$kEventPriorityStandard))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro with-timer (&body body)
    `(unwind-protect
       (progn (activate-timer)
              ,@body)
       (deactivate-timer)))
  )




#|
;; a test
(process-run-function '(:name "countdown-process" :priority 0)
                      #'(lambda ()
                          (loop for n from 5000 downto 0 do
                                ;(setq nn n)
                                #+ignore
                                (when (eq 0 (mod n 100))
                                  (ed-beep)(sleep .1))
                                (print n))))

;(user-pick-color)

;; this causes timer to fail when a choose-file-dialog is already up
;; fixed by doing process wait till the first choose-file-dialog is done
(process-run-function '(:name "foo-process" :priority 1)
                      #'(lambda ()
                          (sleep 5)(choose-file-dialog)))
|#


(defun help-on? ()
  ;; hangs machine if help is on when carbon - the balloon help interface is totally different for carbon
  (and *help-manager-present* #+carbon-compat nil #-carbon-compat (#_HMGetBalloons)))

(defparameter *theme-cursor-alist*
  `((:arrow-cursor . ,#$kThemeArrowCursor)  ;; looks same as *arrow-cursor*
    (:contextual-menu-arrow-cursor . ,#$kThemeContextualMenuArrowCursor)  ;; looks same as *contextual-menu-cursor*
    (:alias-arrow-cursor . ,#$kThemeAliasArrowCursor)
    (:copy-arrow-cursor . ,#$kThemeCopyArrowCursor)
    (:I-beam-cursor . ,#$kThemeIBeamCursor)
    (:cross-cursor . ,#$kThemeCrossCursor)
    (:plus-cursor . ,#$kThemePlusCursor)
    (:watch-cursor . ,#$kThemeWatchCursor)   ;; can animate
    (:closed-hand-cursor . ,#$kThemeClosedHandCursor)
    (:open-hand-cursor . ,#$kThemeOpenHandCursor)
    (:pointing-hand-cursor . ,#$kThemePointingHandCursor)
    (:counting-up-hand-cursor . ,#$kThemeCountingUpHandCursor) ; can animate
    (:counting-down-hand-cursor . ,#$kThemeCountingDownHandCursor) ; can animate
    (:counting-up-and-down-hand-cursor . ,#$kThemeCountingUpAndDownHandCursor) ; can animate
    (:spinning-cursor . ,#$kThemeSpinningCursor) ; can animate
    (:resize-left-cursor . ,#$kThemeResizeLeftCursor)  
    (:resize-right-cursor . ,#$kThemeResizeRightCursor)
    (:resize-left-right-cursor . ,#$kThemeResizeLeftRightCursor)  ;; similar to *horizontal-ps-cursor* but heavier
    (:resize-up-cursor . ,#$kThemeResizeUpCursor)
    (:resize-down-cursor . ,#$kThemeResizeDownCursor)
    (:resize-up-down-cursor . ,#$kThemeResizeUpDownCursor)
    (:not-allowed-cursor .  ,#$kThemeNotAllowedCursor)
    (:poof-cursor . ,#$kThemePoofCursor)
    ))
 
(defun set-cursor (cursor)
  "If the argument is the wrong type this does a no-op"
  (let ((temp *current-cursor*))
    (without-interrupts
     (typecase cursor
       (fixnum
        (with-macptrs ((temp2 (#_GetCursor cursor)))
          (unless (%null-ptr-p temp2)
            (#_SetCursor (%setf-macptr temp (%get-ptr temp2))))))
       (macptr
        (when (not (%null-ptr-p cursor))
          (#_SetCursor (if (handlep cursor) ; ;; most are pointers today - except *i-beam-cursor*
                         (progn ;(#_LoadResource cursor)  ;; our cursors aren't resources today
                                (%setf-macptr temp (%get-ptr cursor)))
                         (%setf-macptr temp cursor)))))
       (keyword
        (let ((value (cdr (assq cursor *theme-cursor-alist*))))
          (when value 
            (#_SetThemeCursor value))))))))



(defun cursorhook (&aux wob)
  (declare (resident))
  (rlet ((pt :point)
         (wptr-ptr :pointer))
    (#_GetGlobalMouse pt)
    (let ((part-code (#_FindWindow  (%get-long pt)  wptr-ptr)))
      (with-macptrs ((wptr (%get-ptr wptr-ptr)))
        (if (and (eql part-code $inContent)
                 (not (%null-ptr-p  wptr))  ;(%get-ptr wptr))) ;; sheesh
                 (setq wob (window-object wptr))
                 (or (eq wob *selected-window*) (windoid-p wob)
                     (setq wob nil)))
          (with-focused-view wob
            (#_GlobalToLocal pt)))
        (window-update-cursor wob (%get-long pt))))))

(defglobal *cursorhook* 'cursorhook)

#|
(defmacro with-cursor (cursor &body body)
  `(unwind-protect
     (let-globally ((*cursorhook* ,cursor))
       (update-cursor)
       ,@body)
     (update-cursor)))
|#

(defmacro with-cursor (cursor &body body)
  (let ((cursor-var (gensym))
        (locked-p (gensym)))
    `(let ((,locked-p nil)
           (,cursor-var ,cursor))       
       (unwind-protect       
         (let-globally ((*cursorhook* ,cursor-var))
           ;; don't call handlep ??
           (when nil ;(and (handlep ,cursor-var)(not (handle-locked-p ,cursor-var))))
             (require-trap #_hlock ,cursor-var)(setq ,locked-p t))
           (update-cursor)
           ,@body)
         (when ,locked-p 
           (require-trap #_hunlock ,cursor-var))
         (update-cursor)))))

;set-cursor and update-cursor should be the same function...
(defun update-cursor (&optional (hook *cursorhook*))
  #+ignore
  (when (and (let ((hmp *help-manager-present*))
               (and hmp (neq hmp '*help-manager-present*)))
             (help-on?))
    (setq *help-manager-present* '*help-manager-present*)
    (let ((*interrupt-level* 0))
      (with-event-processing-enabled ;let-globally ((*processing-events* nil))
        (when (or (probe-file #.(merge-pathnames *.fasl-pathname* "ccl:library;help-manager"))
                  (probe-file "ccl:library;help-manager.lisp"))
          (require "HELP-MANAGER" "ccl:library;help-manager")))))
  (when (and *foreground* hook)
    (if (or (functionp hook) (and (symbolp hook)(fboundp hook)))
      (funcall hook)
      (set-cursor hook))))

(defun find-named-periodic-task (name)
  (dolist (task *%periodic-tasks%*)
    (when (eq name (ptask.name task))
      (return task))))

(defun %install-periodic-task (name function interval &optional 
                                    (flags 0)
                                    (privatedata (%null-ptr)))
  (without-interrupts
   (setq interval (require-type interval 'fixnum))
   (let* ((already (find-named-periodic-task name))
          (state (if already (ptask.state already) (make-record ptaskstate)))
          (task (or already (%istruct 'periodic-task state name nil))))
     (setf (ptask.function task) function)
     (setf (pref state ptaskstate.interval) interval
           (pref state ptaskstate.flags) flags
           (pref state ptaskstate.private) privatedata  ;; not used
           (pref state ptaskstate.nexttick) (%tick-sum (get-tick-count) interval))
     (unless already (push task *%periodic-tasks%*))
     task)))

(defmacro with-periodic-task-mask ((mask &optional disable-gc-polling) &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (funcall-with-periodic-task-mask ,mask ,disable-gc-polling ,thunk))))

(defvar *periodic-task-masks* nil)

(defvar *gc-polling-disable-count* 0)
(declaim (fixnum *gc-polling-disable-count*))

; All this hair is so that multiple processes can vote on the *periodic-task-mask*
;; do we really need all this hair?
(defun funcall-with-periodic-task-mask (mask disable-gc-polling thunk)
  (if (not *%PERIODIC-TASKS%*)
    (let-globally ((*periodic-task-mask* mask))
      (funcall thunk))
    (let* ((cell (list mask)))
      (declare (dynamic-extent cell))
      (flet ((logior-list (list)
               (declare (type list list))
               (let ((res 0))
                 (declare (fixnum res))
                 (loop
                   (when (null list) (return res))
                   (setq res (%ilogior res (pop list)))))))
        (declare (inline logior-list))
        (unwind-protect
          (progn
            (without-interrupts
             (setf (cdr cell) *periodic-task-masks*
                   *periodic-task-masks* cell)
             (setq *periodic-task-mask* (logior-list *periodic-task-masks*))
             (when disable-gc-polling
               (incf *gc-polling-disable-count*)
               (setf *gc-event-status-bits* 
                     (%ilogior (lsh 1 $gc-polling-enabled-bit) *gc-event-status-bits*))
               ; making this a bignum (on 68k) is in very poor taste
               ;(bitsetf $gc-polling-enabled-bit (the fixnum *gc-event-status-bits*))
               ))
            (funcall thunk))
          (without-interrupts
           (let* ((first *periodic-task-masks*)
                  (this first)
                  (last nil))
             (declare (type cons first this last))
             (loop
               (when (eq this cell)
                 (if last
                   (setf (cdr last) (cdr this))
                   (pop first))
                 (return (setq *periodic-task-masks* first)))
               (setq last this
                     this (cdr this))))
           (setq *periodic-task-mask* (logior-list *periodic-task-masks*))
           (when disable-gc-polling
             (when (eql 0 (decf *gc-polling-disable-count*))
               ; as far as I can tell PPC gc ignores all this event stuff
               (setf *gc-event-status-bits* 
                     (%ilogand (%ilognot (lsh 1 $gc-polling-enabled-bit)) *gc-event-status-bits*))
               ;(bitclrf $gc-polling-enabled-bit (the fixnum *gc-event-status-bits*))
               ))))))))


(defun %run-masked-periodic-tasks (&optional (mask $ptask_event-dispatch-flag))
  (let-globally ((*in-scheduler* t))
    (with-periodic-task-mask (mask t)
      (call-with-port %temp-port% #'cmain))))

; We only let one process at a time run periodic tasks.
; Normally, they will run to completion since they run without-interrupts,
; but if one of them does process-wait (e.g. with-focused-view), some
; other process might be scheduled. This flag prevents deadlock by
; letting that other process do periodic tasks as well.
(defvar *running-periodic-tasks* nil)

(defun cmain (&optional no-event-dispatch)
  (unless (or no-event-dispatch *in-scheduler*)
    (let-globally ((*in-scheduler* t))
      (let* ((c *current-process*))
        (when (and c (> (%tick-difference (get-tick-count) (process.nexttick c))
                        0))
          (suspend-current-process)))))
  (flet ((maybe-run-periodic-task (task)
           (let ((now (get-tick-count))
                 (state (ptask.state task)))
             (when (and (>= (%tick-difference now (pref state ptaskstate.nexttick))
                            0)
                        (eql 0 (logand (the fixnum (pref state ptaskstate.flags))
                                       (the fixnum *periodic-task-mask*))))
               (setf (pref state ptaskstate.nexttick) (%tick-sum now (pref state ptaskstate.interval))) ;(+ now (rref state ptaskstate.interval)))
               (funcall (ptask.function task))))))
    (let ((event-dispatch-task *event-dispatch-task*))
      (unless no-event-dispatch
        (if event-dispatch-task (maybe-run-periodic-task event-dispatch-task)))
      (without-interrupts
       (bitclrf $gc-allow-stack-overflows-bit *gc-event-status-bits*)
       (unless *running-periodic-tasks*
         (let-globally ((*running-periodic-tasks* t))
           (dolist (task *%periodic-tasks%*)
             (unless (eq task event-dispatch-task)
               (maybe-run-periodic-task task)))))))))


(defun %remove-periodic-task (name)
  (without-interrupts
   (let ((task (find-named-periodic-task name)))
     (when task (setq *%periodic-tasks%* (delete task *%periodic-tasks%*)))
     task)))



; Is it really necessary to keep this guy in a special variable ?
(defvar *event-dispatch-task* nil)
;; do we need this?

(defloadvar *event-dispatch-task* 
  (%install-periodic-task 
   'event-poll
   'event-poll
   20
   (+ $ptask_draw-flag $ptask_event-dispatch-flag)))



(defun event-ticks ()
  (let ((task *event-dispatch-task*))
    (when task (pref (ptask.state task) ptaskstate.interval))))

(defun set-event-ticks (n)
  (setq n (require-type n '(integer 0 3767)))   ;  Why this weird limit ? - do we mean 32767
  (let ((task *event-dispatch-task*))
    (when task (setf (pref (ptask.state task) ptaskstate.interval) n))))

;; -------- another way of dealing with the sneaky cmd-`
;(add-pascal-upp-alist 'window-foo-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

(add-pascal-upp-alist-macho 'window-foo-proc "NewEventHandlerUPP")

(defpascal window-foo-proc (:ptr targetref :eventref event :word)
  (declare (ignore targetref))
  (rlet ((ref :pointer))
    (if (eq 0 (#_geteventparameter event
                #$kEventParamDirectObject
                #$typeWindowRef
                (%null-ptr)
                (record-length :pointer)
                (%null-ptr)
                ref))
      (let ((window-obj (window-object (%get-ptr ref))))
          (if (or (not window-obj) 
                  (typep window-obj 'windoid))
            #$eventnothandlederr
            (progn (window-select window-obj)
                   #$noerr)))
      #$eventnothandlederr)))

(def-ccl-pointers sneaky-cmd-stuff ()
  (rlet ((event-spec :eventtypespec
                     :eventclass #$keventclasswindow
                     :eventkind #$keventwindowactivated))
    (#_installeventhandler (#_getapplicationeventtarget)
     window-foo-proc 1
     event-spec (%null-ptr) (%null-ptr))
    ))

(defmethod print-object ((task periodic-task) stream)
   (print-unreadable-object (task stream :type t :identity t)
     (let* ((state (ptask.state task))
            (name (ptask.name task))
            (function (ptask.function task))
            (interval (pref state ptaskstate.interval)))
     (format stream "'~a ~a (~a tick~p)" name function interval interval))))







; end of L1-events.lisp

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
