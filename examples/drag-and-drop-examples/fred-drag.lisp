
(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Drag-Aware Fred & Listener
;;;
;;; Theory:  Fred in MCL 3.0 and higher is a window composed of one or more
;;;          editing views (the panes).  There are two types of panes used,
;;;          fred-item and window-fred-item, but for our purposes they perform
;;;          the same thing.
;;;
;;;          For MCL 3.0, a subclass of 'drag-view-mixin is created and named
;;;          'drag-aware-fred-mixin.  Then a subclass of 'window-fred-item is
;;;          created, both inheriting from 'drag-aware-fred-mixin.  For MCL 2.0,
;;;          we sublcass 'fred-window and make it inherit from 'drag-aware-fred-mixin
;;;          as well.  With this scheme, we can write fred-specific drag methods,
;;;          all specialized on 'drag-aware-fred-mixin, and they will work with
;;;          both kinds of fred views.
;;;
;;;          Listener windows are fred windows, too.  The same kind of subclassing
;;;          scheme used for the fred editor windows are used for Listeners.
;;;
;;;          Most of the code differences between fred in 2.0 and 3.0 is accounted
;;;          for here with compiler macros.
;;;
;;;          Functions are provided that bring up a single example of either
;;;          a fred or Listener window, as well as functions that set the
;;;          respective default editor classes to drag-aware versions.
;;;
;;;          Normally, only text flavors are provided for outbound drags.
;;;          However, if you hold down the Control key before starting the
;;;          drag, fred will also promise an HFS flavor.  If the example has
;;;          to create temporary files (if you drop something onto an application
;;;          icon, for instance) then they will appear on your desktop.
;;;
;;;          For inbound drags:  If you hold down the Control key, the windows
;;;          will accept HFS flavors and promised HFS flavors -- no text flavors
;;;          flavors.  If the Control key is up then the windows accept HFS
;;;          flavors and text.
;;;
;;;          There is one obvious visual problem with this code.  It appears when
;;;          the source fred view has been scrolled during a drag, and then the drag
;;;          is rejected (such as attempting to drop the selection into itself).  It
;;;          turns out that the Drag Manager and fred have different ideas about
;;;          "scrolling" (specifically, fred doesn't scroll the way Mac views normally
;;;          scroll).  The result is that the outlined drag region will zoom back to
;;;          a different place.  There is no harm in this, though.
;;;
;;; NOTE:    This module implements two functions from processes.lisp, a contribution
;;;          from Bill St. Clair.  In order to prevent more loading than necessary,
;;;          those two functions are duplicated here.  They are defined within
;;;          a form that first tests for the presence of those functions, and defines
;;;          them only if they are not currently defined.  This will ensure that,
;;;          if you have already loaded (a possibly newer) processes.lisp then these
;;;          functions will not inadvertently overwrite them.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; handle :|utxt|
;; launch-app-with-docs use fsrefs, pretty much a copy of launch-application (in processes.lisp)
;; ------ 5.2b6
;;; 08/26/05  (require :processes) vs redefining fns therein, use %path-to-fsspec or make-fsref-from-path 
;;; with-pointers -> with-dereferenced-handles
;;; akh no more aedesc.datahandle

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :drag-and-drop)
  ;; below uses #_ppcbrowser which ain't defined in CarbonLib
  (require :appleevent-toolkit)
  
  (export '(fred-d
            enable-fred-d
            disable-fred-d
            
            listener-d
            enable-listener-d
            disable-listener-d
            
            drag-aware-fred-window			; 2.0 and higher fred subclass
            
            drag-aware-listener-window			; 2.0 and higher listener subclass
            ))
  
  #+ccl-3 (export '(drag-aware-window-fred-item		; 3.0 and higher fred subclass
                    drag-aware-listener-fred-item	; 3.0 and higher listener subclass
                    ))
  
  (add-feature :drag-aware-fred)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Constants & such
;;
(defconstant $fr.selrgn
  #-powerpc 27
  #+powerpc (if (boundp 'fr.selrgn) fr.selrgn 27)
  )

(defconstant $FredPromisedHFSFlavor :|frdf|)

(defconstant $ccl-file-creator 
  #-ccl-3 :|CCL2|
  #+ccl-3(if (boundp '*ccl-file-creator*) *ccl-file-creator* :|CCL2|)
  )

(defun %%fred-selection-region (fred-view)
  (fr.selrgn (frec fred-view)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Class definitions.
;;

;; This is the basic subclass we'll be hanging specialized methods off of.
(defclass drag-aware-fred-mixin (drag-view-mixin)
  ((dr-insert-offset :initform 0 :accessor dr-insert-offset)
   (dr-insert-point :initform nil :accessor dr-insert-point))   ; used to correctly place multiple drop files
  (:default-initargs
    :drag-allow-copy-p t
    :drag-allow-move-p t
    :drag-auto-scroll-p t
    :drag-accepted-flavor-list nil   ; use a specialization of #'drag-accepted-flavor-list
    )
  )

#+ccl-3 (progn     ;; fred overrides for MCL 3.0 and higher
          
          ;; create a drag-aware subclass of fred-item
          (defclass drag-aware-window-fred-item (window-fred-item
                                                 drag-aware-fred-mixin)
            ())
          
          ;; need to make a new window class so it knows to populate itself with
          ;; the drag-aware fred items
          (defclass drag-aware-fred-window (fred-window)
            ()
            (:default-initargs
              :fred-item-class 'drag-aware-window-fred-item
              )
            )
          
          ;; necessary specialization to accomodate the creation of a new
          ;; drag-aware fred window
          (defmethod window-make-parts ((w drag-aware-fred-window) &rest initargs)
            (apply #'call-next-method w :fred-item-class 'drag-aware-window-fred-item initargs))
          
          (defclass drag-aware-listener-fred-item (listener-fred-item
                                                   drag-aware-fred-mixin)
            ())
          
          (defclass drag-aware-listener-window (listener)
            ()
            (:default-initargs
              :fred-item-class 'drag-aware-listener-fred-item
              )
            )
          
          )

#-ccl-3 (progn     ;; fred overrides for MCL 2.0
          
          ;; make a new fred window class
          (defclass drag-aware-fred-window (fred-window drag-aware-fred-mixin)
            ())
          
          (defclass drag-aware-listener-window (listener drag-aware-fred-mixin)
            ())
          
          )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Hooks to make the examples work
;;

;; brings up one drag-aware fred window
(defun fred-d ()
  (if *drag-manager-present-p*
    (make-instance 'drag-aware-fred-window)
    (error "Drag Manager not installed")))

;; changes the default editor to drag-awareness
(defun enable-fred-d ()
  (if *drag-manager-present-p*
    (progn
      (setf *default-editor-class* (find-class 'drag-aware-fred-window))
      t)
    (error "Drag Manager not installed")))

;; changes the default editor back to the way it was
(defun disable-fred-d ()
  (if *drag-manager-present-p*
    (progn
      (setf *default-editor-class* (find-class 'fred-window))
      t)
    (error "Drag Manager not installed")))

(defun listener-d ()
  (if *drag-manager-present-p*
    (make-instance 'drag-aware-listener-window)
    (error "Drag Manager not installed")))

(defun enable-listener-d ()
  (if *drag-manager-present-p*
    (progn
      (setf *default-listener-class* (find-class 'drag-aware-listener-window))
      t)
    (error "Drag Manager not installed")))

(defun disable-listener-d ()
  (if *drag-manager-present-p*
    (progn
      (setf *default-listener-class* (find-class 'listener))
      t)
    (error "Drag Manager not installed")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Methods for 'drag-aware-fred-mixin
;;

;; We dynamically change the list of acceptable drag flavors based on whether
;; the user is holding down the control key or not.  If the control key is down,
;; we accept HFS flavors and promised HFS flavors; if the control key is up,
;; we accept HFS flavors and text.
(defmethod drag-accepted-flavor-list ((view drag-aware-fred-mixin))
  (if (drag-control-key-p)
    (list #$flavorTypePromiseHFS #$flavorTypeHFS)
    (list :|TEXT| :|utxt| #$flavorTypeHFS)))

;; Fred views in MCL 3.0 are actually somewhat bigger than their parent views,
;; so we need to slightly adjust the drag hilite region to accomodate.  If we
;; didn't the hilite would just barely be seen.
#+ccl-3 (defmethod drag-make-drag-hilite-region ((view drag-aware-fred-mixin)
                                                 &optional
                                                 (topleft nil) (bottomright nil))
          (declare (ignore topleft bottomright))
          (let ((region (call-next-method)))
            ; chop off two pixels all the way around the region
            (setf region (inset-region region 2 2))
            region))

;; Need to explicitly set the corners for an MCL 2.0 fred window.
#-ccl-3 (defmethod drag-make-drag-hilite-region ((view drag-aware-fred-mixin)
                                                 &optional
                                                 (topleft nil) (bottomright nil))
          (declare (ignore topleft bottomright))
          (let ((adjusted-size (subtract-points (view-size view)
                                                (make-point 15 15))))
            (call-next-method view (make-point 0 0) adjusted-size)))

;; We claim that the user can drag something if it's selected, so check the
;; mouse to see if we're in the selection region.
(defmethod drag-selection-p ((view drag-aware-fred-mixin) mouse-position)
  (point-in-region-p (%%fred-selection-region view) mouse-position))

;; Allow drawing of the caret unless the mouse is within the original
;; selection that is being dragged around.
(defmethod drag-draw-caret-p ((view drag-aware-fred-mixin))
  (if (and (drag-within-sender-view-p)
           (point-in-region-p (%%fred-selection-region view)
                              (drag-mouse-position view)))
    nil
    t))

;; The caret position should be at the closest character, not wherever the
;; mouse is.
(defmethod drag-caret-position-from-mouse ((view drag-aware-fred-mixin)
                                           local-mouse-position)
  (let ((char-pos (fred-point-position view local-mouse-position)))
    (make-point (fred-hpos view char-pos) (fred-vpos view char-pos))))

;; Draw the caret.  We ignore the 'shown-p argument because this type of
;; drawing automatically erases if you draw it twice in the same location.
(defmethod drag-draw-caret ((view drag-aware-fred-mixin) local-position shown-p)
  (declare (ignore shown-p))
  (let ((line-num 0)
        (v-bottom 0)
        (v-top 0))
    #+ccl-3 (setf line-num (nth-value 1 (%screen-point-line-pos (frec view) local-position)))
    #-ccl-3 (setf line-num (- (buffer-line (fred-buffer view)
                                           (fred-point-position view local-position))
                              (buffer-line (fred-display-start-mark view))))
    (if line-num
      (progn
        (setf v-bottom (fred-line-vpos view line-num))
        (if (plusp line-num)
          (setf v-top (or (fred-line-vpos view (1- line-num)) 0)))
        (incf v-top))
      (multiple-value-bind (ascent descent width leading) (font-info (view-font view))
        (declare (ignore width))
        (setf v-top (fred-vpos view (buffer-size (fred-buffer view))))
        (if (minusp v-top)
          (setf v-top 1)
          (setf v-top (- v-top (+ ascent leading))))
        (setf v-bottom (+ v-top ascent descent leading))))
    (with-pen-saved
      (pen-normal view)
      (set-pen-pattern view *gray-pattern*)
      (set-pen-mode view :notPatXor)
      (set-pen-size view 1 1)
      (move-to view (point-h local-position) (1+ v-top))
      (line-to view (point-h local-position) (1+ v-bottom)))))

;; We provide only one drag item -- the selection -- and we claim that
;; we will provide only standard ASCII text.  Note that we are only
;; promising the text, not actually delivering it at this time.  It
;; is immeasureably faster this way, particularly if a lot of the
;; text has been selected for dragging.
;; today only provide utf-16 text
(defmethod drag-add-drag-contents ((view drag-aware-fred-mixin))
  (if (control-key-p)
    (progn
      ;(drag-promise-hfs-flavor 1 $ccl-file-creator :|TEXT| #$flavorTypePromiseHFS $FredPromisedHFSFlavor)
      (drag-promise-hfs-flavor 1 $ccl-file-creator :|utxt| #$flavorTypePromiseHFS $FredPromisedHFSFlavor)))    
  ;(drag-promise-item-flavor 1 :|TEXT|)
  (drag-promise-item-flavor 1 :|utxt|)  
  (drag-create-item-bounds view 1 (%%fred-selection-region view))
  t)

;; A destination application has said it wanted the text we were
;; promising, so we deliver it here.  Note the specialization of the
;; 'flavor argument; if we decide to promise a different flavor, we
;; only create a new method, not modify this one.  Much more
;; modular.  You don't have to do it that way, though....  Also note
;; that we're using a real Macintosh pointer for the temporary buffer.
;; This could be a %stack-block macro instead, but then there would
;; be a 32K ceiling on what we could drag.
;;
;; After providing the data, check to see if the drop was into the
;; Finder Trash; if it was, delete it from the view.
#+ignore
(defmethod drag-fulfill-promise ((view drag-aware-fred-mixin)
                                 (item-reference integer)
                                 (flavor (eql :|TEXT|))
                                 target-description)
  (let ((handled-p nil))
    (with-cursor *watch-cursor*
      (multiple-value-bind (start end) (selection-range view)
        (let* ((size (- end start))
               (buffer (#_NewPtr size)))
          (unless (%null-ptr-p buffer)
            (unwind-protect
              (progn
                (dotimes (counter size)
                  (%put-byte buffer    ;; wrong if not 7bit-ascii
                             (char-code (buffer-char (fred-buffer view)
                                                     (+ start counter)))
                             counter))
                (drag-set-item-flavor item-reference flavor buffer size)
                (setf handled-p t))
              (#_DisposePtr buffer))))
        (when (eql (car target-description) :finder-trash)
          (ed-delete-with-undo view start end)
          (fred-update view))))
    handled-p))



(defmethod drag-fulfill-promise ((view drag-aware-fred-mixin)
                                 (item-reference integer)
                                 (flavor (eql :|utxt|))
                                 target-description)
  (let ((handled-p nil))
    (with-cursor *watch-cursor*
      (multiple-value-bind (start end) (selection-range view)
        (declare (fixnum start end))
        (let* ((size (- end start))
               (buffer (#_NewPtr (+ size size))))
          (declare (fixnum size))
          (unless (%null-ptr-p buffer)
            (unwind-protect
              (progn
                (dotimes (counter size)
                  (%put-word buffer
                             (char-code (buffer-char (fred-buffer view)
                                                     (%i+ start counter)))
                             (%i+ counter counter)))
                (drag-set-item-flavor item-reference flavor buffer (+ size size))
                (setf handled-p t))
              (#_DisposePtr buffer))))
        (when (eql (car target-description) :finder-trash)
          (ed-delete-with-undo view start end)
          (fred-update view))))
    handled-p))

;; The user must have held down the Control key, 'cause the destination
;; is requesting an HFS file.  Here we go....
(defmethod drag-fulfill-promise ((view drag-aware-fred-mixin)
                                 (item-reference integer)
                                 (flavor (eql $FredPromisedHFSFlavor))
                                 target-description)
  (let ((handled-p nil)
        (dest-folder (cdr target-description)))
    (when (pathnamep dest-folder)
      (with-cursor *watch-cursor*
        (multiple-value-bind (start end) (selection-range view)
          ; write the file to the destination folder
          (let ((dest-path (%fred-make-drag-file view dest-folder start end)))
            (drag-set-hfs-flavor item-reference $FredPromisedHFSFlavor dest-path))
          ; see if the drop was in the trash, if so then delete original stuff
          (when (eql (car target-description) :finder-trash)
            (ed-delete-with-undo view start end)
            (fred-update view))
          (setf handled-p t))))
    handled-p))

;; A drag from my view was cancelled, but let's see where it went.  If
;; the user dropped the selection on an alias of the Finder Trash then
;; we should delete the text.  If the drop was onto an application icon
;; or an AppleScript applet, we need to create a temp file and force
;; the other app to open the temp file.  In either case, be sure to
;; return t so the drag handlers will provide the "zoom back" animation
;; and the user will know the drag was handled.
(defmethod drag-cancel-new-drag ((view drag-aware-fred-mixin) eventrecord)
  (declare (ignore eventrecord))
  (let ((handled-p nil)
        (target (drag-get-target-description t)))
    (let ((dest-path (cdr target))
          (desktop (findfolder #$kuserdomain :|desk|)))
      (when (and (pathnamep dest-path) desktop)
        (with-cursor *watch-cursor*
          ; make sure destination is an application or AppleScript applet
          (rlet ((fsref :fsref)
                 (catinfo :fscataloginfo))
            (when (make-fsref-from-path dest-path fsref)                   
              (if (eql (#_FSGetCatalogInfo fsref #$KFSCatInfoFinderinfo 
                        catinfo (%null-ptr)(%null-ptr)(%null-ptr)) #$noErr)
                (when (or (eql (pref catinfo :FSCataloginfo.FinderInfo.filetype) :|APPL|)
                          (eql (pref catinfo :FSCataloginfo.FinderInfo.filetype) :|adrp|)) ;; $kApplicationAliasType
                  (multiple-value-bind (start end) (selection-range view)
                    ; create temp file on the desktop
                    (let ((temp-file (%fred-make-drag-file view desktop start end)))
                      ; switch to the application, giving it the file, possibly launching it first
                      (rlet ((psn :processSerialNumber))
                        (declare (ignore-if-unused psn))
                        (if nil ;(find-process (pref  catinfo :FSCataloginfo.FinderInfo.filecreator) psn)
                          (progn
                            (switch-application (pref catinfo :FSCataloginfo.FinderInfo.filecreator) temp-file)
                            (#_SetFrontProcess psn))
                          (launch-app-with-docs dest-path temp-file)))))
                  (setf handled-p t))))))))
    (when (eql (car target) :finder-trash)
      (multiple-value-bind (start end) (selection-range view)
        (ed-delete-with-undo view start end)
        (fred-update view)))
    handled-p))

;; Initializes an internal slot that keeps track of moved & copied items during
;; a drop.  The value will be used to offset the 'insert-cell slot in the case
;; of multiple dropped items; it helps guarantee that they appear in the right
;; order.
(defmethod drag-receive-drop-setup ((view drag-aware-fred-mixin))
  (setf (dr-insert-offset view) 0
        (dr-insert-point view) nil))

;; Here is the method for receiving drops.  Note the specialization of the
;; 'flavor argument.  We've chosen to specialize this particular method
;; instead of one of the "lower level" methods so we don't have to worry
;; about iterating through the drag items or any of that -- just deal with
;; the text flavor.
(defmethod drag-receive-dropped-flavor ((view drag-aware-fred-mixin)
                                        (flavor (eql :|TEXT|))
                                        (data-ptr macptr) (data-size integer)
                                        (item-reference integer))
  (declare (ignore item-reference))
  (unless (and (drag-get-source-view)
               (eql (view-window view) (view-window (drag-get-source-view)))
               (point-in-region-p (%%fred-selection-region view)
                                  (drag-mouse-position view)))
    (unless (dr-insert-point view)
      (setf (dr-insert-point view) (fred-point-position view (drag-mouse-drop-position view))))
    (let ((new-string nil)
          (text-deleted-p nil)
          (insert-pos (+ (dr-insert-point view) (dr-insert-offset view))))
      (setf new-string (%str-from-ptr-in-script data-ptr data-size))
      (when (and (drag-get-source-view)
                 (eql (view-window view) (view-window (drag-get-source-view)))
                 (not (drag-copy-requested-p)))
        (multiple-value-bind (begin end) (selection-range (drag-get-source-view))
          (ed-delete-with-undo (drag-get-source-view) begin end t nil nil)
          (setf text-deleted-p t)
          (if (>= insert-pos end)
            (decf insert-pos (- end begin))
            (if (> insert-pos begin)
              (setf insert-pos begin)))))
      (ed-insert-with-undo view new-string insert-pos text-deleted-p)
      ; update the offset slot in case there are more incoming items
      (incf (dr-insert-offset view) data-size)
      (set-selection-range view insert-pos (+ insert-pos data-size))
      #+ccl-3 (set-current-key-handler (view-window view) view nil)
      (fred-update view)
      (invalidate-view view))
    t))

(defmethod drag-receive-dropped-flavor ((view drag-aware-fred-mixin)
                                        (flavor (eql :|utxt|))
                                        (data-ptr macptr) (data-size integer)
                                        (item-reference integer))
  (declare (ignore item-reference))
  (unless (and (drag-get-source-view)
               (eql (view-window view) (view-window (drag-get-source-view)))
               (point-in-region-p (%%fred-selection-region view)
                                  (drag-mouse-position view)))
    (unless (dr-insert-point view)
      (setf (dr-insert-point view) (fred-point-position view (drag-mouse-drop-position view))))
    (let ((new-string nil)
          (text-deleted-p nil)
          (insert-pos (+ (dr-insert-point view) (dr-insert-offset view))))
      (setf new-string (make-string (ash data-size -1) :element-type 'character))
      (%copy-ptr-to-ivector data-ptr 0 new-string 0 data-size)
      (when (and (drag-get-source-view)
                 (eql (view-window view) (view-window (drag-get-source-view)))
                 (not (drag-copy-requested-p)))
        (multiple-value-bind (begin end) (selection-range (drag-get-source-view))
          (ed-delete-with-undo (drag-get-source-view) begin end t nil nil)
          (setf text-deleted-p t)
          (if (>= insert-pos end)
            (decf insert-pos (- end begin))
            (if (> insert-pos begin)
              (setf insert-pos begin)))))
      (ed-insert-with-undo view new-string insert-pos text-deleted-p)
      ; update the offset slot in case there are more incoming items
      (incf (dr-insert-offset view) data-size)
      (set-selection-range view insert-pos (+ insert-pos data-size))
      #+ccl-3 (set-current-key-handler (view-window view) view nil)
      (fred-update view)
      (invalidate-view view))
    t))

;; The method for receiving Finder files, such as those dragged directly from
;; the Finder.  We check the file type here, which is perhaps not the best
;; but certainly the easiest.  A better solution would be to override
;; #'drag-allow-drop-p and test the file type there; that way, we wouldn't
;; even show a drag hilite unless the file type is correct.
(defmethod drag-receive-dropped-flavor ((view drag-aware-fred-mixin)
                                        (flavor (eql #$flavorTypeHFS))
                                        (data-ptr macptr) (data-size integer)
                                        (item-reference integer))
  (declare (ignore data-size))
  (multiple-value-bind (path file-creator file-type finder-flags)
                       (drag-get-hfs-flavor data-ptr flavor t)
    (declare (ignore file-creator finder-flags))
    (when (or (eql file-type :|TEXT|)
              (eql file-type :|utxt|)
              (eql file-type :|ttro|))
      (with-cursor *watch-cursor*
        (%handle-incoming-hfs-file view path)))
    t))

;; The method for receiving promised Finder files, such as those dragged from
;; Find File's list of found files.  
(defmethod drag-receive-dropped-flavor ((view drag-aware-fred-mixin)
                                        (flavor (eql #$flavorTypePromiseHFS))
                                        (data-ptr macptr) (data-size integer)
                                        (item-reference integer))
  (declare (ignore data-ptr data-size))
  (multiple-value-bind (path file-creator file-type finder-flags)
                       (drag-resolve-promised-hfs-flavor item-reference flavor t)
    (declare (ignore file-creator finder-flags))
    (when (or (eql file-type :|TEXT|)
              (eql file-type :|utxt|)
              (eql file-type :|ttro|))
      (%handle-incoming-hfs-file view path)
      t)))

;; Low-level routines here
(defun %handle-incoming-hfs-file (view path)
  (unless (dr-insert-point view)
    (setf (dr-insert-point view) (fred-point-position view (drag-mouse-drop-position view))))
  (let ((old-buffer-length (buffer-size (fred-buffer view)))
        (insert-pos (+ (dr-insert-point view) (dr-insert-offset view))))
    (when path
      (with-font-focused-view view   ; preserves the insertion point font
        (buffer-insert-file (fred-buffer view) path insert-pos))
      ; update the offset slot in case there are more incoming items
      (incf (dr-insert-offset view) (- (buffer-size (fred-buffer view)) old-buffer-length))
      (set-selection-range view insert-pos (+ insert-pos
                                              (- (buffer-size (fred-buffer view))
                                                 old-buffer-length)))
      #+ccl-3 (set-current-key-handler (view-window view) view nil)
      (invalidate-view view)))
  t)

(defun %fred-make-drag-file (view dest-folder selection-start selection-end)
  (let ((filename (window-filename (view-window view)))
        (dest-path nil)
        (type "lisp"))
    (if filename
      (let ((namestring (mac-file-namestring filename)))
        (cond ((7bit-ascii-p namestring)  ;; so the only use of fsspec won't fail - hmm utf8??        
               (multiple-value-setq (filename type) (%std-name-and-type namestring))
               (if (eq type :unspecific)(setq type "lisp"))
               (setq filename (format nil "~A~A" "~" filename)))
              (t (setf filename "~Untitled"))))
      (setf filename "~Untitled"))
    (setf dest-path (make-pathname :directory (pathname-directory dest-folder)
                                   :type type
                                   :name filename :defaults nil))
    ; make sure filename is unique
    (let ((suffix 1))
      (declare (fixnum suffix))
      (loop while (probe-file dest-path)
            do (incf suffix)
            do (setf dest-path (make-pathname :directory (pathname-directory dest-folder)
                                              :type type
                                              :name (format nil "~A ~D" filename suffix)
                                              :defaults nil))))
    ; actually write the file
    (let ((len (- selection-end selection-start))
          (ascii-p t)
          (buffer (fred-buffer view)))
      (declare (fixnum len))
      (dotimes (i len)
        (when (%i> (char-code (buffer-char buffer (%i+ selection-start i))) #x7f)
          (setq ascii-p nil)
          (return)))      
      (with-open-file (s dest-path :direction :output
                         :if-exists :overwrite
                         :element-type '(unsigned-byte 8)
                         :if-does-not-exist :create) 
        (when (not ascii-p)   ;; write utf-16 BOM
          (stream-write-byte s #xFE)
          (stream-write-byte s #xFF))
        (dotimes (i len)
          (let ((code (char-code (buffer-char buffer (%i+ selection-start i)))))
            (declare (fixnum code))
            (if ascii-p
              (stream-write-byte s code)
              (progn
                (stream-write-byte s (ash code -8))
                (stream-write-byte s (logand code #xff)))))))
      ; set the Finder information
      (set-mac-file-creator dest-path $ccl-file-creator)
      (set-mac-file-type dest-path (if ascii-p :|TEXT| :|utxt|))
      dest-path)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Code copied from processes.lisp, by Bill St. Clair:
;;;
;;;    with-processInfoRec
;;;    find-process
;;;
;;; launch-app-with-doc was based on Bill's launch-application function in the
;;; processes.lisp module
;;;

;(require :processes)

#+ignore
(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (fboundp 'with-processInfoRec)
    (defmacro with-processInfoRec (sym &body body)
      (let ((name (gensym))
            (fsspec (gensym)))
        `(rlet ((,sym :ProcessInfoRec)
                (,name (string 32))
                (,fsSpec :FSSpec))
           (setf (pref ,sym processInfoRec.processInfoLength) (record-length :processInfoRec)
                 (pref ,sym processInfoRec.processName) ,name
                 (pref ,sym processInfoRec.processAppSpec) ,fsSpec)
           ,@body)))))

#+ignore
(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (fboundp 'find-process)
    (defun find-process (signature &optional psn)
      (setq signature (make-keyword signature))
      (unless psn (setq psn  (make-record :processSerialNumber)))
      (with-processInfoRec infoRec
        (setf (pref psn :processSerialNumber.highLongOfPSN) 0
              (pref psn :processSerialNumber.lowLongOfPSN) 0)
        (loop
          (unless (eql (#_GetNextProcess psn) #$noErr) (return nil))
          (when (and (eql (#_getProcessInformation psn infoRec) #$noErr)
                     (or (%equal-ostype infoRec :APPL
                                        (get-field-offset :processInfoRec.processType))
                         (%equal-ostype infoRec :FNDR
                                        (get-field-offset :processInfoRec.processType)))
                     (%equal-ostype infoRec signature
                                    (get-field-offset :processInfoRec.processSignature)))
            (return psn)))))))

#|
(defun launch-app-with-docs (filename &optional (doc-paths nil))
  (let ((err nil)
        (result nil))
    (rlet ((fsspec :FSSpec))
      (rlet ((pb :launchParamBlockRec
                 :launchBlockID #$extendedBlock
                 :launchEPBLength #$extendedBlockLen
                 :launchControlFlags (+ #$launchContinue #$launchNoFileFlags)
                 :launchAppSpec fsspec
                 :launchAppParameters (%null-ptr)))
        #+old
        (with-pstrs ((name (mac-namestring (probe-file filename))))
          (#_FSMakeFSSpec 0 0 name fsspec))
        (%path-to-fsspec filename fsspec :quiet)
        (if doc-paths
          (progn
            (unless (consp doc-paths)
              (setf doc-paths (list doc-paths)))
            (with-aedescs (event temp-event target aliases)
              (create-self-target target)
              (create-appleevent event #$kCoreEventClass #$kAEOpenDocuments target)
              (create-alias-list aliases doc-paths)
              (ae-error (#_AEPutParamDesc event #$keyDirectObject aliases))
              (#_AECoerceDesc event #$typeAppParameters temp-event)
              (if (osx-p)
                (let ((size (#_aegetdescdatasize temp-event)))
                  (rlet ((temp-event-ptr :ptr size))
                    (#_aegetdescdata temp-event temp-event-ptr size)
                    (setf (pref pb :launchParamBlockRec.launchAppParameters) temp-event-ptr)
                    (setf err (#_LaunchApplication pb))))
                (with-dereferenced-handles ((temp-event-ptr (rref temp-event :AEDesc.DataHandle)))
                  (setf (rref pb :launchParamBlockRec.launchAppParameters) temp-event-ptr)
                  (setf err (#_LaunchApplication pb)))))) 
          (setf err (#_LaunchApplication pb)))
        (if (eql err #$noErr)
          (setf result filename))))
    result))
|#

;; pretty much the same as launch-application in processes.lisp

(defun launch-app-with-docs (filename &optional doc-paths stay-in-background-p)
  (let ((result nil)
        (ndocs (if (listp doc-paths)(length doc-paths) 1)))
    (declare (fixnum ndocs))
    (rlet ((fsref :FSref)
           (launchspec :LSlaunchFSRefSpec
                       :appref fsref))
      (let* ((*alias-resolution-policy* :quiet)
             (res (path-to-fsref filename fsref)))
        (when res
          (%stack-block ((refs (* ndocs (record-length :fsref))))
            (cond
             ((null doc-paths)
              (setf (pref launchspec :LSlaunchFSRefSpec.itemrefs) (%null-ptr)))
             (t (if (not (consp doc-paths))
                  (let ((res (path-to-fsref doc-paths refs)))
                    (if (not res)(decf ndocs)))
                  (let ((offset 0))
                    (declare (fixnum offset))
                    (dolist (doc doc-paths) 
                      (let ((res (path-to-fsref doc (%inc-ptr refs offset))))
                        (if res 
                          (incf offset (record-length :fsref))
                          (decf ndocs))))))
                (setf (pref launchspec :LSlaunchFSRefSpec.itemrefs) refs)))
            (setf (pref launchspec :LSlaunchFSRefSpec.numdocs) ndocs)
            (setf (pref launchspec :lsLaunchFSRefspec.passthruparams) (%null-ptr))
            (setf (pref launchspec :LSLaunchFSRefspec.launchflags) 
                  (logior #$kLSLaunchDefaults  (if stay-in-background-p (logior #$kLSLaunchDontAddToRecents #$kLSLaunchDontSwitch) 0)))  ;; ??
            (setf (pref launchspec :LSLaunchFSRefspec.asyncRefCon)(%null-ptr))
            (let ((err (#_LSOpenFromRefSpec launchspec (%null-ptr))))
              (if (eq err #$noerr)
                (setq result filename)))))))
    result))


;; not used today
#+ignore
(defun switch-application (signature &optional (doc-paths nil))
  (with-aedescs (event reply target doc-desc)
    (rlet ((sig :ostype))
      (%put-ostype sig signature)
      (ae-error (#_AECreateDesc #$typeApplSignature sig #.(record-length :ostype) target))
      (create-appleevent event #$kCoreEventClass #$kAEOpenDocuments target)      
      (if doc-paths
        (progn         
          (unless (consp doc-paths)
            (setf doc-paths (list doc-paths)))
          (create-alias-list doc-desc doc-paths)
          (ae-error (#_AEPutParamDesc event #$keyDirectObject doc-desc))))
      (send-appleevent event reply :reply-mode :wait-reply))
    t))