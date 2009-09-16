(in-package :ccl)

;;; search for font, style, and or color
;;; akh@tiac.net 12/20/99
;;; ctrl-meta-s searches for font of current position.
;;; ctrl-meta-shift-s creates or selects a dialog to allow choosing font, style, and color with possible
;;;  "wild cards".
;;; The Edit menu item "Find Font…" does the same.
;;; For fancier feedback in dialog (like red or shadow) do:
(eval-when (:compile-toplevel :execute)
  (pushnew :font-feedback *features*))
;;;  before executing or compiling this file

(defparameter *font-search-mask* (cons #xffffffff 0))
;; font mask #xffff0000
;; face mask #xff00
;; color mask #xff

(defclass font-pop-up (font-menu pop-up-menu)())

(defmethod menu-update ((menu font-pop-up)) nil)

(defmethod attribute ((item menu-item)) nil)  ;; i.e. not a font-menu-item

(defclass font-dialog (dialog)())  ;; much as I dislike windoids there is a case for having this be one

(defparameter *very-light-gray* #xeeeeee)

;; find blue text or whatever -  find font like where we're at  now
;; uses masks set by dialog or initial values if never reset.

(defmethod ed-find-this-font-again ((w fred-mixin))
  (let* ((buffer (fred-buffer w))
         (pos (buffer-position buffer))
         (ffmask (car *font-search-mask*))
         (msmask (cdr *font-search-mask*)))
    (multiple-value-bind (sel-b sel-e)(selection-range w)
      (if (and (not (eql sel-b sel-e))
               (eql sel-e pos))
        (setq pos (if (eql pos 0) 0 (1- pos)))))
    (let ((lc *last-command*))
      (if (and lc (consp lc)(eq (car lc) 'failed-font))
        (let ((ff (second lc))
              (ms (third lc)))
          (window-top w)
          (do-font-search-sub w ff ms ffmask msmask))        
        (multiple-value-bind (ff ms)(buffer-char-font-codes buffer pos)
          (if (eql (buffer-position buffer)(buffer-size buffer))
            (progn
              (set-fred-last-command w (list 'failed-font ff ms))
              (ed-beep))            
            (let ((found-p (do-font-search-sub w ff ms ffmask msmask)))
              (when (not found-p)
                (set-fred-last-command w (list 'failed-font ff ms))))))))))

;;; search for font specified by dialog - we don't do size

(defmethod do-font-search ((w fred-mixin) ff ms)
  (let* ((ffmask (car *font-search-mask*))
         (msmask (cdr *font-search-mask*)))
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
          ))
      start-pos)))

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


(defun font-search-action (item &optional to-top)
  (let* ((dialog (view-window item))
         (font-pu (view-named 'font-pop-up dialog))
         (color-pu (view-named 'color-pop-up dialog))
         (style-pu (view-named 'style-pop-up dialog))
         (font 0)
         (style 0)
         (color 0))
    (let* ((num (pop-up-menu-default-item font-pu))
           (font-item (nth (1- num) (menu-items font-pu))))
      (if (not (attribute font-item))  ;; i.e. any font
        (progn  (setf (car *font-search-mask*) #xFFFF))
        (progn (setf (car *font-search-mask*) #xffffffff)
               (setq font (font-number-from-name-simple (attribute font-item))))))
    (let* ((num (pop-up-menu-default-item color-pu))
           (color-item (nth (1- num) (menu-items color-pu))))
      (if (not (attribute color-item))
        (setf (car *font-search-mask*) (logand (car *font-search-mask*) #xffffff00))
        (setq color (second (car (attribute color-item))))))    
    (let* ((num (pop-up-menu-default-item style-pu))
           (style-item (nth (1- num) (menu-items style-pu))))
      (if (not (attribute style-item))
        (setf (car *font-search-mask*) (logand (car *font-search-mask*) #xffff00ff))
        (setq style (style-arg (attribute style-item)))))
    (let* ((window (front-window-that-isnt dialog)) ;(target))
           (key-handler (if window (current-key-handler window))))
      (if (typep key-handler 'fred-mixin)
        (progn
          (if to-top (window-top key-handler))
          (do-font-search key-handler 
                          (logior (ash font 16)(ash style 8) color)
                          0))
        (ed-beep)))))


(defun font-dialog (w &optional ff ms)
  (declare (ignore w ms))
  (let ((dialog (or (front-window :class 'font-dialog)
                    (make-font-dialog))))
    (window-select dialog)
    (let ((font-pop-up (view-named 'font-pop-up dialog))
          (color-pop-up (view-named 'color-pop-up dialog))
          (style-pop-up (view-named 'style-pop-up dialog)))
      (when ff
        (let* ((font-name (font-name-from-ff ff))
               (style (logand #xff (ash ff -8)))
               (color (logand #xff ff)))
          (let* ((pos (position font-name
                                (menu-items font-pop-up)
                                :key #'menu-item-title
                                :test #'string-equal)))
            (set-pop-up-menu-default-item font-pop-up (1+ pos)))
          (let ((pos (position color
                               (menu-items color-pop-up)
                               :key #'(lambda (item)
                                        (when (attribute item)
                                          (second (car (attribute item)))))
                               :test 'eql)))
            (when (not pos)
              ;; not there so add it
              (let ((new-item  (make-instance 'font-menu-item
                                 :menu-item-title "New Color"
                                 :attribute (list (list :color-index color)))))
                (set-part-color new-item :item-title (color-index-to-color color))
                (add-menu-items color-pop-up new-item)
                (setq pos (1- (length (menu-items color-pop-up))))))
            (set-pop-up-menu-default-item color-pop-up (1+ pos))
            #+:font-feedback
            (menu-item-action (elt (menu-items color-pop-up) pos))
            )
          (let ((pos (position style
                               (menu-items style-pop-up)
                               :key #'(lambda (item)
                                        (when (attribute item)
                                          (style-arg (attribute item))))
                               :test 'eql)))
            (set-pop-up-menu-default-item style-pop-up (1+ pos))
            #+:font-feedback
            (menu-item-action (elt (menu-items style-pop-up) pos))
            ))))))

(defun color-index-to-color (color-index)
  (rlet ((rgb :rgbcolor))
    (fred-color-index->rgb color-index rgb)
    (rgb-to-color rgb)))

(defun font-name-from-ff (ff)
  (rlet ((np (:string 256)))
    (#_getfontname (point-v ff) np)
    (%get-string np)))

(defun make-font-dialog ()
  (let ((font-pop-up (make-instance 'font-pop-up ;:menu-title "Font: "
                                    :view-position #@(54 10)
                                    :menu-colors `(:menu-body ,*very-light-gray*)  ;,*tool-back-color*) ;; lighter still
                                    :view-nick-name 'font-pop-up
                                    ))
        (color-pop-up (make-instance 'font-pop-up ;:menu-title "Color:"
                                     :view-position #@(54 40)
                                     :menu-colors `(:menu-body ,*very-light-gray*)
                                     :view-nick-name 'color-pop-up))
        (style-pop-up (make-instance 'font-pop-up ;:menu-title "Style:"
                                     :view-position #@(54 70)
                                     :menu-colors `(:menu-body ,*very-light-gray*)
                                     :view-nick-name 'style-pop-up))
        (search-button (make-instance 'button-dialog-item :dialog-item-text "Search"
                                      :view-position #@(17 104)
                                      :default-button t
                                      :dialog-item-action #'(lambda (item) (font-search-action item))))
        (from-top-button (make-instance 'button-dialog-item :dialog-item-text "From Top"
                                        :view-position #@(107 104)
                                        :dialog-item-action #'(lambda (item) (font-search-action item t))))
        ;; Static text vs menu-titles to avoid the possible color of menu-title or font-codes of menu.
        ;; Also makes alignment simpler.
        (font-label (make-instance 'static-text-dialog-item :view-position #@(10 10)
                                   :dialog-item-text "Font:"))
        (color-label (make-instance 'static-text-dialog-item :view-position #@(10 40)
                                   :dialog-item-text "Color:") )
        (style-label (make-instance 'static-text-dialog-item :view-position #@(10 70)
                                   :dialog-item-text "Style:")))
    
    (let ((*font-menu* font-pop-up))
      (add-font-menus))
    (add-menu-items font-pop-up (make-instance 'menu-item :menu-item-title "-")
                    (make-instance 'font-menu-item :menu-item-title "Any Font" :attribute nil))
    (add-font-color-items color-pop-up)
    (add-menu-items color-pop-up (make-instance 'menu-item :menu-item-title "-")
                    (make-instance 'font-menu-item :menu-item-title "Any Color" :attribute nil))
    (add-font-style-items style-pop-up)
    (add-menu-items style-pop-up (make-instance 'menu-item :menu-item-title "-")
                    (make-instance 'font-menu-item :menu-item-title "Any Style" :attribute nil))
    (let* ((fs (view-default-size font-pop-up))
           (cs (view-default-size color-pop-up))
           (ss (view-default-size style-pop-up))
           (hmax (max (point-h fs)(point-h cs)(point-h ss))))
      (set-view-size font-pop-up hmax (point-v fs))
      (set-view-size color-pop-up hmax (point-v cs))
      (set-view-size style-pop-up hmax (point-v ss))      
      (make-instance 'font-dialog  :window-title "Font Search"
                     :view-size (make-point (max 202 (+ hmax 58)) 140)
                     :view-position '(:right 20)
                     :back-color *tool-back-color*
                     :view-subviews (list font-label font-pop-up color-label color-pop-up 
                                          style-label style-pop-up search-button from-top-button)))))
         
      

(defmethod ed-setup-find-font ((w fred-mixin))
  (let* ((buffer (fred-buffer w))
         (pos (buffer-position buffer)))
    (multiple-value-bind (sel-b sel-e)(selection-range w)
      (if (and (not (eql sel-b sel-e))
               (eql sel-e pos))
        (setq pos (if (eql pos 0) 0 (1- pos)))))
    (multiple-value-bind (ff ms)(buffer-char-font-codes buffer pos)
      (font-dialog w ff ms))))

;; c-m-r is already used

;; search for ff of current pos (or (1- end-of selection)) masked by dialog settings if there were any
(def-fred-command (:control :meta #\s) ed-find-this-font-again)

;; show or create the dialog for font choices and searching
(def-fred-command (:control :meta :shift #\s) ed-setup-find-font)

;; maybe
(when (not (find-menu-item (edit-menu) "Find Font…"))
  (add-menu-items (edit-menu)
                  (make-instance 'window-menu-item
                    :menu-item-title "Find Font…"
                    :update-function
                    #'(lambda (menu-item)
                        (let* ((w (front-window))
                               (item (and w (current-key-handler w))))
                          (if (typep item 'fred-mixin)
                            (menu-item-enable menu-item)
                            (menu-item-disable menu-item))))
                    :menu-item-action
                    #'(lambda (w)
                        (ed-setup-find-font (current-key-handler w))))))

#+:font-feedback
(defmethod menu-item-action :around ((item font-menu-item))
 (let ((owner (menu-item-owner item)))
   (if (typep owner 'font-pop-up)
     (progn
       (when (eq (view-nick-name owner) 'color-pop-up)
         (let ((attribute (attribute item))
               (color *black-color*))
           (when (consp attribute)
             (setq color (color-index-to-color (second (car attribute)))))
           ;; too bad :menu-title encompasses so much - less now
           (set-part-color owner :menu-title color)))
       (when (eq (view-nick-name owner) 'style-pop-up)
         (let ((attribute (or (attribute item) :plain)))
           (set-view-font-codes owner (ash (style-arg attribute) 8) 0 #xff00 0)
           (invalidate-view owner))) 
       t)
     (call-next-method))))       


(provide :font-search)


