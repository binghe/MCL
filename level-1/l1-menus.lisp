;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 10/5/97  akh  see below
;;  5 8/25/97  akh  optimizations for long menus
;;  4 7/4/97   akh  see below
;;  3 6/2/97   akh  see below
;;  7 9/4/96   akh  conditionalize use of hash table for 3.1 vs 4.0
;;  5 5/20/96  akh  remove some goofy underlining
;;  2 11/9/95  akh  attach-menu - assure that menus intended to be disabled are in fact disabled
;;  7 3/2/95   akh  changed menu-update to enable if any items enabled????
;;  6 2/9/95   akh  install-menu-item sets style also
;;  5 2/7/95   akh  probably no change
;;  4 1/30/95  akh  dont remember
;;  (do not edit before this line!!)

;; L1-menus.lisp - Object oriented menu stuff
; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;; no change
;; menus can have unicode titles
;; Replace (#_SetItemMark mh n (%code-char (slot-value item 'menu-id)))
;;  with (#_setmenuitemhierarchicalid  mh n (slot-value item 'menu-id))
;;  so hierarchical menu can have check-mark - from Takehiko Abe
;; don't do the cfstring business for font-menu-items
;; deal with initial #\- in menu-item-title
;; install-menu-item ditto
;; set-menu-item-title does the right thing with extended-string and non 7bit-ascii 
;; menu-item-action ((item windows-menu-menu-item)) - woi - user reported wptr may be gone??
;; ------ 5.1 final
;; lose view-font initarg for menu - always caused an error anyway
;; no more instance-initialize-mixin here thank you, make mark tapia unhappy?
;;   now at least (make-instance 'menu :junk t) will error as it should.
;; allow encoded-string in instance-initialize of menu-item
;; ---- 5.1b1
;; menu may have a menu-font
;; menu-update fixes for ift - actually real problem was in ift
;; remove some garbage in set-menu-item-title-with-cfstr
;; worry about unicode menu items
;; --------- 5.0final
;; menu-item-action ((item windows-menu-menu-item)) more likely to dtrt for collapsed windows on OSX
;; set-hide-command-key on *lisp-startup-functions* is conditionalized
;; ----------- 5.0b4
;; selecting a collapsed window from the windows menu uncollapses. Thank you.
;; add set-hide-command-key and add it to *lisp-startup-functions*
;; ---------- 4.4b5
;; instance-initialize :after ((menu-item menu-item) - no more require-type command-key
;; --------- 4.4b4
;; 02/11/02 akh some stuff about keeping menu-item-icon-type in sync with menu-item-icon-handle
;; -------- 4.4b2
;; 07/20/01 akh fix set-menu-item-icon-handle and set-menu-item-script for non carbon - we need AppearanceLib 
;; 06/06/01 akh see osx-p in menu-item-enable
;; akh 05/05/01 akh set-command-key accepts e.g. (:shift #\H)
;; akh carbon-compat
; 09/19/99 akh added some  stuff for menu-item-icon-handle, menu-item-icon-type and menu-item-script
; ------ 4.3f1c1
; 04/22/99 akh update-menu-items no longer enables the menu, update-edit-menu-items is different
; akh another tweak to remove-menu-items, also revert to forgiving a NIL menu-item
;------------- 4.3b1
; 08/05/98 akh most of set-menubar is without-interrupts - seems to fix a CLIM problem
; 06/09/98 akh set-menu-item-title messes with initial #\- just like install-menu-item
; 04/11/98 akh install-menu-item passes the item-number to various set-xx fns
; 03/31/98 akh minor tweak to remove-menu-items
;;; --------- 4.2
; 07/28/97 akh   set-menu-item-check-mark - do nothing if same cause menu-item-number is slow for lots of items
; 04/17/97 bill  fix-menu-color-bug does something only if *fix-menu-color-bug* is true.
;                The default is NIL.
;                This speeds up set-menubar.
; 04/15/97 bill  (method menu-install (menu)) calls initialize-menubar-color
; -------------  4.1b2
; 06/03/96 bill  (method menu-update :around (t)) prevents reentry for a single menu.
;                This stops Edit menu problems from repeating.
; -------------  MCL-PPC 3.9
; 03/26/96  gb  lowmem accessors.
; 11/29/95 bill  New trap names to avoid emulator.
;  4/20/95 slh   update-menus-for-modal folded into update-menus
; menu-update different
; 01/30/95 alice add-menu-items checks if installed-p - from patch
;12/26/94 alice make fix-menu-color-bug and set-menubar work when building from scratch
; update-menus-for-modal was brain dead tho it happened to work in the usual case
; menu-enable/disable and set-menu-title pass the menu to draw-menubar-if
; draw-menubar-if takes optional menu arg - draws only when in menubar (pop-up-menus dont have owners either)
;10/12/93 alice menu-item-action ((item windows-menu-menu-item)) - control brings class front wards
;------------
;;start of added text
;06/29/94 bill  set-menubar works around a system 7.1.1 bug in menu colors.
;-------------- 3.0d13
;05/04/93 alice 'character -> 'base-character, make-menu-item second arg is optional
;05/04/93 bill  *menu-id-object-table* replaces *menu-id-object-alist*
;               Faster algorithm for allocate-menu-id
;04/30/93 bill  in window-menu-item methods: front-window -> get-window-event-handler
;               bootstrapping version on get-window-event-handler
;-------------- 2.1d4
;02/03/93 alice instance-initialize for menu is primary instead of :after so item-list is set 
; 		before view-default-size is called by the after method on simple-view  (pop-ups care)
;12/10/92 bill menu-item-icon-num slot for menu-item's.
;              initarg is :icon-num, read by menu-item-icon-num, set by set-menu-item-icon-num
;              Thanx to Steve Mitchell for the initial version of the icon code.
;07/30/92 alice change update-menu-items so menu state is truly fn of state of items
;------------ 2.0
;10/30/91 bill remove "-iv" on the end of slot names
;10/16/91 bill  Selecting a hierarchical menu instead of one of its items
;               no longer causes an error.
;10/15/91 bill  menu-items no longer conses if it doesn't need to.
;09/25/91 alice more menu-update fiddling
;---------- 2.0b3
;09/05/91 alice another menu-update tweak
;09/04/91 alice menu-update and menu-item-update tweaks
;08/27/91 alice menu-update - enable item then call menu-item-update
;08/23/91 alice menu-update - let updater decide
;08/24/91 gb   use new trap syntax.
;07/11/91 bill leading "-" in menu-item title becomes n-dash so the damn
;              ROM won't interpret it as a seperator line.
;08/12/91 alice menu-disable - (when enabled ...), menu-enable too - looks better, goes faster
;08/12/91 alice dim-if-undefined look at handler if any
;06/10/91 bill install-menu-item no longer causes all menu-items below a
;              menu-item with a title of "" to display as "xxx".
;06/07/91 bill help-spec for menu-elements.
;------------- 2.0b2
;01/28/91 bill add set-menu-item-action-function
;01/18/91 bill set-menu-item-update-function no longer a :writer (wrong arg order)
;01/04/91 bill instance-initialize for menu-item take menu-item-title as well
;              as menu-title.
;12/11/90 bill (setf menu-item-update-function) -> set-menu-item-update-function
;10/03/90 bill %class-cpl -> %inited-class-cpl
;08/27/90 bill install-menu-item: wrong sense on test of (slot-value item 'checkedp)
;07/23/90 bill proper return value for set-menu-item-check-mark
;07/05/90 bill menu-item-update-function & menu-update-function
;06/18/90 bill call window-ensure-on-screen if windows-menu-menu-item is
;              selected with the shift key down.
;05/30/90 gb   Use print-unreadable-object.
;05/04/90 bill _DelMCEntries only if *color-available*
;03/26/90 bill Use "_InsMenuItem instead of _AppendMenu so that adds to the
;              apple-menu will work.  No longer need add-menu-items specialization
;              for apple-menu.
;03/20/90 bill initialize-instance => instance-initialize.
;03/17/90 bill add readers to menu-element and menu-item classes.
;03/13/90 bill menu-owner => menu-item-owner
;02/27/90 bill Add menu-owner method.
;12/27/89 gz apple-menu-class -> apple-menu.  Remove obsolete #-bccl conditionals.
;12/15/89 bill set-command-key: fix error on setting to NIL.
;10/11/89 as MENU-ITEMS defaults class to MENU-ELEMENT
;10/03/89 gz with-menu-detached returns
;09/27/89 gb simple-string -> ensure-simple-string.
;09/16/89 bill Removed the last vestiges of object-lisp windows.
; 9/31/89 bill menu-item-action & dim-if-undefined: make work for CLOS windows.
; 8/25/89 bill dim-if-undefined: Alwas dim unless the window is an object.
;              This needs to be modified to work with CLOS windows.
; 7/28/89   gz Use :default-initargs for apple-menu-class.
; 7/20/89   gz closified.
; 18-mar-89 as from 1.3: uninstalled menus are gc-able
;                        flushed dispose-menu, menus
;                        color support
; 3/17/89  gz CLOS window-select syntax.
; 2-mar-89 as removed window-selection-menu-item
;             added windows-menu-menu-item
; 11/19/88 gb dispatch on functionp or symbolp.
; 10/27/88 gb char-int -> %char-code.
; 9/19/88 as  (unless *menubar-frozen* (_drawmenubar)) -->> (draw-menubar-if)
; 8/21/88 gz  declarations
; 8/6/88  gb  make (menu-install *apple-menu-class*) check macptrp-ness.
;             stack-cons.
; 6/28/88 jaj re-init menup to nil in add-menu-items
; 6/6/88  jaj added *window-selection-menu-item* fns
; 5/19/88 as  brought over from Beany
; 4/21/88 jaj more changes for apple menu (cannot be deinstalled except
;             by system code), double install is okay.
; 4/20/88 jaj set-menubar doesn't remove apple-menu (for multifinder)
;             added menu-deinstall for apple-menu
; 4/10/88 jaj did solo defobfuns
; 4/6/88  as  added definitions for *apple-menu-class*
;             heirarchical menus dump properly
; 3/31/88 as  moved with-menu-detached to l1-macros
;             removed add-item, remove-item
; 3/30/88 as  replaced call to with-menubar-frozen with let
;             changed with-detached-menu to not use detach-menu
;             punted detach-menu, domenu
; 3/30/88 gz  New macptr scheme. Flushed pre-1.0 edit history.
; 3/2/88  gz  Eliminate compiler warnings

(defvar %menubar ())

#+ignore
(eval-when (:compile-toplevel :execute :LOAD-TOPLEVEL)
  (or (ignore-errors (add-to-shared-library-search-path "AppearanceLib" t))
      ;; if it aint there when we build the app maybe it's there when we run it - but I doubt we will build another non carbon app?
      (pushnew "AppearanceLib" *lazy-shared-libraries* :test #'equalp)))

(defclass menu-element ()
  ((owner :initform nil :reader menu-item-owner :reader menu-owner)
   (title :initform "" :reader menu-item-title :reader menu-title)
   (enabledp :initarg :enabledp :initform t :reader menu-item-enabled-p :reader menu-enabled-p)
   (style :initform nil :reader menu-item-style :reader menu-style)
   (color-list :initform nil)                         ; part-color-list will read this
   (update-function :initform nil :initarg :update-function
                    :accessor menu-update-function 
                    :accessor menu-item-update-function)
   (help-spec :initarg :help-spec :initform nil :accessor help-spec)
   (checkedp :initform nil)))

(defmethod set-menu-item-update-function ((e menu-element) value)
  (setf (menu-item-update-function e) value))

(export '(appearance-available-p menu-item-icon-handle menu-item-icon-type menu-item-script
          set-menu-item-icon-handle set-menu-item-icon-type set-menu-item-script set-menu-item-icon) :ccl)

;; without appearance manager, script uses both icon-num and command-key
(defclass menu-item (menu-element)      ; really "simple-menu-element"
  ((checkedp)
   (command-key)
   (menu-item-action :accessor menu-item-action-function)
   (menu-item-icon-num :reader menu-item-icon-num
                       :writer (setf menu-item-icon-num-slot)
                       :initform nil
                       :initarg :icon-num)
   ;; this slot eventually contains a list of handle ostype and id
   ;; so if handle goes dead after save-application it can be reconstructed, in some cases anyway
   (menu-item-icon-handle ;reader menu-item-icon-handle    
                          :writer (setf menu-item-icon-handle-slot)
                          :initform nil
                          :initarg :icon-handle)   
   (menu-item-icon-type :reader menu-item-icon-type
                        :writer (setf menu-item-icon-type-slot)
                        :initform nil
                        :initarg :icon-type)
   (menu-item-script :reader menu-item-script
                     :writer (setf menu-item-script-slot)
                     :initform nil
                     :initarg :menu-item-script)))
#|
(defclass better-menu-item (menu-item)())

(defmethod menu-item-action ((menu-item better-menu-item))
  (let ((action (slot-value menu-item 'menu-item-action)))
    (when action (funcall action menu-item))))
|#

(defmethod set-menu-item-action-function ((menu-item menu-item) value)
  (setf (menu-item-action-function menu-item) value))

;menu-handle and menu-id are nil if not installed
(defclass menu (menu-element)
  ((item-list :initform nil)
   (menu-id :initform nil :reader menu-id)
   (menu-handle :initform nil :reader menu-handle)
   (menu-font :initform nil :initarg :menu-font)
   ))

(defmethod menu-font ((menu menu))
  (or (slot-value menu 'menu-font)
      (and (menu-owner menu)
           (menu-font (menu-owner menu)))))

(defmethod print-object ((thing menu-element) stream)
  (print-unreadable-object (thing stream)
    (format stream "~S ~S"
            (class-name (class-of thing))
            (slot-value thing 'title))))

(defmacro with-menu-detached (menu &rest body)
  (let* ((rest-mbar (gensym)) (item (gensym)))
    `(let ((,rest-mbar (reverse (memq ,menu %menubar)))
           (*menubar-frozen* t))
       (dolist (,item ,rest-mbar) (menu-deinstall ,item))
       ,@body
       (dolist (,item (nreverse ,rest-mbar)) (menu-install ,item)))))

#-ppc-clos ; we mean cclx or something
(progn
(defvar *menu-id-object-table* nil)

(defun allocate-menu-id (object)
  (without-interrupts
   (let ((start-id (+ 2 (length *menu-id-object-table*))))
     (flet ((search (start end)
              (do ((id start (1+ id)))
                  ((>= id end) nil)
                (unless (menu-object id)
                  (return id)))))
       ; There is evidence that ids >= 256 don't work correctly,
       ; so attempt to allocate one less than that.
       ; Start at start-id so we likely succeed sooner.
       (let ((id (or (search start-id 256)
                     (search 2 start-id)
                     (search (max 256 start-id) 32767)
                     (error "Can't allocate menu id"))))
         (push (cons id object) *menu-id-object-table*)
         id)))))

(defun deallocate-menu-id (id)
  (without-interrupts
   (setq *menu-id-object-table* (remove-from-alist id *menu-id-object-table*))
   nil))

(defun menu-object (menuID)
  "Given a menu id returns the associated menu object"
  (%cdr (assq menuid *menu-id-object-table*)))

(queue-fixup

(defun allocate-menu-id (object)
  (without-interrupts
   (let ((start-id (+ 2 (hash-table-count *menu-id-object-table*))))
     (flet ((search (start end)
              (do ((id start (1+ id)))
                  ((>= id end) nil)
                (unless (menu-object id)
                  (return id)))))
       ; There is evidence that ids >= 256 don't work correctly,
       ; so attempt to allocate one less than that.
       ; Start at start-id so we likely succeed sooner.
       (let ((id (or (search start-id 256)
                     (search 2 start-id)
                     (search (max 256 start-id) 32767)
                     (error "Can't allocate menu id"))))
         (setf (gethash id *menu-id-object-table*) object)
         id)))))

(defun deallocate-menu-id (id)
  (without-interrupts
   (remhash id *menu-id-object-table*)
   nil))

(defun menu-object (id)
  (gethash id *menu-id-object-table*))

(setq *menu-id-object-table*
      (alist-hash-table *menu-id-object-table* :size 0))

))  ; end of queue-fixup


#+ppc-clos
(progn
(defvar *menu-id-object-table* (make-hash-table :size 0))

(defun allocate-menu-id (object)
  (without-interrupts
   (let ((start-id (+ 2 (hash-table-count *menu-id-object-table*))))
     (flet ((search (start end)
              (do ((id start (1+ id)))
                  ((>= id end) nil)
                (unless (menu-object id)
                  (return id)))))
       ; There is evidence that ids >= 256 don't work correctly,
       ; so attempt to allocate one less than that.
       ; Start at start-id so we likely succeed sooner.
       (let ((id (or (search start-id 256)
                     (search 2 start-id)
                     (search (max 256 start-id) 32767)
                     (error "Can't allocate menu id"))))
         (setf (gethash id *menu-id-object-table*) object)
         id)))))

(defun deallocate-menu-id (id)
  (without-interrupts
   (remhash id *menu-id-object-table*)
   nil))

(defun menu-object (id)
  (gethash id *menu-id-object-table*))
)


(defmethod init-menu-id ((menu menu))
  (unless (slot-value menu 'menu-id)
    (let ((id (allocate-menu-id menu)))
      (when (and nil (menu-owner menu)(> id 235)) ;; ??
        (warn "Menu id > 235 for heirarchical menu may not work" ))
      (setf (slot-value menu 'menu-id) id))))

(defun menubar () (copy-list %menubar))

(defun draw-menubar-if (&optional menu)
  (unless (or *menubar-frozen*
              (and menu (not (memq menu %menubar))))
    (#_DrawMenuBar)))

(defun set-menubar (menu-list)
  (let ((*menubar-frozen* t))
    (without-interrupts
     (dolist (menu %menubar)
       ; menu-deinstall of apple-menu is a nop
       (if (neq menu *apple-menu*) (menu-deinstall menu)))
     (when (boundp '*menubar*)(fix-menu-color-bug *menubar*))  ; UH what is *menubar* this week??
     (dolist (menu menu-list)
       (menu-install menu)
       (fix-menu-color-bug menu)
       )))
  (draw-menubar-if)
  menu-list)

(defvar *fix-menu-color-bug* nil)

; work around a system 7.1.1 menu color bug
(defun fix-menu-color-bug (menu-or-menubar)
  (when (and *fix-menu-color-bug*
             (fboundp 'part-color)
             (method-exists-p (fboundp 'part-color) menu-or-menubar)) ; dont die when called from l1-initmenus.
    (let ((color (or (part-color menu-or-menubar :default-item-title))))
      (if color
        (progn
          (set-part-color menu-or-menubar :default-item-title nil)
          (set-part-color menu-or-menubar :default-item-title color))
        (progn
          (set-part-color menu-or-menubar :default-item-title *black-color*)
          (set-part-color menu-or-menubar :default-item-title nil))))))

(defun find-menu (name)
  (setq name (ensure-simple-string name))
  (dolist (menu %menubar)
    (if (string-equal name (slot-value menu 'title)) (return menu))))

;;Menu Object Primitives

;These get replaced later.
(defmethod set-part-color-loop (part colors) (declare (ignore part colors)))

(when (not (fboundp 'typep))
  (defun typep (object type)
    (memq (find-class type nil)
          (%inited-class-cpl (class-of object)))))


(defmethod initialize-instance :after  ((menu menu) &key
                                 menu-title
                                 ;view-font
                                 menu-item-title
                                 (menu-items ())
                                 menu-colors)  
  (setf (slot-value menu 'title)
        (ensure-simple-string (or menu-title menu-item-title "Untitled")))
  (setf (slot-value menu 'color-list) menu-colors)
  ;(when view-font (set-initial-view-font menu view-font)) ;; what??
  (when menu-items (apply #'add-menu-items menu menu-items))
  ;(call-next-method)  ;; << make mark tapia happy - mixing menu and window??
  )

(defmethod add-menu-items ((menu menu) &rest args &aux item mh)
  (declare (dynamic-extent args))
  (do* ((number (%i+ 1 (list-length (slot-value menu 'item-list))) (%i+ number 1)))
       ((null args) nil)
    (setq item (require-type (pop args) 'menu-element))
    (when (typep item 'menu)
      (when (slot-value item 'menu-handle)
        (error "Menu ~S is already installed" item)))
    (setf (slot-value menu 'item-list)
          (nconc (slot-value menu 'item-list) (list item)))
    (setf (slot-value item 'owner) menu)
    (when (and (stringp (slot-value item 'title))(string= (slot-value item 'title) "-"))
      (setf (slot-value item 'enabledp) nil))
    (when (setq mh (menu-handle menu))
      (when (typep item 'menu)
        (when (menu-installed-p menu)
          (menu-install item)))
      (install-menu-item mh item number))    
    (set-part-color-loop item (slot-value item 'color-list))))


(defmethod remove-menu-items ((menu menu) &rest args &aux item-num)
  (declare (dynamic-extent args))
  (without-interrupts
   (dolist (item args)
     (when item
       (let ((owner (menu-item-owner item)))
         (when owner
           (when (neq owner menu)(error "~S is not a menu item of ~S" item menu))         
           (setq item-num (menu-item-number item))
           (when (slot-value menu 'menu-id)
             (when *color-available*
               (#_DeleteMCEntries  (slot-value menu 'menu-id) item-num))
             (#_DeleteMenuItem (slot-value menu 'menu-handle) item-num))
           (setf (slot-value item 'owner) nil)
           (when (typep item 'menu)
             (let ((*menubar-frozen* t))
               (menu-deinstall item)))
           (setf (slot-value menu 'item-list)
                 (nremove item (slot-value menu 'item-list)))))))
   (dolist (item (slot-value menu 'item-list))
     (update-color-defaults item))))


(defun make-menu-item (title &optional action &rest stuff)
  (declare (dynamic-extent stuff))
  (apply #'make-instance 'menu-item :menu-item-title title :menu-item-action action stuff))



(defun add-new-item (menu title &optional action &rest rest &key
                          (class 'menu-item) &allow-other-keys)
  (declare (dynamic-extent rest))
  (remf rest :class)
  (let ((item (apply #'make-instance
                     class
                     :menu-item-title title
                     :menu-item-action action
                     rest)))
    (add-menu-items menu item)
    item))

(defmethod menu-items ((menu menu) &optional (menu-item-class 'menu-element)
                       &aux ret)
  (let ((items (slot-value menu 'item-list)))
    (if (neq menu-item-class 'menu-element)
      (dolist (item items (nreverse ret))
        (when (typep item menu-item-class) (push item ret)))
      items)))

(defmethod find-menu-item ((menu menu) title)
  "Returns menu item with given title or nil if none."
  (dolist (item (slot-value menu 'item-list))
    (when (string-equal title (menu-item-title item))
      (return item))))

(defmethod menu-title ((menu menu)) (slot-value menu 'title))

(defmethod set-menu-title ((menu menu) new-title)
  (if (slot-value menu 'owner)
    (set-menu-item-title menu new-title)
    (progn
      (let ((handle (slot-value menu 'menu-handle)))
        (setf (slot-value menu 'title) new-title)
        (when handle
          (set-menu-title-cfstring handle new-title)))))
  (slot-value menu 'title))


; Bootstrapping

(unless (fboundp 'initialize-menubar-color)
  (%fhave 'initialize-menubar-color
          #'(lambda ())))



(defmethod menu-install ((menu menu) &aux (n 0))
  (unless (slot-value menu 'menu-handle)
    ;(dbg 16)
    (init-menu-id menu)
    (if (slot-value menu 'owner)
      (progn
        (let ((the-title (slot-value menu 'title))
              (menu-handle))
          (rlet ((foo :ptr))
            (errchk (#_CreateNewMenu (slot-value menu 'menu-id) 0 foo))
            (setq menu-handle (%get-ptr foo))
            (if (7bit-ascii-p the-title)
              (with-pstrs ((menu-title the-title))
                (#_setmenutitle menu-handle menu-title))
              (set-menu-title-cfstring menu-handle the-title)))
          (setf (slot-value menu 'menu-handle) menu-handle)
          (#_insertmenu menu-handle -1)          
          (dolist (subitem (slot-value menu 'item-list))
            (setq n (%i+ n 1))
            (when (typep subitem 'menu)
              (menu-install subitem))
            (install-menu-item (slot-value menu 'menu-handle) subitem n))
          (initialize-menubar-color)
          (set-part-color-loop menu (slot-value menu 'color-list))))
      (progn
        (setf (slot-value menu 'menu-handle) (%null-ptr))
        (attach-menu menu)
        (dolist (item (slot-value menu 'item-list))
          (when (typep item 'menu) (menu-install item)))
        (setq %menubar (nconc %menubar (list menu)))
        (initialize-menubar-color)
        (set-part-color-loop menu (slot-value menu 'color-list))
        (draw-menubar-if)))
    (when (menu-font menu)
      (multiple-value-bind (ff ms)(font-codes (menu-font menu))
        (#_setmenufont (menu-handle menu)(ash ff -16)(logand ms #xffff)))))
  
  t)

(defun set-menu-title-cfstring (mh title)
  (let* ((string (if (typep title 'encoded-string)(the-string title) title))
         (len (length string)))
    (declare (fixnum len))          
    (%stack-block ((sb (+ len len)))
      (copy-string-to-ptr string 0 len sb)      
      (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) sb len)))
        (#_SetMenuTitleWithCFString mh  cfstr)
        (#_cfrelease cfstr)))))


; << another patch
#+ignore
(defun attach-menu (menu &aux (n 0) mh) ;No DrawMenuBar
  (with-pstrs ((tp (slot-value menu 'title)))
    (when (%izerop (%get-byte tp)) (%put-word tp #x0120))
    ;(dbg 32)
    (setq mh (%setf-macptr (slot-value menu 'menu-handle)
                           (#_NewMenu  (slot-value menu 'menu-id) tp))))
  (dolist (item (slot-value menu 'item-list))
    (setq n (%i+ n 1))
    (install-menu-item mh item n))
  ;(dbg 34)
  (#_InsertMenu mh 0)
  (when (not (menu-enabled-p menu))
    (setf (slot-value menu 'enabledp) t) ; lie to assure it gets disabled << put back
    (menu-disable menu)))

(defun attach-menu (menu &aux (n 0) mh) ;No DrawMenuBar
  (let ((the-title (slot-value menu 'title)))
    (if (7bit-ascii-p the-title)
      (with-pstrs ((tp (if (eq (length the-title) 0) " " the-title)))
        ;(dbg 32)
        (setq mh (%setf-macptr (slot-value menu 'menu-handle)
                               (#_NewMenu  (slot-value menu 'menu-id) tp))))
      (rlet ((foo :ptr))
        (errchk (#_CreateNewMenu (slot-value menu 'menu-id) 0 foo))
        (setq mh (%get-ptr foo))
        (%setf-macptr (slot-value menu 'menu-handle) mh) ;; ??
        (set-menu-title-cfstring mh the-title))))
  (dolist (item (slot-value menu 'item-list))
    (setq n (%i+ n 1))
    (install-menu-item mh item n))
  ;(dbg 34)
  (#_InsertMenu mh 0)
  (when (not (menu-enabled-p menu))
    (setf (slot-value menu 'enabledp) t) ; lie to assure it gets disabled << put back
    (menu-disable menu)))


;; #_InsertMenuItemTextWithCFString

(defun insert-menu-item-cfstring (mh title n)
  (let* ((string (if (typep title 'encoded-string)(the-string title) title))
         (len (length string))
         (minus-sign (and (> len 1)(eq #\- (%schar string 0)) )))
    (declare (fixnum len))          
    (%stack-block ((sb (+ len len)))
      (copy-string-to-ptr string 0 len sb)      
      (if minus-sign (%put-word sb (char-code #\Ð) 0))
      (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) sb len)))
        (#_InsertMenuItemTextWithCFString mh cfstr (%i- n 1)
         0 ;; attributes
         0 ;; commandid
         )
        (#_cfrelease cfstr)))))

(defclass font-menu-item ()())  ;; bootstrap

(defun install-menu-item (mh item n)
  (let ((title (slot-value item 'title)))
    ;(push (list title n) horse)
    (when (typep title 'encoded-string)
      (if (eq (the-encoding title) #$kcfstringencodingunicode)
        (setq title (the-string title))
        (setq title (convert-string (the-string title) (the-encoding title) #$kcfstringencodingunicode))))
    (if (and (not (typep item 'font-menu-item))
             (not (7bit-ascii-p title)))
      (insert-menu-item-cfstring mh title n)
      (with-pstrs ((xp "xxx"))
        ;(#_appendMenu mh  xp)
        (#_InsertMenuItem mh xp (%i- n 1))
        (with-pstrs ((tp (if (eq 0 (length title)) " " title)))          
          (if (and (not (eql 1 (%get-byte tp)))
                   (eq (char-code #\-) (%get-byte tp 1)))
            ;(char-code (schar (convert-string (string #\Ð) 256 0) 0))
            (%put-byte tp 208 1)) ;; this was wrong 208 is roman (char-code #\Ð)
          (#_setmenuitemtext mh n tp)))))
  ;Looks like a job for a generic function...
  (cond ((typep item 'menu)
         (init-menu-id item)
         (#_SetItemCmd mh n #\escape)
          #-carbon-compat
         (#_SetItemMark mh n (%code-char (slot-value item 'menu-id)))
         #+carbon-compat
         (#_setmenuitemhierarchicalid mh n (slot-value item 'menu-id)))
        ((typep item 'menu-item)
         (if (slot-value item 'command-key)
           (set-command-key item (slot-value item 'command-key) n))
         (if (slot-value item 'checkedp)
           (set-menu-item-check-mark item (slot-value item 'checkedp) n))
         (let ((style (menu-item-style item)))
           (when (not (or (null style)(eq style :plain)))
             (set-menu-item-style item style n)))
         (let ((icon-num (menu-item-icon-num item)))
           (when (and icon-num (not (eql 0 icon-num)))
             (set-menu-item-icon-num item icon-num n)))
         (let ((script (menu-item-script item)))  ;; do we need this today?
           (when script
             (set-menu-item-script item script n)))
         (let ((icon-handle (menu-item-icon-handle item)))
           (when icon-handle
             (set-menu-item-icon-handle item icon-handle #+ignore (menu-item-icon-type item) n)))))
  (unless (menu-item-enabled-p item)
    (menu-item-disable item)))


(defmethod menu-deinstall ((menu menu) &aux mh md)
  (dolist (item (slot-value menu 'item-list))
    (when (typep item 'menu)
      (menu-deinstall item)))
  (when (setq md (slot-value menu 'menu-id))
    (deallocate-menu-id md)
    (setf (slot-value menu 'menu-id) nil))
  (when (setq mh (slot-value menu 'menu-handle))
    (#_DeleteMenu md)
    (#_DisposeMenu mh)
    (setf (slot-value menu 'menu-handle) nil)
    (setq %menubar (nremove menu %menubar))
    (draw-menubar-if))
  nil)

(defmethod menu-installed-p ((menu menu))
  (if (slot-value menu 'menu-handle) t))
#|
(setq poo nil)
(maphash #'(lambda (k v)(when (neq (slep.sld (car v))(carbonlib-sld)) (push v poo)))
         *shared-library-entry-points*)
|#
(defmethod menu-enable ((menu menu) &aux mh (owner (slot-value menu 'owner)))
  (when (not (menu-enabled-p menu))
    (if owner
      (when (setq mh (slot-value owner 'menu-handle))
        (let ((num (menu-item-number menu)))
          (setf (slot-value menu 'enabledp) t)
          #+carbon-compat
          (#_EnableMenuItem mh num)
          #-carbon-compat
          (#_EnableItem mh num)))
      (when (setq mh (slot-value menu 'menu-handle))
        (setf (slot-value menu 'enabledp) t)
        #-carbon-compat
        (#_EnableItem mh 0)
        #+carbon-compat
        (#_EnableMenuItem mh 0)
        (draw-menubar-if menu)))))

(defmethod menu-disable ((menu menu) &aux mh (owner (slot-value menu 'owner)))
  (when (menu-enabled-p menu)
    (if owner
      (when (setq mh (slot-value owner 'menu-handle))
        (setf (slot-value menu 'enabledp) nil)        
        (let ((num (menu-item-number menu)))
          #-carbon-compat
          (#_DisableItem mh num)
          #+carbon-compat
          (#_DisableMenuItem mh num)))
      (when (setq mh (slot-value menu 'menu-handle))
        (setf (slot-value menu 'enabledp) nil)
        #-carbon-compat
        (#_DisableItem mh 0)
        #+carbon-compat
        (#_DisableMenuItem mh 0)
        (draw-menubar-if menu)))))


; >> patch
(defmethod menu-update ((menu menu))
  (let ((updater (menu-update-function menu)))
    (if updater 
      (funcall updater menu)
      (update-menu-items menu))))

(defvar *updating-menus* nil)

(defmethod menu-update :around ((menu menu))
  (unless (memq menu *updating-menus*)
    (let ((*updating-menus* (cons menu *updating-menus*)))
      (declare (dynamic-extent *updating-menus*))
      (call-next-method))))

;; probably not needed
(defmethod menu-update ((menu t))
  nil)
#|
; b2 version
(defmethod menu-update ((menu menu))
  (let ((updater (menu-update-function menu)))
    (when updater (funcall updater menu)))
  (dolist (item (slot-value menu 'item-list))
    (menu-item-update item)))

; b3 kill it
(defmethod menu-update ((menu menu))
  (let ((updater (menu-update-function menu)))
    (cond (updater (funcall updater menu))
          (*modal-dialog-on-top* (menu-disable menu))
          (t  (menu-enable menu)))
    (when (not updater)
      (update-menu-items menu))))

; nother possibility
(defmethod menu-update ((menu menu))
  (let ((updater (menu-update-function menu)))
    (if updater 
      (funcall updater menu)
      (dolist (item (slot-value menu 'item-list))
        (menu-item-update item)))))

|#

#|
; I like this better - edit menu is the only caller
; leave alone if no menu items
(defun update-menu-items (menu)
  (let (;(enb (menu-enabled-p menu))
        on)
    (let ((items (slot-value menu 'item-list)))
      (when items
        (dolist (item (slot-value menu 'item-list))
          (menu-item-update item)
          (when (menu-item-enabled-p item)(setq on t)))
        (if (not on)
          (menu-disable menu)
          (menu-enable menu))))))
|#
#|
(defmethod update-menu-items ((menu edit-menu))
  (let ((enb (menu-enabled-p menu))
        on)
    (dolist (item (slot-value menu 'item-list))
      (if enb
        (progn 
          ;(menu-item-enable item) ; ??
          (menu-item-update item)
          (when (menu-item-enabled-p item)(setq on t)))
        (menu-item-disable item)))
    (when (and enb (not on))(menu-disable menu))))
|#



(defmethod update-menu-items ((menu menu))
  (let ((items (slot-value menu 'ccl::item-list)))
      (when items
        (dolist (item (slot-value menu 'ccl::item-list))
          (ccl:menu-item-update item)))))


(defun update-edit-menu-items (menu)
  (let (;(enb (menu-enabled-p menu))
        on)
    (let ((items (slot-value menu 'item-list)))
      (when items
        (dolist (item (slot-value menu 'item-list))
          (menu-item-update item)
          (when (menu-item-enabled-p item)(setq on t)))
        (if (not on)
          (menu-disable menu)
          (menu-enable menu))))))

#| folded into update-menus now
; >> patch - merge with update-menus?
(defun update-menus-for-modal (&optional what state
                                          &aux mob offset changed oldstate)
  (let ((*menubar-frozen* t))
    (with-macptrs ((mh (#_LMGetMenuList)))
      (setq offset (%hget-word mh))
      (while (%i> offset 0)
        (when (setq mob (menu-object (%hget-word (%hget-ptr mh offset))))
          (let ((before (menu-enabled-p mob)))
            (when (eq what :disable) (push before oldstate))            
            (menu-update-for-modal mob (if state
                                         (if (car state) :enable :disable)
                                         what))
            (when (neq before (menu-enabled-p mob))(setq changed t)))
          (setq state (cdr state)))
        (setq offset (%i- offset 6)))))
  (when changed (draw-menubar-if))
  (if oldstate (nreverse oldstate)))
|#

; >>Patch
(defmethod menu-update-for-modal ((menu menu) &optional what)
  (let ((updater (menu-update-function menu)))
    (cond (updater (funcall updater menu))
          (t (case what
               (:disable (menu-disable menu))
               (:enable (menu-enable menu)))))))
    

(defmethod menu-select ((menu menu) num)
  ;Use ELT because errs out if list too short...
  (menu-item-action (elt (slot-value menu 'item-list) (%i- num 1))))

;;;Menu-item objects

(defmethod initialize-instance :after ((menu-item menu-item)
                                       &key menu-item-colors
                                       owner
                                       (menu-item-title "Untitled")
                                       disabled
                                       command-key
                                       menu-item-checked
                                       style
                                       menu-item-action
                                       icon)
  (if (stringp menu-item-title)
    (setq menu-item-title (ensure-simple-string menu-item-title))
    (if (not (encoded-stringp menu-item-title))
      (report-bad-arg menu-item-title 'string))) ;; not really right
  (setf (slot-value menu-item 'color-list) menu-item-colors)
  (setf (slot-value menu-item 'owner) (when owner (require-type owner 'menu)))
  (setf (slot-value menu-item 'title) menu-item-title) ;(ensure-simple-string menu-item-title))
  (setf (slot-value menu-item 'enabledp) (not disabled))
  (setf (slot-value menu-item 'command-key) command-key)
        ;(when command-key (require-type command-key 'base-character)))
  (setf (slot-value menu-item 'checkedp) menu-item-checked)
  (if icon (set-menu-item-icon menu-item icon))
  (setf (slot-value menu-item 'style) style)
  (setf (slot-value menu-item 'menu-item-action)
        (require-type menu-item-action '(or function symbol))))

(defmethod menu-install ((item menu-element)) )

#|
(defmethod menu-item-number ((item menu-element) &aux owner)
  (when (setq owner (slot-value item 'owner))
    (1+ (position item (the list (slot-value owner 'item-list))
                  :test 'eq))))
|#


(defmethod menu-item-number ((item menu-element) &aux owner)
  (when (setq owner (slot-value item 'owner))
    (let ((n 0))
      (declare (fixnum n))
      (dolist (x (the list (slot-value owner 'item-list)))
        (setq n (1+ n))
        (when (eq x item)(return n))))))

(defmethod menu-item-action ((menu-item menu-item))
  (let ((action (slot-value menu-item 'menu-item-action)))
    (when action (funcall action))))



(defmethod menu-item-action ((menu menu))
  nil)

(defmethod menu-item-title ((item menu-element))
  (slot-value item 'title))

(defmethod set-menu-item-title ((item menu-element) new-title &aux owner)
  ;; font-menu-items are mac encoded with "what to say" determined by #_SetMenuItemFontID
  (if (and (not (typep item 'font-menu-item))
           (or (typep new-title 'encoded-string)
               (and (stringp new-title)(not (7bit-ascii-p new-title)))))
    (progn (setf (slot-value item 'title) new-title)
           (set-menu-item-title-with-cfstr item new-title))
    (progn 
      (setf (slot-value item 'title)
            (setq new-title (ensure-simple-string new-title)))
      (when (setq owner (slot-value item 'owner))
        (if (equalp new-title "-")
          (progn 
            (if (slot-value owner 'menu-handle) (with-menu-detached owner))
            (menu-item-disable item))
          (let ((num (menu-item-number item)))
            (if (slot-value owner 'menu-handle)
              (with-pstrs ((tp new-title))
                (if (%izerop (%get-byte tp)) (%put-word tp #x0120))
                (when (and (not (eql 1 (%get-byte tp)))
                           (eq (char-code #\-) (%get-byte tp 1)))
                  (%put-byte tp 208 1))  ; 208 is roman (char-code #\Ð)
                (#_SetMenuItemText (slot-value owner 'menu-handle) num tp))))))))
  new-title)

;; SetMenuItemTextWithCFString
(defun set-menu-item-title-with-cfstr (item new-title)
  (let ((owner (slot-value item 'owner)))
    (when owner 
      (let* ((real-string (if (typep new-title 'encoded-string)(the-string new-title) new-title))
             (new-len (length real-string))
             (num (menu-item-number item))
             (minus-sign (and (> new-len 1)(eq #\- (%schar real-string 0)))))
        (declare (fixnum new-len))        
        (%stack-block ((sb (%i+ new-len new-len)))
          (copy-string-to-ptr real-string 0 new-len sb)          
          (if minus-sign (%put-word sb (char-code #\Ð) 0))
          (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) sb new-len)))
            (#_SetMenuItemTextWithCFString (slot-value owner 'menu-handle) num cfstr)
            (#_cfrelease cfstr)))))))
     

(defmethod command-key ((item menu-element))
  nil)

(defmethod set-command-key ((item menu-element) new-key &optional num)
  (declare (ignore new-key num))
  )

(defmethod command-key ((item menu-item))
  (slot-value item 'command-key))


(defun set-hide-command-key (&key (others nil) (char #\H) (modifier :option))
  (when t ;(osx-p)
    (rlet ((out-menu :ptr)
           (out-index :unsigned-integer))
      (let ((err (#_getIndMenuItemWithCommandID *null-ptr* 
                  (if others #$kHICommandHideOthers #$kHICommandHide) 1 out-menu out-index)))
        (when (eq #$noerr err)
          (#_setMenuItemCommandkey (%get-ptr out-menu) (%get-unsigned-word out-index) nil (char-code char))
          (#_setMenuItemModifiers (%get-ptr out-menu) (%get-unsigned-word out-index)         
           (ecase modifier
             (:shift #$kMenuShiftModifier)
             ((:option :meta) #$kMenuOptionModifier )
             (:control #$kMenuControlModifier)
             ((nil) #$kMenuNoModifiers))))))))

(defun maybe-set-hide-command-key ()
  (when (eql (command-key *execute-item*) #\H)
    (set-hide-command-key)))
    

(pushnew 'maybe-set-hide-command-key *lisp-startup-functions*)
    

;; one modifier is all you get like '(:shift #\H)
(defmethod set-command-key ((item menu-item) new-key &optional item-num &aux mh owner)
  (let ((char (if (consp new-key) (second new-key) new-key))
        (mod (if (consp new-key) (first new-key)))
        (old-key (slot-value item 'command-key)))
    (declare (ignore-if-unused mod old-key))    
    ;(when char (setq char (require-type char 'base-character))) ;; ??    
    (setf (slot-value item 'command-key) new-key)
    (when (and (setq owner (slot-value item 'owner))
               (setq mh (slot-value owner 'menu-handle)))
      (when (not item-num)(setq item-num (menu-item-number item)))
      (#_SetItemCmd mh item-num (or char #\Null))
      #+carbon-compat
      (when (and (or mod old-key) (appearance-available-p))
        (#_setmenuitemmodifiers mh item-num
         (ecase mod
           (:shift #$kMenuShiftModifier)
           ((:option :meta) #$kMenuOptionModifier )
           (:control #$kMenuControlModifier)
           ((nil) #$kMenuNoModifiers)))))))

(defmethod menu-item-enable ((item menu-item) &aux mh owner)
  (when (or (typep (slot-value item 'title) 'encoded-string)(not (string= "-" (slot-value item 'title))))
    (when t ;(if (osx-p) t (not (menu-item-enabled-p item))) ; sometimes select all is permanently disabled on OSX - gag      
      (if (and (setq owner (slot-value item 'owner))
               (setq mh (slot-value owner 'menu-handle)))
        (progn (setf (slot-value item 'enabledp) t)
               #-carbon-compat
               (#_EnableItem mh (menu-item-number item))
               #+carbon-compat
               (#_EnableMenuItem mh (menu-item-number item))
               )))))

(defmethod menu-item-enable ((menu menu)) (menu-enable menu))

; enabledp is nil but the darn thing is enabled!
(defmethod menu-item-disable ((item menu-element) &aux mh owner)
  (when t ;(menu-item-enabled-p item) ; WHY? - rearranged a little - does that fix it    
    (if (and (setq owner (slot-value item 'owner))
             (setq mh (slot-value owner 'menu-handle)))
      (progn 
        (setf (slot-value item 'enabledp) nil)
        #-carbon-compat
        (#_DisableItem mh (menu-item-number item))
        #+carbon-compat
        (#_DisableMenuItem mh (menu-item-number item))))))

(defmethod menu-item-disable ((menu menu)) (menu-disable menu))

#|
(defmethod menu-item-enabled-p ((item menu-element))
  (slot-value item 'enabledp))
|#

(defmethod menu-item-enabled-p ((menu menu)) (menu-enabled-p menu))

(defmethod set-menu-item-enabled-p ((item menu-element) value)
  (if value
    (menu-item-enable item)
    (menu-item-disable item))
  value)


(defmethod menu-item-check-mark ((item menu-element))
  (slot-value item 'checkedp))

(defmethod set-menu-item-check-mark ((item menu-element) mark &optional item-num &aux mh owner)
  (setq mark
        (cond ((characterp mark) mark)
              ((fixnump mark) (code-char mark))
              ((eq t mark) #\CheckMark)
              ((not mark) nil)
              (t (report-bad-arg mark '(or character (member t nil))))))
  (when (or (not (null mark))(not (eql mark (menu-item-check-mark item))))
    (setf (slot-value item 'checkedp) mark)
    (when (and (setq owner (slot-value item 'owner))
               (setq mh (slot-value owner 'menu-handle)))
      (#_SetItemMark  mh (or item-num (menu-item-number item)) (or mark #\Null)))
    mark))

(defmethod set-menu-item-style ((item menu-element) newstyle &optional item-num  &aux mh owner)
  (when (and (setq owner (slot-value item 'owner))
             (setq mh (slot-value owner 'menu-handle)))
    (#_SetItemStyle mh (or item-num (menu-item-number item)) (style-arg newstyle)))
  (setf (slot-value item 'style) newstyle))

(defmethod menu-item-update ((item menu-element))
  (let ((updater (menu-item-update-function item)))
    (when updater
      (funcall updater item)
      t)))

(defmethod menu-item-update ((menu menu)) (menu-update menu))

(defmethod set-menu-item-icon-num ((item menu-item) icon-num &optional item-num)
  (unless (or (null icon-num) (<= 0 icon-num 255))
    (setq icon-num (require-type icon-num '(integer 0 255))))
  (setf (menu-item-icon-num-slot item) icon-num)
  (let* ((owner (menu-item-owner item))
         (mh (and owner (menu-handle owner))))
    (when mh
      (#_SetItemIcon mh (or item-num (menu-item-number item)) (or icon-num 0))))
  icon-num)


(defvar *appearance-available-p* nil)

(def-ccl-pointers appearance ()
  (setq *appearance-available-p* 
        (let ((flags (gestalt #$gestaltAppearanceAttr)))
          (when (and flags
                     (logbitp #$gestaltAppearanceExists flags))
            t))))

(defun appearance-available-p ()
  *appearance-available-p*)

(defun set-icon-type-from-ostype (item ostype)
  (let ((icon-type (slot-value item 'menu-item-icon-type)))
    (when (null icon-type)
      (setq icon-type
            (ecase ostype
              ((NIL) #$kMenuIconSuiteType)
              (:ICON #$kMenuShrinkIconType)
              (:SICN #$kMenuSmallIconType)
              (:|cicn| #$kMenuColorIconType)))
      (setf (slot-value item 'menu-item-icon-type) icon-type))))
  
(defmethod menu-item-icon-handle ((item menu-item))
  (let ((slot (slot-value item 'menu-item-icon-handle)))
    (when slot
      (if (consp slot)
        (let ((handle (car slot)))
          (when (not (handlep handle)) 
            (setq handle (#_getresource (second slot)(third slot)))            
            (rplaca slot handle)))
        (progn
          (when (handlep slot)
            (let ((icon-ostype (get-icon-ostype slot)))
              (setf (slot-value item 'menu-item-icon-handle)(list slot icon-ostype (get-icon-id slot)))              
              ))))
      (let ((now-slot (slot-value item 'menu-item-icon-handle)))
        (when (and now-slot (not (slot-value item 'menu-item-icon-type)))
          (set-icon-type-from-ostype item (second now-slot)))
        (car now-slot)))))


(defmethod set-menu-item-icon-handle ((item menu-item) icon-handle &optional #+ignore icon-type item-num)
  #+ignore
  (unless (or (null icon-type)  (<= 0 icon-type 255))
    (setq icon-type (require-type icon-type '(integer 0 255))))
  (unless (or (null icon-handle)(handlep icon-handle))  ;; dead macptr?
    (setq icon-handle (require-type icon-handle '(satisfies handlep))))
  (if icon-handle
    (let ((slot (slot-value item 'menu-item-icon-handle)))
      (when (or (not (consp slot))(not (eql (car slot) icon-handle)))
        (let ((ostype (get-icon-ostype icon-handle))
              (id (get-icon-id icon-handle)))
          (cond ((not (consp slot))
                 (setf (menu-item-icon-handle-slot item) (list icon-handle ostype id)))
                (t (rplaca slot icon-handle)
                   (rplaca (cdr slot) ostype)
                   (rplaca (cddr slot) id))))))
    (setf (menu-item-icon-handle-slot item) icon-handle))
  #+ignore (setf (menu-item-icon-type item) icon-type)
  (let* ((owner (menu-item-owner item))
         (mh (and owner (menu-handle owner))))
    (when mh
      (cond ((and (appearance-available-p)(ppc-target-p)
                  #+ignore ;; not needed
                  (let* ((slep (get-shared-library-entry-point "SetMenuItemIconHandle")))
                    (ignore-errors (resolve-slep-address slep))))
             ;; need appearancelib - doesn't work for 68K
             (#_SetMenuItemIconHandle 
              mh 
              (or item-num (menu-item-number item))
              (or (menu-item-icon-type item) (get-icon-type-num icon-handle))
              (or icon-handle #+ppc-target 0 #-ppc-target (%null-ptr))))
            (t
             (let ((id (cond ((handlep icon-handle)
                              ;; this doesn't work for id < 256
                              (- (get-icon-id icon-handle) 256))
                             ((null icon-handle) 0)
                             (t icon-handle))))
               (#_setitemicon mh (or item-num (menu-item-number item)) id))))))
  icon-handle)

;; nil means use type of given icon, 0 means no icon 2 means shrink
(defmethod set-menu-item-icon-type ((item menu-item) icon-type &optional item-num)
  (unless (or (null icon-type)  (<= 0 icon-type 255))
    (setq icon-type (require-type icon-type '(integer 0 255))))
  (setf (menu-item-icon-type-slot item) icon-type)  
  (when (appearance-available-p)
    (let* ((owner (menu-item-owner item))
           (mh (and owner (menu-handle owner)))
           (icon-handle (menu-item-icon-handle item)))
      (when (and mh icon-handle)
        (#_SetMenuItemIconHandle
         mh 
         (or item-num (menu-item-number item)) 
         (or icon-type (get-icon-type-num icon-handle))
         icon-handle))))
  icon-type)
  

(defun get-icon-id (icon)
  (require-type icon '(satisfies handlep))
  (when (logbitp 5 (the fixnum (#_HGetState icon)))  ;; its a resource
    (%stack-block ((rname 256)
                   (rtype 4)
                   (rid 2))
      (#_GetResInfo icon rid rtype rname)
      (%get-word rid))))

;; from Terje N.
(defun get-icon-ostype (icon)
  ;(assert (handlep icon))
  (when (logbitp 5 (the fixnum (#_HGetState icon)))
    (%stack-block ((rname 256)
                   (rtype 4)
                   (rid 2))
      (#_GetResInfo icon rid rtype rname)
      (%get-ostype rtype))))

(defun get-icon-type-num (icon)
  (if (null icon)
    #$kMenuNoIcon
    (ecase (get-icon-ostype icon)
      ((NIL) #$kMenuIconSuiteType)
      (:ICON #$kMenuIconType)
      (:SICN #$kMenuSmallIconType)
      (:|cicn| #$kMenuColorIconType))))

(defmethod set-menu-item-script ((item menu-item) script &optional item-num)
  (setf (menu-item-script-slot item) script)
  (let ((system-script (#_GetScriptManagerVariable #$smSysScript)))
    (when (neq script system-script)
      (when (null item-num)(setq item-num (menu-item-number item)))
      (let* ((owner (menu-item-owner item))
             (mh (and owner (menu-handle owner))))
        (if (or (not (appearance-available-p))
                #+ignore (let* ((slep (get-shared-library-entry-point "SetMenuItemTextEncoding")))                                       
                                  (not (ignore-errors (resolve-slep-address slep)))))
          (progn  
            (when mh
              (#_setitemicon mh item-num (or script 0)))
            (cond ((null script)
                   (set-command-key item nil item-num))
                  (t (set-command-key item (code-char #x1c) item-num))))          
          (when mh
            (#_SetMenuItemTextEncoding mh item-num (or script 0))))))  ;; ??
    script))
    
      


;; Idea from terje N.

(defmethod set-menu-item-icon ((item menu-item)(icon-handle macptr)
                               &optional item-num)  
  (set-menu-item-icon-handle item icon-handle item-num))

(defmethod set-menu-item-icon ((item menu-item)(icon-handle null)
                               &optional item-num)
  (set-menu-item-icon-handle item nil item-num)
  (when (not (eql (command-key item) (code-char #x1c)))
    (set-menu-item-icon-num item nil item-num)))

(defmethod set-menu-item-icon ((item menu-item)(icon-num fixnum)
                               &optional item-num)
  (set-menu-item-icon-num item icon-num item-num))

(defmethod set-menu-item-icon ((item menu-item)(icon-info cons)
                               &optional item-num)
  ;; list of handle-or-nil ostype id
  (when (or (not (eq (length icon-info) 3))(not (ostype-p (second icon-info))))
    (error "Illegal icon arg ~S to set-menu-item-icon" icon-info))
  (let ((handle (car icon-info)))
    (when (not (handlep handle))
      (setq handle (#_getresource (second icon-info)(third icon-info)))
      (rplaca icon-info handle))
    (set-menu-item-icon-handle item handle item-num)))
#| ;; test

(setq m (make-instance 'menu :menu-items (list (setq i (make-instance 'menu-item :menu-item-title "Foo" :icon
                                                              (list nil :ICON 131))))))
(menu-install m)

(set-menu-item-icon-type i #$kMenuShrinkIconType)

(set-menu-item-icon-type i NIL)
|#


;;;;; window menu-items

(defclass window-menu-item (menu-item) ())


; Bootstrapping version. Real one in "ccl:lib;windoids".

(unless (fboundp 'get-window-event-handler)
  (%fhave 'get-window-event-handler #'(lambda () (front-window))))


(defmethod menu-item-action ((item window-menu-item))
  (let ((action (slot-value item 'menu-item-action))
        (w (get-window-event-handler)))
    (when action
      (funcall action w))))

(defmethod menu-item-update ((item window-menu-item))
  (unless (call-next-method) ; i.e. does menu-element method deal with it
    (let ((action (slot-value item 'menu-item-action)))
      (when (or (non-nil-symbol-p action)
                (typep action 'generic-function))
        (dim-if-undefined item action)))))

(defmethod dim-if-undefined ((item window-menu-item) sym &aux wob)
  (if (and (setq wob (get-window-event-handler))
           (or (method-exists-p sym wob)
               (let ((handler (current-key-handler wob)))
                 (and handler (method-exists-p sym handler)))))
    (menu-item-enable item)
    (menu-item-disable item)))

(defclass windows-menu-menu-item (menu-item)
  ((my-window :initarg :window)))

(defmethod menu-item-action ((item windows-menu-menu-item))
  (let ((window (slot-value item 'my-window))
        wptr)
    (without-interrupts
     (when (setq wptr (wptr window))       
       (when (#_iswindowcollapsed wptr)
         (#_collapsewindow wptr nil)
         (window-bring-to-front window)
         ;; who knows why tf this is needed
         (when t #|(osx-p)|# (#_bringtofront wptr)))
       (window-select window)
       (when (shift-key-p)
         (window-ensure-on-screen window))))
    (when (control-key-p)
      (let* ((windows (windows :class (class-of window)))
             (n 1))
        (dolist (win windows)
          (when (neq win window)(set-window-layer win n)(incf n)))))))

;;apple-menu
;
; used for creating menus with da's appended

(defclass apple-menu (menu)
  ()
  (:default-initargs :menu-title #.(string #\applemark))
  )

#| Not needed
(defmethod add-menu-items ((menu apple-menu) &rest menu-items)
  (declare (ignore menu-items))
  (let ((*menubar-frozen* t))
    (with-menu-detached menu
      (call-next-method)))
  (draw-menubar-if))
|#

(defmethod menu-install ((menu apple-menu))
  (progn
    (unless (and (slot-value menu 'menu-id)
                 (macptrp (slot-value menu 'menu-handle)))
      (setf (slot-value menu 'menu-handle) nil)
      (setq %menubar nil))
    (unless (slot-value menu 'menu-handle)
      (let ((*menubar-frozen* t)
            (mbar (menubar)))
        (call-next-method)
        
        (progn
          ;(dbg 64)
          #-carbon-compat ;; causes menu-items to appear twice
          (#_AppendResMenu (slot-value menu 'menu-handle) "DRVR")
          ;(dbg 65)
          (dolist (x mbar)
            (menu-install x))))
      (draw-menubar-if))))

(defmethod menu-deinstall ((menu apple-menu))
  ;;The apple menu cannot be removed by the user (it causes multifinder
  ;;to overwrite random memory).
  ;;*menubar-frozen* is true only for system code, it is used when adding
  ;;menu-items to the apple menu (seems not to confuse multifinder).
  nil)

(defmethod menu-select ((menu apple-menu) item)
  (if (<= item (length (slot-value menu 'item-list)))
    (call-next-method)
    #-carbon-compat
    (rlet ((str (:string 255)))
      (#_GetMenuItemText (slot-value menu 'menu-handle) item str)
      (#_OpenDeskAcc str)
      (let ((front (front-window)))
        (when (typep front 'da-window)
          (unselect-windows t)
          (setq *selected-window* front))))))


    
; end of L1-menus.lisp


#|
	Change History (most recent last):
	2	12/23/94	akh	fix update-menus-for-modal again
	3	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
