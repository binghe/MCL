;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  9 5/20/96  akh  styled-line-break - conditionalize ash of result
;;  8 4/17/96  akh  fixnum decls
;;  6 11/16/95 bill CCL 3.0x40
;;  2 3/2/95   akh  probably no change
;;  1 1/13/95  akh  add to project
;;  (do not edit before this line!!)

; Copyright 1990-1994 Apple Computer, Inc.
; Copyright 1995-2000 Digitool, Inc.

;;; script-manager.lisp
;;;
;;; High level interface to the Macintosh Script manager
;;;

(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; pixel-2-char - fix usage of :boolean
;;; ------ 5.2b6
;;; use add-pascal-upp-alist-cfm - try macho
;;; no change
;;; ----- 5.1 final
;;; akh some carbon-compat stuff
;;; 08/05/99 akh string-2-date and string-2-time from T. Norderhaug
;;; ---------- 4.3f1c1
;;;  6/06/96 slh   styled-line-break from patch slightly better (error msg value)
;;;     ?    akh   styled-line-break - conditionalize ash of result
;;;  4/15/96 akh   decl in measure-just
;;;  3/28/96 slh   removed unused multiple-fixed, xmultiply-2-fixed
;;; 11/14/95 bill  callbacks work, no more dummy get-format-order
;;; 11/10/95 bill  dummy ppc get-format-order until callbacks work
;;; 11/02/95 bill  #_SetSysJust -> #_SetSysDirection (the former isn't in InterfaceLib)
;;;                #_Font2Script -> #_FontToScript
;;;                #_setenvirons -> #_SetScriptManagerVariable
;;; 10/20/95 slh   de-lapified: multiply-2-fixed
;;;  3/11/95 slh   use gestalt bitnum arg
;;; 06/28/93 bill  get-environs, get-key-script, set-key-script moved to
;;;                l1-events.lisp
;;; 08/14/92 bill  New file
;;;

(defmacro with-string-portion ((string start end cstr-var &optional len-var)
                               &body body)
  (let* ((decls nil)
         (thunk (gensym)))
    (if len-var
      (setq decls `((declare (fixnum ,len-var))))
      (progn
        (setq len-var (gensym)
              decls `((declare (ignore ,len-var))))
        len-var))
    `(let ((,thunk #'(lambda (,cstr-var ,len-var) ,@decls ,@body)))
       (declare (dynamic-extent ,thunk))
       (call-with-string-portion ,string ,start ,end ,thunk))))

(defun call-with-string-portion (string start end thunk)
  (let* ((macptrp (macptrp string))
         (string-length (unless macptrp (length string))))
    (setq start (if start (require-type start 'fixnum) 0)
          end (if end (require-type end 'fixnum) string-length))
    (locally (declare (fixnum start end))
      (let ((len (- end start)))
        (declare (fixnum end))
        (when (< len 0)
          (error "~s > ~s" start end))
        (if macptrp
          (if (eql start 0)
            (funcall thunk string len)
            (with-macptrs ((cstr (%inc-ptr string start)))
              (funcall thunk cstr len)))
          (progn
            (unless (<= end string-length)
              (error "~s: ~s > ~s" 'end end string-length))
            (with-cstrs ((cstr string start end))
              (funcall thunk cstr len))))))))

;; string is a Lisp string
;; offset is the index in the string of the desired pixel
;; direction is :left, :right, or :hilite
;; slop is nil or a fixnum giving the number of pixels of slop
;; start and end denote the region of string to consider as
;;   the start and end of the line in which to find a pixel offset.

;; used by fred. carbon-compat version does work now - not used
(defun char-2-pixel (string offset direction &key slop start end)
  (%char-2-pixel string offset direction slop start end))

(defun %char-2-pixel (string offset direction slop start end)
  (with-string-portion (string (or start 0) (or end (length string)) cstr len)
    #-carbon-compat
    (#_Char2Pixel
     cstr 
     len
     (if slop (require-type slop 'fixnum) 0)
     (require-type offset 'fixnum)
     (if (fixnump direction)
       direction
       (ecase direction
         (:left  #$smLeftCaret)
         (:right  #$smRightCaret)
         (:hilite  #$smHilite))))
    #+carbon-compat
    (let ((numer #@(1 1))  ;; don't know what these are
          (denom #@(1 1))
          (stylerunposition #$onlyStyleRun))
        (#_charToPixel         
         cstr 
         len
         (if slop (progn (require-type slop 'fixnum)(ash slop 16)) 0)
         (require-type offset 'fixnum)
         (if (fixnump direction)
           direction
           (ecase direction
             (:left  #$smLeftCaret)
             (:right  #$smRightCaret)
             (:hilite  #$smHilite)))
         stylerunposition
         numer
         denom))))


;; this is used by fred - no longer
(defun char-byte (string offset &optional start (script #$smroman))
  (declare (ignore-if-unused script))
  (setq offset (require-type offset 'fixnum))
  (setq start
        (if start
          (require-type start 'fixnum)
          0))
  (locally (declare (fixnum start))
    (let ((norm-offset (- offset start)))
      (declare (fixnum norm-offset))
      (with-string-portion (string start (the fixnum (1+ norm-offset))
                                   cstr)
        #-carbon-compat
        (#_CharByte cstr norm-offset)
        #+carbon-compat
        (#_CharacterByteType cstr norm-offset script)))))

;; not used by us
(defun char-type (string offset &optional start script)
  (declare (ignore-if-unused script))
  (when (null script)(setq script #$smroman))
  (setq offset (require-type offset 'fixnum))
  (setq start
        (if start
          (require-type start 'fixnum)
          0))
  (locally (declare (fixnum start))
    (let ((norm-offset (- offset start)))
      (declare (fixnum norm-offset))
      (with-string-portion (string start (the fixnum (1+ norm-offset))
                                   cstr)
        #-carbon-compat 
        (#_CharType cstr norm-offset)
        #+carbon-compat
        (#_CharacterType cstr norm-offset script)))))

;; not used by us
(defun draw-just (string &key start end (slop 0))
  (%draw-just string start end slop))

(defun %draw-just (string start end slop)
  (declare (ignore-if-unused string start end slop))
  #-carbon-compat
  (with-string-portion (string start end cstr len)
    (#_DrawJust cstr len slop))
  #+carbon-compat
  (error "draw-just not in carbon"))

; Returns three values:
; 1) The script (0 being Roman text)
; 2) script specific (Kanji returns a subscript here)
; 3) The index in string of the start of the next script run.

;; not used
(defun find-script-run (string &optional (start 0) end)
  (with-string-portion (string start end cstr length)
    (rlet ((len :long))
      (let ((status (#_FindScriptRun cstr length len)))
        (declare (fixnum status))
        (values (ash status -8)
                (the fixnum (logior status #xff))
                (+ start (%get-long len)))))))


; break-table can be:
;   nil      Use the default word-selection break table
;   t        Use the default word-wrap break table
;   macptr   This is the break table.
;; not used
(defun find-word (string offset leading-edge-p
                         &key start end break-table script)
  (%find-word string offset leading-edge-p start end break-table (or script #$smRoman)))

(defun %find-word (string offset leading-edge-p start end break-table script)
  (declare (ignore-if-unused script))
  (unless start (setq start 0))
  (setq offset (require-type offset 'fixnum)) 
  (with-string-portion (string start end cstr len)
    (locally (declare (fixnum start offset))
      ; This is backwards from what #_Pixel2Char's doc says, but it works
      (cond ((eql offset start)
             (setq leading-edge-p t))
            ((eql offset end)
             (setq leading-edge-p nil)))
      (with-macptrs ((minus-1-ptr (%int-to-ptr -1))
                     (null-ptr (%null-ptr)))
        (rlet ((offsets :offsetTable))
          #-carbon-compat
          (#_FindWord cstr len (- offset start) leading-edge-p
           (cond ((null break-table) null-ptr)
                 ((macptrp break-table) break-table)
                 (t minus-1-ptr))
           offsets)
          #+carbon-compat
          (#_FindWordBreaks cstr len (- offset start) leading-edge-p
           (cond ((null break-table) null-ptr)
                 ((macptrp break-table) break-table)
                 (t minus-1-ptr))  ;; probably wrong but we don't use it
           offsets
           script)
          (values (the fixnum (+ start (pref offsets :offPair.offFirst)))
                  (the fixnum (+ start (pref offsets :offPair.offSecond)))))))))

(defun font-2-script (font-number)
  (#_FontToScript font-number))

(defun font-script ()
  (#_FontScript))

(defmacro unimplemented ()
  `(error "Unimplemented"))

(defun format-2-str ()
  (unimplemented))

(defun format-x-2-str ()
  (unimplemented))

(defun format-str-2-x ()
  (unimplemented))

(defun get-app-font ()
  (#_GetAppFont))

(defun get-def-font-size ()
  (#_GetDefFontSize))

#| ; Moved to l1-events.lisp
(defun get-environs (verb)
  (#_GetEnvirons verb))
|#
;; this sucks
#+carbon-compat
;(add-pascal-upp-alist 'rldirproc #'(lambda (procptr)(#_newstyleRunDirectionUPP procptr)))
(add-pascal-upp-alist-macho 'rldirproc "NewStyleRunDirectionUPP")

(defpascal rlDirProc (:word the-format :ptr dir-proc :word)
  (declare (ignore dir-proc) (fixnum the-format))
  (declare (special *dir-function*))
  (if (funcall *dir-function* the-format)
    -1 0))

; start and end are as for sequence functions.
; line-right-p is true for a right-to-left line order.
; The dir-function will be called with a font-index from start <= i < end.
; It should return true if the font number at that index is a right-to-left font.
; ordering is an array for the ordering numbers, a permuted sequence
; of start <= i < end.
(defun get-format-order (start end line-right-p dir-function 
                               &optional ordering ordering-start)
  (setq start (require-type start 'fixnum))
  (setq end (require-type end 'fixnum))
  (locally (declare (fixnum start end))
    (let* ((len (the fixnum (- end start)))
           (bytes (* 2 len)))
      (declare (fixnum len))
      (unless (>= len 0)
        (error "~s: ~s > ~s: ~s" 'start start 'end end))
      (unless ordering
        (setq ordering (make-array len)))
      (if (eql len 1)
        ; #_GetFormatOrder has a bug. Doesn't work for single run
        (setf (aref ordering (or ordering-start 0)) start)
        (%stack-block ((ordering-ptr bytes))
          (let ((*dir-function* dir-function))
            (declare (special *dir-function*))
            (#_GetFormatOrder
             ordering-ptr start (1- end) line-right-p rlDirProc (%null-ptr)))
          (let ((index (or ordering-start 0))
                (offset 0))
            (declare (fixnum index offset))
            (dotimes (i len)
              (setf (aref ordering index) (%get-word ordering-ptr offset))
              (incf index)
              (incf offset 2)))))))
  ordering)

#+ignore                                ; ppc booststrapping version
(defun get-format-order (start end line-right-p dir-function 
                               &optional ordering ordering-start)
  (declare (ignore line-right-p dir-function))
  (setq start (require-type start 'fixnum))
  (setq end (require-type end 'fixnum))
  (locally (declare (fixnum start end))
    (let* ((len (the fixnum (- end start))))
      (declare (fixnum len))
      (unless (>= len 0)
        (error "~s: ~s > ~s: ~s" 'start start 'end end))
      (unless ordering
        (setq ordering (make-array len)))
      (let ((index (or ordering-start 0))
            (offset start)
            )
        (declare (fixnum index))
        (dotimes (i len)
          (setf (aref ordering index) offset)
          (incf index)
          (incf offset)))))
  ordering)

(defun get-script (script verb)
  (#_getScriptvariable script verb))

(defun get-sys-font ()
  (#_GetSysFont))

(defun get-sys-just ()
  (#_GetSysDirection))

; Returns six values: three pairs of offsets to pass to Char2Pixel
;; not used
(defun hilite-text (string first-offset second-offset &optional
                           (start 0) (end (length string)))
  (rlet ((offset-table :offsetTable))
    (with-string-portion (string start end cstr len)
      (#_HiLiteText cstr len first-offset second-offset offset-table))
    (values (%get-word offset-table 0)
            (%get-word offset-table 2)
            (%get-word offset-table 4)
            (%get-word offset-table 6)
            (%get-word offset-table 8)
            (%get-word offset-table 10))))

#|
(defun init-date-cache ()
  (unimplemented))
|#

(defglobal %DateCacheRec% NIL)


(defun init-date-cache ()
  (unless (handlep %DateCacheRec%) ; may be dead macptr
    (setf %DateCacheRec%
      (make-record DateCacheRecord)))
   (#_InitDateCache %DateCacheRec%))

(pushnew 'init-date-cache *lisp-startup-functions*)



(defun intl-script ()
  (#_IntlScript))

(defun intl-tokenize ()
  (unimplemented))

(defun iul-date-string ()
  (unimplemented))

(defun iul-time-string ()
  (unimplemented))

#| ; Moved to l1-events.lisp
(defun get-key-script ()
  (get-environs #$smkeyscript))

(defun set-key-script (code)
  (#_KeyScript code))
|#

(defun long-date-2-secs ()
  (unimplemented))

(defun long-secs-2-date ()
  (unimplemented))

; Will clobber string if it is a macptr.
; Specify :overwrite for output to overwrite string with the result.
;; not used
(defun lwr-string (string &key start end
                          output output-start (script #$smroman ))
  (with-string-portion (string start end cstr len)
    (#_LowercaseText cstr len script)
    (let ((output output))
      (if output
        (when (eq output :overwrite)
          (setq output string output-start (or start 0)))
        (if (macptrp string)
          (return-from lwr-string string)
          (setq output (make-string len :element-type 'base-character))))
      (let ((index (if output-start 
                     (require-type output-start 'fixnum)
                     0))
            (offset 0))
        (declare (fixnum index offset))
        (dotimes (i len)
          (setf (char output index) (code-char (%get-byte cstr offset)))
          (incf index)
          (incf offset)))
      output)))

(setf (symbol-function 'lwr-text) #'lwr-string)

;; used by fred - no longer
(defun measure-just (string slop &key start end locs (locs-start 0))
  (setq locs-start (require-type locs-start 'fixnum))
  (locally (declare (fixnum locs-start))
    (with-string-portion (string start end cstr len)
      (let* ((1+len (1+ len))
             (bytes (* 2 1+len)))
        (declare (fixnum 1+len bytes))
        (%stack-block ((charLocs bytes))
          #-carbon-compat
          (#_MeasureJust cstr len slop charLocs) ;; not in carbon replacement, takes more args
          #+carbon-compat
          (let ((numer #@(1 1))  ; huh what are these about
                (denom #@(1 1)))
            (let ((stylerunposition #$onlyStyleRun)
                  (slop (ash slop 16)))
              (#_MeasureJustified cstr len slop charLocs stylerunposition numer denom)))
          (unless locs (setq locs (make-array 1+len)
                             locs-start 0))
          (let ((index locs-start)
                (offset 0))
            (declare (fixnum index offset))
            (dotimes (i 1+len)
              (setf (aref locs index) (%get-word charLocs offset))
              (incf index)
              (incf offset 2)))))))
  locs)

(defun parse-table (&optional (table (make-array 256 :element-type '(unsigned-byte 8))) (script #$smroman))
  (%stack-block ((parseTable 256))
    (#_fillParseTable parseTable script)
    (dotimes (i 256)
      (setf (aref table i) (%get-byte parseTable i))))
  table)

; Returns two values:
; 1) The index in string of the pixel-width
; 2) leading-edge-p
(defun pixel-2-char (string slop pixel-width &optional (start 0) end)
  (with-string-portion (string start end cstr len)
    #-carbon-compat
    (rlet ((leadingEdge :word))
      (values (the fixnum 
                (+ start (the fixnum
                           (#_Pixel2Char cstr len slop pixel-width leadingEdge))))
              ; This comes back with the wrong sense
              (pascal-true (the fixnum (%get-word leadingEdge)))))
    #+carbon-compat ;; doesn't work -  does now - see below
    (rlet ((leadingEdge :boolean)
           (widthremaining :signed-long))
      (let ((stylerunposition #$onlyStyleRun)
            (numer #@(1 1))
            (denom #@(1 1))
            (slop (ash slop 16))
            (pixel-width (ash pixel-width 16))) ; oh my goodnesss, it's type "fixed" which means the interesting part is in the high 16 bits!!
        ;; same true of slop as well but we only provide 0.
        (values (the fixnum 
                  (+ start (the fixnum
                             (#_PixelToChar cstr len slop pixel-width leadingEdge
                              widthremaining stylerunposition numer denom))))                       
                (pref leadingedge :boolean))))))

(defun portion-text (string &optional start end)
  (declare (ignore-if-unused string start end))
  #-carbon-compat
  (with-string-portion (string start end cstr len)
    (#_PortionText cstr len))
  #+carbon-compat
  (error "portion-text not in carbon"))

(defun fixed->float (fixed)
  (scale-float (float fixed) -16))

(defun float->fixed (float)
  (values (round (scale-float float 16))))

(defun round-fixed (fixed)
  (integer->fixed (round fixed #.(expt 2 16))))

(defun fixed->integer (fixed)
  (round fixed #.(expt 2 16)))

(defun integer->fixed (integer)
  (ash integer 16))

(defun add-fixed (&rest numbers)
  (declare (dynamic-extent numbers))
  (let ((res (apply '+ numbers)))
    (if (or (> res #.(1- (expt 2 31)))
            (< res #.(- (expt 2 31))))
      (error "Overflow")
      res)))

#-ppc-target
(progn
  (eval-when (:compile-toplevel :execute)
    (require "LAPMACROS"))
  
  ; This is actually wrong. It needs to round the result, not truncate.
  (defun multiply-2-fixed (num1 num2)
    (lap-inline ()
      (:variable num1 num2)
      (move.l (varg num1) arg_z)
      (jsr_subprim $sp-getxlong)
      (move.l acc da)
      (move.l (varg num2) arg_z)
      (jsr_subprim $sp-getxlong)
      (mulu.l arg_z (da arg_z))
      (if# (cc (cmp.l ($ #xffff) da))
        (ccall error '"Overflow"))
      (swap da)
      (clr.w arg_z)
      (swap arg_z)
      (add.l da arg_z)
      (jsr_subprim $sp-mklong)))
  )

; So, I'm lazy. What else is new?
(defun divide-fixed (number &rest numbers)
  (declare (dynamic-extent numbers))
  (cond ((null numbers) number)
        (t (let ((res (fixed->float number)))
             (dolist (num numbers)
               (setq res (/ res (fixed->float num))))
             (float->fixed res)))))

(defun read-location ()
  (unimplemented))

(defun set-environs (verb param)
  (check-set-environs-errcode (#_SetScriptManagerVariable verb param)))

(defun check-set-environs-errcode (errcode)
  (unless (eql errcode 0)
    (error
     (case errcode
       (#$smBadVerb "Bad verb")
       (#$smBadScript "Bad script")
       (t "Error from #_SetScriptManagerVariable")))))

(defun setScript (script verb param)
  (check-set-environs-errcode (#_SetScriptVariable script verb param)))

; new-just can be :left (or 0) or :right (or -1).
(defun set-sys-just (new-just)
  (#_SetSysDirection (cond ((eq new-just :left) 0)
                      ((eq new-just :right) -1)
                      ((or (eql new-just 0) (eql new-just -1)) new-just)
                      (t (return-from set-sys-just
                           (set-sys-just (require-type new-just
                                                       '(member :left :right 0 -1))))))))
                       
(defun str-2-format ()
  (unimplemented))

#|
(defun string-2-date ()
  (unimplemented))


(defun string-2-time ()
  (unimplemented))
|#

(defun string-2-date (string &key (start 0) (end (length string)))
  "Parses an input string for a date"
  (check-type string string)
  (rlet ((lDateRec :longDateRec)
         (numBytes :signed-long))
    (with-pstrs ((strPtr string))
      (let ((strLen (- end start)))
        (%incf-ptr strPtr (1+ start))
        (let ((status (#_StringToDate strPtr strLen %DateCacheRec%
                       numBytes lDateRec)))
          (values
           (pref lDateRec longDateRec.day)
           (pref lDateRec longDateRec.month)
           (pref lDateRec longDateRec.year)
           status))))))

 (defun string-2-time (string &key (start 0) (end (length string)))
  "Parses an input string for time information"
  (check-type string string)
  (rlet ((lDateRec :longDateRec)
         (numBytes :signed-long))
    (with-pstrs ((strPtr string))
      (let ((strLen (- end start)))
        (%incf-ptr strPtr (1+ start))
        (let ((status (#_StringToTime strPtr strLen %DateCacheRec%
                       numBytes lDateRec)))
          (values
           (pref lDateRec longDateRec.second)
           (pref lDateRec longDateRec.minute)
           (pref lDateRec longDateRec.hour)
           status))))))

; sub-start & sub-end are a sub-string of the part of string
; between start and end.
; text-width is a fixed
;
; returns three values:
; 1) text offset for the break
; 2) :word-break, :character-break, or :no-break
; 3) updated text-width: a fixed
;
(defun styled-line-break (string sub-start sub-end text-width first-run-p
                                 &optional (start 0) end)
  (with-string-portion (string start end cstr len)
    (rlet ((textWidth :long)
           (textOffset :long))
      (setf (%get-long textWidth) text-width
            (%get-long textOffset) (if first-run-p -1 0))
      (let ((break-type (#_StyledLineBreak
                         cstr len (- sub-start start) (- sub-end start) 0
                         textWidth textOffset)))
        (declare (fixnum break-type))
        #-ppc-target
        (setq break-type (ash break-type -8))
        (values (+ (%get-long textOffset) start)
                (case break-type
                  (#.#$smBreakWord :word-break)
                  (#.#$smBreakChar :character-break)
                  (#.#$smBreakOverflow :no-break)
                  (t (error "Unknown break-type: #x~x returned by #_StyledLineBreak"
                            break-type)))
                (%get-long textWidth))))))

(defun text-width (string &optional (start 0) end)
  (with-string-portion (string start end cstr len)
    (#_TextWidth cstr 0 len)))

(defun toggle-date ()
  (unimplemented))

(defun toggle-results ()
  (unimplemented))

(defun transliterate ()
  (unimplemented))

;; not used by us
(defun upper-text (string &optional start end (script #$smRoman))
  (with-string-portion (string start end cstr len)
    (#_UppercaseText cstr len script)
    (if (macptrp string)
      string
      (%get-cstring cstr 0 len))))

;; not used by us
(defun lower-text (string &optional start end (script #$smroman))
  (with-string-portion (string start end cstr len)
    (#_LowercaseText cstr len script)
    (if (macptrp string)
      string
      (%get-cstring cstr 0 len))))

(defun valid-date ()
  (unimplemented))

(defun visible-length (string &optional start end)
  (with-string-portion (string start end cstr len)
    (#_VisibleLength cstr len)))

(defun write-location ()
  (unimplemented))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From the Font manager chapter of IM VI
;;;

(defvar *outline-fonts-supported* nil)

(def-ccl-pointers *outline-fonts-supported* ()
  (setq *outline-fonts-supported*
        (gestalt #$gestaltFontMgrAttr #$gestaltOutlineFonts)))

(defmacro outline-fonts-not-supported ()
  `(error "Outline fonts not supported"))

(defun set-outline-preferred (predicate)
  (if *outline-fonts-supported*
    (#_SetOutlinePreferred predicate)
    (when predicate
      (outline-fonts-not-supported))))

(defun get-outline-preferred ()
  (if *outline-fonts-supported*
    (#_GetOutlinePreferred)
    nil))

(defmacro with-outline-preferred (outline-preferred &body body)
  (let ((temp (gensym)))
    `(let ((,temp (get-outline-preferred)))
       (unwind-protect
         (progn 
           (set-outline-preferred ,outline-preferred)
           ,@body)
         (set-outline-preferred ,temp)))))

(defun is-outline (&optional (numer 1) (denom 1))
  (#_IsOutline numer denom))

(defun set-preserve-glyph (predicate)
  (if *outline-fonts-supported*
    (#_SetPreserveGlyph predicate)
    (when predicate
      (outline-fonts-not-supported))))

(defun get-preserve-glyph ()
  (if *outline-fonts-supported*
    (#_GetPreserveGlyph)
    nil))

(defmacro with-preserve-glyph (preserve-glyph &body body)
  (let ((temp (gensym)))
    `(let ((,temp (get-preserve-glyph)))
       (unwind-protect
         (progn 
           (set-preserve-glyph ,preserve-glyph)
           ,@body)
         (set-preserve-glyph ,temp)))))

; execute body with preserve-glyph & outline-preferred set
; according to FLAG. If outline fonts are not supported, just
; execute body.
(defmacro with-truetype-flags (flag &body body)
  (let ((outline-preferred (gensym))
        (preserve-glyph (gensym))
        (flag-var (gensym)))
    `(let ((,flag-var ,flag)
           (,outline-preferred :unknown)
           (,preserve-glyph :unknown))
       (unwind-protect
         (progn
           (when *outline-fonts-supported*
             (setq ,outline-preferred (get-outline-preferred)
                   ,preserve-glyph (get-preserve-glyph))
             (set-outline-preferred ,flag-var)
             (set-preserve-glyph ,flag-var))
           ,@body)
         (when (neq ,outline-preferred :unknown)
           (set-outline-preferred ,outline-preferred))
         (when (neq ,preserve-glyph :unknown)
           (set-preserve-glyph ,preserve-glyph))))))

; Use #_OutlineMetrics to compute the maximum & minimum y value
; for a block of text.
; Returns two values: max-y and min-y
(defun string-max-and-min-y (string &key start end (numer #@(1 1)) (denom #@(1 1)))
  (%string-max-and-min-y string start end numer denom))

(defun %string-max-and-min-y (string start end numer denom)
  (if (get-outline-preferred)
    (with-string-portion (string start end cstr len)
      (rlet ((yMax :word)
             (yMin :word))
        (#_OutlineMetrics len cstr numer denom yMax yMin
         (%null-ptr) (%null-ptr) (%null-ptr))
        (values (%get-signed-word yMax) (%get-signed-word yMin))))
    (values 0 0)))

; Returns three values: ascent, descent, & leading
; for the string in the current font.
(defun string-font-info (string &key start end (numer #@(1 1)) (denom #@(1 1)))
  (multiple-value-bind (a d w l) (font-info)
    (declare (ignore w) (fixnum a d l))
    (multiple-value-bind (y-max y-min) 
                         (%string-max-and-min-y string start end numer denom)
      (declare (fixnum y-max y-min))
      (values (max a y-max)
              (max d (- y-min))
              l))))

#|
(string-2-time "3:25:12 AM")
|#


(provide "SCRIPT-MANAGER")