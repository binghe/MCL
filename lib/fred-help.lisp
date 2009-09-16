;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  1 7/18/96  akh  new file - from fred-additions
;;  (do not edit before this line!!)


(in-package :ccl)

;; Copyright 1996 Digitool, Inc. The 'tool rules!

;;
;; Modification History
;; vdc key-cap use draw-string-in-rect-with-options
;; ------ 5.2b4
;; moveto - dont do :long
;; fix bsubstringp
;; bsubstringp calls unicode-string-compare vs string-compare
;; --------- 5.1 final
;; set-view-size of window focuses for good measure
;; ---------- 5.1b2
;; 05/05/04 use scrolling-fred-view-with-frame
;; 04/08/04 use wait-mouse-up-or-moved vs mouse-down-p
;; with-timer in view-click-event-handler ((view key-cap)
;; --------- 5.1b1
;; theme-background for dialogs
;; -------- 4.4b3
;; 08/23/96 bill  sieve-table calls (invalidate-view table) unless nothing changed.
;;

;;;;;;;;;;;;;
;; stuff for fred-commands dialog - was in fred-additions

(defun ed-listener-help (&optional ignore)
  (declare (ignore ignore))
  (ed-help nil t))

(defclass key-cap (simple-view)
  ((:down-p :initarg :down-p :initform nil :accessor key-cap-down-p)
   (:key-name :initarg :key-name :initform nil :accessor key-cap-name)
   (:color-list :initarg :part-color-list :initform `(:body ,*white-color*)
                :reader part-color-list)))

(defmethod part-color ((key-cap key-cap) key)
  (getf (part-color-list key-cap) key))

(defmethod view-draw-contents ((view key-cap))
  (with-font-focused-view (view-container view)
    (let ((down-p (key-cap-down-p view))
          (pos (view-position view)))
      (with-back-color (part-color view :body)
        (rlet ((rect :rect
                     :topleft pos
                     :bottomright (add-points pos (view-size view))))
          ;(#_eraserect rect)
          (#_framerect rect)
          (#_insetrect rect 2 2)
          (#_eraserect rect)
          (#_framerect rect)        
          (let ((name (key-cap-name view)))
            (rlet ((text-rect :rect
                              :topleft (add-points pos #@(2 4))
                              :bottomright  (pref rect :rect.bottomright)))
              (when name
                ;; justification only works if truncation or max-width also specified - fixed now
                (draw-string-in-rect name text-rect :justification :center :truncation :none))
              (when down-p (#_invertrect rect)))))))))


(defmethod view-click-event-handler ((view key-cap) where)
  (declare (ignore where)); (call-next-method))
  (set-key-cap-down-p view t)
  (let* ((w (view-window view)))
    (sieve-table w)
    (with-event-processing-enabled ;let-globally ((*processing-events* nil))
      ; let em be drawn
      (event-dispatch))
    (let ((c (view-container view)))
      (with-timer
        (loop       
          (when (not (and  (wait-mouse-up-or-moved)(view-contains-point-p view  (view-mouse-position c))))
            (return)))
        (set-key-cap-down-p view nil)
        (sieve-table w)))))

(defmethod set-key-cap-down-p ((view key-cap) which)
  (let ((old (key-cap-down-p view)))
    (when (neq old which)
      (setf (key-cap-down-p view) which)
      (view-draw-contents view)
      t)))

(defclass ed-help-window (window)
  ((:char :initform nil :accessor ed-help-char)))

(defmethod window-null-event-handler ((w ed-help-window))
  ; kind of pokey
  (call-next-method)
  (when (window-active-p w)
    (let* ((keypad (view-named 'keypad w)))      
      (unless  (#_stilldown)
        (when 
          (or
           (set-key-cap-down-p (view-named 'shift keypad) (shift-key-p))
           (set-key-cap-down-p (view-named 'control keypad) (control-key-p))
           (set-key-cap-down-p (view-named 'meta keypad) (option-key-p)))
          (sieve-table w))))))


(defmethod set-view-size ((w ed-help-window) h &optional v)
  (declare (ignore h v))
  (with-focused-view w
    (let ((old-size (view-size w)))
      (call-next-method)
      (let* ((table (view-named 'table w))
             (new-size (view-size w))
             (keypad (view-named 'keypad w))
             (fred (view-named 'fred w))
             (fred-title (view-named 'fred-title w))
             (string-item (view-named 'string-item w))
             (point-delta (subtract-points new-size old-size))
             ph)
        (set-view-position keypad (setq ph
                                        (- (point-h new-size)
                                           (point-h (view-size keypad))
                                           6))
                           (point-v (view-position keypad)))
        (set-view-size string-item (- ph (point-h (view-position string-item)) 14)
                       (point-v (view-size string-item)))      
        (set-view-size table (add-points (view-size table) point-delta))
        (let ((fsize (view-size fred))
              (fpos (view-position fred))
              (tpos (view-position fred-title)))
          (set-view-position fred-title (point-h tpos)(+ (point-v tpos) (point-v point-delta)))
          (set-view-position fred (point-h fpos)(+ (point-v fpos) (point-v point-delta)))
          (set-view-size fred (+ (point-h fsize)(point-h point-delta))
                         (point-v fsize)))))))

; like a snail
(defun bsubstringp (a b end start)
  (declare (optimize (speed 3)(safety 0)))
  (let* ((alen (length a))
         (charn (%schar a (%i- alen 1)))
         (c-up (char-upcase charn))
         (c-down (if (neq c-up charn) charn (char-downcase charn))))
    (declare (fixnum end start alen))
    (while (%i< start end)
      (let ((char (%schar b (%i- end 1))))
        (when (or (eq char c-up)(eq char c-down))
          (when (or (eq alen 1)
                    (eq t (unicode-string-compare a b 0 (%i- alen 1) (%i- end  alen) (%i- end 1))))
            (return-from bsubstringp end)))
        (setq end (%i- end 1))))))

(defun sieve-table (w)  
  (let* ((table (view-named 'table w))
         (items (original-table-sequence table))
         (str (dialog-item-text (view-named 'string-item w)))
         (strlen (length str))
         (keypad (view-named 'keypad w))
         (char (ed-help-char w))
         ;(*string-compare-script* #$smroman)
         (ctrl (key-cap-down-p (view-named 'control keypad))) ; (control-key-p)
         (meta (key-cap-down-p (view-named 'meta keypad)))   ;(option-key-p))
         (shift (key-cap-down-p (view-named 'shift keypad))))  ;(shift-key-p))         
    (if (and (eq 0 strlen)(not ctrl)(not meta)(not shift)(not char))
      (when (not (eq (table-sequence table) items))
        (set-table-sequence table items))
      (let* ((vect (temp-table-vector table))
             tstr tlen graphic-not-alpha changed-p) 
        (when char
          (let ((real-char (code-char char)))
            (setq tstr (dialog-item-text (view-named 'ed-help-key keypad))
                  tlen (length tstr)
                  graphic-not-alpha (and (graphic-char-p real-char)
                                         (not (alpha-char-p real-char))))))
        (when (null vect)
          (setq vect (make-array (length items) :fill-pointer 0))
          (setf (temp-table-vector table) vect))        
        (setf (fill-pointer vect) 0)
        (dolist (item items)
          (let* ((len (length item))
                 (end len)
                 (start (- len (%apropos-substring-p "  "  item)))) ; assume "  " is found
            (when (or (eq 0 strlen)
                      (let ((spos (%apropos-substring-p str item)))
                        (and spos (%i<= (%i- len spos) start))))
                (when (and
                       (or (not char)                           
                           (and (setq end (bsubstringp tstr item len start))
                                (or
                                 (and (%i< end len) ; e.g. c-x mumble                                  
                                      (eq  (%schar item end) #\space))
                                 (and (eq end len)
                                      (case (%schar item (%i- (%i- len tlen) 1))
                                        ((#\space #\-) t))))))
                       (or (not shift)
                           graphic-not-alpha
                           (setq end (bsubstringp "shift-" item end start)))
                       (or (not meta)
                           (setq end (bsubstringp "m-" item end start)))
                       (or (not ctrl)
                           (setq end (bsubstringp "c-" item end start))))
                  (unless changed-p
                    (let ((length (length vect)))
                      (when (and (< length (array-total-size vect))
                                 (neq item (aref vect length)))
                        (setq changed-p t))))
                  (vector-push-extend item vect)))))
        (set-table-sequence table vect)
        (when changed-p (invalidate-view table))))
    (dialog-item-action table)))

(defclass ed-help-key (editable-text-dialog-item)())

(defmethod view-key-event-handler ((v ed-help-key) char)
  ; phooey - modifiers don't cause events
  ; so window-null-event-handler gets to do it.
  (let ((w (view-window v)) keystroke)
    (#_seteventmask (- #$everyevent 0)) ;$autokeymask))
    (setq keystroke (event-keystroke (rref *current-event* eventrecord.message)
                                     (rref *current-event* eventrecord.modifiers)))
    (setq char (logand (logior $functionkeymask #xff) keystroke))    
    (when (neq (ed-help-char w) char)
      (setf (ed-help-char w) char)      
      (setq char (code-char (logand #xff char)))    
      (set-dialog-item-text v (if (logbitp $functionkeybit keystroke)
                                (%str-cat "f-" (string char))
                                (if (eq char #\Return) "Return"
                                    (or (char-name char) (string char)))))
      (#_seteventmask (- #$everyevent #$autokeymask))
      (sieve-table w)
      )))

; ?? we like having key go away on keyup because it is trivial to revert to original table,
; and it seems more like "Key Caps" 
; we don't like it because it is awkward to get the doc from an elt of the table subset - 
; Especially because the ff'ing auto repeat is still enabled which causes the table to ed-beep.
; Perhaps we could eschew the beep - which is done by view-key-evt simple-view
; Maybe cell is selected when there is only one elt in sequence - and/or enter key handler
; (key) blows away its contents 
; You can't use Delete to get rid of it!@ cause he is a key too.
; could make meta-. work for selected cell in table - if you're clever you will discover that
; it works in the doc window.
; Todays alternative makes it easier to select an item of the subsequence - but you have to
; know to reselect the key to nuke it, and thus revert to full sequence?

(defmethod window-key-up-event-handler ((w ed-help-window))
  (let ((phoo (view-named 'ed-help-key (view-named 'keypad w))))
    (when (or (eq (current-key-handler w) phoo)) ;(ed-help-char w))
      (setf (ed-help-char w) nil)       
      (set-dialog-item-text phoo "")
      (sieve-table w)
      (#_seteventmask (- #$everyevent #$keyupmask)))))


(defmethod view-activate-event-handler ((v ed-help-key))
  (call-next-method)
  (window-key-up-event-handler (view-window v)))

#|
(defmethod view-mouse-leave-event-handler ((v ed-help-key))
  (#_seteventmask (- #$everyevent  #$keyupmask)))


(defmethod exit-key-handler ((v ed-help-key) other)
  (declare (ignore other))
  ;(#_seteventmask (- #$everyevent  #$keyupmask))
  t)
; this is not called when a modal dialog appears
(defmethod view-deactivate-event-handler ((v ed-help-key))
  (call-next-method)
  ;(#_seteventmask (- #$everyevent  #$keyupmask))
  )

(defmethod enter-key-handler ((v ed-help-key) other)
  (declare (ignore other))
  (#_seteventmask (- #$everyevent 0)) ;#$autokeymask))
  nil)
|#


(defmethod window-close :before ((w ed-help-window))
  (when (string-equal (window-title w) "Fred commands")
    (let ((it *fred-help-window-size&pos*))
      (rplaca it (view-size w))
      (rplacd it (view-position w)))))

; to do - listener-help doesnt remember size gets pos from fred-help
; do we want to just show what applies to current state of the modifier keys?
; the position of the phoo-view should be a function of the tab stop in the items - don't bother

(defun ed-help (&optional ignore listener-p)
  (declare (ignore ignore))
  (when (not (find-class 'listener nil)) (setq listener-p nil))
  (let* ((title (if listener-p "Listener Commands" "Fred Commands"))        
        (d (find-window title 'ed-help-window))
        string)
    (if d 
      (window-select d)
      (let ((items  (make-ed-help-items (if listener-p *listener-comtab* *comtab*)))
            (pos (cdr *fred-help-window-size&pos*)))
        (if listener-p (setq pos (add-points pos #@(15 15))))
        (setq d (make-instance 'ed-help-window
                  :window-show nil
                  :back-color *tool-back-color*
                  :theme-background t
                  :window-title title
                  :window-type :document-with-grow
                  :view-size #@(370 282)
                  :view-position pos
                  :help-spec (if listener-p 15100 15090)
                  :view-subviews
                  (list               
                   (make-instance 'filtered-arrow-dialog-item
                     :view-nick-name 'table
                     :view-size #@(355 112)
                     :view-position #@(8 70)
                     :help-spec 15096
                     ;:table-hscrollp nil ; t doesn't work
                     :dialog-item-action #'update-ed-help-doc
                     :original items
                     :table-sequence items)
                   (make-instance 'static-text-dialog-item
                     :view-font '("geneva" 10 :bold)
                     :view-position #@(5 189)
                     :view-nick-name 'fred-title
                     :dialog-item-text "Documentation")
                   (make-instance 'scrolling-fred-view-with-frame
                     :h-scrollp nil
                     :allow-tabs nil
                     :view-nick-name 'fred
                     :buffer-chunk-size 128
                     :part-color-list `(:body ,*white-color*)
                     :view-size #@(356 63)
                     :view-position #@(7 203)
                     :help-spec 15097)
                   (make-instance 'static-text-dialog-item
                     :view-font '("geneva" 10 :bold)
                     :view-position #@(5 4)
                     :dialog-item-text "Function")
                   (make-instance 'static-text-dialog-item
                     :view-font '("geneva" 10 :bold)
                     :view-position #@(5 26)
                     :dialog-item-text "Contains:")
                   (make-instance 'view ; 'phoo
                     :view-nick-name 'keypad
                     :view-font '("geneva" 10) ; :bold) ;*fred-default-font-spec*
                     :view-subviews
                     (list
                      (make-instance 'static-text-dialog-item
                        :view-position #@(0 0)
                        :dialog-item-text "Keystroke"
                        :view-font '("geneva" 10 :bold))                        
                      (make-instance 'key-cap
                        :view-nick-name 'shift
                        :key-name "Shift"
                        :help-spec 15092
                        :view-size #@(60 20)
                        :view-position #@(0 16))  ; 0
                      (make-instance 'key-cap
                        :view-nick-name 'control
                        :key-name "Ctrl"
                        :help-spec 15093
                        :view-size #@(40 20)
                        :view-position #@(0 36))
                      (make-instance 'key-cap
                        :view-nick-name 'meta
                        :key-name "Meta"
                        :help-spec 15094
                        :view-size #@(40 20)
                        :view-position #@(40 36))
                      (make-instance 'static-text-dialog-item
                        :view-font '("Geneva" 9 :bold) ;*fred-default-font-spec*
                        :view-size #@(60 13)
                        :view-position #@(86 22)
                        :dialog-item-text "Key:")
                      (make-instance 'ed-help-key
                        :view-nick-name 'ed-help-key                    
                        :dialog-item-text ""
                        :help-spec 15095
                        :view-font *fred-default-font-spec*
                        :allow-returns t
                        :allow-tabs t
                        :view-size #@(60 13)
                        :view-position #@(88 40)))
                     :view-position #@(205 4)
                     :view-size #@(155 56))
                   ; this fellow wants a comtab with no control meta or shift
                   ; i.e. self-insert + arrows delete and rubout
                   (setq string
                   (make-instance 'editable-text-dialog-item
                     :view-nick-name 'string-item
                     :view-position #@(9 45)
                     :view-font *fred-default-font-spec*
                     :view-size #@(120 12)
                     :help-spec 15091
                     :dialog-item-action
                     #'(lambda (item)
                         (sieve-table (view-window item))))))))
        (if listener-p 
          (set-view-size d #@(320 269))
          (set-view-size d (car *fred-help-window-size&pos*)))
        (dialog-item-action (view-named 'table d))
        ;(set-table-sequence (view-named 'table d) items)
        (set-current-key-handler d string)
        (window-select d)))))

(defun update-ed-help-doc (item)
  (let* ((cell (selected-cell-contents item))
         (container (view-container item))
         thing)
    (when container
      (let* ((output (fred-item (view-named 'fred container))))
        (when (neq cell (table-last-cell item))
          (setf (table-last-cell item) cell)
          (set-dialog-item-text output "")
          (if (not cell)
            (fred-update output)            
            (progn
              (setq thing (read-from-string cell))
              (view-put output :right-margin (- (point-h (view-size output)) 10))
              (show-documentation thing output))))
        (when (and cell (double-click-p))(edit-definition (or thing (read-from-string cell))))))))

              

; (pprint (make-ed-help-items *comtab*))
; (pprint (make-ed-help-items initial-control-x-comtab))

; works ok as long as key names in c-x comtab are not longer than main comtab
(defun make-ed-help-items (comtab &optional title-prefix (max 0)
                                  &aux items (data (comtab-data comtab)))
  (if (find-class 'listener nil)
    (if (eq comtab *listener-comtab*)
      (setq data (mapcan #'(lambda (item)
                             (when (not (equalp (comtab-get-key %initial-comtab% (car item))
                                                (comtab-get-key comtab (car item))))
                               (list item)))
                         data))
      (setq data (copy-list data))))
  (setq items (sort data
                    #'(lambda (cmd1 cmd2)
                        (let ((c1 (%code-char (logand #xff (car cmd1))))
                              (c2 (%code-char (logand #xff (car cmd2)))))
                          ; put all the digits except function-digit at end
                          (cond ((and (digit-char-p c1)
                                      (not (%ilogbitp 10 (car cmd1))) ; function
                                      (not (digit-char-p c2)))
                                 nil)
                                ((and (digit-char-p c2)
                                      (not (%ilogbitp 10 (car cmd2)))
                                      (not (digit-char-p c1)))
                                 t)
                                (t (char-lessp c1 c2)))))))
  (dolist (item items)
    (let ((fn (cadr item)))
      (when (symbolp fn)
        (setq max (max max (length (symbol-name fn)))))))
  (let ((the-str (make-array 60 :element-type 'base-character :fill-pointer 0 :adjustable t)))
    ; cut the garbage by a factor of 4
    (setq items
          (mapcan
           #'(lambda (item)
               (cond ((typep (cadr item) 'comtab)
                      (make-ed-help-items (cadr item) (keystroke-code-string (car item))))
                     (t (list
                         (let ((fn (cadr item)))
                           ;(setf (fill-pointer the-str) 0)
                           (labels ((coerce-to-string (fn)
                                      (cond ((symbolp fn) (symbol-name fn))
                                            ((fixnump fn)
                                             (%str-cat (keystroke-code-string fn)
                                                       " Same as"))
                                            ((functionp fn) (coerce-to-string (function-name fn)))
                                            (t (prin1-to-string fn)))))
                             (with-output-to-string (stream the-str)
                               (stream-write-entire-string stream (coerce-to-string fn))
                               (let ((pos (stream-column stream)))
                                 (dotimes (i (- (+ 2 max) pos))
                                   (stream-tyo stream #\space)))
                               (when title-prefix 
                                 (stream-write-entire-string stream title-prefix)
                                 (stream-tyo stream #\space))
                               (format-keystroke (car item) stream)
                               (get-output-stream-string stream ))))))))
           items))))


(defun keystroke-code-string (code)
  (with-output-to-string (stream) (format-keystroke code stream)))

(let ((comtab %initial-comtab%))
  (comtab-set-key comtab '(:control #\/)         'ed-help)
  (comtab-set-key comtab '(:control #\?)         'ed-help)
)