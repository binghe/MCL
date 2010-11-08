;; Modernize the MCL menus!

(in-package :ccl)

;; Eliminate redundant non-standard menu item:

(remove-menu-items *tools-menu* 
 (find-menu-item *tools-menu* "Search/Replace…"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; New "Debug" menu:

(defvar *debug-menu* (make-instance 'menu :menu-title "Debug"))

(let* ((menubar (menubar))
       (split (position (find-menu "Tools") menubar))) 
  (set-menubar
   (append 
    (subseq menubar 0 split)
    (list *debug-menu*)
    (subseq (menubar) split))))

(let* ((items (subseq (menu-items *lisp-menu*) 3)))
  (apply #'remove-menu-items *lisp-menu* items)
  (apply #'add-menu-items *debug-menu* items))

(let ((item (find-menu-item *tools-menu* "Backtrace")))
  (remove-menu-items *tools-menu* item)
  (add-new-item *debug-menu* "-")
  (add-menu-items *debug-menu* item))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Improved "Lisp" menu:(load (merge-pathnames "set-command-key-patch.lisp" (loading-file-source-file)))

(defclass ed-menu-item (window-menu-item)())

(defmethod menu-item-action ((item ed-menu-item))
  (let ((action (slot-value item 'menu-item-action))
        (w (current-key-handler (get-window-event-handler))))
    (when action
      (funcall action w))))

(add-new-item *lisp-menu* "Documentation" #'ed-get-documentation
   :class 'ed-menu-item
   :command-key (list :no-command :control #\H)) ;  #$kMenuHelpGlyph))   ;;  originally c-x-c-d 

(comtab-set-key *comtab*  '(:control #\h)             'ed-get-documentation)

(add-new-item  *lisp-menu* "Definition" #'ed-edit-definition 
 :class 'ed-menu-item
 :command-key '(:no-command :control #\.))  ;; was opt-.

(assert (not (comtab-get %initial-comtab% '(:control #\.))))

(add-new-item  *lisp-menu* "Callers" #'ed-edit-callers 
 :class 'ed-menu-item
 :command-key '(:no-command :control #\C))

(add-new-item  *lisp-menu* "Inspect" #'ed-info-current-sexp ;; how does it differ from help: ed-inspect-current-sexp? not much!
 :class 'ed-menu-item
 :command-key '(:no-command :control #\I)) ;; originally c-x-c-i

;; Note that the patch for menukey-modifiers-p is required for C-I not to be mixed with with C-tab.

(assert (not (comtab-get %initial-comtab% '(:control #\i))))

(add-new-item  *lisp-menu* "-")

(add-new-item  *lisp-menu* "Macroexpand" #'ed-macroexpand-1-current-sexp
 :class 'ed-menu-item
 :command-key '(:no-command :control #\M)) ;; set to c-m in MCL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; New "Help" menu:

(eval-when (:load-toplevel :execute)
  (unless (find-menu "Help")
    
    (defvar *help-menu* (make-instance 'menu :menu-title "Help"))
    
    (set-menubar (append (menubar) (list *help-menu*)))
    
    ((lambda (&rest items)
       (apply #'remove-menu-items *tools-menu* items)
       (apply #'add-menu-items *help-menu* items)) 
     (find-menu-item *tools-menu* "Fred Commands")
     (find-menu-item *tools-menu* "Listener Commands"))
    
    (remove-menu-items *tools-menu* (first (last (menu-items *tools-menu*))))
    (set-menu-item-title (find-menu-item *help-menu* "Fred Commands") "Editor Commands")
    
    ;; move report bug item
    
    (let ((report-item (find-menu-item *tools-menu* "Create Bug Report")))
      (remove-menu-items *tools-menu* report-item)
      (set-menu-item-title report-item "Make Report")
      (add-menu-items *debug-menu* report-item)
      (remove-menu-items *tools-menu* (first (last (menu-items *tools-menu*))))))
  
  ) ; end redefine


