; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  6 2/6/96   akh  change call to _drawchar
;;  2 10/12/95 akh  no lap
;;  5 4/25/95  akh  make it work when more than one page
;;  4 4/24/95  akh  Use frec functions to print thereby getting all the new features such as word wrap
;;  3 4/4/95   akh  file got mashed somehow
;;  2 4/4/95   akh  get tabwidth from frec, indentation
;;  3 3/2/95   akh  surely must be something about base-character
;;  (do not edit before this line!!)

;; EdHardcopy.lisp - hardcopy for Fred windows
;; Copyright 1987-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-2000 Digitool, Inc.

; Modification History
;
; #_drawtext -> grafport-write-string etc.
; ----- 5.2b4
; say $kFontIDGeneva vs #$geneva
; ------- 5.1 final
; print-style-dialog gets with-timer
; -------- 5.1b2
; hc-file-date-str more sensible
;; -------- 5.0 final
; if carbon use the modren PMSession... stuff
; fix hc-current-date-str to not crash on OSX - used by create-bug-report
;---------- MCL 4.4b3
; 07/30/01 akh more carbon stuff
; error if osx-p for now
; no mo lmgettime
; 04/16/99 akh  header-font-spec from David Lamkins
;  9/04/96 slh   window-hardcopy: _SetCursor -> with-cursor
;  7/03/96 slh   hc-current-date-str: (ptime 4) -> (ptime)
; 03/26/96  gb   lowmem accessors.
; 03/21/96 bill  (errchk (#_DisposeHandle ...)) => (#_DisposeHandle :errchk ...)
; 12/05/95 slh   update trap names
; 12/3/95 bill   really fix #_DrawChar call for PPC
; 11/29/95 bill  (#_GetFInfo :errchk pb) -> (errchk (#_PBGetFInfoSync pb))
; 11/30/95 slh   fix _DrawChar call for PPC
;  4/17/95 alice draw-hardcopy uses frec code to do the work so we get all the features
; fix draw-hardcopy for n.w.o
;---------------
;03/16/93 bill  *hc-page-header-p*
;12/03/92 bill  GB's patch to window-hardcopy makes it work correctly
;               for Imagewriter printers.
;07/31/92 bill  window-hardcopy now handles fred-dialog-item's as well
;               as fred-window's.
;-------------- 2.0
;01/08/92 gb    A whole month later: use new records.
;12/08/91 alice gotta draw the string when font changes
;--------------- 2.0b4
;10/29/91 alice def-load-pointers => def-ccl-pointers
;10/21/91 gb   no more #_PB.
;------------- 2.0b3
;09/05/91 bill %setport -> set-gworld
;08/24/91 gb   new trap syntax.
;07/21/91 gb   declaim
;------------- 2.0b2
;02/14/91 alice draw-hardcopy use draw-text instead of draw-char (about twice the speed)
;------------- 2.0b1
;02/04/91 bill def-load-pointers *hc-pRec*
;01/01/91 gb  resident decl in draw-hardcopy.
;11/09/90 bill Obey form-feed (#\page) requests.
;06/12/90 bill window-buffer -> fred-buffer.
;5/7/90   gz Preserve port over _PrOpenPage calls.
;02/13/90 gz removed redundant $err-xxx defs.
;12/03/89 gz Make it work.
;12/16/88 gz New buffers.
;11/16/88 gz new fred windows
;9/1/88  gz  %signal-error -> %err-disp
;6/21/88 jaj catch :error -> catch-error
;5/31/88 as  %error -> :error
;5/25/88 jaj keywordified rlets

;4/12/88 gz  new macptr scheme.
;7/25/87 gz  name -> window-title
;7/12/87 gb  Provide thyself.
;6/22/87 gz  lock pRec around draw-hardcopy.  Get margins from prec, not port.
;6/8/87  gz  made window-hardcopy return T if printed, nil if cancelled.
;5/21/87 gb  %(h)get-signed-word.
;4/19/87 gz  no mac-records.
;4/10/87 jaj changed to new records
; 3/30/87 gz Load fredenv rather than edlow. title -> name.
; 3/1/87  gz New

(eval-when (eval compile)
   (require 'backquote)
   (require 'sysequ)
   ;(require 'toolequ)
   (require 'defrecord)
   (require 'fredenv)

   (defconstant $boldStyle #x100)
   (defconstant $italicStyle #x200)
   (defconstant $ulineStyle #x400)
   (defconstant $outlineStyle #x800)
   (defconstant $shadowStyle #x1000)
   (defconstant $condenseStyle #x2000)
   (defconstant $extendStyle #x4000)
   (defconstant $PrintErr #x944)
   (defconstant $iPrintSize 120)
   (defconstant $prJob.bJDocLoop (%i+ 62 6))
   (defconstant $iPrStatSize 26)
   (defconstant $bSpoolLoop 1)

 #-carbon-compat
   (defmacro $pnLoc.h (port &optional (val () val-p))
     (if val-p `(%put-word ,port ,val 50) `(%get-signed-word ,port 50)))
   #+carbon-compat 
   ;; assumes focused - are we
   (defmacro $pnLoc.h (port &optional (val () val-p))
     (declare (ignore-if-unused port))
     (if val-p 
       `(rlet ((poo :penstate))
          (#_getpenstate  poo)
          (setf (rref poo penstate.pnloc) (make-point ,val (point-v (rref poo penstate.pnloc))))
          (#_setpenstate poo)) 
       `(rlet ((poo :point))
          (point-h (#_getpen poo)))))
   #-carbon-compat
   (defmacro $pnLoc.v (port &optional (val () val-p))
     (if val-p `(%put-word ,port ,val 48) `(%get-signed-word ,port 48)))
   #+carbon-compat
   (defmacro $pnLoc.v (port &optional (val () val-p))
     (declare (ignore-if-unused port))
     (if val-p 
       `(rlet ((poo :penstate))
          (#_getpenstate poo)
          (setf (rref poo penstate.pnloc) (make-point (point-h (rref poo penstate.pnloc)) ,val))
          (#_setpenstate poo))
       `(rlet ((poo :point))
          (point-v (#_getpen poo)))))

)

(declaim (special *hc-left-header* *hc-middle-header* *hc-line-ht*
                  *hc-header-font-spec* *hc-left-margin* *hc-right-margin* 
                  *hc-bottom-margin* *hc-page-hpos* *hc-middle-hpos*
                  *hc-header-baseline* *hc-top-margin* *hc-page-number*
                  *hc-page-open-p*))

;(defvar *tab-char-width* 8)

(defmacro check-printer-error (form &optional str)
  (let ((err (gensym)))
    `(let ((,err ,form))
       (when (neq ,err #$noerr)
         (printer-error ,str ,err)))))

(defvar *pmsession* nil)

(defun pm-open ()
  (rlet ((pmsession :ptr)
         ;(accepted :boolean)
         )
    ;(declare (ignore accepted))
    (setq *pmsession* nil)
    (let ((err (#_PMCreateSession pmsession)))
      (when (neq err #$noErr)
        (printer-error "when load" err)))
    (setq *pmsession* (%get-ptr pmsession))))

  
(defun printer-error (err-str error-result)
  (if (null err-str)
    (error (format nil "Printer error ~s" error-result))
    (error (format nil "Printer error when ~a ~s" err-str error-result))))

(defvar *pageformat* nil)

(defun print-style-dialog ()   ;; this does the page setup dialog
  (rlet ((pmsession :ptr)
         (accepted :boolean)
         (pageformat :ptr))
    (with-timer
       (unwind-protect
         (progn
           (setq *pmsession* nil)
           (setq *pageformat* nil)
           (let ((err (#_PMCreateSession pmsession)))
             (when (neq err #$NoErr)
               (printer-error "when create session" err)))
           (setq *pmsession* (%get-ptr pmsession))        
           (let ((err (#_PMCreatePageFormat pageformat)))
             (when (neq err #$noERR)
               (printer-error nil err)))
           (setq *pageformat* (%get-ptr pageformat))
           (let ((err (#_PMSessionDefaultPageFormat *pmsession* *pageformat*)))
             (when (neq err #$noerr)
               (#_PMRelease *pageformat*) (setq *pageformat* nil)(printer-error nil err)))
           (with-cursor *arrow-cursor*
             (let ((err (#_PMSessionPageSetupDialog *pmsession* *pageformat* accepted)))
               (when (neq err #$NOERR) (#_PMRelease *pageformat*)(setq *pageformat* nil)(printer-error nil err))))
           (let ((a-val (%get-byte accepted)))
             (when (eq a-val #$false)  ;; cancelled 
               (#_PMRelease *pageformat*)
               (setq *pageformat* nil)
               (throw :cancel :cancel))))
         
         (when *pmsession*
           (#_PMRelease *pmsession*)
           (setq *pmsession* nil))))))



(defvar *printsettings* nil)
(defun get-carbon-print-settings ()
  (if (null *printsettings*)
    (rlet ((printsettings :ptr))
      (setq *printsettings* nil)
      (let ((err (#_PMCreatePrintSettings printsettings)))
        (if (eq err #$noerr)
          (setq *printsettings* (%get-ptr printsettings))
          (printer-error nil err)))        
      (let ((err (#_PMSessionDefaultPrintSettings *pmsession* *printsettings*)))
        (if (neq err #$noerr)
          (progn (#_pmrelease *printsettings*)(setq *printsettings* nil)(printer-error nil err))))))
  (if (null *pageformat*)
    (rlet ((pageformat :ptr))
      (let ((err (#_PMCreatePageFormat pageformat)))
          (when (neq err #$noERR)
            (printer-error nil err)))
        (setq *pageformat* (%get-ptr pageformat))
      (let ((err (#_PMSessionDefaultPageFormat *pmsession* *pageformat*)))
        (if (neq err #$noerr)
          (progn (#_pmrelease *pageformat*)(setq *pageformat* nil)(printer-error nil err)))))))

(def-ccl-pointers pm ()
  (setq *pmsession* nil *printsettings* nil *pageformat* nil))

          


; The logic here should be inverted, so that we have a hardcopy stream anybody
; could create and write to... Can't do it until the system can handle random
; external windows.
(defmethod window-hardcopy ((w fred-mixin) &optional (show-dialog t))  
  (when nil ;(osx-p)
    (error "printing not implemented yet for OSX"))
  (unwind-protect
    (progn
      (PM-open)      
      (when (not (and *printsettings* *pageformat*))
        (get-carbon-print-settings))      
      (when show-dialog
        (let ((err (#_PMSetPageRange *printsettings* 0 999)))
          (when (neq err #$Noerr)(printer-error "setting page range" err)))
        (rlet ((accepted :boolean))
          (let ((err (#_PMSessionPrintDialog *pmsession* *printsettings* *pageformat* accepted)))
            (when (neq err #$Noerr)
              (printer-error "doing print dialog" err))
            (when (eq (%get-byte accepted) #$false)(throw-cancel :cancel)))))
      ;_PrOpenDoc puts up a dialog window which causes the event system
      ;to get confused.  So we do the whole thing without interrupts, and
      ;make sure to clean up before handling errors.
      (handler-case
        (let ((*hc-page-open-p* nil) (*break-on-errors* nil))
          (with-macptrs (saved-port saved-device)
            (get-gworld saved-port saved-device)
            (without-interrupts
             (unwind-protect
               (progn
                 (let ((err (#_PMSessionBeginDocument *pmsession* *printsettings* *pageformat*)))
                   (when (neq err #$noerr)
                     (printer-error "begindocument" err)))
                 (progn ;rlet ((grafptrptr :ptr))
                   #+ignore
                   (with-cfstrs ((foo "com.apple.graphicscontext.quickdraw"))
                     (let ((err (#_PMSessionGetGraphicsContext *pmsession* foo grafptrptr)))
                       (when (neq err #$noerr)
                         (printer-error "grafport" err))))
                   #+ignore                     
                   (let ((err (#_PMGetGrafPtr *pmsession* grafptrptr))) ; gets error -30871
                     (when (neq err #$noerr)
                       (printer-error "grafport" err))) 
                   ;; looks like port is set by PmSessionbeginpage - i think
                   (progn  ;with-macptrs ((port (%get-ptr grafptrptr)))
                     ;(set-gworld port)
                     (unwind-protect
                       (draw-hardcopy w)
                       (when *hc-page-open-p* (hc-close-page))
                       (#_PMSessionEndDocument *pmsession*)))))
               (set-gworld saved-port saved-device)))
            ))
        (error (c) (error c)))
      t)
    (without-interrupts
     (when *pageformat*
       (#_PMRelease *pageformat*)
       (setq *pageformat* nil))
     (when *printsettings*
       (#_PMRelease *printsettings*)
       (setq *printsettings* nil))
     (when *pmsession*
       (#_PMrelease *pmsession*)
       (setq *pmsession* nil))
     )))



    

(defparameter *hc-page-header-p* t)

(defun hc-compute-margins (pmrect)
  (hc-put-font *hc-header-font-spec*)
  (rlet ((finfo :fontinfo))
    (#_GetFontInfo finfo)
    (let (;(ppi-x *pixels-per-inch-x*)  ;; what are the floats in pmrect - fractions of pixels, inches, cm ???
          ;(ppi-y *pixels-per-inch-y*)
          (pmrecttop (rref pmrect :pmrect.top))
          (pmrectleft (rref pmrect :pmrect.left))
          (pmrectbottom (rref pmrect :pmrect.bottom))
          (pmrectright (rref pmrect :pmrect.right)))
      (declare (ignore-if-unused ppi-x ppi-y))
      (setq *hc-left-margin* (+ (truncate pmrectleft) 7) ;bounds.left
            *hc-right-margin* (- (truncate pmrectright)  7) ;bounds.right
            *hc-bottom-margin* (- (truncate  pmrectbottom) *hc-line-ht*) ;bounds.bottom
            *hc-page-hpos* (- *hc-right-margin* (hc-width "Page 00000"))
            *hc-middle-hpos* (ash (- (+ *hc-left-margin*
                                        (hc-width *hc-left-header*)
                                        *hc-page-hpos*)
                                     (hc-width *hc-middle-header*))
                                  -1)
            *hc-header-baseline* (+ (truncate pmrecttop)  ;bounds.top
                                    (rref finfo fontinfo.ascent))
            *hc-top-margin* (+ (if *hc-page-header-p* *hc-header-baseline* 0)
                               (rref finfo fontinfo.descent)
                               *hc-line-ht*
                               *hc-line-ht*))
      )))





(defun hc-start-page (pmrect)
  (with-macptrs ((port (%getport)))
    (declare (ignore-if-unused port))
    (hc-open-page pmrect)
    (setq *hc-page-number* (+ *hc-page-number* 1))
    (when *hc-page-header-p*
      ;(print (list *hc-left-margin* *hc-middle-hpos* *hc-page-hpos* *hc-top-margin*))
      (hc-put-font *hc-header-font-spec*)
      ($pnLoc.v port *hc-header-baseline*)
      ($pnLoc.h port *hc-left-margin*)
      (hc-string *hc-left-header*)
      ($pnLoc.h port *hc-middle-hpos*)
      (hc-string *hc-middle-header*)
      ($pnLoc.h port *hc-page-hpos*)
      (hc-string "Page ")
      (hc-positive-int *hc-page-number*))
    ($pnLoc.v port *hc-top-margin*)
    ($pnLoc.h port *hc-left-margin*)))


(defun hc-close-page ()
  (let ((err (#_PMSessionEndPage *pmsession*)))
    (setq *hc-page-open-p* nil)
    (when (neq err #$noerr)
      (printer-error nil err))))



(defun hc-open-page (pagerect)
  (let ((err (#_PMSessionBeginPage *pmsession* *pageformat* pagerect)))
    (when (neq err #$noerr)
      (printer-error nil err))
    (setq *hc-page-open-p* t)))


(defun hc-put-font (spec)  
  (progn
    (#_textfont (pop spec))
    (#_textface (pop spec))
    (#_textsize (pop spec))))

#|
(defun hc-string (s)
  (with-pstrs ((sp s))
    (#_DrawString  sp)))
|#

(defun hc-string (s)
  (grafport-write-string s 0 (length s)))

#|
(defun hc-text (s start count)
  (with-pstrs ((sp s))
    (#_DrawText sp start count)))
|#

(defun hc-text (s start count)
  (grafport-write-string s start (+ start count)))

#|
(defun hc-width (s)
  (with-pstrs ((sp s))
    (#_StringWidth sp)))
|#

(defun hc-width (s)
  (multiple-value-bind (ff ms)(grafport-font-codes)
    (font-codes-string-width s ff ms)))

#|
(defun hc-positive-int (n)
  (multiple-value-bind (q r) (floor n 10)
    (unless (eql q 0) (hc-positive-int q))
    (#_DrawChar (code-char (%i+ r (%char-code #\0))))))
|#

(defun hc-positive-int (n)
  (multiple-value-bind (q r) (floor n 10)
    (unless (eql q 0) (hc-positive-int q))
    (grafport-write-char (code-char (%i+ r (%char-code #\0))))))

;; ain't right either but closer
(defun hc-file-date-str (file-name)
  (rlet ((foo :pointer))
    (%put-long foo (mac-file-write-date file-name))
    (hc-date-to-str foo)))



(defun hc-current-date-str ()
  (let ()
    (rlet ((ptime :unsigned-long))
      (#_getdatetime ptime)
      (hc-date-to-str ptime))))



(defun hc-date-to-str (dateptr &aux timeptr n)
  (%stack-block ((str 120))   
    (#_datestring (%get-long dateptr) 2 str (%null-ptr))
    (setq timeptr (%inc-ptr str (setq n (%i+ (%get-byte str) 2))))   
    (#_timestring (%get-long dateptr)  t timeptr (%null-ptr))
    (setq n (%i+ n (%get-byte timeptr)))
    (%put-byte timeptr (%char-code #\space))
    (%put-byte timeptr (%char-code #\space) -1)
    (%str-from-ptr (%inc-ptr str 1) n)))




;; from David Lamkins

;; The MCL 4.2 draw-hardcopy produces an "unpredictable" font for
;; the header line.  It should be italicized, but it is sometimes
;; plain and sometimes (like when a buffer contains colors) shadowed.
;; There's also no way to override the font used for the headers.
;; Also, the font -- since is based on one of the buffer fonts -- is
;; usually monospace; this makes it take up more room than necessary
;; in the header, and tends to cause header fields to overlap.
;;
;; This patch sets the header font to Geneva italic, 7 point.
;; You can change ccl::*hc-header-font-spec* to a 3-element list
;; containing the font number, style bits, and font size.

(defmethod draw-hardcopy ((w fred-mixin) &aux
                          (buffer (fred-buffer w))
                          (window (view-window w))
                          (file-modcnt (slot-value w 'file-modcnt))
                          last-page)
  (declare (resident))

  (if (setq *hc-left-header* (window-filename w))
    (progn
      (setq *hc-left-header* (namestring *hc-left-header*))
      (if (and (fixnump file-modcnt)
               (not (eql file-modcnt (buffer-modcnt buffer))))
        (setq *hc-left-header* (%str-cat (string (slot-value window 'modified-marker))
                                         *hc-left-header*)
              *hc-middle-header* (hc-current-date-str))
        (setq *hc-middle-header* (hc-file-date-str (window-filename w)))))
    (setq *hc-left-header*
          (if (typep window 'window)
            (%str-cat "Window: " (window-title window))
            "")
          *hc-middle-header* (hc-current-date-str)))

  (setq *hc-line-ht* (+ (%buffer-maxasc buffer)
                        (%buffer-maxdsc buffer)
                        (fr.lead (frec w))))

  ;; Changed by DBL
  (unless (and (boundp '*hc-header-font-spec*)
               (listp *hc-header-font-spec*)
               (= (length *hc-header-font-spec*) 3)
               (every #'numberp *hc-header-font-spec*))
    (setq *hc-header-font-spec*
          (list #$kFontIDGeneva (ash 1 #$italic) 7)))
  (rlet ((poo :unsigned-long))
    (#_PMGetLastPage *printsettings* poo)  ;; is that always valid?
    (setq last-page (%get-long poo)))
  (rlet ((pagerect :pmrect))  ;; oh my, they is floats - do we really need  to do getadjustedpaperrect first
    (#_PMGetAdjustedPageRect *pageformat* pagerect)
    
    (hc-compute-margins pagerect)
    (let* ((height *hc-bottom-margin*)
           (ivpos *hc-top-margin*)
           (frec (make-frec buffer nil (make-point (- *hc-right-margin* *hc-left-margin*)
                                                   height)))
           (pos 0))
      (setq *hc-page-number* 0)
      (loop
        (setf (fr.nodrawing-p frec) t)
        (setf (fr.printing-p frec) t)
        (setf (fr.bmod frec) pos)  ; added these
        (setf (fr.zmod frec) 0)
        (%update-lines-maybe frec pos)
        (setf (fr.nodrawing-p frec) nil)
        (hc-start-page pagerect)
        (when (> *hc-page-number* last-page)(return))
        (let* ((numlines (fr.numlines frec))
               (linevec (fr.linevec frec))
               (lineheights (fr.lineheights frec))
               (end-pos pos)
               (real-numlines 0)
               (vpos ivpos))
          (dotimes (i numlines) ; get rid of partial last line if exists
            (incf vpos (linevec-ref lineheights i))
            
            (when (> vpos height)
              (return))
            (incf end-pos (linevec-ref linevec i))
            (incf real-numlines))
          (%redraw-screen-lines frec pos 0 (1- real-numlines) ivpos)
          (setq pos end-pos)
          (set-mark (fr.wposm frec) pos)
          (hc-close-page)
          (when (>= pos (buffer-size buffer))(return)))))))





(provide 'edhardcopy)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
