;;;-*- Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  4 7/4/97   akh  see below
;;  3 6/2/97   akh  see below
;;  33 1/22/97 akh  %buffer-insert-file - use *input-file-script* iff fred did not write the file
;;                  Handle bogus scriptruns - believe number of CHARS actually in file
;;                  Fix case of no scriptruns but buffer is extended.
;;                  Don't die when script is not installed
;;                  buffer-insert-file - << sometimes length wrong?? its ok now
;;  31 9/15/96 akh  %buffer-insert-file - rearrange wrap stuff
;;  30 9/13/96 akh  %buffer-insert-file - its ok if no frec
;;  29 9/4/96  akh  font-codes-info to sysutils
;;  27 7/26/96 akh  %buffer-insert-file - fix wrap and word-wrap for revert case
;;  26 7/18/96 akh  add a comment
;;  25 6/7/96  akh  maybe a decl or two
;;  23 5/20/96 akh  couple of decls in %snarf-buffer-line
;;                  be defensive in %expand-chunk, %buf-insert-in-gap set extended before grow-gap
;;  22 4/17/96 akh  remove consistency check from buffer-insert-file
;;  21 2/6/96  akh  macro set-fontruns-pos was wrong for PPC - clobbered the font
;;  19 12/24/95 akh buffer-char rets #\null if pos is buffer-size, vs out of bounds svref.
;;  18 12/22/95 gb  get-chunk-buffer looks for dead macptrs in CAR
;;  17 12/12/95 akh used" array in get/set-style is only as big as need be - vs 256
;;  15 12/1/95 akh  no more io to/from lisp strings 
;;                  fix %i-- macro
;;
;;  14 11/30/95 akh make-array - :initial-element nil where it matters
;;  9 10/31/95 akh  dont remember
;;  6 10/26/95 gb   use %istruct.
;;  5 10/23/95 akh  some ppc stuff
;;  4 10/17/95 akh  more from patch 3 - hmm
;;                  use (ppc-target-p) vs *fasl-target*
;;  3 10/13/95 bill ccl3.0x25
;;  2 10/9/95  akh  No more lap for PPC, newer version of the file
;;  31 9/14/95 akh  added convert-kanji-fred (probably belongs in Library)
;;  30 9/14/95 akh  merge patch 3
;;
;;  29 9/14/95 akh  merge patch3 re extended strings
;;  26 8/22/95 akh  fix %buffer-insert-file again for non zero start pos
;;  25 8/18/95 akh  buffer-insert - use fat script for extended string or char
;;  23 7/27/95 akh  buffer-remove-unused fonts - dont reorder unless actually removing some
;;  22 7/27/95 akh  buffer-bytes->chars - script fix
;;  21 7/27/95 akh  %buffer-prescan-style - fix for mixed scripts
;;  20 7/27/95 akh  buffer-char-font-index  make update-key-script-from-click consistent with typing into empty buffer
;;
;;  19 7/27/95 akh  merge %buffer-insert-file patch
;;  17 5/30/95 akh  fix for japanese write/read - ge => geu in squeeze-string-bytes
;;                  get #chars  right in buffer-prescan-style
;;  16 5/30/95 akh  check-read-only-p - refnum is "optional"
;;                  dialog for read-only buffer allows just making buffer writable, or both file and buffer
;;                  dont be so eager to reset insertion font
;;  14 5/23/95 akh  use more mac-file-write-date
;;  13 5/23/95 akh  use mac-file-write-date
;;  12 5/15/95 akh  bill's fix to buffer-get-style
;;  10 5/10/95 akh  fix buffer-write-file :supersede to not whine about write date
;;  8 5/4/95   akh  no declare fixnum ff
;;  7 5/4/95   akh  %buffer-prescan-style
;;  6 5/1/95   akh  change check for fred 2 resource too small
;;  5 4/26/95  akh  minor tuning in buffer-insert
;;  4 4/24/95  akh  messing around with %set-mark
;;  3 4/7/95   akh  fix a fixnum declaration
;;  2 4/4/95   akh  save wrap-p etc in file, add buffer-plist, buffer-justification etc. for buffer-mark and buffer
;;  17 3/14/95 akh  buffer-char-replace - get zmod right
;;  15 3/2/95  akh  fix allocate-chunk for new regime, calls to make-string are explicit about element-type
;;  14 2/17/95 slh  better error dialog
;;  13 2/17/95 akh  macros fontruns-pos and fontruns font always included. Used in l1-sysio too.
;;  12 2/17/95 akh  added function %buffer-position
;;  11 2/9/95  akh  set-mark returns mark not pos
;;  10 2/6/95  akh  added print-rect in a comment
;;  9 2/2/95   akh  add color stuff
;;  8 1/11/95  akh  move modeline
;;  7 1/11/95  akh  none really
;;  (do not edit before this line!!)

; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2007 Digitool, Inc.
 
(in-package :ccl)

;; Modification History

;; remove some pre ppc code
;; buffer-insert-try-harder - special case listener re. letting font for 7bit-ascii be inherited from predecessor
;; fix buffer-insert-file for utf file - want mac-file-write-date vs file-write-date
;; buffer-substring-p - case independent for char arg
;; remove some obsolete code in buffer-forward/backward-find-char
;; ------- 5.2b6
;; buffer-write-file - expectw window to be passed in, 
;; buffer-write-file - reinstate some of the "close all open files" business that was lost post OS9
;; buffer-filename is the file if any - lives in slot bf.owner
;; buffer-write-file works harder if delete-file required a move-to-trash
;; keep track of file-external-format in containing view.
;; buffer-write-file - get window-fsref right after :supersede, and more
;; %buffer-insert-file - don't do ed-xform-crlf here - done elsewhere now
;; -------- 5.2b5
;; 27 Jun 06 fix nasty bugs in move-io-buf-bytes-to-gap and %buffer-insert-file inserting a Mac encoded file with multiple scripts and file bigger than chunksz
;; no more relying on fonts to determine encoding for writing mac encoded files - do it slowly by find-encoding-for-uchar
;; export char-eolp and char-code-eolp
;; find-encoding-for-uchar-slow - more likely to return a Japanese or Korean encoding
;; *transform-CRLF-to-carriage-return* -> *transform-CRLF-to-preferred-eol*
;; add variable *preferred-eol-character*, %buffer-write-file heeds it
;; %buffer-insert-file - error if data fork and resource fork are seriously out of sync
;; ----- 5.2b4
;; find-encoding-for-uchar-slow - dingbats includes all of them, greek -> macgreek rather than macsymbol
;; ----- 5.2b3
;; buffer-insert-substring calls buffer-insert in simple case, fix to buffer-insert-try-harder
;; encoding-to-font-simple - arabic-> geeza pro
;; find-encoding-for-uchar-slow - don't say it's macroman if it isn't
;; add variable *one-byte-encodings* - so things like #$kCFStringEncodingMacVT100 don't confuse move-io-buf-bytes-to-gap and two-byte-encoding-p
;; add variable *transform-CRLF-to-CarriageReturn*
;; ----- 5.2b1
;; %buffer-write-file deals with external-format :unix
;; %buffer-prescan-style - any encoding other than macroman is deemed "fat" and will be saved in scriptruns
;; buffer-write-file - if exchange-files fails don't bother with tem-file 
;; don't say :errchk in #_sethandlesize - :errchk temporarily broken in that case for new headers - fixed now
;; change find-encoding-for-uchar-slow so some dingbats characters aren't deemed korean
;; fix move-io-buf-bytes-to-gap for symbol and dingbats
;; change find-encoding-for-uchar-slow so that some macsymbol/greek characters aren't viewed as japanese
;; fix boot problem re *uchar-encoding-table*
;; fix brain death in buffer-insert-try-harder
;; #_textwidth => xtext-width in buffer-string-width
;; find-font-ff-for-uchar calls buffer-find-font-in-script vs. buffer-find-font-in-script-with-fallback
;; find-encoding-for-uchar does table lookup
;;fix bug in buffer-insert-try-harder
;; truncate-string somewhat less stupid
;; remove bad calls to convert string
;; 01/29/05 scriptruns now encoding runs
;; 12/20/04 make-buffer - character-type default is 'extended-character
;; 12/17/04 %buffer-write-file does external-format (:utf-16 and :utf-8)
;; 12/16/04 make-buffer has owner keyword, %buffer-insert-file uses buffer-owner
;; 12/14/04 open utf-16 or utf-8 files
;; 12/10/04 eol stuff
;; ------ 5.1 finsl
;; delete-file of temporary file passes :temporary-file-p
;; buffer-insert-file - #$fsrdwrperm not needed
;; %buffer-write-style - fix for negative font
;; add-buffer-font - dont think file is modified??
;; trying to lose %path-from-iopb, #_hopenresfile and friends
;; --------- 5.0final
;; dont say handlep
;; fix in buffer-insert-file for negative font
;; fix style vector stuff for negative font
;; %buffer-substring-p had a 1 when it meant i !! and shouldn't callers say case-insensitive !!?? - done
;; fix to buffer-remove-unused-fonts From: "Takehiko Abe" <keke@gol.com>
;; --------- 4.4b5
;; 03/20/01 do flush-volume BEFORE mac-file-write-date - makes classic happier maybe - NOPE
;; getscript -> getscriptvariable
;; buffer-write-file doesn't do the read-only thing if file is locked
;; 04/14/99 akh ADD handle-file-gonzo
;; ------------- 4.3b1
;; 10/12/98 akh  %buffer-insert-file - dtrt when no fred resources and *input-file-script*
;; 05/15/98 akh   %buffer-insert-file - dtrt when a script is not installed.
;;10/28/97  akh   buffer-write-file doesn't do handle-buffer-save-conflict, window-save does
;; 03/03/97 bill  Make the start & end parameters to buffer-get-style optional
;;                so that they agree with the documentation.
;; 02/12/97 bill  PPC version of inline-check-mark errors if the arg is not a buffer-mark
;; 01/14/97 bill  make-buffer initializes bf.refcount to 1, not 0.
;; 12/23/96 akh %buffer-insert-file - use *input-file-script* iff fred did not write the file
;;		Handle bogus scriptruns - believe number of CHARS actually in file
;;		Fix case of no scriptruns but buffer is extended.
;;		Don't die when script is not installed
;;		buffer-insert-file - << sometimes length wrong?? its ok now
;; 12/07/96 akh read-scriptruns to l1-streams
;; -------------  4.0
;;  7/31/96 slh   scriptruns-p -> l1-edbuf.lisp
;; akh %buffer-insert-file - fix wrap and word-wrap for revert case
;; 05/07/96 bill  buffer-substring takes a new, optional, string arg.
;;                If specified, of the right type, and long enough,
;;                it will be used instead of consing up a new string.
;; akh couple of decls in %snarf-buffer-line
;; akh be defensive in %expand-chunk, %buf-insert-in-gap set extended before grow-gap
;;         call %expand-chunk with correct pos sometimes
;; 04/16/96 akh remove consistency check from buffer-insert-file
;; 04/14/96 akh  buffer-char-replace check read-only
;; 02/04/96 akh   macro set-fontruns-pos was wrong for PPC - clobbered the font
;; 01/04/96 bill  buffer-substring-p checks that the substring fits in the buffer
;;                before calling %buffer-substring-p. This prevents the latter
;;                from accessing off the end of the buffer's chunkarr.
;; 12/01/95 bill  #_disposptr -> #_DisposePtr
;; 11/23/95 bill  (#_PBxxx :check-error ...) -> (errchk (#_PBxxxSync ...))
;;                #_RmveResource -> #_RemoveResource
;; 11/13/95 gb    use #_PB traps.
;; 11/08/95 bill  font2script -> FontToScript
;; 10/27/95 slh   inline-check-mark fix
;; 10/12/95 bill  Don't redefine log if it's already defined.
;;  5/09/95 slh   Bill's fix to buffer-remove-unused-fonts
;;  3/24/95 akh   fix %buffer-write-file for extended strings
;;  3/23/95 slh   handle-buffer-save-conflict: use mac-namestring
;;  2/15/95 slh   handle-buffer-save-conflict: truncate filename, use larger dialog
;; 01/03/95 added buffer-previous-script-change
;; 12/31/94 alice added set-buffer-empty-font-codes and index, set-buffer-insert-font-codes,
;;		  buffer-insert-font-codes
; buffer-insert-file failed for empty file (oops)
; buffer-insert-file and remove-unused-fonts use byte array (prevents stack ovf loading finder selected file)
; using-buffer unwind-protect didnt
; alice fix clear-buffer-chunks 
;10/08/93 alice buffer-bwd-up-sexp had a bug if count went to 0 more than once in a line.
;09/22/93 alice buffer-string-width uses %snarf-buffer-line so will work for fat chars,
;		save a few bytes in buffer-font-index, in buffer-bwd-up-sexp \ at eol doesnt count

;11/17/93 bill  buffer-tabcount: make it interact correctly with the MPSR resource
;08/18/93 bill  buffer-insert-file now eliminates duplicate font entries for a single buffer position.
;               There were some of these in the MCL 2.0 on-line help source files, how they got
;               there I don't know.
;07/30/93 bill  %buffer-write-file says mac-namestring instead of namestring.
;               This prevents a file not found error if the user says "Save As..."
;               and types "foo.bar.bletch".
;07/21/93 bill  recompute maxasc, maxdsc, maxwid in buffer-remove-unused-fonts
;               buffer-set-font-codes only calls buffer-set-font-index if it has non-nil start & end args
;               buffer-set-font-index does nothing when (eql start end)
;07/15/93 bill  %snarf-buffer-line ignores the script; just copies all the bytes.
;               %buffer-bytes->chars
;07/14/93 bill  %growfontruns in buffer-insert-file as attempt to speed it up: didn't work.
;07/13/93 bill  buffer-remove-unused-fonts now preserves the buffer-insert-font-index
;07/31/94 alice buffer-bwd-up-sexp moves here from l1-edcmd. Faster
;07/30/93 alice delete-backward & forward easier to read, some fixnum stuff in %xchange-font-index,
;               move-fontruns, %buf-find-font
; ------------ THE END R.I.P.
;-------------- 3.0d12
;07/28/93 alice yet another fix in %xchange-font-index
;07/27/93 alice nother fix in %xchange-font-index and %delete-backward
;07/22/93 alice buffer-set-style and buffer-insert-file do better. Fixed a bug in
;		%xchange-font-index/move-fontruns. %delete-forward and %delete-backward were
;		broken w.r. to fonts.
;07/16/93 alice buffer-set-style better if were font changes in the range (unlikely but its doc'd)
;07/15/93 alice buffer-insert-file and buffer-set-style more efficient. macro set-fontruns was missing a .l 
;07/14/93 alice buffer-forward-search was usually starting before start when crossing the gap.
;07/14/93 alice %buf-next-font-change returns pos font and idx, %buf-find-font does binary search
;07/13/92 alice added buffer-get-scriptruns
;07/10/93 alice forward and backward search work (more slowly) for extended strings but dont know from scripts
;07/05/93 alice added buffer-next-script-change
;06/30/93 alice fix long-standing bug in %buffer-insert-file occurring if filelen = 0 mod chunksz
;		If gapstart = chunksz then gapchunk is the chunk containing 1- gappos
;		and there will be no next chunk if gaplen is 0
;		if 0 <= gapstart < chunksz then gapchunk is the chunk containing gappos
;06/26/93 alice buffer-insert etal make an exception to font inheritance if newline
;		 precedes insertion and following font is different.
;06/26/93 alice buffer-insert-file no longer sets the font to use for next insertion.
;		and make-buffer sets it to %no-font-index
;06/14/93 alice char-byte-table stuff to l1-aprims
;06/11/93 alice %snarf-buffer-line needs to check ptr-len in both fat and skinny cases.
;06/08/93 alice %snarf-buffer-line only transmits fat chars if the script understands them.
;		otherwise display code is likely to become confused.
;06/02/93 alice added *script-char-byte-tables*, get-char-byte-table, make-char-byte-table
;		and %buffer-insert-file deals with fat scripts slowly.
;06/01/93 alice buffer-write-file writes a fred 4 resource if any fat scripts
;05/29/93 alice buffer-prescan-style optionally collects script runs and tells us if any are 2byte
;05/26/93 alice added squeeze-string-bytes
;-------------- 3.0d9
;05/23/93 alice move-string-bytes moved to l1-prims
;05/21/93 alice move-string-bytes and reverse deal with source 8 bit, dest 16 bit.
;		callers of these check for bad case source 16, dest 8 and do something about it.
;05/19/93 alice buffer-fwd-up-sexp faster by ~50%, and does fat strings, %buffer-substring-p does fat strings too.
;05/05/93 alice some stuff for 16 bit strings, buffer-fwd-up-sexp and %buffer-substring-p to do
;		snarf-buffer-line really does fat strings.
;-------------- 2.1d7
;05/05/93 alice fix a fence post in %add-font-change
;04/28/93 bill  %snarf-buffer-line returns two more values
;-------------- 2.1d5 
;04/29/03 alice buffer-forward/backward-find somewhat faster
;04/28/93 alice new %i++ macro - gary changed something so the old one doesnt dwim.
;04/23/93 alice set-buffer-insert-font-index index can be nil meaning clear it.
;		ditto buffer-set-font-codes. Add buffer-empty-font-index, nuke current-buffer-font-index
;04/15/93 alice add-buffer-font and part of buffer-insert-file also without-interrupts - nuke
;04/15/93 alice font-codes-info now without-interrupts - needed due to overuse
;		of %temp-port%?? - nuke this
;03/16/93 bill  no more binding of *cursorhook* in handle-buffer-save-conflict
;02/19/93 alice fix a bug in %move-gap that took a long time to show up.
;11/18/92 bill  buffer-file-write-date
;09/02/92 bill  %snarf-buffer-line takes an optional max-len arg
;03/02/92 bill  moon's handle-buffer-save-conflict support
; fix %buffer-insert-file - uses _open instead of _hopen and a clean pb
; %buffer-write-file had the same problem with files beginning with dot on Quadra
; ... crashes in GoDriver
; today we are doing both the chunk list and the string array!
; BUG - we aren't saving bf-cfont in the file any place - where should it go?
; maybe make cfont be the first used font - then its index is 0 and it works by magic?
; Rewritten mostly in Lisp
;-------------  2.0

(eval-when (:compile-toplevel :execute :load-toplevel)
  (defmacro make-buffer-marks ()
    `(gvector :population 0 0 nil))

      
; to avoid the possibility of bignums
  (defmacro fontruns-font (array idx)
    (let ((arr (gensym)))
      `(the fixnum
         (let ((,arr ,array))
           (declare (optimize (speed 3)(safety 0)))
           (declare (type (simple-array (unsigned-byte 8) (*)) ,arr)) ; lie
           (aref ,arr (%ilsl 2 ,idx)))))
    )


  (defmacro fontruns-pos (array idx)
    (let ((arr (gensym))
          (iv (gensym)))
      `(the fixnum
         (let ((,arr ,array)
               (,iv (%ilsl 1 ,idx)))
           (declare (optimize (speed 3)(safety 0)))
           (declare (type (simple-array (unsigned-byte 16) (*)) ,arr)) ; lie
           (%ilogior (%ilsl 16 (%ilogand (aref ,arr ,iv) #xff))
             (aref ,arr (%i+ 1 ,iv))))))
    )
)

(eval-when (:compile-toplevel :load-toplevel :execute)

(def-accessors %svref
  bfc.prev
  bfc.next
  bfc.string)
)

(eval-when (:compile-toplevel :execute)

(require "FREDENV")

(def-accessors %svref
  nil
  markl.gclink
  markl.data)


(defmacro inline-check-mark (thing)
  (let ((thing-sym (gensym)))
    `(let ((,thing-sym ,thing))
       (unless (eq (ppc-typecode ,thing-sym) ppc::subtag-mark)
         (%badarg ,thing-sym 'buffer-mark)))))
    

(defmacro set-fontruns-font (array idx value)
  (let ((arr (gensym)))
    `(the fixnum
       (let ((,arr ,array))
         (declare (optimize (speed 3)(safety 0)))
         (declare (type (simple-array (unsigned-byte 8) (*)) ,arr)) ; lie
         (setf (aref ,arr (%ilsl 2 ,idx)) ,value))))
  )     



(defmacro set-fontruns-pos (array idx pos)
  (let* ((arr (gensym))
         (iv (gensym))
         (pv (gensym)))
    `(let ((,arr ,array)
           (,iv (%ilsl 1 ,idx)) ; this sucks
           (,pv ,pos))         
       (declare (optimize (speed 3)(safety 0)))
       (locally (declare (type (simple-array (unsigned-byte 8)(*)) ,arr))
         (setf (aref ,arr (%i+ 1 (%ilsl 1 ,iv))) (%ilsr 16 ,pv)))
       (locally (declare (type (simple-array (unsigned-byte 16) (*)) ,arr)) ; lie
         (setf (aref ,arr (%i+ 1 ,iv)) ,pv))))
  )

(defmacro set-fontruns (array idx font pos)
  (let* ((arr (gensym))
         (iv (gensym))
         (pv (gensym)))
    `(let ((,arr ,array)
           (,pv ,pos)
           (,iv (%ilsl 1 ,idx))) ; this sucks
       (declare (optimize (speed 3)(safety 0)))
       (locally (declare (type (simple-array (unsigned-byte 16) (*)) ,arr)) ; lie
         (setf (aref ,arr ,iv) (%ilogior (%ilsl 8 ,font)(%ilsr 16 ,pv)))
         (setf (aref ,arr (%i+ 1 ,iv)) ,pv))))  
  )

(defmacro move-fontrun (array from to)
  (let* ((arr (gensym))
         (fromv (gensym))
         (tov (gensym)))                  
    `(let ((,arr ,array)
           (,fromv (%ilsl 1 ,from))
           (,tov (%ilsl 1 ,to)))
       (declare (optimize (speed 3)(safety 0)))
       (declare (type (simple-array (unsigned-byte 16) (*)) ,arr)) ; lie
       (setf (aref ,arr ,tov)(aref ,arr ,fromv))
       (setf (aref ,arr (%i+ 1 ,tov))(aref ,arr (%i+ 1 ,fromv)))))    
  )

; allow more than 2 args
; Handy.  Good thing it's (eval-when (:compile-toplevel))
; in l1-edbuf.
(defmacro %i++ (a b &rest args)
  (if args `(%i+ ,a (%i++ ,b ,@args))
      `(%i+ ,a ,b)))
           
; not unary
(defmacro %i-- (arg1 arg2 &rest args)
  (if args `(%i- ,arg1 (%i++ ,arg2 ,@args))
      `(%i- ,arg1 ,arg2)))
)                    


(defvar *buffer-fold-bounds* nil)

;; for font to style-vector
(defun font-out (x)(declare (fixnum x)) (if (minusp x)(logand x #xffff) x))

;; for font from style-vector
;(defun font-in (x)(if (> x 32767) (- (+ 32768 (- (logand x #x7fff)))) x))

(defun font-in (x)(declare (fixnum x))(if (> x 32767)(%i+ -32768 (logand x #x7fff))  x))



(defun buffer-mark-p (thing)
  (eq (ppc-typecode thing) ppc::subtag-mark))
      
(set-type-predicate 'buffer-mark 'buffer-mark-p)


#|
; unused, just frob the fixnum
(defun bf-flags (buf &optional newval)  
  (if newval
    (progn (dpb (the fixnum newval) (byte 5 0) (the fixnum (bf.fixnum buf))) newval)
    (ldb (byte 5 0) (the fixnum (bf.fixnum buf)))))
                     
|#


(defconstant %no-font-index #xff)

; contrary to what one might think bf-cfont is for empty buffer
; and bf-efont is for next insertion.
(defun set-buffer-insert-font-index  (mark findex)
  (let ((buf (mark-buffer mark)))
    (when findex
      (setq findex (1- findex)))
    (if (and (eq 0 (bf.bufsiz buf)) findex)
      (progn (bf-cfont buf findex)(bf-efont buf %no-font-index))
      (bf-efont buf (or findex %no-font-index))))
  nil)

(defun set-buffer-empty-font-index  (mark findex)
  (let ((buf (mark-buffer mark)))
    (when findex
      (setq findex (1- findex)))
    (bf-cfont buf (or findex %no-font-index)))
  nil)
    

; font index for next insertion if any, else nil
(defun buffer-insert-font-index (mark)
  (let ((buf (mark-buffer mark)))
    (if (eq 0 (bf.bufsiz buf))
      (1+ (bf-cfont buf))
      (let ((it (bf-efont buf)))
        (if (neq it %no-font-index)
          (1+ it)
          nil)))))

(defun bf-chartype (buf &optional newval)
  (let ((fix (bf.fixnum buf)))
    (if newval
      (setf (bf.fixnum buf)
            (if (eq newval 'extended-character)
              (%ilogior fix #x200000)
              (%ilogand fix #x1FFFFF)))
      (if (%ilogbitp 21 fix) 'extended-character 'base-character))))

(defun bf-efont (buf &optional newval)
  (if newval
    (progn (setf (bf.fixnum buf)(dpb (the fixnum newval) (byte 8 5) (bf.fixnum buf))) newval)
    (ldb (byte 8 5) (bf.fixnum buf))))

 

(defun bf-cfont (buf &optional newval)
  (if newval
    (progn (setf (bf.fixnum buf)(dpb (the fixnum newval) (byte 8 13) (bf.fixnum buf))) newval)
    (ldb (byte 8 13) (bf.fixnum buf))))

; the font to use for the next insertion #xff means none



#|
(defun bf-gfont (buf &optional newval)
  (if newval
    (progn (setf (bf.fixnum buf)(dpb (the fixnum newval) (byte 8 21) (bf.fixnum buf))) newval) 
    (ldb (byte 8 21) (bf.fixnum buf))))
|#





#+PPC-target
(defun move-string-bytes-reverse (source dest off1 off2 n)
  (declare (optimize (speed 3)(safety 0)))
  (declare (fixnum off1 off2 n))
  (if (simple-base-string-p source)
    (if (simple-base-string-p dest)
      (locally
        (declare (type (simple-array (unsigned-byte 8) (*)) dest))
        (declare (type (simple-array (unsigned-byte 8) (*)) source))
        (dotimes (i n)
          (setf (aref dest (%i- off2 i 1)) (aref source (%i- off1 i 1)))))
      (if t ; (simple-extended-string-p dest)
        (locally
          (declare (type (simple-array (unsigned-byte 16) (*)) dest))
          (declare (type (simple-array (unsigned-byte 8) (*)) source))
          (dotimes (i n)
            (setf (aref dest (%i- off2 i 1)) (aref source (%i- off1 i 1)))))))    
    (if (simple-base-string-p dest)
      (locally
        (declare (type (simple-array (unsigned-byte 16) (*)) SOURCE))
        (declare (type (simple-array (unsigned-byte 8) (*)) dest))
        (dotimes (i n)
          (setf (aref dest (%i- off2 i 1)) (aref source (%i- off1 i 1)))))
      (if  t ;(simple-extended-string-p dest)
        (locally
          (declare (type (simple-array (unsigned-byte 16) (*)) dest))
          (declare (type (simple-array (unsigned-byte 16) (*)) source))
          (dotimes (i n)
            (setf (aref dest (%i- off2 i 1)) (aref source (%i- off1 i 1)))))))))


(defloadvar *chunk-buffer* nil)
#|
; should be resource or pool or somesuch
(defun get-chunk-buffer (size-in-bytes)
  (without-interrupts
   (if (and *chunk-buffer* (not (macptrp (car *chunk-buffer*)))) ; ie dead - should set nil in save app
     (setq *chunk-buffer*  nil))
   (let ((buf *chunk-buffer*))
     (if (and buf (>= (cdr buf) size-in-bytes)) ; the size is in there someplace - pointer-size but may ret nil? 
       (prog1 buf (setq *chunk-buffer* nil))
       (cons (#_newptr size-in-bytes) size-in-bytes)))))         

(defun free-chunk-buffer (buf)
  (without-interrupts
   (if (null *chunk-buffer*)
     (setq *chunk-buffer* buf)
     (#_DisposePtr (car buf)))))
|#

;; now get 2 buffers
(defun get-chunk-buffer (size-in-bytes)
  (without-interrupts
   (if (and *chunk-buffer* (or (not (macptrp (car *chunk-buffer*)))(not (consp  (cdr *chunk-buffer*))))) ; ie dead - should set nil in save app
     (setq *chunk-buffer*  nil))
   (let ((buf *chunk-buffer*))
     (if (and buf (>= (second buf) size-in-bytes)) ; the size is in there someplace - pointer-size but may ret nil? 
       (prog1 buf (setq *chunk-buffer* nil))
       (list  (#_newptr size-in-bytes) size-in-bytes (#_newptr size-in-bytes))))))         

(defun free-chunk-buffer (buf)
  (without-interrupts
   (if (null *chunk-buffer*)
     (setq *chunk-buffer* buf)
     (progn (#_DisposePtr (car buf))
            (#_Disposeptr (third buf))))))

(defun x%put-my-ptr (pb chunk pb-offset buffer chunk-offset size)
  (x%put-my-string pb (bfc.string chunk) pb-offset buffer chunk-offset size))

(defun x%put-my-string (pb string pb-offset buffer offset size)
  (declare (ignore pb-offset))
  (%copy-ivector-to-ptr string offset buffer 0 size)
  
  (setf (pref pb :FSForkIOParam.buffer) buffer)
  ;(%put-ptr pb buffer pb-offset)
  )

(defun copy-ptr-to-chunk (ptr chunk offset size-in-bytes)
  (%copy-ptr-to-ivector ptr 0 (bfc.string chunk) offset size-in-bytes))

(defun copy-ptr-to-string (ptr string offset size-in-bytes)
  (%copy-ptr-to-ivector ptr 0 string offset size-in-bytes))




#|
(defun font-codes-info (ff-code ms-code)
  (with-port %temp-port%
    (with-font-codes ff-code ms-code
      (rlet ((fi :fontinfo))
        (#_GetFontInfo fi)
        (values (rref fi fontinfo.ascent)
                (rref fi fontinfo.descent)
                (rref fi fontinfo.widmax)
                (rref fi fontinfo.leading))))))
|#

(defun %buf-signal-read-only ()
  (error (make-condition 'modify-read-only-buffer)))

; formerly %%buf-check-buffer
(defun mark-buffer (mark)  
  (if (typep mark 'buffer-mark)
    (mark.buffer mark)
    (report-bad-arg mark 'buffer-mark)))

(defmethod buffer-plist ((buffer buffer))
  (bf.plist buffer))

(defmethod buffer-plist ((buffer buffer-mark))
  (bf.plist (mark-buffer buffer)))  

(defmethod set-buffer-plist ((buffer buffer) plist)
  (unless (plistp plist) (report-bad-arg plist '(satisfies plistp)))
  (setf (bf.plist buffer) plist))

(defmethod set-buffer-plist ((buffer buffer-mark) plist)
  (unless (plistp plist) (report-bad-arg plist '(satisfies plistp)))
  (setf (bf.plist (mark-buffer buffer)) plist))

(defsetf buffer-plist set-buffer-plist)

(defun buffer-getprop (buffer prop &optional default)
  (getf (buffer-plist buffer) prop default))

(defsetf buffer-getprop buffer-putprop)

(defun %buffer-maxwid (buffer)
  (bf.maxwid (mark-buffer buffer)))

(defun %buffer-maxdsc (buffer)
  (bf.maxdsc (mark-buffer buffer)))

(defun %buffer-maxasc (buffer)
  (bf.maxasc (mark-buffer buffer)))

(defun buffer-putprop (buffer prop value)
  (let ((plist (buffer-plist buffer)))
    (set-buffer-plist buffer (setprop plist prop value))
    value))

(defun buffer-chunk-size (buffer)
  (bf.chunksz (mark-buffer buffer)))

(defun buffer-purge-fonts-p (buffer &optional (new-value nil new-value-p))
  (let* ((the-buffer (mark-buffer buffer))
         (flags (bf.fixnum the-buffer)))
    (if (not new-value-p)
      (logbitp $bf_purge-fonts-flag flags)
      (progn
        (if new-value
          (setq flags (logior flags (ash 1 $bf_purge-fonts-flag)))
          (setq flags (logand flags (lognot  (ash 1 $bf_purge-fonts-flag)))))
        (setf (bf.fixnum the-buffer) flags)
        new-value))))

(defun same-buffer-p (mark1 mark2)
  (eq (mark-buffer mark1)(mark-buffer mark2)))



;A position arg may be NIL meaning use buffer mark, T meaning end of buffer,
;an integer position, or a mark on the same buffer.
; should be optimized for nil?
; doesn't make a whole lot of difference

(defun buffer-position (mark &optional pos)
  (locally (declare (optimize (speed 3)(safety 0)))
    (inline-check-mark mark)
    (let* ((the-buffer (mark.buffer mark)))
      (cond ((fixnump pos)
             (locally (declare (fixnum pos))
               (if (or (< pos 0)(%i> pos (bf.bufsiz the-buffer))) 
                 (progn (if (null *buffer-fold-bounds*)                          
                         (error "Buffer position ~S out of bounds for ~S." pos mark)
                         (if (>  pos 0)(bf.bufsiz the-buffer) 0)))
                 pos)))
            ((eq pos t)
             (bf.bufsiz the-buffer))
            (t
             (cond ((null pos)
                    (setq pos (mark.value mark)))
                   ((or (eq pos mark)(and (typep pos 'buffer-mark)(eq (mark.buffer pos) the-buffer)))
                    (setq pos (mark.value pos)))
                   (t (error '"~S is not a valid position in ~S." pos mark)))
             (locally (declare (fixnum pos))
               (setq pos (ash pos -1))
               (if (%i> pos (bf.gappos the-buffer))
                 (%i- pos (%i- (bf.gapend the-buffer)(bf.gapstart the-buffer)))
                 pos)))))))

(defun %buffer-position (mark)
  (declare (optimize (speed 3)(safety 0)))
  (let* ((the-buffer (mark.buffer mark))
         (pos (mark.value mark)))
    (declare (fixnum pos))
    (setq pos (ash pos -1))
    (if (%i> pos (bf.gappos the-buffer))
      (%i- pos (%i- (bf.gapend the-buffer)(bf.gapstart the-buffer)))
      pos)))



;End position may not be NIL.
; buffer-range - returns start, end

(defun buffer-range (mark end start)
  (setq start (buffer-position mark start))
  (locally (declare (fixnum start)(optimize (speed 3)(safety 0)))
    (let ((buffer (mark.buffer mark)))
      (cond ((fixnump end)
             (locally (declare (fixnum end))
               (let ((size (bf.bufsiz buffer)))
                 (declare (fixnum size))
                 (if (or (< end 0)(> end size))
                   (progn 
                     (if (null *buffer-fold-bounds*)
                       (error "Buffer position ~S out of bounds for ~S." end mark)
                       (setq end (if (> end 0) size 0))))))))
            ((eq end t)
             (setq end (bf.bufsiz buffer)))            
            ((or (eq end mark)(and (typep end 'buffer-mark)(eq (mark.buffer end) buffer)))
             (setq end (ash (the fixnum (mark.value end)) -1))
             (if (%i> end (bf.gappos buffer))
               (setq end (%i- end (%i- (bf.gapend buffer)(bf.gapstart buffer))))))
            (t (error "~S is not a valid end in buffer ~S" end mark)))
      (if (%i> end start)(values start end)(values end start)))))



(defun buffer-size (buffer)
  (bf.bufsiz (mark-buffer buffer)))

;(= (buffer-position buffer pos) (buffer-size buffer))
(defun buffer-end-p (buffer &optional pos)
  (= (buffer-position buffer pos) (buffer-size buffer)))

;(= (buffer-position buffer pos) 0) - one caller - who needs it
(defun buffer-start-p (buffer &optional pos)
  (= 0 (buffer-position buffer pos)))

;(= (buffer-position buffer) (buffer-position buffer pos))
(defun mark-equal-p (buffer posn)
  (= (buffer-position buffer) (buffer-position buffer posn)))

(defun buffer-modcnt (buffer)
  (let ((bf (mark-buffer buffer)))
    (abs (bf.modcnt bf)))) ; was (bclr ($ 31) acc) ???

(defun set-buffer-modcnt (buffer cnt)
  (let ((bf (mark-buffer buffer)))
    (setf (bf.modcnt bf) cnt)))

(defun make-buffer (&Key (chunk-size #x400)
                         (character-type 'extended-character)
                         (read-only nil)
                         (font *fred-default-font-spec*)
                         (owner nil))
  (let (ff ms)
    (setq chunk-size (require-type chunk-size '(integer 4 #x7FFF)))
    (let ((buf (%istruct
                'buffer
                chunk-size                          ; bf.chunksz
                nil                                 ; bf.gapchunk
                0                                   ; bf.gapstart
                0                                   ; bf.gapend
                0                                   ; bf.gappos
                0                                   ; bf.bufsiz
                1                                   ; bf.bfonts
                0                                   ; bf.afonts
                (make-array 1 :element-type '(unsigned-byte 32) :initial-element 0)   ; bf.fontruns
                (make-buffer-marks)                 ; bf.bmarks
                (make-buffer-marks)                 ; bf.amarks
                0                                   ; bf.modcnt
                0                                   ; bf.bmod
                0                                   ; bf.zmod
                nil                                 ; bf.plist
                0                                   ; bf.maxasc - later
                0                                   ; bf.maxdsc - later
                0                                   ; bf.maxwid - later
                (progn
                  (multiple-value-setq (ff ms)        ; bf.flist
                    (font-codes font
                                (make-point 0 $monaco)
                                (make-point 9 $srcOr)))
                  (vector ff ms))
                0                                   ; bf.fixnum
                1                                   ; bf.refcount
                (make-array 1)			    ; bf.chunkarr
		0				    ; bf.logsiz
                nil				    ;bf.undo-string
                nil				    ;bf.undo-redo
                nil                                 ;bf.fred-history
                owner                               ;bf.owner
                )))         
      (let ((ilen (integer-length chunk-size)))
        (if (eq ilen (integer-length (1- chunk-size)))
          (progn (setq chunk-size (expt 2 ilen))  ; not power of 2, round up
                 (setf (bf.chunksz buf) chunk-size)
                 (setf (bf.logsiz buf) ilen))
          (setf (bf.logsiz buf) (1- ilen))))
      #|
      (multiple-value-bind (log rem)(truncate (log chunk-size 2))
        (when (not (zerop rem))
          (setq chunk-size (expt 2 (setq log (1+ log))))
          (setf (bf.chunksz buf) chunk-size))
        (setf (bf.logsiz buf) log))|#
      (bf-efont buf %no-font-index)
      (if read-only (%buffer-set-read-only buf t))
      (when (eq character-type 'extended-character)
        (bf-chartype buf 'extended-character))
      (multiple-value-bind (ascent descent maxwid) ; this is all obs anyway
                           (font-codes-info ff ms)
        (setf (bf.maxasc buf) ascent)
        (setf (bf.maxdsc buf) descent)
        (setf (bf.maxwid buf) maxwid))
      (cons-mark buf 1))))

; log is defined in numbers or in ppc-float
(unless (fboundp 'log)

(defun log (num base)
  (declare (ignore  base))
  (case num
    (128 7)
    (256 8)
    (512 9)
    (1024 10)
    (2048 11)
    (4096 12)))

)
  
    
  



;Use a resource now.
(defvar *%buffer-chunks%* nil)
(def-ccl-pointers make-buffer-chunks-resource ()
  (setq *%buffer-chunks%* (%cons-pool nil)))
     
(defun kill-buffer (b &aux buf)
  (setq b (require-type b 'buffer-mark))
  (when (and b (setq buf (mark.buffer b))
             (<= (bf.refcount buf) 0))
    (without-interrupts
     (%buffer-set-read-only b nil)
     (buffer-delete b 0 t)
     (clear-buffer-chunks buf)
     (setf (bf.gapend buf) 0)
     (dolist (mark (markl.data (bf.amarks buf)))
       (setf (mark.value mark) 1))))    ; magic
  nil)

; free all chunks in buffer b -

(defun clear-buffer-chunks (b)
  (let* ((c (bf.gapchunk b))
         (poolchunk (pool.data *%buffer-chunks%*)))
    (setf (bf.gapchunk b) nil)
    (setf (bf.chunkarr b) nil)
    (when c
      (while (bfc.prev c)(setq c (bfc.prev c)))
      (setf (pool.data *%buffer-chunks%*) c)
      (while (bfc.next c)
        (setf (bfc.prev c) nil)
        (setq c (bfc.next c)))      
      (setf (bfc.next c) poolchunk))))

(defun use-buffer (b)
  (let ((buf (mark-buffer b)))
    (incf (bf.refcount buf))))

(defun unuse-buffer (b)  
  (let* ((buf (mark-buffer b))
         (refcount (1- (bf.refcount buf))))
    (when (>= refcount 0)
      (setf (bf.refcount buf) refcount))
    (when (<= refcount 0)
      (kill-buffer b))
    refcount))

(defmacro using-buffer (buf &body body)
  (let ((buf-var (gensym))
        (used-var (gensym)))
    `(let* ((,buf-var ,buf)
            (,used-var nil))
       (unwind-protect
         (progn
           (use-buffer ,buf-var)
           (setq ,used-var t)
           ,@body)
         (when ,used-var (unuse-buffer ,buf-var))))))

; ahh - mark.value is 2*pos (incl gap) + 1 if not bwdp
(defun make-mark (mark &optional posn bwd-p)
  (setq posn (buffer-position mark posn))
  (let* ((buffer (mark.buffer mark))
         (gappos (bf.gappos buffer)))
    (declare (fixnum gappos posn))
    (setq posn (%i++ posn posn (if bwd-p 0 1)))
    (when (> posn (%i+ gappos gappos))
      (let* ((gaplen (%i- (bf.gapend buffer) (bf.gapstart buffer))))
        (setq posn (%i++ posn gaplen gaplen))))
    (cons-mark buffer posn)))

(defun cons-mark (the-buffer posn)
  (let ((mark (%ppc-gvector 
               ppc::subtag-mark
               posn
               the-buffer)))
    (buf-insert-mark (cons mark nil))
    mark))

(defun buf-insert-mark (x)
  (declare (optimize (speed 3)(safety 0)))
  (without-interrupts
   (let* ((mark (%car x))
          (pos (mark.value mark))
          (buf (mark.buffer mark))
          (gappos (bf.gappos buf))
          before markl)
     (declare (fixnum pos gappos))
     (setq before
           (if (%i> pos (%i+ gappos gappos))
             (let ((amarks (markl.data (setq markl (bf.amarks buf)))))
               (declare (list amarks))
               (do* ((last nil l)
                     (l amarks (cdr l)))
                    ((or (null l)(%i>= (mark.value (car l)) pos)) last)
                 (declare (list last l))))
             (let ((bmarks (markl.data (setq markl (bf.bmarks buf)))))
               (do* ((last nil l)
                     (l bmarks (cdr l)))
                    ((or (null l)(%i<= (mark.value (car l)) pos)) last)
                 (declare (list last l))))))    
     (cond ((not before) 
            (setf (markl.data markl)(%rplacd x (markl.data markl))))
           (t (%rplacd x (%cdr before))
              (%rplacd before x))))))
  

(defun move-mark (mark &optional distance)
  (locally (declare (optimize (speed 3)(safety 0)))
    (progn ;without-interrupts
     (let* ((buffer (mark-buffer mark))
            (pos (ash (mark.value mark) -1))
            (size (bf.bufsiz buffer)))
       (declare (fixnum pos size))
       (if (not distance) (setq distance 1)(require-type distance 'fixnum))
       (when (%i> pos (bf.gappos buffer))
         (setq pos (- pos (%i- (bf.gapend buffer)(bf.gapstart buffer)))))
       (setq pos (%i+ pos distance))
       (when (or (> pos size)(< pos 0))
         (when (null *buffer-fold-bounds*) ; do we need this?
           (error "Buffer position ~S out of bounds for ~S." pos buffer))
         (setq pos (if (> pos 0) size 0)))
       (%set-mark mark pos)
       mark))))

(defun set-mark (buffer pos)
  (%set-mark buffer (setq pos (buffer-position buffer pos)))
  buffer)

#|
; not quite right and shouldnt be needed
(defun x%set-mark (mark pos)
  (lap-inline (mark pos)
    ;(dc.w #_debugger)
    (move.l arg_y atemp1)
   (move.l (svref atemp1 mark.value) dy)      ; dy is old pos in mark
   (move.l (svref atemp1 mark.buffer) atemp0) ; atemp0 is buffer
   (add.l acc acc)     ; acc is 2 * pos
   (if# (ne (btst ($ $fixnumshift) dy))
     (add.l (fixnum 1) acc))
   (move.l (svref atemp0 bf.gappos) da)
   (add.l da da)       ; da is 2 * gappos
   (if# (gt (cmp.l da acc))  ; if pos > gappos
     (move.l (svref atemp0 bf.gapend) db)
     (sub.l (svref atemp0 bf.gapstart) db)
     (add.l db db)     ; db is 2 * delta
     (add.l db acc))   ; acc is pos + 2 * delta
   (move.l acc (svref atemp1 mark.value))   ; put pos in mark
   (move.l atemp1 dx)            ; the mark
   (if# (gt (cmp.l da dy))
     (move.l (svref atemp0 bf.amarks) atemp1)   ; look for it in amarks
    else#
     (move.l (svref atemp0 bf.bmarks) atemp1))
   ;(lea (vref.l atemp1 markl.data (- $_cdr)) atemp1)
   (move.l (svref atemp1 markl.data) atemp1)
   (prog#
    (dc.w #_debugger)
    (move.l atemp1 atemp0)
    (cdr atemp1 atemp1)                ; atemp1 is next
    (until# (eq (car atemp1) dx)))
   (cdr atemp1 atemp1)
   (with-preserved-registers #(asave0 asave1)
     (car atemp0 asave0)
     (car atemp1 asave1)
     (dc.w #_debugger)
     (if# (gt (cmp.l da dy))   ; in amarks     
       (if# (and (or (eq (cmp.l atemp0 nilreg))
                     (ge (cmp.l (svref asave0 mark.value) acc)))
                 (or (eq (cmp.l atemp1 nilreg))
                     (lt (cmp.l (svref asave1 mark.value) acc))))
         (bra out)
         else#
         (if# (and (or (eq (cmp.l atemp0 nilreg))
                       (le (cmp.l (svref asave0 mark.value) acc)))
                   (or (eq (cmp.l atemp1 nilreg))
                       (gt (cmp.l (svref asave1 mark.value) acc))))
           (bra out))))                     
     (move.l atemp1 (cdr atemp0))   ; splice it out
     (ccall buf-insert-mark atemp1)
     (dc.w #_debugger)
     out))
  NIL)
|#


; returns NIL
(defun %set-mark (mark pos)
  (declare (optimize (speed 3)(safety 0)))
  (progn ;without-interrupts
   (let* ((mpos  (mark.value mark))
          (buf (mark.buffer mark))
          (gappos (bf.gappos buf))
          markl am ap)
     (declare (fixnum mpos pos gappos))
     (setq gappos (%i+ gappos gappos))
     (setq pos (%i+ pos pos))
     (if (%ilogbitp 0 mpos)(setq pos (1+ pos)))
     (when (%i> pos gappos)
       (let ((delta (%i- (bf.gapend buf)(bf.gapstart buf))))
         (setq ap t)
         (setq pos (%i++ pos delta delta))))
     (unless (eq pos mpos)
       (if (%i> mpos gappos)
         (progn (setq markl (bf.amarks buf))
                (setq am t))
         (setq markl (bf.bmarks buf)))
       (let ((marks (markl.data markl)))
         (declare (list marks))
         ;(setf (mark.value mark) pos)
         (do* ((last nil l)
               (l marks (cdr l)))
              ()
           (declare (list l last))
           (when (null l) (error "phooey")) ; it's supposed to be there
           (when (eq (car l) mark)   ; find it
             (let ((next (cdr l)))
               (declare (list next))
               (when (eq am ap)      ; is it still in the right place?
                 (if am
                   (when (and (or (not last)
                                  (%i>= pos (mark.value (car last))))
                              (or (not next)(%i>= (mark.value (car next)) pos)))
                     (setf (mark.value mark) pos)
                     (return))               
                   (when (and (or (not last)
                                  (%i<= pos (mark.value (car last))))
                              (or (not next)(%i<=  (mark.value (car next))  pos)))
                     (setf (mark.value mark) pos)
                     (return))))
               (without-interrupts
                (setf (mark.value mark) pos)
                (cond (last (rplacd last next))  ; not in the right place. Nuke it
                      (t (setf (markl.data markl)(cdr marks))))
                (buf-insert-mark l)))
             (return-from %set-mark)))))
     nil)))

      

(defun mark-backward-p (mark)
  (inline-check-mark mark)  
  (not (logbitp 0 (mark.value mark))))

; changed at the Cumberland Gap - is this right when insert a substring?
(defun %buf-changed (buf &optional pos)
  (declare (optimize (speed 3)(safety 0)))
  (when (not pos)(setq pos (bf.gappos buf)))
  (let* ((cnt (bf.modcnt buf))
         (to-end (- (bf.bufsiz buf) pos)))
    (declare (fixnum cnt gappos to-end))
    ; bmod is distance in chars from start
    ; zmod is distance in chars from end
    ; chars between the two need to be redisplayed
    (setf (bf.modcnt buf) (%i+ 1 cnt))
    (when (%i< to-end (bf.zmod buf))
      (setf (bf.zmod buf) to-end))
    (when (%i< pos (bf.bmod buf))
      (setf (bf.bmod buf) pos))))

; assumes gap at pos, pos not 0
(defun %font-exception (buf pos)
  (let ((afonts (bf.afonts buf)))
    (when (not (%izerop afonts))
      (let* ((fontruns (bf.fontruns buf))
             (len (length fontruns))
             (fpos (fontruns-pos fontruns (%i- len afonts))))
        (when (eq pos (%i- fpos (%i- (bf.gapend buf)(bf.gapstart buf))))
          (when (char-eolp (%buffer-char buf (1- pos)))
            (1+ (fontruns-font fontruns (%i- len afonts)))))))))
      
      
; do something sensible if thing is extended and font is not 2 byte
#|
(defun buffer-insert (mark thing &optional posn font)
  (when (symbolp thing)
    (setq thing (string thing)))
  (without-interrupts
   (setq posn (buffer-position mark posn))   
   (let* ((the-buffer (mark.buffer mark))
          (gappos (bf.gappos the-buffer)))
     (declare (fixnum posn gappos) (optimize (speed 3)(safety 0)))    
     (when (not (= gappos posn))
       (%move-gap the-buffer (%i- posn gappos)))    
     (when  (%ilogbitp $bf_r/o-flag (bf.fixnum the-buffer))
       (%buf-signal-read-only))
     (when (null font)
       (let ((efont (bf-efont the-buffer)))
         (cond ((neq efont %no-font-index)
                (setq font (1+ efont)))
               ((neq 0 posn)
                (setq font (%font-exception the-buffer posn))))))
     (when (or (extended-character-p thing)
               (extended-string-p thing)) ; if string, check if needs to be fat!
       (setq font (buffer-extended-font? mark thing font)))
     (cond
      ((stringp thing)        
       (let ((strlen (length thing)))
         (declare (fixnum strlen))
         (unless (= 0 strlen)           
           (if font 
             (progn 
               (%buf-change-font mark font)
               ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
               )
             (when (= 0 (the fixnum (bf.bufsiz the-buffer)))
               (setf (bf.bfonts the-buffer) 1)
               (let ((fontruns (bf.fontruns the-buffer)))              
                 (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))
           (multiple-value-bind (str strb)(array-data-and-offset thing)
             (declare (fixnum strb))
             (%buf-insert-in-gap the-bu≤ffer str strb strlen)))))
      ((characterp thing)       
       (when font (%buf-change-font mark font))
       (let* ((gapstart (bf.gapstart the-buffer))
              (gapend (bf.gapend the-buffer)))
         (declare (fixnum gapstart gapend))         
         (when (= gapstart gapend)
           (%buf-grow-gap the-buffer 1)
           (setq gapend (bf.gapend the-buffer)))        
         (%buf-changed the-buffer)          
         (let* ((gapchunk (bf.gapchunk the-buffer))
                (bufsiz (bf.bufsiz the-buffer)))
           (declare (fixnum bufsiz))
           (when (and (= 0 bufsiz) (not font)) ;(= 0 (bf.bfonts the-buffer))) ; old code lets bfonts be 0
             (setf (bf.bfonts the-buffer) 1)
             (let ((fontruns (bf.fontruns the-buffer)))              
               (set-fontruns fontruns 0 (bf-cfont the-buffer) 0)))
           (when (= (the fixnum (bf.chunksz the-buffer)) gapstart) ; huh
             (setf (bf.gapchunk the-buffer)(setq gapchunk (bfc.next gapchunk)))
             (setf (bf.gapend the-buffer)(- gapend gapstart))
             (setq gapstart 0))
           (setf (bf.gapstart the-buffer)(%i+ 1 gapstart))
           (setf (bf.gappos the-buffer)(%i+ 1 posn)) 
           (setf (bf.bufsiz the-buffer)(%i+ 1 bufsiz))           
           (when (and (extended-character-p thing)(simple-base-string-p (bfc.string gapchunk)))
             (%expand-chunk gapchunk the-buffer posn))
           (setf (%schar (bfc.string gapchunk) gapstart) thing)
           ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
           )))
      (t (require-type thing '(or character string))))
     ;(check-runs the-buffer thing)
     ))
  t)
|#

;; font is either nil or a list like '(:plain) or a font-index into fontruns - if fixnum font provided, assume correct
(defun buffer-insert (mark thing &optional posn font)
  (when (symbolp thing)
    (setq thing (string thing)))
  (let ((start 0)
        (strlen 0))
    (declare (fixnum start strlen))
    (when (stringp thing)
      (setq strlen (length thing))
      (multiple-value-setq (thing start)(array-data-and-offset thing)))    
    (without-interrupts
     (setq posn (buffer-position mark posn))     
     (let* ((the-buffer (mark.buffer mark))
            (gappos (bf.gappos the-buffer)))
       (declare (fixnum posn gappos) (optimize (speed 3)(safety 0)))    
       (when  (%ilogbitp $bf_r/o-flag (bf.fixnum the-buffer))
         (%buf-signal-read-only))    
       (when (not (= gappos posn))
         (%move-gap the-buffer (%i- posn gappos)))
       (when (not (fixnump font))
         (when (and (stringp thing)
                    (or (not (7bit-ascii-p thing start (%i+ start strlen)))
                        (not (memq (ff-encoding (buffer-char-font-codes mark posn)) *script-list*))))
           (return-from buffer-insert (buffer-insert-try-harder mark thing posn font start (%i+ strlen start))))           
         (let (d-font d-ff d-ms)
           (when (characterp thing)
             (let ((cur-encoding (ff-encoding (buffer-char-font-codes mark posn))))
               (when (or (%i> (%char-code thing) #x7f)
                         (not (memq cur-encoding *script-list*)))  ;; beware something like dingbats lurking nearby             
                 (multiple-value-setq (d-font d-ff d-ms) (buffer-extended-font-simple2 mark thing font start (%i+ strlen start) ))
                 (when d-font
                   (if (consp font) 
                     (multiple-value-bind (new-fs new-ms) (font-codes font d-ff d-ms)
                       (setq font (add-buffer-font mark new-fs new-ms)))
                     (setq font d-font))))))))
       (when (null font)
         (let ((efont (bf-efont the-buffer)))
           (cond ((neq efont %no-font-index)
                  (setq font (1+ efont)))
                 ((neq 0 posn)
                  (setq font (%font-exception the-buffer posn))))))
       (cond
        ((stringp thing)        
         (let ()
           (unless (= 0 strlen)           
             (if font 
               (progn 
                 (%buf-change-font mark font)
                 ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
                 )
               (when (= 0 (the fixnum (bf.bufsiz the-buffer)))
                 (setf (bf.bfonts the-buffer) 1)
                 (let ((fontruns (bf.fontruns the-buffer)))              
                   (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))
             
             (%buf-insert-in-gap the-buffer thing start strlen))))
        ((characterp thing)       
         (when font (%buf-change-font mark font))
         (let* ((gapstart (bf.gapstart the-buffer))
                (gapend (bf.gapend the-buffer)))
           (declare (fixnum gapstart gapend))         
           (when (= gapstart gapend)
             (%buf-grow-gap the-buffer 1)
             (setq gapend (bf.gapend the-buffer)))        
           (%buf-changed the-buffer)          
           (let* ((gapchunk (bf.gapchunk the-buffer))
                  (bufsiz (bf.bufsiz the-buffer)))
             (declare (fixnum bufsiz))
             (when (and (= 0 bufsiz) (not font)) ;(= 0 (bf.bfonts the-buffer))) ; old code lets bfonts be 0
               (setf (bf.bfonts the-buffer) 1)
               (let ((fontruns (bf.fontruns the-buffer)))              
                 (set-fontruns fontruns 0 (bf-cfont the-buffer) 0)))
             (when (= (the fixnum (bf.chunksz the-buffer)) gapstart) ; huh
               (setf (bf.gapchunk the-buffer)(setq gapchunk (bfc.next gapchunk)))
               (setf (bf.gapend the-buffer)(- gapend gapstart))
               (setq gapstart 0))
             (setf (bf.gapstart the-buffer)(%i+ 1 gapstart))
             (setf (bf.gappos the-buffer)(%i+ 1 posn)) 
             (setf (bf.bufsiz the-buffer)(%i+ 1 bufsiz))           
             (when (and (extended-character-p thing)(simple-base-string-p (bfc.string gapchunk))) ;; never happens today
               (%expand-chunk gapchunk the-buffer posn))
             (setf (%schar (bfc.string gapchunk) gapstart) thing)
             ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
             )))
        (t (require-type thing '(or character string))))
       ;(check-runs the-buffer thing)
       ))
    t))

;; today font is nil or '(:plain)
(defun buffer-insert-try-harder (mark string posn in-font start end) ;; start and end arent optional
  ;(declare (ignore-if-unused posn))
  ;; string is unicode with possibly more than one script/encoding and we know its a string - is it simple? - yes 
  ;; bug re in-font = cons I think
  (let* ((curpos start)
         last-ff last-ms
         font-style
         efont-index
         last-encoding
         (posn (buffer-position mark posn))
         (tl *top-listener*)
         (in-listener (and tl (same-buffer-p (fred-buffer tl) mark))))
    (declare (fixnum curpos start end))
    (when (and (consp in-font)(null (cdr in-font))
               (assq (car in-font) *style-alist*))
      (setq font-style in-font in-font nil))
    (cond ((null in-font)
           (let* ((the-buffer (mark-buffer mark))
                  (efont (bf-efont the-buffer)))
             (cond ((neq efont %no-font-index)
                    (setq in-font (1+ efont))
                    (setq efont-index in-font))
                   ((neq 0 posn)
                    (setq in-font (%font-exception the-buffer posn)))))))
    (cond ((fixnump in-font) 
           (multiple-value-setq (last-ff last-ms) (buffer-font-index-codes mark in-font)))
          ((null in-font)
           (multiple-value-setq (last-ff last-ms)(buffer-char-font-codes mark posn)))
          (t (error "Unexpected font ~s" in-font)))
    (if last-ff (setq last-encoding (ff-encoding last-ff)))    
    (while (< curpos end)
      (let* ((char-code (%scharcode string curpos))
             (encoding (%find-encoding-for-uchar-code char-code)))
        (declare (fixnum char-code))
        (if (and (<= char-code #x7f)  ;; making the bold assumption that all can print 7bit-ascii
                 (not in-listener)  ;; ?? maybe always forego this assumption??
                 last-encoding
                 (neq last-encoding encoding)
                 (or efont-index
                     (and  (memq last-encoding *script-list*)
                           (memq encoding *script-list*))))          
          (setq encoding last-encoding))
        (if (not last-encoding)  ;; shouldn't happen
          (progn (setq last-encoding encoding)
                 (multiple-value-setq (last-ff last-ms)(buffer-find-font-for-encoding mark encoding))))
        (when (or (eq curpos end)(not (= last-encoding encoding)))
          (if (not last-ff) (multiple-value-setq (last-ff last-ms) (buffer-find-font-for-encoding mark last-encoding)))
          (if (consp font-style)
            (setq last-ff (font-codes font-style last-ff last-ms)))
          (buffer-insert-substring-utf mark string start curpos posn (add-buffer-font mark last-ff last-ms))
          (multiple-value-setq (last-ff last-ms)(buffer-find-font-for-encoding mark encoding))
          (setq last-encoding encoding)
          (incf posn (- curpos start))
          (setq start curpos))          
        (incf curpos)
        (when (eq curpos end)                 
          (if (consp font-style)
            (multiple-value-setq (last-ff last-ms)(font-codes font-style last-ff last-ms)))
          (buffer-insert-substring-utf mark string start curpos posn (add-buffer-font mark last-ff last-ms)))))))      


;; called when just a character inserted - 
(defun find-font-ff-for-uchar (uchar mark)  
  (let ((char-code (char-code uchar)))
    (declare (fixnum char-code))
    (let ((encoding (if (<= char-code #x7f) #$kcfstringencodingmacroman (%find-encoding-for-uchar-code char-code))))       
      (buffer-find-font-for-encoding mark encoding))))



(defun ff-encoding (ff)
  (font-to-encoding-no-error (ash ff -16)))

; Return two values: ff & ms of font corresponding to the given encoding.
; Search backwards from pos, then try forwards, then get system font for
; the script.
;; sort of like buffer-find-font-in-script but don't retrun dingbats when looking for roman

(defun buffer-find-font-for-encoding (buf encoding &optional (pos (buffer-position buf)))
  (let ((cpos pos)
        cff)
    (block find-font
      (loop
        (setq cff (ccl::buffer-char-font-codes buf cpos))
        (when (eql encoding (ff-encoding cff))
          (return-from find-font))
        (unless (setq cpos (ccl::buffer-previous-font-change buf cpos))
          (return)))
      (setq cpos pos)
      (loop
        (unless (setq cpos (buffer-next-font-change buf cpos))
          (return))
        (setq cff (ccl::buffer-char-font-codes buf pos))
        (when (eql encoding (ff-encoding cff))
          (return-from find-font)))
      (setq cff nil))
    (multiple-value-bind (ff ms) (ccl::buffer-char-font-codes buf pos)
      (values
       (make-point (point-h ff)
                   (if cff
                     (point-v cff) 
                     (encoding-to-font-simple encoding)
                     ))
       ms))))



#|
(defun encoding-to-font-simple (encoding)
  (case encoding
    (#.#$kcfstringencodingmacdingbats (font-number-from-name-simple  "Zapf Dingbats"))
    (#.#$kcfstringencodingmacsymbol (font-number-from-name-simple  "Symbol"))
    (#.#$kcfstringencodingmacVT100 (font-number-from-name-simple "VT100"))
    (#.#$kcfstringencodingmacArabic (font-number-from-name-simple "Geeza Pro"))
    (t (let ((script (if (memq encoding *script-list*) encoding (if encoding (encoding-to-script encoding)))))
         (if script
           (script-to-font-simple script)
           (error "Can't find font for encoding ~x" encoding))))))
|#
#| (setq foo "⏏␣⏏⎋⎈⎇⌫⌧⌦⌥⌤⌃⇪⇥⇤⇟⇞↪↩"  ) |#

(defun encoding-to-font-simple (encoding)
  (or (cdr (assq encoding *script-font-alist*))
      (case encoding
        (#.#$kcfstringencodingmacdingbats (font-number-from-name-simple  "Zapf Dingbats"))
        (#.#$kcfstringencodingmacsymbol (font-number-from-name-simple  "Symbol"))
        (#.#$kcfstringencodingmacVT100 (font-number-from-name-simple "VT100"))
        (#.#$kcfstringencodingmacArabic (font-number-from-name-simple "Geeza Pro"))
        (t 
         (multiple-value-bind (script langid fname)(encoding-to-script-info encoding) ;; defined in pathnames.lisp - gets ".Keyboard" for 41
           (declare (ignore langid))
           (if fname 
             (font-number-from-name-simple fname)
             (if script
               (script-to-font-simple script)
               (error "Can't find font for encoding ~s" encoding))))))))
    

(defparameter *macjapanese-symbol-char-codes*
  '(969 968 967 966 965 964 963 961 959 958 957 956 955 954 953 952 951 950 949 948 
    947 946 945 936 935 934 933 932 931 929 928 927 926 925 924 923 922 921 920 919 918 917 916 915 914 913))

(defun find-encoding-for-uchar-slow  (uchar)
  (let ((buf-len 8)
        (char-code (char-code uchar)))
    (declare (fixnum char-code))
    (if (or (<= char-code #x7f)(memq char-code *macroman-char-codes*))
      #$kcfstringencodingMacRoman      
      (if (memq char-code '(188 189 190))  ;; don't let these be korean - 1/4 etal - actually do - they exist in mackorean.
                                           ;; #_gettextandencoding... says macroman 3 chars long - e.g. 1 and / and 4
                                           ;; dont exist in CE though some CE fonts can print them
        #$kcfstringencodingmackorean ; #$kcfstringencodingmacCentralEurRoman
        (if (or (and (>= char-code #x38e)(<= char-code #x3A1))
                (and (>= char-code #x3A3)(<= char-code #x3ce))
                (and (>= char-code #x3d0)(<= char-code #x3f5))) ;; and more?? - else they become japanese
          (if (memq char-code *macjapanese-symbol-char-codes*)  ;;let em be Japanese make Takehiko Abe happier ? re keyboard sync etc
            #$kcfstringencodingmacjapanese       ;; also make saving file as mac encoded happier
            #$kcfstringencodingMacSymbol)   ;; was macGreek in MCL 5.2b4          
          (if 
            #+ignore
            (memq char-code '(#x2713 #x2716 #X271A #x2720 #x2731 #X273d #X273f #X2740 #X2741 #X2747
                                #x2748 #X274d #x2756))  ;; korean otherwise            
            (or (<= #x2701 char-code #x2704)
                 (<= #x2706 char-code #x2709)
                 (<= #x270c char-code #x2752)
                 (= char-code #x2756)
                 (<= #X2758 char-code #x275e)
                 (<= #x2761 char-code #x2767)
                 (<= #x2776 char-code #x2794)
                 (<= #x2798 char-code #x27be))             
            #$kcfstringencodingMacDingbats            
            (%stack-block ((ustr buf-len)
                           (out-buf buf-len))
              (%put-word ustr char-code)        
              (with-macptrs ((cfstr (#_cfStringCreateWithCharacters (%null-ptr) ustr 1)))
                (rlet ((out-encoding :unsigned-long)
                       (out-len :unsigned-long))
                  (let ((err (#_GetTextAndEncodingFromCFString cfstr out-buf buf-len out-len out-encoding)))
                    ;; the only err is for #xfffe - byte swapping BOM - 45 deemed roman with out-len 0
                    (let ((encoding (if (eq err #$noerr)(%get-unsigned-long out-encoding) nil)))
                      (#_cfrelease cfstr)                      
                      (if encoding 
                        (setq encoding (%ilogand encoding #xffff))) ;; lose eurosign - sigh
                      (if (eq encoding #$kcfstringencodingmacroman) (setq encoding #xff))
                      ;; dont say roman if it isn't! previously 41212 chars were deemed so
                      (or encoding #xff))))))))))))

;; redefined below to do table lookup based on results of find...slow
(defun find-encoding-for-uchar (uchar)
  (find-encoding-for-uchar-slow uchar))
                                      
                    

#|
(defun buffer-extended-font-simple2 (mark thing &optional font start end)
  ;(declare (ignore font))
  (let (ff ms last-ff)
    (if (characterp thing)
      (multiple-value-bind (ff ms)(find-font-ff-for-uchar thing mark)
        (values (add-buffer-font mark ff ms) ff ms))
      (progn
        (dotimes (i (- end start))
          (multiple-value-setq (ff ms)(find-font-ff-for-uchar (%schar thing (+ i start)) mark))
          (if (and last-ff (not (= last-ff ff)))
            (return-from buffer-extended-font-simple2 nil))
          (setq last-ff ff))
        (if (consp font)
          (multiple-value-setq (ff ms) (font-codes font ff ms)))
        (values (add-buffer-font mark ff ms) ff ms)))))
|#

(defun buffer-extended-font-simple2 (mark thing &optional font start end)
  (declare (ignore-if-unused start end))
  (let (ff ms)
    (if (characterp thing)
      (progn 
        (multiple-value-setq (ff ms)(find-font-ff-for-uchar thing mark))
        (if (consp font)
          (multiple-value-setq (ff ms) (font-codes font ff ms)))        
        (values (add-buffer-font mark ff ms) ff ms))
      #+ignore  ;; only do for character 
      (let (last-ff)
        (dotimes (i (- end start))
          (multiple-value-setq (ff ms)(find-font-ff-for-uchar (%schar thing (+ i start)) mark))
          (if (and last-ff (not (= last-ff ff)))
            (return-from buffer-extended-font-simple2 nil))
          (setq last-ff ff))
        (if (consp font)
          (multiple-value-setq (ff ms) (font-codes font ff ms)))
        (values (add-buffer-font mark ff ms) ff ms)))))

;; for 1 unicode char - we hope this is never called 
;; is for (65534 64260 64259 190 189 188) 65534 errors (its byte swapping bom?) 189 = 1/2 -> korean 
;; not called today - it errors and previously only called for 65534 64260 64259
;; worked on dec 14 - prior to MACHO frenzy
;; actually crashes now maybe unicode-runinfo is the culprit - yes 
#+ignore
(defun get-scriptruns-from-utf-buf-simple (ustr ustr-size)  
  (let ((run-info (unicode-runinfo :utf-16))
        (buffer-size (+ ustr-size ustr-size))
        (options (logior #$kUnicodeUseFallbacksMask
                         #$kUnicodeTextRunMask
                         #$kUnicodeKeepSameEncodingMask)))
    ;; something is wrong here if more than one run
    (if (eq (%get-word ustr 0) 65534)(return-from get-scriptruns-from-utf-buf-simple nil))
    (%stack-block ((buffer buffer-size))
      (with-lock-grabbed ((runinfo-lock run-info))
        (let* ((err 0)
               (rcount 2))  ;; or less
          (declare (fixnum err rcount))
          (progn
            (%stack-block ((script-runs (* #.(record-length :scriptcoderun)
                                           rcount)))
              (rlet ((offset-count :unsigned-long)
                     (offset-arr :pointer)
                     (read-len :unsigned-long)
                     (output-len :unsigned-long)
                     (script-count :itemcount))
                (setq err (#_ConvertFromUnicodeToScriptCodeRun 
                           (runinfo-ptr run-info)
                           ustr-size
                           ustr
                           options
                           0                  ; iOffsetCount
                           (%null-ptr)        ; iOffsetArray
                           offset-count       ; not used
                           offset-arr         ; not used
                           buffer-size
                           read-len
                           output-len
                           buffer            ; can this be null? - no gets paramerr
                           rcount
                           script-count
                           script-runs))
                (case err
                  ((#.#$noerr #.#$kTECUsedFallbacksStatus #.#$kTECOutputBufferFullStatus)
                   (let* ((scount (%get-unsigned-long script-count))
                          script) 
                     (if (neq scount 1) (error "phooey"))                     
                     (setq script (pref script-runs :scriptcoderun.script))
                     script))
                  ((#.#$kTECArrayFullErr) ;; huh
                   ;(error "phooey")
                   ;(incf rcount 10)
                   nil  ;; or :too-many-scripts
                   )
                  ;; get $kTECPartialCharErr -8753         ;  input buffer ends in the middle of a multibyte character, conversion stopped
                  ;; for 190 - what? and 64260 64259 
                  (t (error "ConvertFromUnicodeToScriptCodeRun failed with ~A." err))))))))))
  )


;; assume we know thing is utf16-encoded character or string - if string we know there is only one encoding
#|  ;; unused
(defun buffer-insert-utf (mark thing &optional posn font)
  (when (symbolp thing)  ;; ??
    (setq thing (string thing)))
  (without-interrupts
   (setq posn (buffer-position mark posn))   
   (let* ((the-buffer (mark.buffer mark))
          (gappos (bf.gappos the-buffer))
          (strb 0)
          (strlen 0))
     (declare (fixnum posn gappos strb strlen) (optimize (speed 3)(safety 0)))    
     (when (not (= gappos posn))
       (%move-gap the-buffer (%i- posn gappos)))    
     (when  (%ilogbitp $bf_r/o-flag (bf.fixnum the-buffer))
       (%buf-signal-read-only))
     (when (stringp thing)
       (setq strlen (length thing))
       (multiple-value-setq (thing strb)(array-data-and-offset thing)))
     (when (null font)(error "confused"))     
     (cond
      ((stringp thing)        
       (let ()
         (unless (= 0 strlen)           
           (if font 
             (progn 
               (%buf-change-font mark font)
               ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
               )
             (when (= 0 (the fixnum (bf.bufsiz the-buffer)))
               (setf (bf.bfonts the-buffer) 1)
               (let ((fontruns (bf.fontruns the-buffer)))              
                 (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))
           (progn ;multiple-value-bind (str strb)(array-data-and-offset thing)  ;; do this sooner!!
             ;(declare (fixnum strb))
             (%buf-insert-in-gap the-buffer thing strb strlen)))))
      ((characterp thing)       
       (when font (%buf-change-font mark font))
       (let* ((gapstart (bf.gapstart the-buffer))
              (gapend (bf.gapend the-buffer)))
         (declare (fixnum gapstart gapend))         
         (when (= gapstart gapend)
           (%buf-grow-gap the-buffer 1)
           (setq gapend (bf.gapend the-buffer)))        
         (%buf-changed the-buffer)          
         (let* ((gapchunk (bf.gapchunk the-buffer))
                (bufsiz (bf.bufsiz the-buffer)))
           (declare (fixnum bufsiz))
           (when (and (= 0 bufsiz) (not font)) ;(= 0 (bf.bfonts the-buffer))) ; old code lets bfonts be 0
             (setf (bf.bfonts the-buffer) 1)
             (let ((fontruns (bf.fontruns the-buffer)))              
               (set-fontruns fontruns 0 (bf-cfont the-buffer) 0)))
           (when (= (the fixnum (bf.chunksz the-buffer)) gapstart) ; huh
             (setf (bf.gapchunk the-buffer)(setq gapchunk (bfc.next gapchunk)))
             (setf (bf.gapend the-buffer)(- gapend gapstart))
             (setq gapstart 0))
           (setf (bf.gapstart the-buffer)(%i+ 1 gapstart))
           (setf (bf.gappos the-buffer)(%i+ 1 posn)) 
           (setf (bf.bufsiz the-buffer)(%i+ 1 bufsiz))           
           (when (and (extended-character-p thing)(simple-base-string-p (bfc.string gapchunk)))
             (%expand-chunk gapchunk the-buffer posn))
           (setf (%schar (bfc.string gapchunk) gapstart) thing)
           ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
           )))
      (t (require-type thing '(or character string))))
     ;(check-runs the-buffer thing)
     ))
  t)
|#


; change the font at the gap
(defun %buf-change-font (mark font)
  (let* ((buffer (mark.buffer mark))
         (size (bf.bufsiz buffer))
         (fontruns (bf.fontruns buffer))
         (gapfont (if (= 0 size)
                    (bf-cfont buffer)
                    (fontruns-font fontruns (%i- (bf.bfonts buffer) 1)))))
    (declare (fixnum size))
    (cond ((consp font)
           (multiple-value-bind (oldff oldms)(%buffer-font-codes buffer gapfont)
             (multiple-value-bind (ff ms)(font-codes font oldff oldms)
               (setq font (%i- (add-buffer-font mark ff ms) 1)))))
          ((fixnump font)
           (setq font (1- font))
           (when (not (<= 0 font (1- (ash (length (bf.flist buffer)) -1))))
             (error "~s is not a valid font index in ~s" (1+ font) buffer)))
          (t (report-bad-arg font '(or fixnum cons))))
    (if (= 0 size)
      (progn
        (setf (bf.bfonts buffer) 1)
        (set-fontruns fontruns 0 font 0))        
      (when (not (= gapfont font))
        (%buf-insert-font buffer font)))))
              

(defun %buf-insert-in-gap (the-buffer thing org len)
  (declare (fixnum org len)(optimize (speed 3)(safety 0)))
  (let* ((gapstart (bf.gapstart the-buffer))
         (gaplen (%i- (bf.gapend the-buffer) gapstart))
         (chunksz (bf.chunksz the-buffer))
         (bufsiz (bf.bufsiz the-buffer))
         (extendp (simple-extended-string-p thing)))
    (declare (fixnum gapstart gaplen chunksz bufsiz))
    (when extendp (bf-chartype the-buffer 'extended-character)) ; so grow gap will get extended strings
    (without-interrupts     
     (when (< gaplen len)
       (%buf-grow-gap the-buffer (- len gaplen))
       (setq gaplen (%i- (bf.gapend the-buffer) gapstart)))
     (%buf-changed the-buffer)
     (let ((gapchunk (bf.gapchunk the-buffer))) 
       (when (= (bf.chunksz the-buffer) gapstart) ; huh
         (setq gapchunk (bfc.next gapchunk))
         (setq gapstart 0))
       (let* ((chars-left len)
              (nchars 0)
              (chars-in-chunk (- chunksz gapstart))
              (dest-org gapstart))
         (declare (fixnum chars-left nchars chars-in-chunk dest-org))
         (loop
           (when extendp
             (when (simple-base-string-p (bfc.string gapchunk))
               (%expand-chunk gapchunk the-buffer (bf.gappos the-buffer)))) ; <<
           (setq nchars
                 (if (< chars-left chars-in-chunk) chars-left chars-in-chunk))
           (move-string-bytes thing (bfc.string gapchunk)
                                   org dest-org nchars)
           (when (>= 0 (setq chars-left (- chars-left nchars)))
             (return))
           (setq gapchunk (bfc.next gapchunk))
           (setq dest-org 0)
           (setq chars-in-chunk chunksz)
           (setq org (+ org nchars)))
         (setq gapstart (+ dest-org nchars)))
       (setf (bf.gapchunk the-buffer) gapchunk)
       (setf (bf.gapend the-buffer)(%i+ gapstart (%i- gaplen len)))
       (setf (bf.gapstart the-buffer) gapstart)
       (setf (bf.gappos the-buffer)(%i+ len (bf.gappos the-buffer)))
       (setf (bf.bufsiz the-buffer)(%i+ len bufsiz))
       ))))

#| ;; not used today
(defun buffer-extended-font? (mark thing font)
  (let* ((the-buffer (mark.buffer mark))
         ff ms)
    (cond ((listp font)
           (multiple-value-bind (oldff oldms)
                                (%buffer-font-codes 
                                 the-buffer 
                                 (if (= 0 (bf.bufsiz the-buffer))
                                   (bf-cfont the-buffer)
                                   (fontruns-font (bf.fontruns the-buffer)(%i- (bf.bfonts the-buffer) 1))))
             (if font
               (multiple-value-setq (ff ms) (font-codes font oldff oldms))
               (setq ff oldff ms oldms))))
          ((fixnump font)
           (multiple-value-setq (ff ms)(buffer-font-index-codes mark font))))
    (let* ((script (FF-script ff)))
      (when (logbitp #$smsfSingByte (#_getscriptvariable script #$smscriptflags))
        (when (or (characterp thing)(real-xstring-p thing))
          (multiple-value-bind (eff)(extended-string-font-codes)
            (when eff
              ; keep old face and size?
              (setq font (add-buffer-font mark (make-point (point-h ff)(point-v eff)) ms)))))))
    font))
|#

#|
; fix him same as buffer-insert for fat string, skinny font
(defun buffer-insert-substring (mark string &optional
                                     (start 0) (end (length string))
                                     position font)  
  (unless (<= 0 start end (length string))
    (error "Start or end out of range"))          
  (multiple-value-bind (string strb)(array-data-and-offset string)    
    (without-interrupts
     (setq position (buffer-position mark position))     
     (locally (declare (fixnum start end strb position))
       (let* ((the-buffer (mark.buffer mark))
              (gappos (bf.gappos the-buffer))
              (len (- end start)))
         (declare (fixnum len  gappos))
         (unless (= 0 len)           
           (when (not (= gappos position))
             (%move-gap the-buffer (- position gappos)))
           (when (not font)
             (let ((efont (bf-efont the-buffer)))
               (cond ((neq efont %no-font-index)
                      (setq font (1+ efont)))
                     ((neq 0 position)
                      (setq font (%font-exception the-buffer position))))))
           (when (not font)
             (when (extended-string-p string)  ;; wrong wrong
               (setq font (buffer-extended-font? mark string font))))
           (if font 
             (progn (%buf-change-font mark font)
                    ;(bf-efont the-buffer %no-font-index) ; 5/28
                    )
             (when (= 0 (the fixnum (bf.bufsiz the-buffer)))
               (setf (bf.bfonts the-buffer) 1)
               (let ((fontruns (bf.fontruns the-buffer)))              
                 (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))
           (%buf-insert-in-gap the-buffer string (%i+ strb start) len)))))))
|#

(defun buffer-insert-substring (mark string &optional
                                     (start 0) (end (length string))
                                     position font)  
  (unless (<= 0 start end (length string))
    (error "Start or end out of range"))
  (cond
   ((and (eq 0 start)(eq end (length string))(7bit-ascii-p string))
    (buffer-insert mark string position font))
   (t      
    (multiple-value-bind (string strb)(array-data-and-offset string)
      (setq start (+ start strb))
      (setq end (+ end strb))
      (when (null position)(setq position (buffer-position  mark)))
      (let* ((the-buffer (mark-buffer mark))
             (gappos (bf.gappos the-buffer)))
        (when (not (= gappos position))  ;; does this happen?
          (%move-gap the-buffer (%i- position gappos))))
      (buffer-insert-try-harder mark string position font start end))))) 


;; is used - font is always provided and hopefully correct
(defun buffer-insert-substring-utf (mark string start end
                                     position font)  
  (unless (<= 0 start end (length string))
    (error "Start or end out of range"))          
  (progn ;multiple-value-bind (string strb)(array-data-and-offset string) ;; when we get here it is a simple string?  yes   
    (without-interrupts
     (locally (declare (fixnum start end strb position))
       (let* ((the-buffer (mark.buffer mark))
              (gappos (bf.gappos the-buffer))
              (len (- end start)))
         (declare (fixnum len  gappos))
         (unless (= 0 len)           
           (when (not (= gappos position))  ;; we think callers already do this 
             (%move-gap the-buffer (- position gappos)))                      
           (if font 
             (progn (%buf-change-font mark font)
                    ;(bf-efont the-buffer %no-font-index) ; 5/28
                    )
             (when (= 0 (the fixnum (bf.bufsiz the-buffer)))
               (setf (bf.bfonts the-buffer) 1)
               (let ((fontruns (bf.fontruns the-buffer)))              
                 (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))
           (%buf-insert-in-gap the-buffer string start len)))))))

#| ; debugging
(defun count-chunks (mark)
  (let ((buf (mark-buffer mark)))
    (let ((chunk (bf.gapchunk buf))
          (n 1))
      (let ((foo chunk))
      (while (setq foo (bfc.next foo))(incf n))
      (setq foo chunk)
      (while (setq foo (bfc.prev foo))(incf n)))
      n)))

(defun check-chunks (mark)
  (let ((buf (mark-buffer mark)))
    (let ((chunk (bf.gapchunk buf))
          (chunkarr (bf.chunkarr buf))
          (i 0))
      (while (bfc.prev chunk)(setq chunk (bfc.prev chunk)))
      (loop
        (print (type-of (bfc.string chunk)))
        (when (not (eq (bfc.string chunk)(svref chunkarr i)))
          (print i))
        (setq i (1+ i))
        (setq chunk (bfc.next chunk))
        (when (not chunk) (return))))))

(defun check-marks (mark)
  ; this can't help if the problem is losing a mark.
  (let* ((buf (mark-buffer mark))
         (amarks (bf.amarks buf))
         (bmarks (bf.bmarks buf))
         (gappos (bf.gappos buf))
         (gaplen (- (bf.gapend buf)(bf.gapstart buf)))
         (bufsiz (bf.bufsiz buf))
         (max (1+ (* 2 (+ bufsiz gaplen))))
         (last #xffffff))
    (dolist (m (markl.data bmarks))      
      (let ((v (mark.value m)))
        ;(when (not (logbitp 0 v))(print m))
        (when (or (< v 0)(> v (+ gappos gappos 1))(> v last))(error "puke"))
        (setq last v)))
    (setq last (+ gappos gaplen))
    (dolist (m (markl.data amarks))      
      (let ((v (mark.value m)))
        ;(when (not (logbitp 0 v))(print m))
        (when (or (> v max)(< v (* 2 (+ gappos gaplen)))(< v last))(error "puke"))
        (setq last v)))))

(defun print-runs (mark)
  (let* ((buf (mark-buffer mark))
         (fontruns (bf.fontruns buf))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         (gaplen (- (bf.gapend buf)(bf.gapstart buf)))
         (len (length fontruns)))
    (DOTIMES (i bfonts)
      (let ((value (uvref fontruns i)))
        (format t "~A,~a  " (ash value -24)(logand #xffffff value))))
    (dotimes (i afonts)
      (let ((value (uvref fontruns (+ (- len afonts) i))))
        (format t "~A,~a  " (ash value -24)(- (logand #xffffff value) gaplen))))))
(defun print-raw (mark)
  (let* ((buf (mark-buffer mark))
         (fontruns (bf.fontruns buf))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         ;(gaplen (- (bf.gapend buf)(bf.gapstart buf)))
         (len (length fontruns)))
    (DOTIMES (i bfonts)
      (let ((value (uvref fontruns i)))
        (format t "~A,~a  " (ash value -24)(logand #xffffff value))))
    (dotimes (i afonts)
      (let ((value (uvref fontruns (+ (- len afonts) i))))
        (format t "~A,~a  " (ash value -24)(logand #xffffff value))))))
  

(defun check-runs (mark &optional flg)
  (let* ((buf (mark-buffer mark))
         (fontruns (bf.fontruns buf))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         (gaplen (- (bf.gapend buf)(bf.gapstart buf)))
         (gappos (bf.gappos buf))
         (len (length fontruns))
         (last -1)
         (max-font (buffer-font-count mark))
         (font))
    (DOTIMES (i bfonts)
      (let ((pos (fontruns-pos fontruns i))
            (f (fontruns-font fontruns i)))
        (when (or (<= pos last)(eq f font)(>= f max-font)
                  (if (zerop gappos)(> pos gappos)(>= pos gappos)))
          (cerror "fie" "foo ~a ~a ~a ~a ~a" pos last gappos font flg))
        (setq font f)
        (setq last pos)))
    (dotimes (i afonts)
      (let ((pos (fontruns-pos fontruns (+ (- len afonts) i)))
            (f (fontruns-font fontruns (+ (- len afonts) i))))
        (setq pos (- pos gaplen))
        (when (or (<= pos last)(eq f font)(< pos gappos)(>= f max-font))
          (cerror  "foo" "fie ~A ~A ~A ~A ~A" pos last gappos font flg))
        (setq font f)
        (setq last pos)))))

(defun print-runs (mark)
  (let* ((buf (mark-buffer mark))
         (fontruns (bf.fontruns buf))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         (gaplen (- (bf.gapend buf)(bf.gapstart buf)))
         (len (length fontruns)))
    (format t "~%~A ~a ~a ~A~%" (buffer-size mark)(bf.gappos buf) bfonts afonts)
    (DOTIMES (i bfonts)
      (let ()
        (format t "~A,~a  " (fontruns-font fontruns i)(fontruns-pos fontruns i))))
    (dotimes (i afonts)
      (let ((idx  (+ (- len afonts) i)))
        (format t "~A,~a  " (fontruns-font fontruns idx)(- (fontruns-pos fontruns idx) gaplen))))))

(defun print-rect (rect)
  (print (list (point-string (rref rect :rect.topleft))(point-string (rref rect :rect.botright)))))

|#

; assumes that gap is currently where the font belongs
; and font is a valid font index

(defun %buf-insert-font (buf font)  
  (let* ((fontruns (bf.fontruns buf))
         (len (length fontruns))
         (bfonts (bf.bfonts buf)) 
         (gappos (bf.gappos buf))
         (afonts (bf.afonts buf))
         (gaplen (%i- (bf.gapend buf)(bf.gapstart buf))))
    (declare (fixnum len bfonts gappos afonts gaplen))
    ;(when (= gappos (fontruns-pos fontruns (1- bfonts)))(error "puke"))
    ; font changes at the gap belong in afonts - unless buffer is empty
    (when (not (= font (fontruns-font fontruns (1- bfonts)))) ; callers probably checked this
      (let* ((easier (and (> afonts 0)  ; first after gap font change at gapend?
                          (= (%i+ gappos gaplen)
                             (fontruns-pos fontruns (- len afonts)))))
             (oldbfont (when (not easier) (fontruns-font fontruns (1- bfonts)))))
        ; nuke aftergap fontrun at gapend if same as new font
        (without-interrupts
         (when (and easier (= font (fontruns-font fontruns (- len afonts))))
           (setf (bf.afonts buf)(setq afonts (1- afonts))))
         (cond
          ((zerop gappos)
           (when (not easier)
             (when (%i< (- len (%i+ afonts bfonts)) 1)
               (setq fontruns (%growfontruns buf afonts bfonts))
               (setq len (length fontruns))))
           (set-fontruns fontruns 0 font 0))
          (t
           (when (< (%i- len (%i+ afonts bfonts)) 2)
             (setq fontruns (%growfontruns buf afonts bfonts))
             (setq len (length fontruns)))
           (set-fontruns fontruns bfonts font gappos)
           (setf (bf.bfonts buf)(1+ bfonts))))
         (when (and (not easier) (not (= gappos (bf.bufsiz buf))))
           (set-fontruns fontruns (%i-- len afonts 1) oldbfont (%i+ gappos gaplen))
           (setf (bf.afonts buf) (1+ afonts))))))    
    font))


(defun %growfontruns (buf afonts bfonts &optional need)
  (declare (fixnum afonts bfonts))
  (let* ((fontruns (bf.fontruns buf))
         (len (length fontruns))
         (avail (%i- len (%i+ afonts bfonts))))
    (cond 
     ((and need (< need avail))
      fontruns)
     (t (let* ((newlen (%i+ len (max 2 (ash (%i+ len 3) -2) 
                                   (if need (%i+ 2 (- need avail)) 0))))
               (newvect (make-array newlen  :element-type '(unsigned-byte 32))))
          (declare (fixnum newlen))
          (dotimes (i bfonts)
            (set-fontruns newvect i (fontruns-font fontruns i)(fontruns-pos fontruns i)))
          (dotimes (i afonts)
            (set-fontruns  newvect (%i- newlen i 1)
                           (fontruns-font fontruns (%i- len i 1))
                           (fontruns-pos fontruns (%i- len i 1))))
          (setf (bf.fontruns buf) newvect)
          newvect)))))          

#|
(defun %buf-grow-gap (buf n)
  (let* ((gapend (bf.gapend buf))
         ;(gapchunk (bf.gapchunk buf))
         (chunksize (bf.chunksz buf)))
    (if (>= (+ (bf.bufsiz buf) n (- gapend (bf.gapstart buf))) #xFFFFFF)
      (error '"Buffer size limit exceeded"))
    (multiple-value-bind (n lastchunk)(%buf-allocate-chunks buf chunksize n)
      (when (and ;gapchunk
                 (< gapend chunksize))
        ; gotta move some good characters from gapchunk to new lastchunk
        (move-string-bytes (svref (bf.chunkarr buf)(%iasr (bf.logsiz buf)(bf.gappos buf)))
                                (bfc.string lastchunk)
                           gapend gapend (- chunksize gapend)))      
      (%buf-new-gap-size buf n))))
|#


(defun %buf-grow-gap (buf n)
  (let* ((gapend (bf.gapend buf))
         (gapchunk (bf.gapchunk buf))
         (chunksize (bf.chunksz buf)))
    (declare (fixnum gapend chunksize))
    (if (>= (%i+ (bf.bufsiz buf) n (%i- gapend (bf.gapstart buf))) #xFFFFFF)
      (error '"Buffer size limit exceeded"))
    (multiple-value-bind (n firstchunk lastchunk)(%buf-allocate-chunks buf chunksize n)
      (when (and gapchunk
                 (< gapend chunksize)) ; looks wrong if gap is huge
        ; gotta move some good characters from gapchunk to new lastchunk
        (let ((gapstring (bfc.string gapchunk)))
          (when (simple-extended-string-p gapstring)
            (when (simple-base-string-p (bfc.string lastchunk))
              (%expand-chunk lastchunk buf nil)))
          (move-string-bytes gapstring (bfc.string lastchunk)
                             gapend gapend (%i- chunksize gapend))))
      (setf (bfc.prev firstchunk) gapchunk)
      (let (gapnext)
        (cond ((null gapchunk)
               (setf (bf.gapchunk buf) firstchunk))
              (t (setq gapnext (bfc.next gapchunk))
                 (setf (bfc.next gapchunk) firstchunk)))
        (setf (bfc.next lastchunk) gapnext)
        (when gapnext (setf (bfc.prev gapnext) lastchunk))
        ; no no - adjust by amt actually added        
        (%buf-new-gap-size buf n)))))

  
(defun %buf-allocate-chunks (buf size n) ; n is bytes required
  (let* ((chunks (ceiling n size))
         (chunkarr (bf.chunkarr buf))
         (type (bf-chartype buf))
         (prev-chunk (%allocate-chunk size type))
         (first-chunk prev-chunk)
         (logsiz (bf.logsiz buf))
         (used (%iasr logsiz (%i+ (%i- (bf.chunksz buf) 1)
                                (bf.bufsiz buf)
                                (%i- (bf.gapend buf)(bf.gapstart buf)))))
         (len (length chunkarr))
         (gappos (bf.gappos buf)))
    (declare (fixnum logsiz used len gappos chunks))
    (when (> (%i+ chunks used) len)
      (let ((newarr (make-array (the fixnum (%i+ chunks used 2)))))
        (dotimes (i used)
          (setf (svref newarr i)(svref chunkarr i)))        
        (setf (bf.chunkarr buf) (setq chunkarr newarr))))
    ; move chunks after first gapchunk down by chunks
    (let* ((gapidx (if (%izerop gappos) 0 (%iasr logsiz (%i- gappos 1))))
           (total size))
      (declare (fixnum gapidx total))
      ;(print gapidx)
      ;(dotimes (i used)(print (%address-of (svref chunkarr i))))
      (dotimes (i (%i-- used gapidx 1))
        (setf (svref chunkarr (%i+ chunks (%i-- used i 1)))(svref chunkarr (%i-- used i 1))))
      (cond ((zerop used)
             (setf (svref chunkarr 0) (bfc.string first-chunk))
             (setq gapidx -1))
            (t (setf (svref chunkarr (1+ gapidx)) (bfc.string first-chunk))))
      (let (chunk)
        (dotimes (i (%i- chunks 1))
          (setq chunk (%allocate-chunk size type))
          (setf (bfc.next prev-chunk) chunk)
          (setf (bfc.prev chunk) prev-chunk)
          (setq prev-chunk chunk)
          (setq total (+ total size))
          (setf (svref chunkarr (%i+ gapidx i 2)) (bfc.string chunk)))
        ;(print chunks)
        ;(dotimes (i (%i+ used chunks))(print (%address-of (svref chunkarr i))))
        (values total first-chunk prev-chunk)))))           
 
; need to keep the next and prev things for this goo!
(defun %allocate-chunk (size &optional (type 'base-character))
  (let* ((freechunks  *%buffer-chunks%*)
         (max (+ size size)))
    (do ((last-chunk nil chunk)
         (chunk (pool.data freechunks) (bfc.next chunk)))
        ((null chunk) nil)
      (let* ((string (bfc.string chunk))
             (elt-type (array-element-type string)))
        (when (and (or (eq type elt-type)                       
                       (and (memq type '(extended-character character))
                            (subtypep type elt-type))
                       )
                   (<= size (length string) max))
          (if last-chunk
            (setf (bfc.next last-chunk)(bfc.next chunk))
            (setf (pool.data freechunks) (bfc.next chunk))) 
          (return-from %allocate-chunk chunk))))
    (vector nil nil (make-string size :element-type type))))

(defun %expand-chunk (chunk buf pos)
  (let* ((string (bfc.string chunk))
         (len (length string))
         (new-string (make-string len :element-type 'extended-character))
         (arr (bf.chunkarr buf)))
    ; really only need to move the good chars
    (move-string-bytes string new-string 0 0 len)
    (setf (bfc.string chunk) new-string)
    ; has to go in the chunkarr too
    (or (and pos 
             (let ((idx (%iasr (bf.logsiz buf) pos))) ; make sure pos is right - isnt always
               (and (eq string (svref arr idx))
                    (setf (svref arr idx) new-string))))
        (let ()
          (unless
            (dotimes (i (%i+ 1 (%iasr (bf.logsiz buf) 
                                      (%i+ (bf.bufsiz buf)(%i- (bf.gapend buf)(bf.gapstart buf)))))
                        nil)
              (when (eq string (svref arr i))
                (setf (svref arr i) new-string)
                (return t)))
            (error "%expand-chunk can't find the string in chunk array"))))
    (bf-chartype buf 'extended-character)))

(defun %buf-new-gap-size (buf n)
  (declare (fixnum n))
  ; n is the amount the gap has grown
  (setf (bf.gapend buf)(%i+ (bf.gapend buf) n))  
  ; and fontruns
  (let* ((afonts (bf.afonts buf))
         (fontruns (bf.fontruns buf))
         (len (length fontruns)))
    (declare (fixnum afonts len))
    (dotimes (i afonts)
      (let ((p (%i-- len i 1)))
        (set-fontruns-pos fontruns p (%i+ n (fontruns-pos fontruns p))))))
  ; update marks
  (let ((marks (markl.data (bf.amarks buf))))
    (setq n (+ n n))
    (dolist (m marks)
      (setf (mark.value m)(%i+ n (mark.value m))))))

(defun %move-gap (buf distance)
  (let* ((chunksz (bf.chunksz buf))
         (gapstart (bf.gapstart buf))
         (gaplen (%i- (bf.gapend buf) gapstart))
         (gaplen*2 (+ gaplen gaplen))
         (cp (bf.gapchunk buf))
         (oldgappos (bf.gappos buf))
         (newend 0)
         (gappos 0))
    (declare (fixnum distance chunksz gapstart gaplen gaplen*2 oldgappos newend gappos))
    (declare (optimize (speed 3)(safety 0)))
    ; make sure gapstart is O.K.
    (unless (= 0 gaplen) ; if gaplen is 0 there may not be a next chunk
      (while (>= gapstart chunksz) ; gapstart is relative to gapchunk
        (setq cp (bfc.next cp))
        (setq gapstart (- gapstart chunksz))))
    (setq gappos (+ oldgappos distance))
    (without-interrupts
     (cond
      ((> distance 0) ; gap going down
       (setq newend (+ gappos gaplen))
       ; relocate some after gap fontruns
       (let* ((fontruns (bf.fontruns buf))
              (length (length fontruns))
              (afonts (bf.afonts buf))
              (bfonts (bf.bfonts buf))
              (aidx (- length afonts)))
         (declare (fixnum length aidx afonts bfonts))
         (loop
           (when (= aidx length)(return))
           (let* ((pos (fontruns-pos fontruns aidx)))
             (declare (fixnum pos))
             (cond ((>= pos newend)
                    (return))
                   (t 
                    (set-fontruns fontruns bfonts 
                                       (fontruns-font fontruns aidx) (%i- pos gaplen))
                    (setq bfonts (1+ bfonts))
                    (setq aidx (1+ aidx))))))
         (setf (bf.bfonts buf) bfonts)
         (setf (bf.afonts buf) (%i- length aidx)))
       ; bmarks are in decreasing order
       ; amarks are in increasing order
       (setq newend (+ newend newend)) ; double it for marks
       (let* ((amarks (markl.data (bf.amarks buf)))
              (bmarks (markl.data (bf.bmarks buf)))
              tem)
         (declare (list amarks bmarks tem))
         ; some amarks become bmarks
         (loop
           (let ((mark (car amarks)))
             (cond ((and amarks (%i<= (mark.value mark) newend))
                    (setf (mark.value mark)(%i- (mark.value mark) gaplen*2))
                    (setq tem  (cdr amarks))
                    (rplacd amarks bmarks)
                    (setq bmarks amarks)
                    (setq amarks tem))
                   (t (setf (markl.data (bf.bmarks buf)) bmarks)
                      (setf (markl.data (bf.amarks buf)) amarks)
                      (return))))))
       ; now move data      
       (let* ((nchars 0)
              (src-chunk cp)
              (src-org 0))
         (declare (fixnum nchars src-org))
         (loop
           (when (eq gapstart chunksz)
             (setq cp (bfc.next cp))
             (setq gapstart 0))
           (setq src-chunk cp)
           (setq src-org (+ gapstart gaplen))
           ; this can be slow if we allow gap to be big!
           (while (%i>= src-org chunksz)
             (setq src-org (- src-org chunksz))
             (setq src-chunk (bfc.next src-chunk)))
           ; nchars is min of distance (- chunksz src-org)(- chunksz gapstart)
           (when (= src-org chunksz) (setq src-org 0)) ; <<
           (setq nchars (- chunksz src-org))
           (when (> gapstart src-org)
             (setq nchars (- chunksz gapstart)))
           (when (> nchars distance)(setq nchars distance))
           (unless (= gaplen 0)
             (let ((src-string (bfc.string src-chunk)))
               (when (simple-extended-string-p src-string)               
                 (when (simple-base-string-p (bfc.string cp))
                   (%expand-chunk cp buf nil)))
               (move-string-bytes src-string (bfc.string cp)
                                  src-org gapstart nchars)))
           (setq gapstart (+ gapstart nchars))
           (setq distance (- distance nchars))
           (when (<= distance 0)(return)))))
      (t ; gap moving up
       ; font stuff some bfonts become afonts
       (let* ((fontruns (bf.fontruns buf))
              (length (length fontruns))
              (bidx (%i- (bf.bfonts buf) 1))
              (aidx (%i-- length (bf.afonts buf) 1)))
         (declare (fixnum len bidx aidx))
         (unless (< bidx 0) ; the old buffer code lets bfonts be zero if buffer is empty
           (loop 
             (let* ((pos (fontruns-pos fontruns bidx)))
               (declare (fixnum pos))
               (cond ((if (= gappos 0)
                        (> pos 0)        ; dont remove bfont for 0
                        (>= pos gappos))
                      (set-fontruns fontruns aidx  
                                         (fontruns-font fontruns bidx)(%i+ pos gaplen))
                      (setq bidx (1- bidx))
                      (setq aidx (1- aidx)))
                     (t (return)))))
           (setf (bf.bfonts buf)  (if (minusp bidx) 1 (%i+ 1 bidx)))
           (setf (bf.afonts buf) (setq aidx (%i-- length aidx 1))) ; its really afonts now
           (when (and (zerop gappos)
                      (> aidx 0)
                      (= (fontruns-pos fontruns  (%i- length aidx))
                         (%i+ gappos gaplen)))
             (set-fontruns-font fontruns 0 (fontruns-font fontruns (%i- length aidx)))
             (setf (bf.afonts buf)(%i- aidx 1)))))
       (let* ((amarks (markl.data (bf.amarks buf)))
              (bmarks (markl.data (bf.bmarks buf)))
              (2*gappos (+ gappos gappos))
              tem)
         (declare (list amarks bmarks tem)(fixnum 2*gappos))
         ; some bmarks become amarks
         (loop
           (let ((mark (car bmarks)))
             (cond ((and bmarks (%i> (mark.value mark) 2*gappos))
                    (setf (mark.value mark)(%i+ gaplen*2 (mark.value mark)))
                    (setq tem (cdr bmarks))
                    (rplacd bmarks amarks)
                    (setq amarks bmarks)
                    (setq bmarks tem))
                   (t (setf (markl.data (bf.bmarks buf)) bmarks)
                      (setf (markl.data (bf.amarks buf)) amarks)
                      (return))))))
       (let* ((dst-chunk cp)
              (nchars 0)
              (dst-org 0))
         (declare (fixnum nchars dst-org))
         (setq distance (- distance))
         (loop           
           (when (= 0 gapstart)
             (setq cp (bfc.prev cp))
             (setq gapstart chunksz))
           (setq dst-org (+ gapstart gaplen))
           (setq dst-chunk cp)
           (while (%i> dst-org chunksz)
             (setq dst-org (- dst-org chunksz))
             (setq dst-chunk (bfc.next dst-chunk)))
           (when (= dst-org 0)(setq dst-org chunksz))
           ; nchars (min gapstart dst chars-left)
           (setq nchars dst-org)
           (when (< gapstart dst-org)(setq nchars gapstart))
           (when (< distance nchars)
             (setq nchars distance))
           (unless (= gaplen 0)
             (let ((cp-string (bfc.string cp)))
               (when (simple-extended-string-p cp-string)
                 (when (simple-base-string-p (bfc.string dst-chunk))
                   (%expand-chunk dst-chunk buf nil)))
               (move-string-bytes-reverse cp-string (bfc.string dst-chunk)
                                          gapstart dst-org nchars)))
           (setq gapstart (- gapstart nchars))
           (setq distance (- distance nchars))
           (when (<= distance 0)(return))))))
     (setf (bf.gappos buf) gappos)
     (setf (bf.gapstart buf) gapstart)
     (setf (bf.gapend buf)(%i+ gapstart gaplen))
     (setf (bf.Gapchunk buf) cp)
     nil)))

(defun buffer-delete (buffer end &optional start)
  (multiple-value-setq (start end)(buffer-range buffer end start))
  (locally (declare (fixnum start end)(optimize (speed 3) (safety 0)))
    (without-interrupts
     (when (not (= start end))
       (let* ((the-buffer (mark.buffer buffer))
              (gappos (bf.gappos the-buffer)))
         (declare (fixnum gappos))
         (when (logbitp $bf_r/o-flag (bf.fixnum the-buffer))
           (%buf-signal-read-only))
         (when (not (<= start gappos end))
           (%move-gap the-buffer (%i- start gappos)))
         (setq gappos (bf.gappos the-buffer))
         (when (not (= gappos start))
           (%delete-backward the-buffer (- gappos start)))
         ;(check-runs buffer 'backward)
         (when (not (= gappos end))
           (%delete-forward the-buffer (- end gappos)))
         ;(check-runs buffer 'forward)
         (%buf-changed the-buffer)
         (when (zerop (bf.bufsiz the-buffer))  ; maybe don't need this here - just in inserts
           (let ((fontruns (bf.fontruns the-buffer)))
             (setf (bf.bfonts the-buffer) 1)
             (setf (bf.afonts the-buffer) 0)
             (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))))))

(defun %delete-forward (buf distance)
  (declare (optimize (speed 3)(safety 0))(fixnum distance))
  ; so we move the end of the gap
  (let* ((bufsiz (bf.bufsiz buf))
         (gapend (bf.gapend buf))) 
    (declare (fixnum bufsiz gapend))
    (setf (bf.bufsiz buf)(setq bufsiz (- bufsiz distance)))
    (setf (bf.gapend buf)(setq gapend (+ gapend distance)))
    (let* ((amarks (markl.data (bf.amarks buf)))
           (bmarks (markl.data (bf.bmarks buf)))
           (gappos (bf.gappos buf))
           (gaplen (- gapend (bf.gapstart buf)))
           (bw (+ gappos gappos)) ; value for bwd mark at beginning
           (fw  (%i+ bw gaplen gaplen 1)) ;value for fwd mark at new end
           (marks amarks) 
           last tem)
      (declare (fixnum gappos gaplen bw fw)(list amarks bmarks marks last tem))
      (loop
        (if marks 
          (let* ((mark (car marks))
                 (value (mark.value mark)))
            (declare (fixnum value))
            (cond ((> value fw) (return))
                  ((%ilogbitp 0 value)
                   (setf (mark.value mark) fw)
                   (setq last marks)
                   (setq marks (cdr marks)))
                  (t 
                   (setf (mark.value mark) bw)
                   (setq tem (cdr marks))
                   (setq bmarks (rplacd marks bmarks))
                   (if last
                     (rplacd last tem)
                     (setq amarks tem))
                   (setq marks tem))))
          (return)))
      (setf (markl.data (bf.bmarks buf)) bmarks)
      (setf (markl.data (bf.amarks buf)) amarks)
      ; now deal with fonts      
      (cond 
       ((= bufsiz gappos)
        (setf (bf.afonts buf) 0))
       (t (let* ((afonts (bf.afonts buf))
                 (gapend (+ gappos gaplen)))
            (declare (fixnum afonts gapend))
            (when (not (zerop afonts))
              (setq gapend (+ gappos gaplen))
              (let* ((fontruns (bf.fontruns buf))
                     (len  (length fontruns))
                     (aidx (- len afonts))
                     (pos 0)
                     tfont)
                (declare (fixnum len aidx pos))                 
                (loop
                  (let* ((ffont (fontruns-font fontruns aidx)))
                    (setq pos (fontruns-pos fontruns aidx))
                    (cond ((= pos gapend)
                           (setq tfont ffont)
                           (return))
                          ((> pos gapend)
                           (setq aidx (1- aidx))
                           (return))
                          (t (setq tfont ffont)
                             (when (= aidx (%i- len 1))(return))
                             (setq aidx (1+ aidx))))))
                (when tfont ; the last one <= new gapend
                  (let* ((bfonts (bf.bfonts buf))
                         (len (length fontruns))
                         (bfont (when (> bfonts 0)(fontruns-font fontruns (%i- bfonts 1))))
                         (bpos (fontruns-pos fontruns (%i- bfonts 1))))                    
                    (declare (fixnum bfonts len bpos))
                    (setf (bf.afonts buf) (%i-- len aidx 1))
                    (cond ((eq bfont tfont))
                          ((and (eq pos gapend) (eq bpos gappos))
                           (set-fontruns-font fontruns (%i- bfonts 1) tfont))
                          (t (setf (bf.afonts buf) (%i- len aidx))
                             (set-fontruns-pos fontruns aidx gapend)))))))))))))      

(defun %delete-backward (buf distance)
  (declare (optimize (speed 3)(safety 0))(fixnum distance))
  ; find the font at old gap before messing with anything
  (multiple-value-bind (epos efont eidx) (%buf-find-font buf (bf.gappos buf))
    (declare (fixnum efont eidx)(ignore epos))
    (setf (bf.gappos buf) (%i- (bf.gappos buf) distance))
    (let* ((bufsiz (bf.bufsiz buf))
           (gapstart (bf.gapstart buf))
           (gaplen (+ (%i- (bf.gapend buf) gapstart) distance))
           (chunksz (bf.chunksz buf))
           (cp (bf.gapchunk buf)))
      (declare (fixnum bufsiz gapstart gaplen chunksz))
      (setf (bf.bufsiz buf)(setq bufsiz (- bufsiz distance)))
      (setq gapstart (- gapstart distance))
      (while (< gapstart 0)
        (setq gapstart (+ gapstart chunksz))
        (cond ((= gapstart chunksz)
               (setq gapstart 0))
              (t (setq cp (bfc.prev cp)))))
      ;(when (null cp) (cerror "a" "b"))
      #|  ; was - which actually looks equivalent
    (while (< (setq gapstart (- gapstart distance)) 0)
      (setq cp (bfc.prev cp))
      (setq distance (- chunksz)))
    |#
      (setf (bf.gapstart buf) gapstart)
      (setf (bf.gapchunk buf) cp)
      (setf (bf.gapend buf) (%i+ gapstart gaplen))
      (let* ((amarks (markl.data (bf.amarks buf)))
             (bmarks (markl.data (bf.bmarks buf)))
             (gappos (bf.gappos buf))  ; new gappos
             (bw (+ gappos gappos)) ; value for bwd mark at beginning
             (fw  (%i++ bw gaplen gaplen 1)) ;value for fwd mark at new end
             (marks bmarks)
             tem last)
        (declare (fixnum gappos bw fw)(list amarks bmarks marks tem last))
        (loop
          (if marks
            (let* ((mark (car marks))
                   (value (mark.value mark)))
              (declare (fixnum value))
              (if (< bw value)
                (cond ((logbitp 0 value) ; fwd mark to after
                       (setf (mark.value mark) fw)
                       (setq tem (cdr marks))
                       (setq amarks (rplacd marks amarks))
                       (if last
                         (rplacd last tem)
                         (setq bmarks tem))
                       (setq marks tem))
                      (t (setf (mark.value mark) bw)
                         (setq last marks)
                         (setq marks (cdr marks))))  ; bwd mark stays before
                (return)))
            (return)))
        (setf (markl.data (bf.bmarks buf)) bmarks)
        (setf (markl.data (bf.amarks buf)) amarks)
        (let* ((fontruns (bf.fontruns buf))
               (bfonts (bf.bfonts buf))
               (bidx (1- bfonts)))
          (declare (fixnum bfonts bidx))
          (when (< bidx 0) (error "bfonts m.b. > 0"))
          ; special case gappos = 0 ?
          (let* ((tfont (loop
                          (cond 
                           ((%i< (fontruns-pos fontruns bidx) gappos)
                            (return (fontruns-font fontruns bidx)))
                           (t (setq bidx (1- bidx))
                              (when (< bidx 0)(return))))))
                 (afonts (bf.afonts buf))
                 (len (length fontruns))
                 (aidx (- len afonts)))
            (declare (fixnum afonts len aidx))
            (cond ((not tfont) ; no change before new gappos
                   (setf (bf.bfonts buf) 1)
                   (set-fontruns-font fontruns 0 efont)
                   (when (= eidx aidx)
                     (setf (bf.afonts buf)(%i- afonts 1))))
                  (t (setf (bf.bfonts buf) (%i+ 1 bidx))
                     (cond ((eq efont tfont)
                            (when (= eidx aidx)
                              (setf (bf.afonts buf)(%i- afonts 1))))
                           ((= eidx aidx))
                           (t ; was in bfonts - goes to afonts
                            (set-fontruns fontruns (%i- aidx 1) efont (%i+ gappos gaplen))
                            (setf (bf.afonts buf)(%i+ 1 afonts))))))))))))                  
          
(defun buffer-font-count (buffer)
  (let* ((flist  (bf.flist (mark-buffer buffer))))
    (ash (length flist) -1))) 

(defun buffer-char-font-codes (buffer &optional pos)
  (setq pos (buffer-position buffer pos))
  (let ((the-buffer (mark.buffer buffer)))
    (let* ((fidx (nth-value 1 (%buf-find-font the-buffer pos))) 
           (flist (bf.flist the-buffer))
           (len (length flist)))
      (if (>= (+ fidx fidx) len)(setq fidx 0))  ;; happens with utf files      
      (values (%svref flist (%i+ fidx fidx))(%svref flist (%i+ fidx fidx 1))))))

; make update-key-script-from-click consistent with typing into empty buffer

(defun buffer-char-font-index (buffer &optional pos)
  (setq pos (buffer-position buffer pos))
  (let ((the-buffer (mark.buffer buffer)))
     (if (and (eq pos 0)(eq 0 (bf.bufsiz the-buffer))) ; 6/17/95
       (let ((font (bf-efont the-buffer)))
         (1+ (if (eql font %no-font-index)(bf-cfont the-buffer) font)))
       (1+ (nth-value 1 (%buf-find-font the-buffer pos))))))

(defun buffer-font-codes (buffer)
  ; seems to want index to start at 0
  (let ((font-index (buffer-insert-font-index buffer)))
    (if font-index 
      (buffer-font-index-codes buffer font-index)
      (let ((pos (buffer-position buffer)))
        (if (or (eq pos 0) (char-eolp (buffer-char buffer (%i- pos 1))))
          (buffer-char-font-codes buffer pos)
          (buffer-char-font-codes buffer (%i- pos 1)))))))

(defun buffer-font-index-codes (buffer font-index)
  (let* ((buf (mark-buffer buffer))
         (flist (bf.flist buf)))
    (when (not (<= 1 font-index (ash (length flist) -1)))
      (error "~s is not a valid font index in ~s" font-index buffer))
    (%buffer-font-codes buf (%i- font-index 1))))

(defun %buffer-font-codes (buf font-index)
  (declare (optimize (speed 3)(safety 0)))
  (let ((flist (bf.flist buf)))
    (values (svref flist (%i+ font-index font-index))
            (svref flist (%i+ font-index font-index 1)))))    
  

; returns font+position (in user coords??) and the index in fontruns
(defun %buf-find-font (buf position)
  (declare (fixnum position)(optimize (speed 3)(safety 0)))
  (let* ((fontruns (bf.fontruns buf))
         (gappos (bf.gappos buf))
         (gaplen (%i- (bf.gapend buf) (bf.gapstart buf)))
         (bfonts (%i- (bf.bfonts buf) 1))
         (low 0)
         (high bfonts)
         pidx)
    (declare (fixnum gappos gaplen bfonts low high))
    (when (>= position gappos)
      (setq position (%i+ position gaplen))
      (let ((afonts (bf.afonts buf)))
        (if (%i> afonts 0)
          (let ((len (length fontruns)))
            (setq low (%i- len afonts) high (%i- len 1))
            (when (%i> (fontruns-pos fontruns low) position)
              (setq pidx bfonts)))
          (setq pidx bfonts))))
    (when (not pidx)
      (loop
        (cond ((> high (%i+ 1 low))
               (setq pidx (%i+ low (ash (%i-  high low) -1)))
               (let* ((mpos (fontruns-pos fontruns pidx)))
                 (declare (fixnum mpos))
                 (cond ((= mpos position)
                        (return))
                       ((> mpos position)
                        (setq high pidx))
                       (t (setq low pidx)))))
              ((eq high low)(setq pidx low) (return))
              (t 
               (if (<= (the fixnum (fontruns-pos fontruns high)) position)
                 (setq pidx high)
                 (setq pidx low))
               (return)))))
      (let ((pos (fontruns-pos fontruns pidx)))
          (values (if (%i> pos gappos)(%i- pos gaplen) pos)(fontruns-font fontruns pidx) pidx))))


; return script at pos and pos of next script change
; N.B. The relevent scripts have to be installed - else FontToScript always returns smRoman
; not used by us
#|
(defun buffer-next-script-change (buffer &optional pos end)
  (when (not pos) (setq pos (buffer-position buffer)))
  (multiple-value-setq (pos end)(buffer-range buffer pos end))
  (let* ((buf (mark.buffer buffer))
         npos nfont)
    (multiple-value-bind (ppos pfont pidx)(%buf-find-font buf pos)
      (declare (ignore ppos))
      (let* ((real-font (ash (%buffer-font-codes buf pfont) -16))
             (script (#_FontToScript real-font)))
        (loop
          (multiple-value-setq (npos nfont pidx) (%buf-next-font-change buf pidx))
          (when (or (null npos)(and end (%i> npos end)))
            (return script))
          (let ((next-real-font (ash  (%buffer-font-codes buf nfont) -16)))
            (when (neq next-real-font real-font)
              (setq real-font next-real-font)
              (when (neq script (#_FontToScript next-real-font))
                (return (values script npos))))))))))
|#

; return script at pos and pos of previous script change
; unused today
#|
(defun buffer-previous-script-change (buffer &optional (pos (buffer-position buffer)) (end 0))  ; end < pos
  ; the font below is an index into fontmumble (e.g. 0, 1 etc.)
  ; the font is also that of starting pos - not the new font
  (let ((buf (mark.buffer buffer))
        prev-pos)
    (multiple-value-bind (x font pidx)(%buf-find-font buf pos)
      (declare (ignore x))
      (let* ((ff (%buffer-font-codes buf font))
             (real-font (ash ff -16))
             (script (#_FontToScript real-font)))    
        (loop
          (multiple-value-setq (prev-pos font pidx) (%buf-prev-font-change buf pidx))
          (when (or (null prev-pos) (< prev-pos end))
            (return script))
          (let* ((p-ff (%buffer-font-codes buf font))
                 (p-real-font (ash p-ff -16)))
            (when (neq p-real-font real-font)
              (setq real-font p-real-font)
              (when (neq script (#_FontToScript p-real-font))
                (return (values script prev-pos))))))))))
|#

(defun buffer-next-font-change (buffer &optional pos)
  (setq pos (buffer-position buffer pos))
  (let* ((buf (mark.buffer buffer)))    
    (let ((pidx (nth-value 2 (%buf-find-font buf pos))))
      (%buf-next-font-change buf pidx))))

(defun %buf-next-font-change (buf idx)
  (declare (optimize (speed 3)(safety 0)))
  (let* ((bfonts (bf.bfonts buf))
         (afonts (bf.afonts buf))
         (fontruns (bf.fontruns buf))
         (len (length fontruns)))
    (declare (fixnum bfonts afonts len idx))
    (setq idx
          (cond ((eq idx (%i- bfonts 1))                 
                 (when (%i> afonts 0)(%i- len afonts)))
                ((%i< idx (1- len))
                 (%i+ 1 idx))))
    (when idx
      (let* ((font (fontruns-font fontruns idx))
             (pos (fontruns-pos fontruns idx)))
        (if (>= idx (%i- len afonts)) 
          (setq pos (%i- pos (%i- (bf.gapend buf)(bf.gapstart buf)))))
        ; returns unbiased position
        (values pos font idx)))))
    


(defun buffer-previous-font-change (buffer &optional pos)
  (setq pos (buffer-position buffer pos))
  (let* ((buf (mark.buffer buffer)))
    (when (> pos 0)
      (multiple-value-bind (ppos pfont pidx)(%buf-find-font buf pos)        
        (if (= pos ppos)
          (%buf-prev-font-change buf pidx)
          (values ppos pfont))))))

(defun %buf-prev-font-change (buf idx)
  (let* ((bfonts (bf.bfonts buf))
         (afonts (bf.afonts buf))
         (fontruns (bf.fontruns buf))
         (len (length fontruns)))
    (setq idx
          (cond ((= idx (- len afonts))
                 (1- bfonts))
                ((> idx 0)(1- idx))))
    (when idx
      (let* ((font (fontruns-font fontruns idx))
             (pos (fontruns-pos fontruns idx)))
        (if (>= idx (- len afonts))
          (setq pos (- pos (- (bf.gapend buf)(bf.gapstart buf)))))
        (values pos font idx)))))
                

(defun buffer-font-index (buffer ff ms)
  (let* ((flist (bf.flist (mark-buffer buffer)))
         (len (length flist)))
    (declare (optimize (speed 3 )(safety 0)))
    (do ((i 0 (%i+ i 2)))
        ((%i>= i len) nil)
      (when (and (= (svref flist i) ff)
                 (= (svref flist (%i+ i 1)) ms))
        (return (%i+ 1 (%ilsr 1 i)))))))

(defun add-buffer-font (buffer ff ms)
  (let ((idx (buffer-font-index buffer ff ms)))
    (or idx
        (progn        
          (let* ((buffer (mark.buffer buffer))
                 (flist (bf.flist buffer))
                 (len (length flist))
                 (newflist))
            (declare (fixnum len))
            #+ignore
            (when (logbitp $bf_r/o-flag (bf.fixnum buffer))
              (%buf-signal-read-only))
            (when (>= len 510)(error "Cannot add any more fonts"))
            (setq newflist (make-array (the fixnum (+ len 2))))
            (without-interrupts
             (%copy-ivector-to-ivector flist 0  newflist 0 (ash len 2))             
             (setf (svref newflist len) ff)
             (setf (svref newflist (%i+ len 1)) ms)
             (setf (bf.flist buffer) newflist)
             #+ignore 
             (setf (bf.modcnt buffer)(1+ (bf.modcnt buffer)))) ; buffer is modified
            (multiple-value-bind (ascent descent maxwid) (font-codes-info ff ms)
              ; all this becomes obsolete - is used in ed-hardcopy
              (when (> ascent (bf.maxasc buffer))
                (setf (bf.maxasc buffer) ascent))
                ;(setf (bf.bmod buffer) 0)
                ;(setf (bf.zmod buffer) 0))
              (when (> descent (bf.maxdsc buffer))
                (setf (bf.maxdsc buffer) descent))
                ;(setf (bf.bmod buffer) 0)
                ;(setf (bf.zmod buffer) 0))
              (when (> maxwid (bf.maxwid buffer))
                (setf (bf.maxwid buffer) maxwid))
                ;(setf (bf.bmod buffer) 0)
                ;(setf (bf.zmod buffer) 0))
              )
            (1+ (ash len -1)))))))

; doesnt move the gap - 

(defun buffer-change-font-index (buffer font-index end &optional start)
  (multiple-value-setq (start end)(buffer-range buffer end start))
  (locally (declare (fixnum start end) (optimize (speed 3)(safety 0)))
    (unless nil ;(= start end) ; bill put back the = ??
      (without-interrupts
       (let* ((buf (mark.buffer buffer))
              (flist (bf.flist buf))
              (bufsiz (bf.bufsiz buf))
              (fontruns (bf.fontruns buf)))
         (declare (fixnum bufsiz))        
         (when (not (<= 1 font-index (%iasr 1 (length flist)) ))
           (error "~s is not a valid font index in ~s" font-index buffer))
         (locally (declare (fixnum font-index))
           (setq font-index (1- font-index))
           (when (%ilogbitp $bf_r/o-flag (bf.fixnum buf))
             (%buf-signal-read-only))
           (setf (bf.modcnt buf)(%i+ 1 (bf.modcnt buf)))
           (when (%i< start (bf.bmod buf))
             (setf (bf.bmod buf) start))
           (when (%i< (- bufsiz end) (bf.zmod buf))
             (setf (bf.zmod buf) (%i- bufsiz end)))
           (when (%izerop (bf.bfonts buf)) ; old make buffer lets this occur
             (setf (bf.bfonts buf) 1)
             ;(bf-gfont buf 0)(bf-afont buf 0) ; makes old code happier
             (set-fontruns fontruns 0 (bf-cfont buf) 0))
           ;(check-runs buffer 'before)
           (%xchange-font-index buf font-index start end)
           ;(check-runs buffer 'after)
           ))))))



(defun %xchange-font-index (buf font-index start end)
  (declare (fixnum start end)(optimize (speed 3)(safety 0)))
  (unless (eq start end)
    (let* ((bfonts (bf.bfonts buf))
           (afonts (bf.afonts buf))
           (fontruns (bf.fontruns buf))
           (len (length fontruns))
           (have 0)
           (need 0)
           (difference 0)
           needb
           neede)
      (declare (fixnum bfonts afonts len have need difference eidx))
      (multiple-value-bind (epos efont eidx)(%buf-find-font buf end)
        (declare (ignore epos))
        (multiple-value-bind (ppos pfont pidx)(%buf-find-font buf start)
          ;(declare (ignore pfont))
          (declare (fixnum pidx eidx))
          (cond ((eq ppos start)
                 (multiple-value-bind (xpos xfont xidx)(%buf-prev-font-change buf pidx)
                   (declare (ignore xpos))
                   (cond ((eq xfont font-index) (setq pidx xidx))
                         (t (set-fontruns-font fontruns pidx font-index)))))
                (t (unless (eq pfont font-index)(setq need 1 needb t))))
          (setq have (cond ((eq pidx eidx) 0)
                           ((or (and (>= pidx bfonts)(>= eidx bfonts))
                                (and (< pidx bfonts)(< eidx bfonts)))
                            (%i- eidx pidx))
                           (nil ; cant happen (>= pidx bfonts)
                            (%i+ (%i- bfonts eidx)(%i- pidx (%i- len afonts))))
                           (t (%i+ (%i- bfonts pidx)(%i- eidx (%i- len afonts))))))          
          (unless (or (eq efont font-index)(eq end (bf.bufsiz buf)))
            (setq neede t)(setq need (1+ need)))          
          (setq difference (- have need))
          (when (minusp difference)
            (setq fontruns (%growfontruns buf afonts bfonts (the fixnum (- difference)))) ; but now indices are fukt 
            (let* ((newlen (length fontruns))
                   (delta (- newlen len)))
              (declare (fixnum newlen delta))
              (when (>= pidx bfonts)(setq pidx (%i+ delta pidx)))
              (when (>= eidx bfonts)(setq eidx (%i+ delta eidx)))
              (setq len newlen)))
          (let* ((gappos (bf.gappos buf))
                 (nafonts (if (< eidx bfonts) afonts (%i- len (%i+ 1 eidx)))))
            (declare (fixnum gappos nafonts))
            (cond ((and (>= start gappos)(< pidx bfonts))
                   (setf (bf.afonts buf)(%i+ nafonts need))
                   (setq difference 0))
                  ((and (if (= 0 gappos)(= 0 start)(< start gappos))(>= end gappos))
                   (setf (bf.bfonts buf)(if needb (%i+ pidx 2)(%i+ pidx 1)))
                   (setf (bf.afonts buf)(if neede (%i+ 1 nafonts) nafonts))
                   (setq difference 0))
                  (t (move-fontruns buf pidx difference))))
          (setq bfonts (bf.bfonts buf))
          (setq afonts (bf.afonts buf))
          (let ((gaplen (%i- (bf.gapend buf)(bf.gapstart buf))))
            (declare (fixnum gaplen))
            (when needb              
              (if (eq pidx (%i- bfonts 1))
                (setq pidx (%i- len afonts))
                (setq pidx (1+ pidx)))
              (let ((xidx pidx))
                (declare (fixnum xidx))
                (when  (>= pidx bfonts)
                  (setq start (+ start gaplen))
                  (setq xidx (+ pidx difference)))
                (set-fontruns fontruns xidx font-index start)))
            (when neede              
              (cond ((eq pidx (%i- bfonts 1))
                     (setq pidx (- len afonts)))
                    (t (setq pidx (1+ pidx))
                       (when (>= pidx bfonts)
                         (setq pidx (+ pidx difference)))))
              (when (>= pidx bfonts)(setq end (+ end gaplen)))
              (set-fontruns fontruns pidx efont end))))))))

(defun move-fontruns (buf pidx difference)
  (declare (optimize (speed 3)(safety 0)))
  ; if difference is positive its the number of runs to nuke after pidx
  ; if negative his abs value is the amount of space to leave after pidx
  ; the run in pidx stays put
  ; the run in eidx goes away
  (let* ((fontruns (bf.fontruns buf))
         (len (length fontruns))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf)))
    (declare (fixnum pidx difference len afonts bfonts))
    (cond ((< pidx bfonts)
           (setf (bf.bfonts buf)(%i- bfonts difference))
           (let ((times (%i- bfonts (%i+ 1 pidx))))
             (declare (fixnum times))
             (cond ((plusp difference)
                    ; moving up - ok
                    (dotimes (i times)
                      (setq pidx (1+ pidx))
                      (move-fontrun fontruns (%i+ pidx difference) pidx)))
                   ((minusp difference); moving down ok
                    (let ((tidx (1- bfonts)))
                      (declare (fixnum tidx))
                      (dotimes (i times)
                        (move-fontrun fontruns tidx (%i- tidx difference))
                        (setq tidx (1- tidx))))))))
          (t ;(neq pidx eidx)
           (setf (bf.afonts buf)(%i- afonts difference))
           (let ((times (%i- (%i+ 1 pidx)(%i- len afonts))))
             (declare (fixnum times))
             (cond ((plusp difference) ; moving down - ok
                    (dotimes (i times)
                      (move-fontrun fontruns pidx (%i+ pidx difference))
                      (setq pidx (1- pidx))))
                   ((minusp difference)
                    (let ((tidx (- len afonts))) ; moving up
                      (declare (fixnum tidx))
                      (dotimes (i times)
                        (move-fontrun fontruns tidx (%i+ tidx difference))
                        (setq tidx (1+ tidx)))))))))))
                       

      
#|
(defun %add-font-change (buf font pos)
  ;(declare (optimize (speed 3)(safety 0)))
  (let* ((bfonts (bf.bfonts buf))
         (afonts (bf.afonts buf))
         (fontruns (bf.fontruns buf))
         (len (length fontruns))
         (gappos (bf.gappos buf))
         (pidx 0))
    (declare (fixnum pos len bfonts afonts gappos))
    (when (< len (%i++ afonts bfonts 1))
      (setq fontruns (%growfontruns buf afonts bfonts))
      (setq len (length fontruns)))    
    (setq pidx (nth-value 2 (%buf-find-font buf pos))) ; goes after pidx unless pidx is nil             
    (cond ((= pos gappos) ; it goes in bfonts
           (setq pidx bfonts)
           (setf (bf.bfonts buf)(1+ bfonts)))
          ((>= pos gappos)
           (setq pos (+ pos (%i- (bf.gapend buf)(bf.gapstart buf))))
           (setf (bf.afonts buf) (setq afonts (1+ afonts)))
           (if (or (not pidx)(< pidx bfonts))
             (setq pidx (- len afonts)))
           (let ((tidx  (- len afonts)))
             (declare (fixnum tidx))
             (dotimes (i  (%i- pidx tidx))
               (declare (fixnum i))
               (move-fontrun fontruns (%i+ 1 tidx) tidx)
               (setq tidx (1+ tidx)))))
          (t (setf (bf.bfonts buf) (setq bfonts (1+ bfonts)))
             (if (null pidx)(setq pidx 0)(setq pidx (1+ pidx)))
             (let ((tidx (- bfonts 1)))
               (declare (fixnum tidx))
               (dotimes (i (%i--  bfonts pidx 1))
                 (declare (fixnum i))
                 (move-fontrun fontruns (%i- tidx 1) tidx)
                 (setq tidx (1- tidx))))))
    (set-fontruns fontruns pidx font pos)))
|#
    
                    
    

(defun buffer-set-font-codes (place ff ms &optional start end &aux findex)
  (cond ((and ff ms)
         (setq findex (add-buffer-font place ff ms))
         (if start
           (buffer-change-font-index place findex start end)
           (set-buffer-insert-font-index place findex)))
        (t (set-buffer-insert-font-index place nil))))

(defun buffer-empty-font-codes (buffer)
  (buffer-font-index-codes buffer (buffer-empty-font-index buffer)))

(defun set-buffer-empty-font-codes (buffer ff ms) 
  (let ((index (add-buffer-font buffer ff ms)))
    (set-buffer-empty-font-index buffer index)))

(defun buffer-insert-font-codes (buffer)
  (let ((index (buffer-insert-font-index buffer)))
    (when index
      (buffer-font-index-codes buffer index)))) 

(defun set-buffer-insert-font-codes (buffer &optional  ff ms)
  (if (and ff ms)
    (let ((index (add-buffer-font buffer ff ms)))
      (set-buffer-insert-font-index buffer index))
    (set-buffer-insert-font-index buffer nil)))

(defun buffer-empty-font-index (buffer)
  (1+ (bf-cfont (mark-buffer buffer))))

#|
; this has changed in meaning - it sets the font to use in an empty buffer
; or at the next insertion
(defun current-buffer-font-index (buffer &optional font-index)
  (let* ((buf (mark-buffer buffer))
         (flist (bf.flist buf)))    
    (if font-index
      (progn
        ;(setq font-index (1- font-index))
        (when (not (<= 1 font-index  (ash (length flist) -1)))
          (error "~s is not a valid font index in ~s" font-index buffer))
        (set-buffer-insert-font-index buffer font-index)
        font-index)
      (or (buffer-insert-font-index buffer) (1+ (bf-cfont buf)))))) ; ????
|#

(defun buffer-replace-font-codes (buf old-ff old-ms new-ff new-ms)
  (let ((old-index (buffer-font-index buf old-ff old-ms)))
    (when old-index
      (%replace-buffer-font buf old-index new-ff new-ms))))

(defun %replace-buffer-font (buffer font-index ff ms)
  (declare (fixnum font-index))
  (let* ((buf (mark-buffer buffer))
         (flist (bf.flist buf)))
    (declare (fixnum font-index))
    (setq font-index (%i- font-index 1))
    (when (not (and (<= 0 font-index) (<= font-index (1- (ash (length flist) -1)))))
      (error "~s is not a valid font index in ~s" (1+ font-index) buffer))
    (setf (svref flist (%i+ font-index font-index)) ff)
    (setf (svref flist (%i+ font-index font-index 1)) ms)
    (setf (bf.modcnt buf)(%i+ 1 (bf.modcnt buf)))
    (setf (bf.bmod buf) 0)
    (setf (bf.zmod buf) 0)
    (%i+ 1 font-index)))

;;; 05/09/95 bill buffer-remove-unused-fonts compares against %no-font-index
;;;               instead of nil in its final loop

#|
(defun buffer-remove-unused-fonts (buffer)
  (let ((buf (mark-buffer buffer)))
    (when  (logbitp $bf_purge-fonts-flag (bf.fixnum buf))
      (let* ((fontruns (bf.fontruns buf))
             (len (length fontruns))
             (bfonts (bf.bfonts buf))
             (afonts (bf.afonts buf))
             (used (make-array 256 :element-type '(unsigned-byte 8)
                               :initial-element %no-font-index)))
        (declare (dynamic-extent used))
        (when (> len 1)
          (let ((idx 0))
            (let ((font (bf-cfont buf)))
              (setf (uvref used font) idx)
              (bf-cfont buf idx)
              (setq idx (1+ idx)))
            (let ((font (bf-efont buf))) ; 6/10/95
              (when (neq font %no-font-index)
                (setf (uvref used font) idx)
                (bf-efont buf idx)
                (setq idx (1+ idx))))                
            (dotimes (i bfonts)
              (let ((font (fontruns-font fontruns  i)))
                (when (eq (uvref used font) %no-font-index)
                  (setf (uvref used font) idx)
                  (setq idx (1+ idx)))))            
            (dotimes (i afonts)
              (let ((font (fontruns-font fontruns (- len i 1))))
                (when (eq (uvref used font) %no-font-index)
                  (setf (uvref used font) idx)
                  (setq idx (1+ idx)))))
            (when (not (eql  (+ idx idx)(length (bf.flist buf))))
              (without-interrupts
               (dotimes (i bfonts)
                 (let* ((old (fontruns-font fontruns i))
                        (new (uvref used old)))
                   (set-fontruns-font fontruns i new)))
               (dotimes (i afonts)
                 (let* ((old (fontruns-font fontruns (- len i 1)))
                        (new (uvref used old)))
                   (set-fontruns-font fontruns (- len i 1) new)))
               (let* ((flen (ash idx 1))
                      (newflist (make-array flen)))
                 (declare (fixnum flen))
                 (dotimes (i 256)
                   (let ((new (uvref used i)))
                     (unless (eql new %no-font-index)
                       (multiple-value-bind (ff ms)(%buffer-font-codes buf i)
                         (setf (svref newflist (+ new new)) ff)
                         (setf (svref newflist (+ new new 1)) ms)))))              
                 (setf (bf.flist buf) newflist))))))))))
|#

#|


(defun buffer-remove-unused-fonts (buffer)
  (let ((buf (mark-buffer buffer)))
    (when  (logbitp $bf_purge-fonts-flag (bf.fixnum buf))
      (let* ((fontruns (bf.fontruns buf))
             (len (length fontruns))
             (bfonts (bf.bfonts buf))
             (afonts (bf.afonts buf))
             (used (make-array 256 :element-type '(unsigned-byte 8)
                               :initial-element %no-font-index)))
        (declare (dynamic-extent used))
        (when (> len 1)
          (let ((idx 0))
            (let ((font (bf-cfont buf)))
              (setf (uvref used font) idx)
              (bf-cfont buf idx)
              (setq idx (1+ idx)))
            (dotimes (i bfonts)
              (let ((font (fontruns-font fontruns  i)))
                (when (eq (uvref used font) %no-font-index)
                  (setf (uvref used font) idx)
                  (setq idx (1+ idx)))))            
            (dotimes (i afonts)
              (let ((font (fontruns-font fontruns (- len i 1))))
                (when (eq (uvref used font) %no-font-index)
                  (setf (uvref used font) idx)
                  (setq idx (1+ idx)))))
            (dotimes (i bfonts)
              (let* ((old (fontruns-font fontruns i))
                     (new (uvref used old)))
                (set-fontruns-font fontruns i new)))
            (dotimes (i afonts)
              (let* ((old (fontruns-font fontruns (- len i 1)))
                     (new (uvref used old)))
                (set-fontruns-font fontruns (- len i 1) new)))
            (let* ((flen (ash idx 1)))
              (declare (fixnum flen))
              (when (< flen (length (bf.flist buf)))
                (let ((newflist (make-array flen)))
                  (dotimes (i 256)
                    (let ((new (uvref used i)))
                      (when new
                        (multiple-value-bind (ff ms)(%buffer-font-codes buf i)
                          (setf (svref newflist (+ new new)) ff)
                          (setf (svref newflist (+ new new 1)) ms)))))              
                  (setf (bf.flist buf) newflist))))))))))
|#



(defun buffer-remove-unused-fonts (buffer)
  (let ((buf (mark-buffer buffer)))
    (when  (logbitp $bf_purge-fonts-flag (bf.fixnum buf))
      (let* ((fontruns (bf.fontruns buf))
             (len (length fontruns))
             (bfonts (bf.bfonts buf))
             (afonts (bf.afonts buf))
             (used (make-array 256 :element-type '(unsigned-byte 8)
                               :initial-element %no-font-index)))
        (declare (dynamic-extent used))
        (when (> len 1)
          (let ((idx 0))
            (let ((font (bf-cfont buf)))
              (setf (uvref used font) idx)
              (bf-cfont buf idx)
              (setq idx (1+ idx)))
            (let ((font (bf-efont buf))) ; 6/10/95
              (when (neq font %no-font-index)
                (setf (uvref used font) idx)
                (bf-efont buf idx)
                (setq idx (1+ idx))))                
            (dotimes (i bfonts)
              (let ((font (fontruns-font fontruns  i)))
                (when (eq (uvref used font) %no-font-index)
                  (setf (uvref used font) idx)
                  (setq idx (1+ idx)))))            
            (dotimes (i afonts)
              (let ((font (fontruns-font fontruns (- len i 1))))
                (when (eq (uvref used font) %no-font-index)
                  (setf (uvref used font) idx)
                  (setq idx (1+ idx)))))
            (when (not (eql  (+ idx idx)(length (bf.flist buf))))
              (without-interrupts
               (dotimes (i bfonts)
                 (let* ((old (fontruns-font fontruns i))
                        (new (uvref used old)))
                   (set-fontruns-font fontruns i new)))
               (dotimes (i afonts)
                 (let* ((old (fontruns-font fontruns (- len i 1)))
                        (new (uvref used old)))
                   (set-fontruns-font fontruns (- len i 1) new)))
               (let* ((flen (ash idx 1))
                      (newflist (make-array flen))
                      (old-flen (length (bf.flist buf))))       ; keke
                 (declare (fixnum flen old-flen))       ; keke
                 (dotimes (i 256)
                   ;; keke: %buffer-font-codes read from bf.flist.
                   ;; ensure that it won't access beyond bf.flist.
                   (when (= (%i+ i i) old-flen)
                     (return))
                   (let ((new (uvref used i)))
                     (unless (eql new %no-font-index)
                       (multiple-value-bind (ff ms)(%buffer-font-codes buf i)
                         (setf (svref newflist (+ new new)) ff)
                         (setf (svref newflist (+ new new 1)) ms)))))              
                 (setf (bf.flist buf) newflist))))))))))

; the style vector is a vector of 16 bit bytes
; 2 bytes - # of fonts
; each font 2 bytes font code, 1 byte size, 1 byte face 
; 2 short words for each run? 1 byte font index, 3 bytes offset
; no long's to avoid bignums???

(defun buffer-get-style (buffer &optional (start 0) (end t))
  (multiple-value-setq (start end)(buffer-range buffer end start))
  (let ((colors (buffer-color-vector  buffer start end)))
    (if (= start end)
      (let ((vect (make-array 3 :element-type '(unsigned-byte 16))))
        (setf (uvref vect 0) 1) ; 1 font
        (multiple-value-bind (ff ms)(buffer-char-font-codes buffer start)        
          (let ((w2 (logior (ash (logand ms #xff) 8)(logand #xff  (ash ff -8))))) ; size and face
            (setf (uvref vect 1) (font-out (ash ff -16)))
            (Setf (uvref vect 2) w2)))
        (if colors (cons vect colors) vect))
      (let* ((buf (mark.buffer buffer))
             (flen (length (bf.flist buf)))
             (used (make-array (the fixnum (ash flen -1)) :initial-element nil)))
        (declare (dynamic-extent used))
        (multiple-value-bind (nfonts nruns pidx)
                             (%buffer-prescan-style buf used start end)
          (let* ((len (%i+ 3 (%i* 2 nfonts)(%i* 2 nruns)))
                 (vect (make-array len :element-type '(unsigned-byte 16))))          
            (declare (fixnum len))
            (%buf-fill-style buf used vect nfonts nruns pidx start end)
            (if colors (cons vect colors) vect)          
            #|vect|#))))))

; in the old world style vectors are signed byte 16 - yuck!
; must we conform?
#|
(defun buffer-set-style (buffer style start)
  (setq style (require-type style '(simple-array (unsigned-byte 16) (*))))  
  (setq start (buffer-position buffer start))  
  (let* ((nfonts (uvref style 0))
         (ridx (+ nfonts nfonts 1))
         (used (make-array 256))
         (length (length style))) ; only need nfonts    
    (declare (dynamic-extent used)(fixnum ridx nfonts))
    (dotimes (i nfonts)
      (let* ((font (uvref style (+ i i 1)))
             (lo (uvref style (+ i i 2)))
             (ff (logior (ash font 16)(ash (logand lo #xff) 8)))
             (ms (logior (ash $srcor 16)(ash  lo -8)))
             (fidx (1- (add-buffer-font buffer ff ms))))
        (declare (fixnum font lo  ms fidx))
        (setf (uvref used i) fidx)))
    (when (> length ridx) ; assure some runs      
      (let* ((hi (uvref style (- length 2)))
             (the-end (uvref style (- length 1)))
             (slen (- (ash length -1) nfonts 1))
             (the-buffer (mark-buffer buffer))
             (gappos (bf.gappos the-buffer)))
        (declare (fixnum hi pos font slen))
        (setq the-end (+ start (logior (ash (logand hi #xff) 16) the-end)))        
        (when (neq gappos the-end)  ; its very likely to be there anyway
          (%move-gap the-buffer (%i- the-end gappos)))
        (let* (font)
          (dotimes (i slen)
            (let ((hi (uvref style ridx))
                  (pos (uvref style (1+ ridx))))
              (setq font (uvref used (1- (ash hi -8))))
              (setq pos (logior (ash (logand  hi #xff) 16) pos))
              (buffer-change-font-index buffer (1+ font) (+ pos start) the-end))
            (setq ridx (+ 2 ridx)))          
          )))
    start))
|#

(defun buffer-set-style (buffer style start &aux colors)
  (when (listp style)
    (setq colors (require-type (cdr style) '(simple-array (signed-byte 16) (*)))
          style (car style)))
  (setq style (require-type style '(simple-array (unsigned-byte 16) (*))))  
  (setq start (buffer-position buffer start))  
  (let* ((nfonts (uvref style 0))
         (ridx (%i+ nfonts nfonts 1))
         (flen (length (bf.flist (mark.buffer buffer))))
         (used (make-array (the fixnum (min (%i+ (ash flen -1) nfonts) 256))
                             :initial-element nil))
         (length (length style))) ; only need nfonts    
    (declare (dynamic-extent used)(fixnum ridx nfonts length))
    (dotimes (i nfonts)
      (let* ((font (font-in (uvref style (%i+ i i 1))))  ; 16 bits font
             (lo (uvref style (%i+ i i 2)))    ; 8 bits face 8 bits size
             (color (if colors (uvref colors (%i+ i 1)) 0))
             (ff (logior (ash font 16)(ash (logand lo #xff) 8) color))
             (ms (logior (ash $srcor 16)(ash  lo -8)))
             (fidx (1- (add-buffer-font buffer ff ms))))
        (declare (fixnum font lo ms fidx))
        (setf (uvref used i) fidx)))
    (when (> length ridx) ; assure some runs      
      (let* ((hi (uvref style (%i- length 2)))
             (the-end (uvref style (%i- length 1)))
             (slen (%i-- (ash length -1) nfonts 1))
             (the-buffer (mark-buffer buffer))
             (gappos (bf.gappos the-buffer)))
        (declare (fixnum hi pos slen gappos the-end))
        (setq the-end (%i+ start (logior (ash (logand hi #xff) 16) the-end)))        
        (when (neq gappos the-end)  ; its very likely to be there anyway
          (%move-gap the-buffer (%i- the-end gappos)))
        (let* ((font (uvref used (%i- (ash (uvref style ridx) -8) 1))))
          (buffer-change-font-index buffer (%i+ 1 font) start the-end))
        (let* ((bfonts (bf.bfonts the-buffer))
               (fontruns (%growfontruns the-buffer (bf.afonts the-buffer) bfonts slen))
               (font nil))
          (declare (fixnum bfonts))
          (multiple-value-bind (epos efont)(%buf-find-font the-buffer the-end)
            (dotimes (i (1- slen))
              (setq ridx (+ 2 ridx))
              (let ((hi (uvref style ridx))
                    (pos (uvref style (1+ ridx))))
                (declare (fixnum hi pos))
                (setq font (uvref used (%i- (ash hi -8) 1)))
                (setq pos (logior (ash (logand  hi #xff) 16) pos))                
                (set-fontruns fontruns bfonts font (%i+ pos start))                
                (setq bfonts (1+ bfonts))))
            (setf (bf.bfonts the-buffer) bfonts)
            (when (and (eq font efont)(eq epos the-end))
              (setq font nil)
              (setf (bf.afonts the-buffer)(%i- (bf.afonts the-buffer) 1)))
            (when (and font (neq font efont)(neq epos the-end)(neq the-end (bf.bufsiz the-buffer)))
              (let ((afonts (1+ (bf.afonts the-buffer))))
                (declare (fixnum afonts))
                (set-fontruns fontruns (%i- (length fontruns) afonts) efont 
                              (%i+ the-end (%i- (bf.gapend the-buffer)(bf.gapstart the-buffer))))
                (setf (bf.afonts the-buffer) afonts)))))))
    start))

; N.B. this doesnt do what one expects if relevent scripts are not installed
;; not used today
#|
(defun buffer-get-scriptruns (buffer start end)
  (let ((tstart start)
        (n 0)
        script)
    (declare (fixnum n))
    (while (and tstart (< tstart end))
      (multiple-value-setq (script tstart)(buffer-next-script-change buffer tstart end))
      (setq n (1+ n)))
    (let ()
      (if (eq n 1)
        (when (neq script #$smRoman)
          (let ((result (make-array 1 :element-type '(unsigned-byte 32))))
            (set-fontruns-font result 0 script)
            (set-fontruns-pos result 0 0)
            result))
        (let* ((result (make-array n :element-type '(unsigned-byte 32)))
               (tstart start)
               (istart start)
               (n 0))
          (while (and tstart (< tstart end))
            (multiple-value-setq (script tstart)(buffer-next-script-change buffer tstart end))
            (set-fontruns-font result n script)
            (set-fontruns-pos result n (- start istart))
            (setq start tstart)
            (setq n (1+ n)))
          result)))))
|#

(defun buffer-get-scriptruns-slow (buffer)
  (let* ((start 0)
         (end (buffer-size buffer))
         (result (make-array 10 :element-type '(unsigned-byte 32)
                             :fill-pointer 0
                             :adjustable t))
         (len (- end start))
         (last -1))
    (declare (fixnum len))
    (dotimes (i len)
      (let ((code (%char-code (buffer-char buffer (%i+ start i)))))
        (when (or (eq last -1)(%i> code #x20))
          (let ((this (%find-encoding-for-uchar-code code)))
            (if (neq this last)
              (progn (vector-push-extend (logior (ash this 24) (%i+ start i)) result) 
                     (setq last this)
                     )))))) 
    (vector-push-extend end result)
    result))

#|
(setq bb (make-buffer))
(buffer-insert bb "asdfasdfasdf" nil '("monaco" 12 :srcor :bold))
(buffer-insert bb "asdfasdfasdf" nil '("monaco" 24 :srcor :bold))
(buffer-insert bb "asdfasdfasdf" nil '("monaco" 12 :srcor :bold))
(%move-gap (mark-buffer bb) -36)

(setq st (buffer-get-style bb 0 t))
(xbuffer-set-style bb st 36)

|#

; from buffer to style vector or resource
(defun %buf-fill-style (buf used vect nfonts nruns pidx start end)
  (declare (fixnum nfonts nrums pidx start end))
  (let* ((ridx (%i+ nfonts nfonts 1))         
         (fontruns (bf.fontruns buf))
         (len (length fontruns))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         (gappos (bf.gappos buf))
         (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
         (handlep (not (vectorp vect))) ; (handlep vect))
         (first t))
    (declare (fixnum ridx len afonts bfonts gappos gaplen))
    ; we want to stuff this stuff into a resource too.
    ; don't assume its a vector????
    (cond
     (handlep
      (%hput-word vect nfonts 0))
     (t (setf (uvref vect 0) nfonts)))
    (dotimes (i (length used))
      (let ((nidx (uvref used i)))
        (when nidx
          (multiple-value-bind (ff ms)(%buffer-font-codes buf i)
            (let* ((w1 (ash ff -16))
                   (w2 (logior (ash (logand ms #xff) 8)(logand #xff  (ash ff -8))))
                   (idx (%i+ nidx nidx 1)))
              (setq w1 (font-out w1))
              (cond
               (handlep
                (%hput-word vect w1 (%i+ idx idx))
                (%hput-word vect w2 (%i+ idx idx 2)))
               (t (setf (uvref vect idx) w1) ; font code
                  (setf (uvref vect (%i+ 1 idx)) w2))))))))                
    (dotimes (i nruns)
      (let* ((fidx (fontruns-font fontruns pidx))
             (nfidx (uvref used fidx))
             (pos (fontruns-pos fontruns pidx)))
        (declare (fixnum fidx pos))
        (when (> pos gappos)(setq pos (- pos gaplen)))        
        (if first (setq pos 0 first nil)(setq pos (- pos start)))
        (let* ((w1 (logior (ash (%i+ 1 nfidx) 8) (ash pos -16)))
               (w2 (logand pos #xffff)))
          ;(break "run ~s ~S" w1 w2)
          (cond
           (handlep 
            (%hput-word vect w1 (%i+ ridx ridx))
            (%hput-word vect w2 (%i+ ridx ridx 2)))
           (t (setf (uvref vect ridx) w1)
              (setf (uvref vect (%i+ 1 ridx)) w2))))
        (setq ridx (+ ridx 2))
        (cond ((>= pidx bfonts)
               (setq pidx (1+ pidx)))
              (t (setq pidx (1+ pidx))
                 (when (>= pidx bfonts)
                   (setq pidx (- len afonts)))))))
    (when end
      (let ((end (- end start)))
        (cond (handlep
               #|(%hput-word vect (ash end -16) (+ ridx ridx))
                 (%hput-word vect (logand end #xffff)(+ ridx ridx 2))|# )
              (t (setf (uvref vect ridx)(ash end -16))   ; is this necessary - yes because a style can
                 					 ; exist indepedent of a string 
                 (setf (uvref vect (%i+ 1 ridx)) (logand end #xffff))))))))
    
                       

; returns # of fonts and # of runs
; if scripts is true also returns number of script runs
; and whether any script has 2 byte chars
; scriptp always nil today
(defun %buffer-prescan-style (buf used start end &optional scriptp)
  (declare (fixnum start end))
  (declare (ignore-if-unused scriptp))
  (let* ((gappos (bf.gappos buf))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
         (fontruns (bf.fontruns buf))
         (len (length fontruns))
         (runs 0)(fonts 0))
    (declare (fixnum gappos afonts bfonts gaplen len runs fonts))
    (when (> end gappos) (setq end (+ end gaplen))) ; or > ?
    (setf (uvref used (bf-cfont buf)) 0) ; cfont becomes 0
    (setq fonts 1)  ; doesnt seem to work
    (multiple-value-bind (ppos pfont pidx)(%buf-find-font buf start)
      (declare (fixnum ppos pfont pidx))      
      (let ((idx pidx))
        (declare (fixnum idx))
        (loop
          (when (>= ppos end)
            (return))
          (setq runs (1+ runs))
          (when (not (uvref used pfont))
            (setf (uvref used pfont) fonts)
            (setq fonts (1+ fonts)))
          (cond ((>= idx bfonts)
                 (setq idx (1+ idx))
                 (when (>= idx len)(return)))
                (t (setq idx (1+ idx))
                   (when (>= idx bfonts)
                     (if (zerop afonts)
                       (return)
                       (setq idx (- len afonts))))))
          (setq ppos (fontruns-pos fontruns idx))
          (setq pfont (fontruns-font fontruns idx)))        
      (values fonts runs pidx )))))

(defmacro buffer-file-write-date (buffer)
  `(buffer-getprop ,buffer 'file-write-date))

#|
(defun buffer-tabcount (buffer)
  (buffer-getprop buffer 'buffer-tabcount 8))
|#


;; from slh
(export '*default-tabcount*)

(defvar *default-tabcount* 8
  "Default number of spaces for Tab key")

; 8 -> *default-tabcount*
(defun buffer-tabcount (buffer)
  (buffer-getprop buffer 'buffer-tabcount *default-tabcount*))


(defun (setf buffer-tabcount) (new-tabcount buffer)
  (setq new-tabcount (require-type new-tabcount '(integer 1 128)))
  (unless (eql new-tabcount (buffer-tabcount buffer))
    (when (%buffer-read-only-p buffer)
      (%buf-signal-read-only))
    (incf (bf.modcnt (mark.buffer buffer)))
    (buffer-putprop buffer 'buffer-tabcount new-tabcount)))

(defun buffer-wrap-p (buffer)
  (buffer-getprop buffer 'buffer-wrap-p))

(defun (setf buffer-wrap-p) (value buffer)
  (unless (eql value (buffer-wrap-p buffer))
    (when (%buffer-read-only-p buffer)
      (%buf-signal-read-only))
    (incf (bf.modcnt (mark.buffer buffer)))
    (buffer-putprop buffer 'buffer-wrap-p value)))

(defun buffer-word-wrap-p (buffer)
  (buffer-getprop buffer 'buffer-word-wrap-p))

(defun (setf buffer-word-wrap-p) (value buffer)
  (unless (eql value (buffer-word-wrap-p buffer))
    (when (%buffer-read-only-p buffer)
      (%buf-signal-read-only))
    (incf (bf.modcnt (mark.buffer buffer)))
    (buffer-putprop buffer 'buffer-word-wrap-p value)))

(defun buffer-justification (buffer)
  (buffer-getprop buffer 'buffer-justification))

(defun (setf buffer-justification) (value buffer)
  (unless (eql value (buffer-justification buffer))
    (when (%buffer-read-only-p buffer)
      (%buf-signal-read-only))
    (incf (bf.modcnt (mark.buffer buffer)))
    (buffer-putprop buffer 'buffer-justification value)))

(defun buffer-line-right-p (buffer)
  (buffer-getprop buffer 'buffer-line-right-p))

(defun (setf buffer-line-right-p) (value buffer)
  (unless (eql value (buffer-line-right-p buffer))
    (when (%buffer-read-only-p buffer)
      (%buf-signal-read-only))
    (incf (bf.modcnt (mark.buffer buffer)))
    (buffer-putprop buffer 'buffer-line-right-p value)))



(defun handle-file-busy (truename)
  (standard-alert-dialog (format nil "File \"~a\" is busy or locked." (back-translate-pathname truename))
                         :Yes-text "Cancel" :no-text nil :cancel-text nil)
  (throw-cancel :cancel))
  

(defun buffer-write-file (buffer name &key (if-exists :error) external-format window)
  (multiple-value-bind (truename bits) (probe-file-x name)
    (cond 
     (truename
      (when (and (check-read-only-p name nil)(NOT (logbitp #$kFSNodeLockedBit bits)))
        (when (not (file-whine-read-only name))
          (return-from buffer-write-file nil)))      
      (ecase if-exists
        (:error (signal-file-error $xfileexists truename))
        ((:overwrite :supersede)
         (when (dolist (x *fsopen-files* nil)
                 (when (equal truename (probe-file (car x)))
                   (return t)))
           (handle-file-busy truename)
           ;(signal-file-error $xfilebusy truename)
           )
         (let ((streams))         
           (when (or (dolist (s *open-file-streams* streams)
                       (when (equal truename (stream-pathname s))
                         (push s streams)))
                     (neq 0 (logand bits #x81))) 
             (unless (and (eq 0 (logand bits #$kfsnodelockedmask)) ;; aka 1                          
                          (and streams
                               (or
                                (not 
                                 (standard-alert-dialog
                                  (format nil "Close all streams for file:~%\"~a\"~%so that the buffer can be written?"
                                          (back-translate-pathname truename))
                                  :yes-text "No" :no-text "Yes" :cancel-text nil))
                                (throw-cancel :cancel))
                               (progn
                                 (dolist (s streams) (close s :abort t))
                                 (setq bits (nth-value 1 (probe-file-x truename)))
                                 ;; only prevents overwrite if another app has open for writing - not if for reading
                                 (eq 0 (logand bits #x81)))))
               (handle-file-busy truename)
               ;(signal-file-error $xfilebusy truename)
               )))
         (when (eq if-exists :supersede)  ;; window = nil from inspector::step-window - but then :supersede is also nil
           (let* ((tem-file)  
                  ;(window (buffer-owner buffer))
                  (old-fsref (and window (window-fsref window))))
             (when (and old-fsref (not (window-filename-from-fsref window)))
               (#_disposeptr old-fsref)
               (setq old-fsref nil))
             (without-interrupts
              (setq tem-file (gen-file-name truename))
              (when window
                (setf (window-fsref window) nil))  ;; <<
              (lock-file truename)
              ;; do it now so no one else will grab the gen name
              (create-file tem-file))
             (handler-bind ((error 
                             #'(lambda (c)
                                 (when tem-file
                                   (delete-file tem-file :temporary-file-p t))
                                 (unlock-file truename)
                                 (when old-fsref
                                   (setf (window-fsref window) old-fsref))
                                 (setq tem-file nil)
                                 (signal c))))             
               (buffer-write-file buffer tem-file :if-exists :overwrite :external-format external-format :window window))
             (without-interrupts 
              (unlock-file truename)
              (let ((moved-to-trash (nth-value 1 (delete-file truename :temporary-file-p t))))
                (rename-file tem-file truename)
                (setf (buffer-filename buffer) truename)
                (cond (moved-to-trash  ;; don't know why proxy needs redo if moved to trash but not if simple delete
                       (when (and old-fsref)
                         (#_disposeptr old-fsref))             
                       (#_removewindowproxy (wptr window))
                       (add-window-proxy-icon window truename))
                      (old-fsref
                       (make-fsref-from-path-simple truename old-fsref)
                       (setf (window-fsref window) old-fsref)))))             
             (return-from buffer-write-file truename))))))
     (t (setq name (create-file name))))
    (let ((encoding-runs (%buffer-write-file buffer name external-format window)))
      (setf (buffer-filename buffer) name)
      (when (eq external-format :utf-16)(set-mac-file-type name :|utxt|))
      (when window (set-file-external-format window external-format))
      (when t ;(not external-format)  ;; currently font stuff doesn't work for utf files - NAh it's an OS9 crock
        (let (refnum)
          (unwind-protect
            (when (setq refnum (%open-res-file2 Name)) ; should this error check - maybe its open in resedit!
              (#_UseResFile  refnum)
              (%buffer-write-style buffer encoding-runs))
            (when refnum
              (#_CloseResFile refnum)))))
      (flush-volume name)
      (setf (buffer-file-write-date buffer) (mac-file-write-date name))
      name)))

(defparameter fname-display-limit 200)

(defun handle-buffer-save-conflict (name)
  (let ((filename (back-translate-pathname name)))
    (when (standard-alert-dialog (format nil "The file \"~A\" has been modified since you last read or wrote it.
Save over it, clobbering someone else's changes?"
                                 filename)
                         :yes-text "No"
                         :no-text "Yes"
                         :cancel-text nil )
      ;; if user says NO skip town else save
      (cancel))))

(defun handle-file-gonzo (name)
  (let ((filename (back-translate-pathname name)))
    ;; this is longhand for saying the file isn't there anymore
    (let ((ans (standard-alert-dialog 
                (format nil "The file \"~A\" has been deleted, moved, or renamed since you last read or wrote it.
Save this version of the file here?~%Or save it elsewhere ...?"
                        filename)
                :yes-text "Save"
                :no-text "Elsewhere"
                :cancel-text "Cancel")))
      ans)))

#|
(defun truncate-string (string max-length)
  ;; THIS IS STUPID FOR ENCODED-STRING
  (let ((real-string string)
        encoding)
    (if (typep string 'encoded-string)
      (setq real-string (the-string string)
            encoding (the-encoding string)))    
    (cond ((> (length real-string) max-length)
           (let ((trunc-string (subseq real-string 0 max-length)))
             (setf (char trunc-string (1- max-length)) (if (null encoding) #\… (convert-char-to-unicode #\…)))
             (if encoding (make-encoded-string trunc-string) TRUNC-STRING)))
          (t string))))
|#

(defun truncate-string (string max-length)
  ;; 
  (let ((real-string string)
        encoding)
    (if (typep string 'encoded-string)
      (progn (setq encoding (the-encoding string))
             (setq real-string (the-string string))))
    (cond ((> (length real-string) max-length)
           (if (and encoding (neq encoding #$kcfstringencodingunicode))
             (progn (setq real-string (convert-string real-string encoding #$kcfstringencodingunicode))
                    (if (not (> (length real-string) max-length))(return-from truncate-string string))))
           (if (extended-string-p real-string)
             (let ((sub (%substr real-string 0 max-length)))
               (setf (schar sub (1- max-length)) #\…)
               sub)
             (let ((new (make-string max-length :element-type 'extended-character)))
               (dotimes (i (1- max-length))
                 (setf (schar new i)(schar real-string i)))
               (setf (schar new (1- max-length)) #\…)
               new)))
          (T string))))


(defparameter *preferred-eol-character* nil
"The character to use to denote end of line
when a Fred buffer is written to a file.
NIL means don't care.")
(export '*preferred-eol-character*)

(defun %buffer-write-file (buffer name &optional external-format window)
  (let ((encoding-runs nil))
    (setq name (truename name))  ; think we already did this
    (when window
      (let ((fred-item (fr.owner (frec window))))
        (cond ((eq external-format :unix)
               (ed-xform-newlines fred-item))
              ((eq *preferred-eol-character* #\linefeed)
               (ed-xform-newlines fred-item))
              ((eq *preferred-eol-character* #\return)
               (ed-xform-linefeeds fred-item)))))         
    (cond ((memq external-format '(:utf-16 :utf-8))
           (%buffer-write-utf-file buffer name external-format))
          (t (setq encoding-runs (%buffer-write-mac-encoded-file buffer name)) ;; caller wants encoding-runs if any
             ))  
    encoding-runs))


; The format of the style resource is the same as that
; of a style vector.  It's stored in the ('FRED' 2) resource.
;
; count         2 bytes - number of fonts
;
; code1         2 bytes - font code 1
; size1         1 byte  - font size 1
; face1         1 byte  - face code 1
; ...
; codeN         2 bytes - font code N
; sizeN         1 byte  - font size N
; faceN         1 byte  - face code N
;
; index0        1 byte  - font index
; offset0       3 bytes - offset
; index1        1 byte  - font index
; offset1       3 bytes - offset
; ...
; indexM        1 byte  - font index
; offsetM       3 bytes - offset

; if empty buffer should save cfont - how - where
(defun %buffer-write-style (buffer &optional encoding-runs)
  (with-macptrs ((fred2  (#_Get1Resource :FRED 2)))
    (if (%null-ptr-p fred2)
      (Progn
        (%setf-macptr fred2 (#_NewHandle :errchk 0))
        (%stack-block ((name 10))
          (%put-byte name 0 0)
          (#_AddResource fred2 :FRED 2 name) ; ??
          (reserrchk)))
      (#_LoadResource fred2))
    (let* ((buf (mark-buffer buffer))
           (flen (length (bf.flist buf)))
           (used (make-array (the fixnum (ash flen -1)) :initial-element nil)))
      (declare (dynamic-extent used))
      (multiple-value-bind (nfonts nruns pidx)  ;; buffer-prescan no longer needs to do scriptruns
                           (%buffer-prescan-style buf used 0 (bf.bufsiz buf) NIL)
        (let* ((len (+ 1 (* 2 nfonts)(* 2 nruns)))) ; length in 16 bit words
          (#_sethandlesize fred2  (+ len len))
          (%buf-fill-style buf used fred2 nfonts nruns pidx 0 (bf.bufsiz buf))
          (#_Changedresource fred2)
          (reserrchk))
        ;; without this bad things happen - why?? - fixed now but still makes sense to do things the easy way when all macroman
        (when (and encoding-runs (eq (length encoding-runs) 2)(eq 0 (aref encoding-runs 0)))
          (setq encoding-runs nil))
        (with-macptrs ((fred4 (#_get1resource :FRED 4)))
          (cond ((and (not (%null-ptr-p fred4))(not encoding-runs))
                 (#_RemoveResource fred4))
                (encoding-runs
                 (when (%null-ptr-p fred4)
                   (%setf-macptr fred4 (#_NewHandle :errchk 0))
                   (%stack-block ((name 10))
                     (%put-byte name 0 0)
                     (#_AddResource fred4 :FRED 4 name) ; ??
                     (reserrchk)))
                 (#_loadResource fred4)
                 (let ((n (length encoding-runs)))
                   (#_setHandleSize fred4 (* 4 n))
                   (dotimes (i n)
                     (%hput-long fred4 (AREF encoding-runs i) (* i 4)))) ; 5/26 WAS UVREF - has fill ptr
                 (#_ChangedResource fred4)
                 (reserrchk)))))
    (with-macptrs ((fred3 (#_Get1Resource :FRED 3)))
      (%stack-block ((font-name 256))
        (if (%null-ptr-p fred3)
          (progn
            (%setf-macptr fred3 (#_NewHandle :errchk 2))
            (setf (%get-byte font-name) 0)
            (#_AddResource fred3 :FRED 3 font-name)
            (reserrchk))
          (#_LoadResource fred3))
        (let* ((size 2)
               (offset 2)
               (count (%hget-word fred2 0)))
          (declare (fixnum size offset count))
          (dotimes (i count)
            (declare (fixnum i))
            (#_GetFontName (%hget-signed-word fred2 offset) font-name)  ;; <<< signed!
            (let* ((index size) 
                   (bytes (1+ (the fixnum (%get-byte font-name)))))
              (declare (fixnum bytes))
              (incf size bytes)
              (#_SetHandleSize fred3 size)  ;; :errchk didn't work here
              (#_BlockMove font-name (%inc-ptr (%get-ptr fred3) index) bytes))
            
            (incf offset 4))))
      (#_ChangedResource fred3)
      (reserrchk)))

    ; Save colors in ('FRED' 5) resource.
    (let* ((color-vector (buffer-color-vector buffer 0 t))
           (count (and color-vector (1- (length color-vector))))
           (size (and count (+ 2 count))))
      (with-macptrs ((fred5 (#_Get1Resource :FRED 5)))
        (if (%null-ptr-p fred5)
          (when size
            (%setf-macptr fred5 (#_NewHandle :errchk size))
            (with-pstrs ((name ""))
              (#_AddResource fred5 :FRED 5 name)
              (reserrchk)))
          (if size
            (progn
              (#_LoadResource fred5)
              (reserrchk)
              (#_SetHandleSize fred5 size))  ;; errchk didn't work here??
            (#_RemoveResource fred5)))
        (When size
          (setf (%hget-word fred5 0) (aref color-vector 0))
          (let ((offset 2)
                (index 1))
            (dotimes (i count)
              (setf (%hget-byte fred5 offset) (aref color-vector index))
              (incf offset)
              (incf index)))
          (#_ChangedResource fred5))))
    (save-wrap buffer)

 ; save MPSR resource
  (with-macptrs ((rsrc))
    (get-mpsr-resource rsrc)
    (with-dereferenced-handles ((rp rsrc))
      (%put-word rp 6 34)                 ;tab width
      (%put-word rp (buffer-tabcount buffer) 36)        ;tab count
      ;(%put-long rp 0 54)                ;date
      (%put-word rp #x100 70)
      (multiple-value-bind (ff ms) (buffer-empty-font-codes buffer)
        (#_GetFontName (point-v ff) rp)
        (let ((len (%get-byte rp 0)))
          (#_BlockMove (%inc-ptr rp 1) (%inc-ptr rp 2) len)
          (%put-byte rp 0 (%i+ len 2)))   ;null terminator
        (%put-word rp (point-h ms))))
    (#_ChangedResource rsrc)
    (reserrchk))
  ))

(defun save-wrap (buffer)  
  (with-macptrs ((fred6 (#_get1resource :FRED 6)))
    ; Thats a lot for 4 bytes
    (if (not (%null-ptr-p fred6))
      (progn
        (#_LoadResource fred6)        
        (cond ((and (not (buffer-wrap-p buffer))
                  (not (buffer-word-wrap-p buffer))
                  (neq (buffer-justification buffer) :left)
                  (not (buffer-line-right-p buffer)))
               (#_RemoveResource fred6)
               (return-from save-wrap))))
      (progn
        (%setf-macptr fred6 (#_NewHandle :errchk 0))
           (%stack-block ((name 10))
             (%put-byte name 0 0)
             (#_AddResource fred6 :FRED 6 name) ; ??
             (reserrchk))
           (#_LoadResource fred6)
           (#_sethandlesize fred6 4)
           ))
    (%hput-byte fred6 (if (buffer-wrap-p buffer) 1 0))
    (%hput-byte fred6 (if (buffer-word-wrap-p buffer) 1 0) 1)
    (%hput-byte fred6
                (case (buffer-justification buffer)
                  ((:left nil) 0)
                  (:right  1)
                  (:center 2)
                  (t 0))
                2)
    (%hput-byte fred6 0 3)
    (#_changedresource fred6)))


;; fred 2 is style vector
;; fred 3 maps font nums to names
;; fred 4 is scriptruns (optional)
;; fred 5 is color (optional)
;; fred 6 is wrap et al
(defun buffer-insert-file (buffer name &optional pos &aux empty old-size)
  (setq pos (buffer-position buffer pos))
  (setq old-size (buffer-size buffer))
  (setq empty (eq 0 old-size))
  (multiple-value-bind (truename length write-date) (%buffer-insert-file buffer name pos)
    (setf (buffer-file-write-date buffer) write-date)
    (let ((refnum -1)
          (fred5-ok nil))
      (unwind-protect
        (rlet ((fsref :fsref))
          (make-fsref-from-path-simple truename fsref)
          (setq refnum (open-resource-file-from-fsref fsref #$fsrdperm)) ;; (setq refnum (with-pstrs ((np (mac-namestring truename))) (#_HOpenResFile 0 0 np #$fsrdwrperm)))
          (unless (eq refnum -1)
            (with-macptrs ((rsrc (#_Get1Resource :FRED 2))
                           (fred5 (#_Get1Resource :FRED 5)))
              (unless (%null-ptr-p rsrc)
                (#_LoadResource rsrc)
                ; Update font codes from font names
                (with-macptrs ((fred3 (#_Get1Resource :FRED 3)))
                  (unless (%null-ptr-p fred3)
                    (#_LoadResource fred3)
                    (%stack-block ((font-name 256)
                                   (fnum 2))
                      (let* ((size 2)
                            (offset 2)
                            (count (%hget-word rsrc 0))
                            font-num)
                        (declare (fixnum size offset count))
                        (when t ;(eq (%hget-word fred3) count)     ; consistency check does more harm than good
                          (dotimes (i count)
                            (declare (fixnum i))
                            (let ((bytes (1+ (the fixnum (%hget-byte fred3 size)))))
                              (declare (fixnum bytes))
                              (#_BlockMove (%inc-ptr (%get-ptr fred3) size) font-name bytes)
                              (incf size bytes))
                            (#_GetFNum font-name fnum)
                            (unless (eql 0 (setq font-num (%get-word fnum)))
                              (setf (%hget-word rsrc offset) font-num))
                            (incf offset 4)))))))
                (unless (%null-ptr-p fred5)
                  (#_LoadResource fred5)
                  (reserrchk)
                  (when (eql (%hget-word fred5) (%hget-word rsrc))
                    (setq fred5-ok t)))
                ; this is just like buffer set style - n.b. the insertion point is not right
                (let ((len (#_gethandlesize rsrc)))
                  (when (or (< len 6)(and (neq 0 (- (buffer-size buffer) old-size))(< len 10)))
                    (error "Fred2 resource too small"))
                  (when empty ; nuke the monaco 9 from make-buffer
                    (setf (bf.flist (mark-buffer buffer))(make-array 0)))                  
                  (let* ((nfonts (%hget-word rsrc 0))
                         (buffer-size (buffer-size buffer))
                         (idx 2)
                         (cidx 2)
                         (used (make-array 256 :element-type '(unsigned-byte 8))))
                    (declare (dynamic-extent used))
                    (declare (fixnum idx cidx nfonts))
                    ; why not change-font-index from pos to real end                    
                    (dotimes (i nfonts)
                      (let* ((font (%hget-signed-word rsrc idx))        ; << keke was %hget-word
                             (lo (%hget-word rsrc (+ idx 2)))
                             (color (if fred5-ok (%hget-byte fred5 cidx) 0))
                             (ff (logior (ash font 16)(ash (logand lo #xff) 8) color))
                             (ms (logior (ash $srcor 16)(ash  lo -8)))
                             (fidx (1- (add-buffer-font buffer ff ms))))
                        (setf (uvref used i) fidx)
                        (setq cidx (1+ cidx))
                        (setq idx (+ idx 4))))
                    (let* ((slen (ash (- len idx) -2))
                           (the-buffer (mark-buffer buffer))
                           (bfonts (bf.bfonts the-buffer))
                           (the-end (min (+ pos length) buffer-size)) ; << sometimes length wrong?? OK now
                           (fontruns (%growfontruns the-buffer (bf.afonts the-buffer) bfonts (1+ slen))))
                      (unless (eql length 0)
                        (let*  ((font (uvref used (1- (%hget-byte rsrc idx))))) ; ((font (uvref used (1- (ash (%hget-word rsrc idx) -8)))))
                          (buffer-change-font-index buffer (1+ font) pos the-end)) ; error here cause byte at idx is 2 but we only have 1 font
                        (multiple-value-bind (epos efont)(%buf-find-font the-buffer the-end)
                          (let* ((font nil)
                                 (lastpos nil))
                            (dotimes (i  (- slen 1))
                              (setq idx (%i+ idx 4))
                              (let* ((hi (%hget-word rsrc idx))
                                     (runpos (%ilogior (ash (%ilogand hi #xff) 16)
                                               (%hget-word rsrc (%i+ idx 2)))))
                                (declare (fixnum runpos))
                                (setq font (uvref used (%i- (ash (the fixnum hi) -8) 1)))                          
                                ; Fixes a bug in old buffer code that saved two entries for some positions
                                (when (eql runpos lastpos)
                                  (decf bfonts))
                                (setq lastpos runpos)
                                (set-fontruns fontruns bfonts font (%i+ pos runpos))
                                (setq bfonts (%i+ 1 bfonts))))
                            (when (and (eq font efont)(eq epos the-end))
                              (setq font nil)
                              (setf (bf.afonts the-buffer)(1- (bf.afonts the-buffer))))
                            (when (and font (neq font efont)(neq epos the-end)(neq the-end (bf.bufsiz the-buffer)))
                              (let ((afonts (1+ (bf.afonts the-buffer))))
                                (set-fontruns fontruns (- (length fontruns) afonts) efont 
                                              (+ the-end (- (bf.gapend the-buffer)(bf.gapstart the-buffer))))
                                (setf (bf.afonts the-buffer) afonts)))                        
                            (setf (bf.bfonts the-buffer) bfonts))))))))                      
              (when (%null-ptr-p rsrc)
                (%setf-macptr rsrc (#_Get1Resource "MPSR" 1005))
                (unless (%null-ptr-p rsrc)
                  (#_LoadResource rsrc)
                  (with-dereferenced-handles ((rp rsrc))
                    (let ((font-spec (list (%get-cstring rp 2) (%get-word rp))))
                      (when (real-font font-spec)
                        (buffer-set-font-spec buffer font-spec)
                        t))
                    (let ((tabcount (%get-word rp 36)))
                      (setf (buffer-tabcount buffer) tabcount)
                      (let ((the-fun
                             #'(lambda (frec)
                                 (when (same-buffer-p buffer (fr.cursor frec))
                                   (setf (fr.tabcount frec) tabcount)))))
                        (declare (dynamic-extent the-fun))
                        (map-frecs the-fun))))))
              (buffer-remove-unused-fonts buffer)))          
          (if (check-read-only-p truename refnum)
            (progn 
            (%buffer-set-read-only buffer t))))
        (unless (eq refnum -1)  ;; wrong
          (#_CloseResFile refnum))))
    truename))


;; does anyone need this today?
#|
(defun convert-kanji-fred (old &optional new (if-exists :supersede))  
    (let ((refnum -1)
          (old-truename (truename old)))
      (unwind-protect
        (rlet ((fsref :fsref))
          (make-fsref-from-path-simple old-truename fsref)
          (setq refnum (open-resource-file-from-fsref fsref #$fsrdwrperm))
          (unless (eq -1 refnum)
            (with-macptrs ((fred4 (#_get1resource :FRED 4)))
              (when (not (%null-ptr-p fred4))
                (cerror "Ignore error" "File ~s already has a :FRED 4 resource" old)
                (#_RemoveResource fred4))))
          (unless (eq refnum -1)
            (#_CloseResFile refnum))))
      (when new (copy-file old new :if-exists if-exists))
      (let ((truename (truename (or new old))))
        (unwind-protect 
          (rlet ((fsref :fsref))
            (make-fsref-from-path-simple truename fsref)
            (setq refnum (open-resource-file-from-fsref fsref #$fsrdwrperm))
            (unless (eq -1 refnum) ; (setq refnum (with-pstrs ((np (mac-namestring truename))) (#_HOpenResFile 0 0 np #$fsrdwrperm))))            
              (with-open-file (infile truename :direction :input :element-type '(unsigned-byte 8))
                (with-macptrs ((rsrc (#_get1resource :FRED 2)))
                  (unless (%null-ptr-p rsrc)
                    (#_LoadResource rsrc)
                    ; Update font codes from font names
                    (with-macptrs ((fred3 (#_Get1Resource :FRED 3)))
                      (unless (%null-ptr-p fred3)
                        (#_LoadResource fred3)
                        (%stack-block ((font-name 256)
                                       (fnum 2))
                          (let* ((size 2)
                                 (offset 2)
                                 (count (%hget-word rsrc 0))
                                 font-num)
                            (declare (fixnum size offset count))
                            (when (eq (%hget-word fred3) count)     ; consistency check
                              (dotimes (i count)
                                (declare (fixnum i))
                                (let ((bytes (1+ (the fixnum (%hget-byte fred3 size)))))
                                  (declare (fixnum bytes))
                                  (#_BlockMove (%inc-ptr (%get-ptr fred3) size) font-name bytes)
                                  (incf size bytes))
                                (#_GetFNum font-name fnum)
                                (unless (eql 0 (setq font-num (%get-word fnum)))
                                  (setf (%hget-word rsrc offset) font-num))
                                (incf offset 4)))))))
                    (let ((len (#_gethandlesize rsrc))
                          (filelength (file-length infile)))
                      (when (or (< len 6))
                        (error "Fred2 resource too small"))
                      (multiple-value-bind (stream-reader reader-arg) (stream-reader infile)                  
                        (let* ((nfonts (%hget-word rsrc 0))
                               (scriptruns (make-array 8 :adjustable t :fill-pointer 0
                                                       :element-type '(unsigned-byte 32))))
                          (flet ((idx->font (idx)
                                   (when (> idx  nfonts)(error "font idx too big"))
                                   (%hget-word rsrc (+ 2 (* 4 (1- idx))))))
                            (let* ((run-idx (+ 2 (* 4 nfonts)))
                                   (pos-chars 0)                            
                                   last-script fatp)
                              (dotimes (i (truncate (- len run-idx) 4))
                                (let* ((hi (%hget-word rsrc run-idx))
                                       (lo (%hget-word rsrc (+ 2 run-idx)))
                                       (fidx (ash hi -8))
                                       (pos (logior (ash (logand hi #xff) 16) lo))
                                       (next-pos (if (eql run-idx (- len 4))
                                                   filelength
                                                   (logior (%hget-word rsrc (+ 6 run-idx))
                                                           (ash (%hget-byte rsrc (+ 5 run-idx))
                                                                16))))
                                       (font (idx->font fidx)))
                                  (let ((script (font-2-script font)))
                                    (%hput-word rsrc (logior (ash fidx 8)(ash pos-chars -16)) run-idx)
                                    (%hput-word rsrc (logand pos-chars #xffff) (+ run-idx 2))
                                    (when (neq script last-script)
                                      (vector-push-extend (logior (ash script 24) pos-chars) scriptruns))
                                    (if (logbitp #$smsfSingByte (#_getscriptvariable script #$smscriptflags))
                                      (incf pos-chars (- next-pos pos))
                                      (progn
                                        (setq fatp t)
                                        (let ((table (get-char-byte-table script)))
                                          (file-position infile pos)
                                          (let ((n (- next-pos pos)))
                                            (while (> n 0)
                                              (let* ((code (funcall stream-reader reader-arg)))
                                                (when (neq #$smSingleByte (aref table code))
                                                  (decf n)
                                                  (funcall stream-reader reader-arg))
                                                (decf n)
                                                (incf pos-chars)))))))
                                    ;(print (list pos next-pos pos-chars fatp fidx font))                                  
                                    (setq last-script script)))
                                (incf run-idx 4))
                              (#_changedresource rsrc)
                              (vector-push-extend pos-chars scriptruns)
                              (when fatp (write-scriptruns scriptruns t))))))))))))
          (unless (eq refnum -1)
            (#_CloseResFile refnum))))))
|#

#|
(defun write-scriptruns (scriptruns fatp)
  (with-macptrs ((fred4 (#_get1resource :FRED 4)))
    (cond ((and (not (%null-ptr-p fred4))(not fatp))
           (#_RemoveResource fred4))
          (fatp (when (%null-ptr-p fred4)
                  (%setf-macptr fred4 (#_NewHandle :errchk 0))
                  (%stack-block ((name 10))
                    (%put-byte name 0 0)
                    (#_AddResource fred4 :FRED 4 name) ; ??
                    (reserrchk)))
                (#_loadResource fred4)
                (let ((n (length scriptruns)))
                  (#_setHandleSize fred4 (* 4 n))
                  (dotimes (i n)
                    (%hput-long fred4 (AREF scriptruns i) (* i 4))))
                (#_ChangedResource fred4)
                (reserrchk)))))
|#

(defun check-read-only-p (pathname rsrcrefnum &aux opened)
  (unwind-protect
    (or  (file-locked-p pathname)
         (progn
           (when (null rsrcrefnum)
             (setq opened t)
             (rlet ((fsref :fsref))
               (make-fsref-from-path-simple pathname fsref)  ;; is it truename?
               (setq rsrcrefnum (open-resource-file-from-fsref fsref #$fsrdperm))
               ;(setq rsrcrefnum (with-pstrs ((np (mac-namestring pathname))) (#_HOpenResFile 0 0 np #$fsrdwrperm))))
               ))
           (and rsrcrefnum 
                (not (eql rsrcrefnum -1))
                (with-macptrs ((rsrc (#_Get1Resource  "ckid" 128)))
                  (and (not (%null-ptr-p rsrc))
                       (progn (#_LoadResource rsrc) t)
                       (eql 4 (%hget-word rsrc 8))       ; ckid resource version
                       (eql 0 (%hget-word rsrc 10))      ; ckid "readonly" flag - 0 -> r/o
                       (eql 0 (%hget-byte rsrc 13)))))))
    (when (and  opened rsrcrefnum (not (eq rsrcrefnum -1)))
      (#_closeResFile rsrcrefnum))))

(defun %buffer-set-read-only (buffer flag)
  (let ((oldflags (bf.fixnum (mark.buffer buffer))))
    (declare (fixnum oldflogs))
    (setf (bf.fixnum (mark.buffer buffer)) 
          (if flag 
            (bitset $bf_r/o-flag oldflags)
            (bitclr $bf_r/o-flag oldflags))))
  flag)

(defun %buffer-read-only-p (buffer)
  (logbitp $bf_r/o-flag (bf.fixnum (mark.buffer buffer))))

;; from big file patch - is in l1-files.lisp
(defun utcseconds (utcptr)
  "Returns bignum seconds from a Mac :UTCDateTime pointer."
  (+ ccl::$mac-time-offset ; Because the Mac thinks Universal time starts in 1904, and Lisp thinks it starts in 1900
     (ash (pref utcptr :UTCDateTime.highSeconds) 16)
     (pref utcptr :UTCDateTime.lowSeconds)))

(defun my-mod-date-from-fsref (fsref)
  (rlet ((cataloginfo :FSCataloginfo))
    (fsref-get-cat-info fsref cataloginfo #$kFSCatInfoContentMod)
    ;; what do we want here? - not universal time? - ???? - why not use universal time for this purpose?
    (universal-to-mac-time (utcseconds (pref cataloginfo :FSCataloginfo.contentModDate)))))


#|
;; this works - i.e. node bits 0 when done if 0 when started
;; what the hell is wrong with %buffer-insert-file ??? - pinhead
(testit "ccl:00sleazy2.lisp")
(defun testit (path)
  (setq path (truename path))
  (read-scriptruns path)
  (let ((fname (data-fork-name))
        (io-buf-ptr)
        size)
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple path fsref)
      (rlet ((paramblock :fsforkioparam))
        (setf (pref paramblock :FSForkIOParam.ref) fsref
              (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)  ;; gack
              (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
              (pref paramblock :FSForkIOParam.permissions) #$fsrdwrperm
              (pref paramblock :FSForkIOParam.positionmode) #$fsfromstart)
        (print (fsref-node-bits fsref))
        (file-errchk (#_PBOpenForkSync paramblock) path)
        (setq date (my-mod-date-from-fsref fsref))
        (errchk (#_PBgetforksizesync paramblock))
        (print (setq size (unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset))))
        (Setq io-buf-ptr (#_newptrclear 1000))
        (setf (rref paramblock :FSForkIOParam.requestCount) (min size 999))  ;; oh shit
        (setf (rref paramblock :FSForkIOParam.positionMode) #$fsAtMark) ;(%put-word pb 0 $ioposmode)
        (setf (rref paramblock :FSForkIOParam.buffer) io-buf-ptr) ;(%put-ptr pb io-buf-ptr $iobuffer)
        ;(%put-my-ptr pb chunk $iobuffer gapstart)
        (file-errchk (#_PBReadForkSync paramblock) path)
        (print (fsref-node-bits fsref))
        (print (%get-cstring io-buf-ptr))
        (file-errchk (#_PBCloseForkSync paramblock) path)
        (setq date (my-mod-date-from-fsref fsref))
        (print (fsref-node-bits fsref))))))
|#

;; lose this someday
(defparameter *transform-CRLF-to-CarriageReturn* nil)
(export '*transform-CRLF-to-carriageReturn*)

(defparameter *transform-CRLF-to-preferred-eol* nil)
(export '*transform-CRLF-to-preferred-eol*)

(export '(char-eolp char-code-eolp))

(defun utf-something-p (file)  
  (let ((fullp (full-pathname file))
        bom-p)
    (if (eq (mac-file-type fullp) :|utxt|)
      (setq bom-p :utf-16)      
      (with-fsopen-file (paramblock fullp)
        (%stack-block ((buf 4))
          (let ((br (fsread paramblock 4 buf)))
            (when (>= br 2 )
              (cond ((eq (%get-unsigned-word buf 0) #xFEFF)
                     (setq bom-p :utf-16))
                    ((>= br 3)
                     (if (and (= (%get-unsigned-word buf 0) #xEFBB)
                              (= (%get-byte buf 2) #xBF))
                       (setq bom-p :utf-8)))))))))
    bom-p))

(defparameter *input-file-script* #$kcfstringencodingmacroman)       
(defun %buffer-insert-file (buffer name pos)
  (let* ((buf (mark-buffer buffer))
         (filelen 0)
         (filechars 0)
         (vrefnum 0)
         (opened)
         chunk-buffer
         (chunksz (bf.chunksz buf))
         (fname (data-fork-name))
         date scriptruns wrap)
    (declare (ignore vrefnum))
    (setq pos (buffer-position buffer pos)) 
    (when (logbitp $bf_r/o-flag (bf.fixnum buf))
      (%buf-signal-read-only))
    (setq name (truename name))
    (setf (buffer-filename buffer) name)   ;; maybe we put the pathname in the buffer
    (let ((utf-encoding (utf-something-p name)))
      (cond 
       (utf-encoding
        (let ((chars-read (%buffer-insert-utf-file utf-encoding buffer name pos)))
          ;; huh
          (setq opened t
                filechars chars-read
                date (mac-file-write-date name))))
       (t               
        (when (not (= (bf.gappos buf) pos))(%move-gap buf (- pos (bf.gappos buf))))    
        (multiple-value-bind (scriptres fredp)(read-scriptruns name)  ;; its in l1-streams
          (declare (ignore-if-unused fredp))
          ; use *input-file-script* iff file has NO fred 2 resource  ????? 
          (setq scriptruns (or scriptres *input-file-script*)))
        (when scriptruns ;; really encoding runs
          (let ((initial-encoding (if (fixnump scriptruns) scriptruns (fontruns-font scriptruns 0))))
            (if (not (script-installed-p (encoding-to-script initial-encoding)))
              (progn 
                (format t "~&Script ~s is not installed. Reading as Roman." (encoding-to-name initial-encoding))
                (setq scriptruns #$kcfstringencodingmacroman))
              (if (two-byte-encoding-p initial-encoding)  ;;; not needed - chartype always extended
                (bf-chartype buf 'extended-character)))))
        ;(print scriptruns)
        ;(if (fixnump scriptruns) (setq filechars1 0)) ;filechars1 is a flag for *input-file-script* case
        
        (setq wrap (read-fred-wrap name))  ; fukt
        (rlet ((fsref :fsref))      
          (make-fsref-from-path-simple name fsref)
          (rlet ((paramblock :fsforkioparam))
            (setf (pref paramblock :FSForkIOParam.ref) fsref
                  (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)  ;; gack
                  (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                  (pref paramblock :FSForkIOParam.permissions) #$fsrdperm
                  (pref paramblock :FSForkIOParam.positionmode) #$fsfromstart)
            (file-errchk (#_PBOpenForkSync paramblock) name)
            (setq opened t)
            (setq date (my-mod-date-from-fsref fsref))        
            (unwind-protect
              (let (io-buf-ptr cfstring-char-buffer)
                (setq chunk-buffer (get-chunk-buffer (* 2 chunksz))
                      io-buf-ptr (car chunk-buffer)
                      cfstring-char-buffer (third chunk-buffer))
                (%buf-changed buf)
                (#_PBgetforksizesync paramblock)
                (setq filelen (unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset)))
                (when (not (= filelen 0))
                  (setq filechars (if (vectorp scriptruns)
                                    (uvref scriptruns (1- (length scriptruns))) ; this is wrong sometimes??
                                    filelen)) ; and in this case may be too big.
                  ;; not really very helpful but may prevent a crash later?? - this happened once to a user - datafork had lost all but one byte
                  (when (vectorp scriptruns)
                    (if (< filelen filechars)(error "Something wrong with file ~s.~% Fred resources disagree with data fork." name)))
                  (let* ((gapend (bf.gapend buf))
                         (gapstart (bf.gapstart buf))
                         (gaplen (- gapend gapstart)))                     
                    (when (> filechars gaplen)
                      (%buf-grow-gap buf (- filechars gaplen))                
                      (setq gaplen (- (setq gapend (bf.gapend buf)) gapstart)))
                    (let* ((chunk (bf.gapchunk buf))
                           (chars-left filechars))
                      ;(print (list 'horse scriptruns))
                      (cond 
                       ((and (fixnump scriptruns) (not (two-byte-encoding-p scriptruns)))  ;; this case seems OK
                        (while (> chars-left 0)
                          (setf (bf.gapchunk buf) chunk)
                          (when (= gapstart chunksz)  ; this was at the bottom of the loop                     
                            (setq gapstart 0))
                          (let ((nchars (min chars-left (- gapend gapstart) (- chunksz gapstart))))
                            (setf (rref paramblock :FSForkIOParam.requestCount) nchars)  ;; oh shit
                            (setf (rref paramblock :FSForkIOParam.positionMode) #$fsAtMark) ;(%put-word pb 0 $ioposmode)
                            (setf (rref paramblock :FSForkIOParam.buffer) io-buf-ptr) ;(%put-ptr pb io-buf-ptr $iobuffer)
                            ;(%put-my-ptr pb chunk $iobuffer gapstart)
                            (file-errchk (#_PBReadForkSync paramblock) name)
                            (copy-ptr-to-utf-chunk io-buf-ptr chunk gapstart nchars scriptruns cfstring-char-buffer)
                            (setq chars-left (- chars-left nchars))
                            (setq gapstart (+ gapstart nchars))
                            (setq chunk (bfc.next chunk)))))                       
                       (t ; the hard one will be slower
                        (let* (;(nscripts (if (fixnump scriptruns) 1 (1- (length scriptruns))))
                               (scriptidx 0)
                               ;(nchars 0)
                               (startrun 0)
                               (endrun (if (fixnump scriptruns) filechars (fontruns-pos scriptruns 1)))
                               (script (if (fixnump scriptruns) scriptruns (fontruns-font scriptruns 0)))
                               (bytesleft filelen)
                               firstbyte)
                          ;(print 'cow)
                          (setf (rref paramblock :FSForkIOParam.buffer) io-buf-ptr)
                          (while (> bytesleft 0)  ;; bytesleft in file                      
                            (let* ((nbytes (min bytesleft (ash (- gapend gapstart) 1)(ash (- chunksz gapstart) 1))))  ;; bytes we can handle 
                              (setf (rref paramblock :FSForkIOParam.requestCount) nbytes)
                              (setf (rref paramblock :FSForkIOParam.positionMode) #$fsAtMark)
                              (file-errchk (#_PBReadForkSync paramblock) name)  ;; we read nbytes from file to io-buf-ptr
                              (multiple-value-setq (script scriptidx startrun endrun chunk gapstart firstbyte)
                                (move-io-buf-bytes-to-gap io-buf-ptr nbytes script scriptruns scriptidx 
                                                          startrun endrun chunk chunksz gapstart firstbyte cfstring-char-buffer))
                              (setf (bf.gapchunk buf) chunk)  ;; << added 27 Jun 06
                              (setq bytesleft (- bytesleft nbytes))))))))
                    
                    (setf (bf.bufsiz buf)(+ (bf.bufsiz buf) filechars))
                    (setf (bf.gappos buf)(+ (bf.gappos buf) filechars))
                    (setf (bf.gapend buf)(+ gapstart (- gaplen filechars)))
                    (setf (bf.gapstart buf) gapstart)
                    ))
                (when chunk-buffer (free-chunk-buffer chunk-buffer)))
              (when opened 
                (file-errchk (#_PBCloseForkSync paramblock) name)
                ;(print (fsref-node-bits fsref)) ;; why does it think still open????
                ))))        
         )))    
    (let* ((frec (block blob ; what a lousy way to get from buffer to fred-item
                   (let ((the-fun
                          #'(lambda (frec)
                              (when (same-buffer-p buffer (fr.cursor frec))
                                (return-from blob frec)))))
                     (declare (dynamic-extent the-fun))
                     (map-frecs the-fun))))
           (w (when frec (fr.owner frec))))  ;; w is a fred-item
      ;;(if (and w (not (slot-boundp w 'frec)))) (setq w nil))  ;; blech
      (if wrap ; I should be shot for this
        ; make it work for revert too.
        (let ((what (case (third wrap)
                      ((0 nil) nil)
                      (1 :right)
                      (2 :center))))
          ; why is this info in n places (buffer and all frecs) with great pains to make consistent?
          ; if its a property of buffer/file just keep it there??
          (if w 
            (progn
              (setf (fred-wrap-p w)(neq 0 (car wrap)))
              (setf (fred-word-wrap-p w)(neq 0 (cadr wrap)))        
              (setf (fred-justification w) what)
              (setf (fred-line-right-p w) (neq 0 (fourth wrap))))
            (progn ; have wrap resource - new buffer no frec yet or maybe never has one
              (setf (buffer-wrap-p buffer) (neq 0 (car wrap)))
              (setf (buffer-word-wrap-p buffer) (neq 0 (cadr wrap)))
              (setf (buffer-justification buffer) what)
              (setf (buffer-line-right-p buffer) (neq 0 (fourth wrap))))))
        (when w ; no wrap resource and was a window => revert, set all nil
          (setf (fred-wrap-p w) nil)
          (setf (fred-word-wrap-p w) nil)
          (setf (fred-justification w) nil)
          (setf (fred-line-right-p w) nil)))) 
    (values (if opened name) filechars date)))

;; when file is entirely one 8bit encoding like MacRoman -- confusion here??
(defun copy-ptr-to-utf-chunk (io-buf-ptr chunk gapstart nchars script cfstring-char-buffer) ;; nbytes = nchars
  (let ((encoding script)) ;(logand #xffff (script-to-encoding script)))) ; ignore eurosign ??
    (with-macptrs ((cfstr (#_cfstringcreatewithbytes (%null-ptr) io-buf-ptr nchars encoding nil)))
      (let ((uni-len (#_cfstringgetlength cfstr)))
        (if (neq uni-len nchars)(error "mistake re nchars"))
        (progn ;%stack-block ((to-buf (+ uni-len uni-len)))  ;; big stack blocks are not cool
          (cfstringgetcharacters cfstr 0 uni-len cfstring-char-buffer)
          (#_cfrelease cfstr)
          (%copy-ptr-to-ivector cfstring-char-buffer 0 (bfc.string chunk) (+ gapstart gapstart) (+ nchars nchars)))))))

(defparameter *one-byte-encodings*
  `( #.#$kCFStringEncodingMacInuit    
     #.#$kCFStringEncodingMacVT100))

;; get io-buf bytes to gap 
;; provide endrun huge = filebytes if aint no scriptruns 
;; won't work if file contains funky fonts like zapf dingbats where encoding /= script -maybe fixed
(defun move-io-buf-bytes-to-gap (io-buf io-buf-bytes script scriptruns scriptidx startrun endrun chunk chunksz gapstart firstbyte cfstring-char-buffer)
  (let ((number-buf-bytes-used 0)
        (number-buf-bytes-this-time 0)
        (number-chars-this-time 0))
    (when firstbyte 
      (let* ((code (logior (ash firstbyte 8)(%get-byte io-buf)))
             (uchar (convert-char-to-unicode (%code-char code) script)))
        (setf (%schar (bfc.string chunk) gapstart) uchar)
        (setq firstbyte nil)
        (incf gapstart)
        (when (eq gapstart chunksz)
          (setq gapstart 0)
          (setq chunk (bfc.next chunk)))          
        (incf number-buf-bytes-used)))
    (block blob
      (while (< number-buf-bytes-used io-buf-bytes)
        ;; beware 1 byte left ?? move test here
        (multiple-value-setq (number-buf-bytes-this-time number-chars-this-time)
          (buf-bytes-in-run io-buf io-buf-bytes number-buf-bytes-used script (min (- chunksz gapstart)(- endrun startrun))))
        (with-macptrs ((cfstr (#_cfstringcreatewithbytes (%null-ptr) 
                               (%inc-ptr io-buf number-buf-bytes-used)  ;; does that cons? - probably not
                               number-buf-bytes-this-time    ;; something to do with endrun here
                               script 
                               nil)))
          (when (%null-ptr-p cfstr) (error "confused"))
          (incf number-buf-bytes-used number-buf-bytes-this-time)
          (let ((uni-len (#_cfstringgetlength cfstr)))
            (when (neq uni-len number-chars-this-time)  (error "uni-len ~S neq nchars ~S" uni-len number-chars-this-time))
            (progn ;%stack-block ((to-buf (+ uni-len uni-len)))
              (cfstringgetcharacters cfstr 0 uni-len cfstring-char-buffer)
              (#_cfrelease cfstr)            
              (%copy-ptr-to-ivector cfstring-char-buffer 0 (bfc.string chunk) (+ gapstart gapstart) (+ uni-len uni-len)))))
        ;; now step to next run or next chunk or both      
        (incf gapstart number-chars-this-time)
        (when (>= gapstart chunksz)
          (setq chunk (bfc.next chunk))
          (setq gapstart 0))
        (setq startrun (+ startrun number-chars-this-time))  ;; << 27 Jun 06 
        (when (eq number-buf-bytes-used io-buf-bytes)
          ;; something about first-byte here
          (return-from blob))
        (when (and (eq number-buf-bytes-used (1- io-buf-bytes))
                   (two-byte-encoding-p script))
          (let ((last-byte (%get-byte io-buf (1- io-buf-bytes)))
                (chartable (if (not (memq script *one-byte-encodings*))(get-char-byte-table (encoding-to-script script)))))
            (when (and chartable (neq (aref chartable last-byte) #$smSingleByte))
              (setq firstbyte last-byte)
              (return-from blob))))
        (when (>= startrun endrun)  ;; << 27 Jun 06
          (SETQ startrun endrun)
          (cond ((not (fixnump scriptruns))
                 (setq scriptidx (1+ scriptidx))
                 (setq endrun (fontruns-pos scriptruns (1+ scriptidx))
                       script (fontruns-font scriptruns scriptidx))  ;; script is encoding today
                 (when (and (not (memq script *one-byte-encodings*)) (not (script-installed-p (encoding-to-script script))))
                   (cerror "Read as Roman." "Script ~s is not installed." (encoding-to-name script))
                   (setq script #$smRoman)))              
                (t (return-from blob))))))      
    (values script scriptidx startrun endrun chunk gapstart firstbyte)))

(defun two-byte-encoding-p (encoding)
  (if (or (memq encoding '(#.#$kcfstringencodingmacroman #.#$kcfstringencodingutf8
                       ;; encoding-to-script also works for these
                       #.#$kcfstringencodingmacsymbol #.#$kcfstringencodingmacdingbats))
          (memq encoding *one-byte-encodings*))
    nil
    (let ((script (encoding-to-script encoding)))
      (and script (two-byte-script-p script)))))

(defun buf-bytes-in-run (io-buf io-buf-bytes io-buf-offset script run-chars-left)
  (if (not (two-byte-encoding-p script))
    (let ((foo (min run-chars-left (- io-buf-bytes io-buf-offset))))
      (values foo foo))
    (let ((chartable (get-char-byte-table script))
          (bytes-so-far 0)
          (chars-so-far 0))
        (prog ()
          top
          (let ((code (%get-byte io-buf (+ io-buf-offset bytes-so-far))))
            (cond ((or (null chartable)(eq (aref chartable code) #$smSingleByte))                   
                   (incf bytes-so-far 1)
                   (incf chars-so-far 1))
                  (t (incf bytes-so-far 2)
                     (incf chars-so-far 1)))
              (if (>= chars-so-far run-chars-left)
                (return))
              (if (>= bytes-so-far io-buf-bytes)
                (return)))
          (go top))
        ;; chars-so-far is wrong ?
        (values bytes-so-far chars-so-far))))



(defmethod buffer-filename ((buffer buffer-mark))
  (bf.owner (mark.buffer buffer)))

(defmethod (setf buffer-filename) (pathname (buffer buffer-mark))
  (setf (bf.owner (mark.buffer buffer)) pathname))


(defun read-fred-wrap (truename)  ;; pass in fsref?
  (let (refnum)
      (unwind-protect
        (progn 
          (rlet ((fsref :fsref))
            (make-fsref-from-path-simple truename fsref)
            (setq refnum (open-resource-file-from-fsref fsref #$fsrdperm)))
          (unless (eq -1 refnum) ;(setq refnum (with-pstrs ((np (mac-namestring truename))) (#_HOpenResFile 0 0 np #$fsrdwrperm))))
            (with-macptrs ((fred6 (#_Get1Resource :FRED 6)))
              (unless (%null-ptr-p fred6)
                (#_LoadResource fred6)
                (let ((wrap-byte (%hget-byte fred6 0))
                      (word-wrap-byte (%hget-byte fred6 1))
                      (just-byte (%hget-byte fred6 2))
                      (right-byte (%hget-byte fred6 3)))
                  (list wrap-byte word-wrap-byte just-byte right-byte))))))        
        (unless (eq refnum -1)
          (#_CloseResFile refnum)))))

#| ; moved to l1-streams
(defun read-scriptruns (truename)
  (let (scriptruns
        fredp)
    (let (refnum)
      (unwind-protect 
        (unless (eq -1 (setq refnum (with-pstrs ((np (mac-namestring truename))) (#_OpenResFile np))))
          (with-macptrs ((fred4 (#_Get1Resource :FRED 4))
                         (fred2 (#_get1resource :fred 2)))
            (unless (%null-ptr-p fred2)(setq fredp t))  ; want to know if fred wrote this file
            (unless (%null-ptr-p fred4)
              (#_LoadResource fred4)
              (let ((n (ash (#_gethandlesize fred4) -2)))
                (declare (fixnum n))
                (setq scriptruns (make-array n :ELEMENT-TYPE '(UNSIGNED-BYTE 32))) ; 5/26
                (dotimes (i n)
                  (setf (uvref scriptruns i)(%hget-long fred4 (ash i 2))))))))
        (unless (eq refnum -1)
          (#_CloseResFile refnum))))
    (values scriptruns fredp)))
|#


; Doesn't handle tabs. Could be made faster.
(defun buffer-string-width (buffer end &optional start)
  (multiple-value-setq (start end)(buffer-range buffer end start))
  (let ((buf (mark.buffer buffer)))
    (declare (fixnum start end))
    (%stack-block ((s 256))
      (let* ((len 0)
             (ptr start)
             (end end)
             ;(wptr (%getport))
             (p 0)
             (cnt 0)
             ff ms)
        (declare (fixnum ptr end len p cnt))
        (with-port-macptr wptr          
          (with-font-codes nil nil
            (while (< ptr end)
              (multiple-value-bind (ppos pfont pidx)(%buf-find-font buf ptr)
                (declare (ignore ppos))
                (setq p (or (%buf-next-font-change buf pidx) end))
                (if (> p end) (setq p end))
                (setq cnt (- p ptr))
                ;(if (> cnt 255) (setq cnt 255))
                ;(%put-byte s cnt)
                (multiple-value-setq (ff ms) (%buffer-font-codes buf pfont))
                #-carbon-compat
                (set-wptr-font-codes wptr ff ms)
                #+carbon-compat
                (set-port-font-codes wptr ff ms)
                (multiple-value-bind (chars bytes term) (%snarf-buffer-line buffer ptr s cnt 256)
                  (declare (ignore-if-unused bytes))
                  (incf len (the fixnum (xtext-width s chars ff ms))) ; was (#_textwidth s 0 bytes))) 
                  (incf ptr (the fixnum (if term (%i+ 1 chars) chars)))))))
          len)))))
              


(defun %buffer-char (buf posn)
  (declare (optimize (speed 3)(safety 0)))
  (let* ((gappos (bf.gappos buf))
         (chunksz (bf.chunksz buf))
         (shft (bf.logsiz buf)))
    (declare (fixnum gappos posn chunksz shft))
    (when (>= posn gappos)
      (setq posn (+ posn (%i- (bf.gapend buf)(bf.gapstart buf)))))
    (%schar (svref (bf.chunkarr buf) (%iasr shft posn))
           (%ilogand (%i- chunksz 1) posn))))
#|
(defun %buffer-chunk-string (buf start end)
  (declare (optimize (speed 3)(safety 0)))
  (let* ((gappos (bf.gappos buf))
         (chunksz (bf.chunksz buf))
         (shft (bf.logsiz buf))
         (nchars (- end start)))
    (declare (fixnum gappos start end nchars chunksz shft))
    (if (>= start gappos)
      (setq start (+ start (%i- (bf.gapend buf)(bf.gapstart buf))))
      (if (>= end gappos)(setq nchars (- gappos start))))
    (let* ((bidx (%ilogand (%i- chunksz 1) start)))          
      (values (svref (bf.chunkarr buf) (%iasr shft start))
              bidx
              (min nchars (- chunksz bidx))))))
|#
; more than 3 times faster than orig (in l1-edcmd)
;Move up, backwards from POS, COUNT open parens. COUNT must be positive.
; this gets confused by an unpaired double quote in a semi comment like this
; attempt to fix that will probably be confused by newline in a ""
(defun buffer-bwd-up-sexp (buf &optional end count start
                           &aux eol-count the-buf)
  ;Supposedly handles comments. hmm
  (when (null end)(setq end (buffer-position buf)))
  (when (null count) (setq count 1))
  (when (null start) (setq start 0))
  (setq the-buf (mark-buffer buf))
  (let* ((lastc nil)
         (skipping nil)
         zpos)
    (declare (fixnum start end)(optimize (speed 3)(safety 0)))
    (while (> end start)
      (multiple-value-bind (string eidx nchars)(%buffer-bwd-chunk-string the-buf start end)
        (declare (fixnum eidx nchars))
        (let ((base-p (simple-base-string-p string)))
          (dotimes (i nchars)
            (let* ((ch (if base-p 
                         (locally (declare (type (simple-array (unsigned-byte 8) (*)) string))
                           (aref string eidx))
                         (locally (declare (type (simple-array (unsigned-byte 16) (*)) string))
                           (aref string eidx)))))
              (cond (skipping
                     (when (and (eq ch skipping)(not (%buffer-lquoted-p the-buf (%i-- end i 1))))
                       (setq skipping nil lastc nil)))
                    ((and (eq ch (char-code #\\))
                          (%buffer-lquoted-p the-buf (%i- end i))
                          (not (char-eolp lastc)))
                     (setq lastc nil))
                    (t (when (neq lastc (char-code #\space))
                         (cond 
                          ((char-code-eolp lastc)
                           (setq eol-count count)
                           (when zpos (return-from buffer-bwd-up-sexp zpos)))
                          (t 
                           (case lastc                                                         
                             (#.(char-code #\)) (setq count (%i+ count 1)))
                             (#.(char-code #\()
                              (setq count (%i- count 1))
                              (when (eq  count 0)
                                (when (not zpos)(setq zpos (%i- end i)))
                                (when (not eol-count)
                                  (return-from buffer-bwd-up-sexp zpos))))                            
                             ((#.(char-code #\") #.(char-code  #\|))
                              (if (and (eq ch lastc)(not (%buffer-lquoted-p the-buf (%i-- end i 1))))
                                (setq ch nil)
                                (setq skipping lastc)))
                             (#.(char-code #\;) (if eol-count
                                                  (setq count eol-count zpos nil)
                                                  (return-from buffer-bwd-up-sexp nil)))))))
                       (setq lastc ch))))
            (setq eidx (1- eidx)))
          (setq  end (%i- end nchars)))))
    (if (and (eq count 1)(eq lastc (char-code #\())) start zpos)))



(defun %buffer-bwd-chunk-string (buf start end)
  (declare (fixnum start end)(optimize (speed 3)(safety 0)))
  (let* ((gappos (bf.gappos buf))
         (chunksz (bf.chunksz buf))
         (shft (bf.logsiz buf))
         (nchars (- end start)))
    (declare (fixnum gappos nchars chunksz shft))
    (when  (> end gappos)
      (if (< start gappos)(setq nchars (- end gappos)))
      (setq end (+ end (%i- (bf.gapend buf)(bf.gapstart buf)))))
    (let* ((bidx (%ilogand (%i- chunksz 1) (%i- end 1))))
      (values (svref (bf.chunkarr buf) (%iasr shft (%i- end 1)))
              bidx    ; index for end (inclusive)
              (min nchars (%i+ 1 bidx))))))

;Should  be fast, used for reading from selections...
; It's faster than old one because old one was not optimized at all.
(defun buffer-read-char (mark)
  (inline-check-mark mark)
  (let* ((buf (mark.buffer mark))
         (pos (ash (the fixnum (mark.value mark)) -1)))
    (declare (fixnum pos) (optimize (speed 3)(safety 0)))
    (if (%i> pos (bf.gappos buf))
      (setq pos (%i- pos (%i- (bf.gapend buf)(bf.gapstart buf)))))
    (when  (%i< pos (the fixnum (bf.bufsiz buf)))
        (%set-mark mark (%i+ 1 pos))
        (%buffer-char buf pos))))

#|
(defmethod stream-tyi ((stream fred-mixin))
  (let ((buffer (fred-buffer stream)))
     (buffer-read-char buffer)))
|#




#|
;Move up, forwards from POS, COUNT close parens.  COUNT must be positive.
(defun buffer-fwd-up-sexp (buf &optional (pos (buffer-position buf))
                                         (end (buffer-size buf))
                                         (count 1)
                               &aux ch)
  (while (setq pos (buffer-forward-find-char buf "();\"#\\\|" pos end))
     (setq ch (buffer-char buf (%i- pos 1)))
     (cond ((eq ch #\() (setq count (%i+ count 1)))
           ((eq ch #\)) (when (eq (setq count (%i- count 1)) 0)
                           (return-from buffer-fwd-up-sexp pos)))
           ((eq ch #\;) (setq pos (buffer-forward-find-eol buf  pos end))
                        (if (null pos) (setq pos end)))
           ((eq ch #\") (unless (setq pos (buffer-fwd-skip-delimited buf "\"\\" pos end))
                           (return-from buffer-fwd-up-sexp nil)))
           ((eq ch #\#) (when (and (neq pos end) (eq (buffer-char buf pos) #\|))
                          (setq pos (buffer-skip-fwd-#comment buf (%i+ pos 1) end))
                          (when (null pos) (return-from buffer-fwd-up-sexp nil))))
           ((eq ch #\\) (if (eq pos end) (return-from buffer-fwd-up-sexp nil)
                          (setq pos (%i+ pos 1))))
           ((eq ch #\|) (unless (setq pos (buffer-fwd-skip-delimited buf "\|\\" pos end))
                           (return-from buffer-fwd-up-sexp nil))))))
|#
; this was in lap for SEARCH-FOR-DEF-SUB or BUFFER-SELECT-BLINK-POS
; don't remember which. Now is 2X lap version but .26X old lisp version
; Believe it or not - this is actually 2 bytes SMALLER than the lap version
; at least it was before it worked
(defun buffer-fwd-up-sexp (mark &optional start end count)
  (multiple-value-setq (start end)(buffer-range mark (or end t) start))
  (when (not count) (setq count 1))
  (locally (declare (fixnum start end count)(optimize (speed 3)(safety 0)))
    (let* ((buf (mark.buffer mark))
           (gappos (bf.gappos buf))
           (chunkarr (bf.chunkarr buf))    
           (shft (bf.logsiz buf))
           (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
           (chunksz (bf.chunksz buf))
           (chars-left (- end start))
           ;(bchar-p (eq (bf-chartype buf) 'base-character))
           (cpos start)
           (nchars 0)
           (sidx 0)
           (sharp-n 0)
           cross state skipping)
      (declare (fixnum gappos chunksz  chars-left cpos  nchars sidx sharp-n))
      (cond
       ((>= start gappos)
        (setq start (%i+ start gaplen)))
       ((> end gappos)
        (setq chars-left (%i- gappos start))
        (setq cross t)))
      (setq sidx (%iasr shft start))
      (setq start (%ilogand (%i- chunksz 1) start))
      (loop        
        (setq nchars (- chunksz start))
        (if (< chars-left nchars)(setq nchars chars-left))
        (let* ((bstr (svref chunkarr sidx))
               (bchar-p (simple-base-string-p bstr))
               (cend (+ start nchars)))
          (declare (fixnum cend))          
          (while (< start cend)
            (let ((code (if bchar-p 
                          (locally (declare (type (simple-array (unsigned-byte 8) (*)) bstr))
                            (aref bstr start))
                          (locally (declare (type (simple-array (unsigned-byte 16)(*)) bstr))
                            (aref bstr start)))))
              (tagbody
                top
                (case state
                  ((NIL)
                   (when (%i> code #x21) ; bypass spaces and tabs
                     (cond 
                      ((eq code (char-code #\|))(setq state :skipping skipping code))
                      ((%i< code 60)
                       (cond ((eq code (char-code #\#))(setq state :sharp))
                             ((eq code (char-code #\;))
                              (setq state :skipping skipping :eol))  ;; HUH
                             ((eq code (char-code #\"))
                              (setq STATE :SKIPPING skipping code))
                             ((eq code (char-code #\())(setq count (%i+ count 1)))
                             ((eq code (char-code #\))) (setq count (%i- count 1))
                              (when (eq count 0)
                                (return-from buffer-fwd-up-sexp (%i++ 1 cpos nchars (%i- start cend)))))
                             )))))
                  (:skip-slash (setq state :skipping))
                  (:skip-1 (setq state nil))
                  (:skipping
                   (cond ((and (eq code (char-code #\\))
                               (or (eq skipping (char-code #\"))
                                   (eq skipping (char-code #\|))))
                          (setq state :skip-slash))
                         ((and (eq skipping :eol)(char-code-eolp code))
                          (setq state nil))
                         ((eq code skipping)
                          (setq state nil))))
                  (:sharp
                   (cond ((eq code (char-code #\|))
                          (setq state :sharp-bar)
                          (setq sharp-n (1+ sharp-n)))
                         ((eq code (char-code #\\))
                          (setq state :skip-1))
                         (t (setq state nil)(go top))))                       
                  (:sharp-bar-bar ; inside a #|, seen a | need a #
                   (setq state :sharp-bar)
                   (when (eq code (char-code  #\#))
                     (setq sharp-n (1- sharp-n))
                     (when (eq sharp-n 0)(setq state nil))))
                  (:sharp-bar-sharp
                   (setq state :sharp-bar)
                   (when (eq code (char-code #\|))
                     (setq sharp-n (1+ sharp-n))))
                  (:sharp-bar
                   (case code
                     (#.(char-code #\|)(setq state :sharp-bar-bar))
                     (#.(char-code #\#)(setq state :sharp-bar-sharp)))))
                (setq start (%i+  start 1))))))
          (setq chars-left (- chars-left nchars))
          (cond ((= chars-left 0)
                 (if cross
                   (let ((gapend (bf.gapend buf)))
                     (declare (fixnum gapend))
                     (setq start (%ilogand (%i- chunksz 1) gapend))
                     (setq sidx (%iasr shft (%i+ gappos gaplen)))
                     (setq chars-left (%i- end gappos))
                     (setq cross nil))
                   (return nil)))
                (t (setq start 0)
                   (setq sidx (1+ sidx))))
          (setq cpos (+ cpos nchars))))))                                        



; now we are constant time of 11 vs old 6 at gap to 12 80k away from gap.

(defun buffer-char (buffer &optional posn)
  (locally (declare (optimize (speed 3)(safety 0)))
    (setq posn (buffer-position buffer posn))
    (when (= posn (buffer-size buffer))
      (return-from buffer-char #\null))
    (let* ((buf (mark.buffer buffer))
           (gappos (bf.gappos buf))
           (chunksz (bf.chunksz buf))
           (shft (bf.logsiz buf)))
      (declare (fixnum gappos posn chunksz shft))
      (when (>= posn gappos)
        (setq posn (+ posn (%i- (bf.gapend buf)(bf.gapstart buf)))))
      (%schar (svref (bf.chunkarr buf) (%iasr shft posn))
             (%ilogand (%i- chunksz 1) posn)))))



; returns old contents
(defun buffer-char-replace (buffer char &optional posn)
  (locally (declare (optimize (speed 3)(safety 0)))
    (when (%buffer-read-only-p buffer)
      (%buf-signal-read-only))
    (setq posn (buffer-position buffer posn))
    (let* ((buf (mark.buffer buffer))           
           (gappos (bf.gappos buf))
           (user-pos posn)
           (chunksz (bf.chunksz buf))
           (shft (bf.logsiz buf)))
      (declare (fixnum gappos posn chunksz shft))
      (when (>= posn gappos)
        (setq posn (+ posn (%i- (bf.gapend buf)(bf.gapstart buf)))))
      (let* ((chunk (svref (bf.chunkarr buf)(%iasr shft posn)))
             (cpos (%ilogand (%i- chunksz 1) posn)))
      (let ((old (%schar chunk cpos)))
        (when (neq old char)
          (setf (%schar chunk cpos) char)
          (%buf-changed buf user-pos)
          ; dont get it but it works
          (%buf-changed buf (1+ user-pos)))
        old)))))


; i hate chugging up and down chunk lists - why dont we put em into
; an array with an INDEX - but (gag puke) truncate is slower than buffer-char
; ahhh - so we make chunksz  a power of 2

; this is 2X slower with optimize


(defun buffer-substring (mark end &optional start string)
  (multiple-value-setq (start end)(buffer-range mark end start))
  (locally (declare (fixnum start end)(optimize (speed 3)(safety 0)))
    (let* ((buf (mark.buffer mark))
           (gappos (bf.gappos buf))
           (type (bf-chartype buf))
           (shft (bf.logsiz buf))
           (chunkarr (bf.chunkarr buf))
           (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
           (chunksz (bf.chunksz buf))
           (chars-left (- end start))
           (spos 0)           
           (nchars 0)
           (sidx 0)
           cross)
      (declare (fixnum  gappos chunksz mask spos chars-left gaplen sidx nchars))
      ;(print (list len start end (length string) (- start end)))
      (when (or (null string)
                (let ((string-type (array-element-type string)))
                  (not (or (eq string-type type)
                           (let ((types '(character extended-character extended-char)))
                             (and (memq string-type types)
                                  (memq type types))))))
                (< (length string) chars-left))
        (setq string (make-string chars-left :element-type type)))
      (cond
       ((>= start gappos)
        (setq start (+ start gaplen)))
       ((> end gappos)
        (setq chars-left (- gappos start))
        (setq cross t)))
      (setq sidx (%iasr shft start))
      (setq start (%ilogand (%i- chunksz 1) start))
      (loop
        (setq nchars (- chunksz start))
        (if (< chars-left nchars)(setq nchars chars-left))
        (move-string-bytes (svref chunkarr sidx) string start spos nchars)        
        (setq chars-left (- chars-left nchars))
        (cond ((= chars-left 0)
               (if cross
                 (let ((gapend (bf.gapend buf)))
                   (setq start (%ilogand (%i- chunksz 1) gapend))
                   (setq sidx (%iasr shft (%i+ gappos gaplen)))
                   (setq chars-left (- end gappos))
                   (setq cross nil))
                 (return)))
              (t 
               (setq start 0)
               (setq sidx (1+ sidx))))
        (setq spos (+ spos nchars)))
      string)))

(defun buffer-forward-find-eol (mark &optional start end)
  (buffer-forward-find-char mark eol-string start end))

(defun buffer-forward-find-char (mark string &optional start end)
  (multiple-value-setq (start end)(buffer-range mark (or end t)  start))  
  (%buffer-forward-find-char/not (mark.buffer mark) string start end nil))

(defun buffer-forward-find-not-char (mark string &optional start end)
  (multiple-value-setq (start end)(buffer-range mark (or end t) start))  
  (%buffer-forward-find-char/not (mark.buffer mark) string start end t))

; 1.25 vs .59  = 2.1X (ugh) 
(defun %buffer-forward-find-char/not (buf string start end not)
  (declare (fixnum start end) (optimize (speed 3)(safety 0)))
  (let ((chars-left (- end start)))
    (declare  (fixnum chars-left))
    (if (zerop chars-left)
      nil      
      (let* ((gappos (bf.gappos buf))
             (chunkarr (bf.chunkarr buf))
             (shft (bf.logsiz buf))
             (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
             (chunksz (bf.chunksz buf))
             (strp (stringp string))
             (len (if strp (length (the string string)) 1))
             (nchars 0)
             (sidx 0)             
             (cpos start)
             (strb 0)
             cross)
        (declare (fixnum gappos chunksz  chars-left len nchars sidx cpos strb))
        ; can we decree that string must be a simple string? probably not
        (when strp
          (multiple-value-setq (string strb)(array-data-and-offset string))
          (when (neq 0 strb)(error "We don't do offset arrays today.")))
        (let ((firstc (if strp (%scharcode string 0)(char-code string))))
          (cond
           ((>= start gappos)
            (setq start (%i+ start gaplen)))
           ((> end gappos)
            (setq chars-left (%i- gappos start))
            (setq cross t)))
          (setq sidx (%iasr shft start))
          (setq start (%ilogand (%i- chunksz 1) start))
          (loop
            (setq nchars (- chunksz start))
            (if (< chars-left nchars)(setq nchars chars-left))
            (let* ((bstr (svref chunkarr sidx))
                   (cend (+ nchars start)))              
              (declare (fixnum cend))
              ; 25% faster when 1 char I think
              ; 20% when 2              
              (while (%i< start cend)
                (prog  ((c (%scharcode bstr start)))               
                  (when (eq firstc c)(go found))
                  (let ((i 1))
                    (while (%i< i len)
                      (when (eq c (%scharcode string i))
                        (go found))
                      (setq i (%i+ 1 i))))
                  (when not (go true))
                  (go more)
                  found (when not (go more))
                  true  (return-from %buffer-forward-find-char/not
                          (%i++ 1 cpos  nchars (%i- start cend)))
                  more (setq start (%i+ 1 start)))))
            (setq chars-left (%i- chars-left nchars))
            (cond ((= chars-left 0)
                   (if cross
                     (let ((gapend (bf.gapend buf)))
                       (declare (fixnum gapend))
                       (setq start (%ilogand (%i- chunksz 1) gapend))
                       (setq sidx (%iasr shft (%i+ gappos gaplen)))
                       (setq chars-left (%i- end gappos))
                       (setq cross nil))
                     (return)))
                  (t 
                   (setq start 0)
                   (setq sidx (%i+ 1 sidx))))
            (setq cpos (%i+ cpos nchars))))))))

(defun buffer-backward-find-eol (buffer &optional start end)
  (buffer-backward-find-char buffer eol-string start end))

(defun buffer-backward-find-char (mark string &optional start end) 
  (multiple-value-setq (start end) (buffer-range mark (or start mark) (or end 0)))
  (%buffer-backward-find-char/not (mark.buffer mark) string start end nil))

(defun buffer-backward-find-not-char (mark string &optional start end)
  (multiple-value-setq (start end) (buffer-range mark (or start mark) (or end 0)))
  (%buffer-backward-find-char/not (mark.buffer mark) string start end t))

(defun %buffer-backward-find-char/not (buf string start end not)
  ; don't look at char at end  
  (declare (fixnum start end) (optimize (speed 3)(safety 0)))
  (let ((chars-left (- end start)))
    (declare (fixnum chars-left))
    (if (zerop chars-left)
      nil
      (let* ((gappos (bf.gappos buf))
             (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
             (chunksz (bf.chunksz buf))
             (shft (bf.logsiz buf))
             (chunkarr (bf.chunkarr buf))
             (strp (stringp string))
             (len (if strp (length string) 1))
             (strb 0)
             (nchars 0)
             (sidx 0)
             (cpos end)
             cross)
        (declare (fixnum gappos gaplen chunksz chars-left shft cpos len strb nchars sidx))
        (when strp
          (multiple-value-setq (string strb)(array-data-and-offset string))
          (when (neq 0 strb)(error "We don't do offset arrays today.")))
        (let ((firstc (if strp (%scharcode string 0)(char-code string)))) ; what if its ""
          (cond
           ((> end gappos) ; end after          
            (when (< start gappos)
              (setq chars-left (- end gappos))
              (setq cross t))
            (setq end (+ end gaplen))))
          (setq sidx (%iasr shft (1- end)))
          (setq end (%ilogand (1- chunksz) end))
          (when (zerop end)(setq end chunksz))
          (loop        
            (setq nchars end)
            (if (< chars-left nchars)(setq nchars chars-left))
            (let* ((bstr (svref chunkarr sidx))
                   (quit (- end nchars)))            
              (declare (fixnum quit))             
              (while (> end quit)
                (prog (c)
                  (setq end (1- end)) 
                  (setq c (%scharcode bstr end))
                  (when (eq c firstc) (go found))
                  (let ((i 1))
                    (while (%i< i len)
                      (when (eq c (%scharcode string i))(go found))
                      (setq i (%i+ i 1))))
                  (when not (go true))
                  (go more)
                  found (when not (go more))
                  true (return-from %buffer-backward-find-char/not 
                         (- (+ cpos (- end quit)) nchars))
                  more)))
            (setq chars-left (- chars-left nchars))
            (cond ((= chars-left 0)
                   (if cross
                     (let ()
                       (setq sidx (%iasr shft gappos))
                       (setq chars-left (- gappos start))
                       (setq end (%ilogand (1- chunksz) (bf.gapstart buf)))
                       (setq cross nil))
                     (return)))
                  (t 
                   (setq end chunksz)
                   (setq sidx (1- sidx))))
            (setq cpos (- cpos nchars))))))))

; doc claims this takes a char but it doesnt seem to work in old code

(defun buffer-substring-p (mark str &optional start)  
  (if (not (stringp str))
    (char-equal str (buffer-char mark start))
    (let ((strlen (length str)))
      (multiple-value-bind (str strb)(array-data-and-offset str)
        (declare (fixnum strb))
        (setq start (buffer-position mark start))
        (and (<= (+ start strlen) (buffer-size mark))
             (%buffer-substring-p (mark.buffer mark) str start strb strlen t))))))

(defun buffer-forward-search (mark str &optional start end)
  ; this should probably be smarter
  (if (not (stringp str))
    (buffer-forward-find-char mark str start end) ; but is case sensitive
    (progn 
      (multiple-value-setq (start end)(buffer-range mark (or end t) start))
      (let ((strlen (length str)))
        (multiple-value-bind (str strb)(array-data-and-offset str)
          (declare (fixnum start end strb)(optimize (speed 3)(safety 0)))
          (let* ((buf (mark.buffer mark))               
                 (gappos (bf.gappos buf))
                 (gaplen (%i- (bf.gapend buf)(bf.gapstart buf))))
            (declare (fixnum  gappos gaplen strlen))
            (if (= strlen 0) 
              start          
              (block frob
                (when (<= start (- gappos strlen))
                  (let* ((end (if (> end gappos) gappos end))
                         (pos (%fwd-search buf str start end strb strlen)))
                    (if pos (return-from frob pos))))
                (when (> end gappos)
                  (when (and (> gappos 0)(< start gappos))
                    ; stagger across the gap slowly - we assume str is short - if not, slooow
                    (let* ((org (max start (+ (- gappos strlen) 1)))
                           (n (min (- end gappos)(%i- strlen 1))))
                      (declare (fixnum org n))                
                      (dotimes (i n)
                        (when (%buffer-substring-p buf str (%i+ org i) strb strlen t)
                          (return-from frob (%i+ org (%i+ i strlen)))))))
                  (when (>= end (%i+ gappos (%i- strlen 1)))
                    (let* ((start (if (> start gappos) start gappos))
                           (pos (%fwd-search buf str (%i+ start gaplen) (%i+ end gaplen) strb strlen)))
                      (when pos (%i- pos gaplen)))))))))))))            
          



; we are 7X slower even with optimize
; maybe this hunk has to be lap -

; 
(defun %fwd-search (buf str start end strb strlen)
  (declare (fixnum start end strb strlen) (optimize (speed 3)(safety 0)))  
  (let* ((chars-left (%i+ 1 (%i-- end start strlen)))) ; possibles to match the first
    (declare (fixnum strlen chars-left))
    (when (<= chars-left 0)(return-from %fwd-search nil))
    
    (let* (;(up-string char-up-string-1)
           (chunksz (bf.chunksz buf))
           (sidx (%iasr (bf.logsiz buf) start))
           (nchars 0)
           #+ignore ;; always true
           (xchar-p (or (eq (bf-chartype buf) 'extended-character)
                        (extended-string-p str))))
      (declare (fixnum chunksz sidx nchars))      
      (setq start (%ilogand (1- chunksz) start))
      (loop 
        (setq nchars (- chunksz start))  ; nchars is chars to end of chunk or end of search        
        (when (<= chars-left nchars) (setq nchars chars-left))
        (let ((nleft (if t ;xchar-p
                       (%xfwd-search-sub buf str start sidx nchars strb strlen)
                       (%fwd-search-sub buf str start sidx nchars strb strlen))))
          (setq chars-left (- chars-left nchars))
          (when nleft 
            (return  (%i-- end  chars-left nleft))))        
        (when (= 0 chars-left)(return))
        (setq start 0)
        ;(setq cpos (+ cpos nchars))
        (setq sidx (1+ sidx))))))


; it would be nice if I knew how to tell the compiler to fetch the byte
; from the string opencoded wise instead of doing (char-code (schar ..))


; sort of what got lapified - ain't half bad - about 12 vs 5
; the necessary hack is to hang onto the upcased first char of string
; use this if any extended strings in sight
(defun %xfwd-search-sub (buf str start sidx nchars strb strlen)
  (declare (fixnum start sidx nchars strb strlen)(optimize (speed 3)(safety 0)))
  (let* ((chunkarr (bf.chunkarr buf))
         (bstr (svref chunkarr sidx))
         (chunksz (bf.chunksz buf))
         ;(up-string char-up-string-1)
         (bend (+ start nchars))
         (code0 (%scharcode  str strb)))
    (declare (fixnum strlen bend chunksz))
    ;(declare (type (simple-array (unsigned-byte 8) (*)) up-string)) ;; cut the crap
    (when  (%i< code0 256)(setq code0 (uvref char-downcase-vector code0)))
    (while (< start bend)
      (let ((code01 (%scharcode bstr start)))
        (when (eq code0 (if (%i< code01 #x100)
                          (uvref char-downcase-vector code01)
                          code01))
          (when (eq strlen 1)(return-from %xfwd-search-sub (%i- nchars 1)))        
          (let* ((tstr bstr)
                 (tidx sidx)
                 (tstart start))
            (declare (fixnum tidx tstart))
            (when 
              (do ((i 1 (1+ i)))
                  ((= i strlen) t)
                (declare (fixnum i))
                (when (>= (%i+ tstart i) chunksz)
                  (setq tstr (svref chunkarr (setq tidx (1+ tidx))))
                  (setq tstart (- i)))
                (let ((code1 (%scharcode str (%i+ i strb)))
                      (code2 (%scharcode tstr (%i+ tstart i))))
                  (when
                    (if (and (%i< code1 #x100)(%i< code2 #x100))
                      (neq (uvref char-downcase-vector code1) (uvref char-downcase-vector code2))
                      (neq code1 code2))
                    (return))))
              (return-from %xfwd-search-sub (%i- nchars 1)))))
        ; nchars is one bigger here than in the lap version
        (setq nchars (1- nchars))
        (setq start (1+ start))))))

#+PPC-target
(%fhave '%fwd-search-sub #'%xfwd-search-sub)



; returns pos of first char of str - start is where to start going backwards
(defun buffer-backward-search (mark str &optional start end)
  ; this should probably be smarter
  (if (not (stringp str))
    (buffer-backward-find-char mark str start end) ; but is case sensitive
    (progn 
      (multiple-value-setq (start end)(buffer-range mark (or start mark) (or end 0)))
      (let ((strlen (length str)))
        (declare (fixnum strlen start end)(optimize (speed 3)(safety 0)))
        (multiple-value-bind (str strb)(array-data-and-offset str)       
          (declare (fixnum  strb ))
          (let* ((buf (mark.buffer mark))               
                 (gappos (bf.gappos buf))
                 (gaplen (%i- (bf.gapend buf)(bf.gapstart buf))))
            (declare (fixnum  gappos gaplen strlen))
            (if (= strlen 0)
              end
              (block frob
                (when (>= end (%i+ gappos (%i- strlen 1)))
                  (let* ((start (if (> start gappos) start gappos))
                         (pos (%bwd-search buf str (%i+ start gaplen) (%i+ end gaplen) strb strlen)))
                    (when pos (return-from frob (%i- pos gaplen)))))
                ; stagger across the gap slowly - we assume str is short - if not, slooow
                (when (< start gappos)
                  (when (> end gappos)
                    (let* ((org (- gappos 1))
                           (n (- gappos start)))
                      (declare (fixnum org n))
                      (dotimes (i (if (< n strlen) n (%i- strlen 1)))
                        (when (%buffer-substring-p buf str (%i- org i) strb strlen t)
                          (return-from frob (%i- org i))))))
                  (when (<= start (- gappos strlen))
                    (%bwd-search buf str start (if (> end gappos) gappos end) strb strlen)))))))))))

; only good when no gap crossing
(defun %bwd-search (buf str start end strb strlen)
  (declare (fixnum start end strb strlen) (optimize (speed 3)(safety 0)))  
  (let* ((chars-left (%i+ 1 (%i-- end  start strlen)))) ; possibles to match the last
    (declare (fixnum strlen chars-left))
    (when (<= chars-left 0)(return-from %bwd-search nil))    
    (let* (;(up-string char-up-string-1)
           (chunksz (bf.chunksz buf))
           (sidx (%iasr (bf.logsiz buf) (1- end)))
           (nchars 0)
           #+ignore ;; always true
           (xchar-p (or (eq 'extended-character (bf-chartype buf))
                        (extended-string-p str))))
      (declare (fixnum chunksz sidx nchars))
      (setq end (%ilogand (1- chunksz) end))
      (when (= end 0)(setq end chunksz))
      (loop 
        (setq nchars end)   ; nchars is chars to end of chunk or end of search        
        (when (<= chars-left nchars) (setq nchars chars-left))
        (let ((nleft (if t ;xchar-p ;; always true today
                       (%xbwd-search-sub buf str end sidx nchars strb strlen)
                       (%bwd-search-sub buf str end sidx nchars strb strlen))))
          (setq chars-left (- chars-left nchars))
          (when nleft 
            (return  (%i++ start chars-left nleft))))        
        (when (= 0 chars-left)(return))
        (setq end chunksz)
        (setq sidx (1- sidx))))))


; its lapified - but this works too
; use it for extended string or buffer
(defun %xbwd-search-sub (buf str end sidx nchars strb strlen)
  (declare (fixnum end sidx nchars strb strlen)(optimize (speed 3)(safety 0)))
  (let* ((chunkarr (bf.chunkarr buf))
         (bstr (svref chunkarr sidx))
         (chunksz (bf.chunksz buf))
         (strlen (1- strlen)) ; its 1- 
         ;(up-string char-up-string-1)
         (bstart (- end nchars))
         (codeN (%scharcode  str (%i+ strb strlen))))
    (declare (fixnum  strlen bstart  chunksz))
    ;(declare (type (simple-array (unsigned-byte 8) (*)) up-string)) ; cut the crap
    (when  (%i< codeN 256)(setq codeN (uvref char-downcase-vector codeN)))
    (while (> end bstart) ; or something
      (setq end (1- end))
      (let ((codeN1 (%scharcode bstr end)))        
        (when (eq codeN (if (%i< codeN1 #x100)
                          (uvref char-downcase-vector codeN1)
                          codeN1))
          (when (eq strlen 0)(return-from %xbwd-search-sub (%i- nchars 1)))
          (let* ((tstr bstr)
                 (tidx sidx)
                 (tend end))
            (declare (fixnum tidx tend))
            (when 
              (do ((i (%i- strlen 1) (1- i)))
                  ((< i 0) t)
                (declare (fixnum i))
                (setq tend (1- tend))
                (when (< tend 0)
                  (setq tstr (svref chunkarr (setq tidx (1- tidx))))
                  (setq tend (1- chunksz)))
                (let ((code1 (%scharcode str (%i+ strb i)))
                      (code2 (%scharcode tstr tend)))
                  (when
                    (if (and (%i< code1 #x100)(%i< code2 #x100)) ;;back to #x100
                      (neq (uvref char-downcase-vector code1) (uvref char-downcase-vector code2))
                      (neq code1 code2))
                    (return))))
              (return-from %xbwd-search-sub (%i- nchars 1)))))
        (setq nchars (1- nchars))))))

#+PPC-target
(%fhave '%bwd-search-sub #'%xbwd-search-sub)

(defun %buffer-substring-p (buf str start cpos strlen &optional insensitive) 
  (declare (fixnum start cpos) (optimize (speed 3)(safety 0)))
  (let* (;(up-string char-up-string-1)
         (chunkarr (bf.chunkarr buf))
         (shft (bf.logsiz buf))
         (gappos (bf.gappos buf))
         (chunksz (bf.chunksz buf))
         (chars-left  strlen)
         (end (+ start chars-left))
         #+ignore
         (base-base (and (eq (bf-chartype buf) 'base-character)
                         (simple-base-string-p str)))
         (nchars 0)
         (sidx 0)
         cross bstr)
    (declare (fixnum gappos chunksz chars-left end nchars sidx cpos))
    ; requires patch 1 to work - and doesn't help much
    (cond
     ((>= start gappos)
      (setq start (+ start (%i- (bf.gapend buf)(bf.gapstart buf)))))
     ((> end gappos)
      (setq chars-left (%i- gappos start))
      (setq cross t)))
    (setq sidx (%iasr shft start))
    (setq start (%ilogand (%i- chunksz 1) start))
    (block frob
      (loop        
        (setq bstr (svref chunkarr sidx))
        (setq nchars (- chunksz start))
        (if (< chars-left nchars)(setq nchars chars-left))        
        (dotimes (i nchars)
          (when 
            (if (not insensitive)
              (neq (%schar str (%i+ cpos i))  ;; << i was 1 !!!
                   (%schar bstr (%i+ start i)))
              (let ((code1 (%scharcode str (%i+ cpos i)))
                    (code2 (%scharcode bstr (%i+ start i))))
                ; we assume extended characters do not do upcase - well now case independent for latin1
                (if (or (%i> code1 #xff)(%i> code2 #xff)) ;; was #x7f
                  (neq code1 code2)
                  (neq (uvref char-downcase-vector code1)
                       (uvref char-downcase-vector code2)))))
            (return-from frob)))
        (setq chars-left (- chars-left nchars))
        (cond ((= chars-left 0)
               (if cross
                 (let ((gapend (bf.gapend buf)))
                   (declare (fixnum gapend))
                   (setq start (%ilogand (%i- chunksz 1) gapend))
                   (setq sidx (%iasr shft (%i+ gappos (%i- gapend  (bf.gapstart buf)))))
                   (setq chars-left (%i- end gappos))
                   (setq cross nil))
                 (return t)))
              (t (setq start 0)
                 (setq sidx (1+ sidx))))
        (setq cpos (+ cpos nchars))))))

;count=-1 -> start of previous line.
;count=0 -> start of current line.
;count=1 -> start of next line.
;First value is always position.  Second value is nil if there were enough
;lines, otherwise updated count.

(defun buffer-line-start (mark &optional start count)
  (if (null count)(setq count 0)
      (require-type count 'fixnum))
  (setq start (buffer-position mark start))
  (let* ((buf (mark.buffer mark))
         (end (bf.bufsiz buf))
         (pos start))
    (declare (fixnum count start end))
    (cond ((<= count 0)
           (setq end start start 0)
           (while (<= count 0) 
             (setq pos (buffer-backward-find-eol mark  start end ))
             (when (not pos)
               (return-from buffer-line-start
                   (values 0 (if (zerop count) nil count))))
             (setq count (1+ count))
             (setq end pos))
           (values (1+ end) nil))
          (t (block nil
               (while (> count 0)
                 (setq pos (buffer-forward-find-eol mark start end))
                 (when (not pos)(setq start end)(return))
                 (setq count (1- count))
                 (setq start pos)))
             (values start (if (zerop count) nil count))))))

;count=-1 -> end of previous line.
;count=0 -> end of this line.
;count=1 -> end of next line.
(defun buffer-line-end (buf &optional startpos (count 0))
  (multiple-value-bind (pos left) (buffer-line-start buf startpos (1+ count))
    (if (null left)
        (if (zerop pos) (setq left 1) (setq pos (%i- pos 1)))
        (setq left (%i+ left (if (minusp count) 1 -1))))
    (values pos (if (%izerop left) nil left))))


;Returns number of instances of char in region.
(defun buffer-count-char (mark char &optional start end)
  (multiple-value-setq (start end)(buffer-range mark end start))
  (locally (declare (fixnum start end))
    (let* ((n 0)
           (buf (mark.buffer mark))
           (pos start))
      (declare (fixnum n))
      (while 
        (setq pos (%buffer-forward-find-char/not buf char pos end nil))
        (setq n (1+ n)))
      n)))

;Copy chars from pos up to Tab or Newline or len chars or 128 chars, whichever
;comes first.  Assumes pos+len<=buffer size.
;For display

; or assume it is a mark?
; well it's 27/16 - not so bad and we're gonna have to look at
; those chars anyway!
; If the script at start is not a 2 byte script we "truncate" any fat chars.
; We assume that there is only one script in the range.
; Assume len is chars and ptr-len is bytes?
; Returns three values:
; 1) number of characters copied
; 2) number of bytes copied
; 3) Terminating character, or NIL if stopped because reached max chars or max bytes

;; get chars from buffer to a contiguous stack block
;; assume buffer chunk strings are always extended-strings

(defun %snarf-buffer-line (mark start ptr len &optional (ptr-len 128))
  (declare (fixnum start len ptr-len) (optimize (speed 3)(safety 0)))
  (setq start (buffer-position mark start))  
  (when (< len 0)(error "negative length ~s" len))
  ;(when (%i> len ptr-len) (setq len ptr-len))  ; why is len < 0 ? 
  (let* (;(script (#_FontToScript (ash (buffer-char-font-codes mark start) -16)))
         ;(table (unless (eq script #$smRoman)(get-char-byte-table script)))
         (buf (mark.buffer mark))
         (gappos (bf.gappos buf))
         (shft (bf.logsiz buf))
         (chunkarr (bf.chunkarr buf))
         (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
         ;(char-type (bf-chartype buf))
         (chunksz (bf.chunksz buf))
         (chars-left len)
         (end (+ start len))
         (spos 0)           
         (nchars 0)
         (sidx 0)
         (2byte 0)
         cross)
    (declare (fixnum  gappos chunksz shft spos chars-left gaplen end  sidx nchars chars-out
                      2byte))
    (let ((siz (bf.bufsiz buf)))
      (declare (fixnum siz))
      (when (> end siz)(setq end siz)))    
    (cond
     ((>= start gappos)
      (setq start (+ start gaplen)))
     ((> end gappos)
      (setq chars-left (- gappos start))
      (setq cross t)))
    (setq sidx (%iasr shft start))
    (setq start (%ilogand (%i- chunksz 1) start))
    (block block
      (loop
        (setq nchars (- chunksz start))
        (if (< chars-left nchars)(setq nchars chars-left))
        (let* ((bstr (svref chunkarr sidx))
               (cend (+ start nchars))
               ch)
          (declare (fixnum cend ch))          
          (locally (declare (type (simple-array (unsigned-byte 16)(*)) bstr))
            (while (< start cend)
              (setq ch (aref bstr start))
              ; don't want to output half a character!!!!
              (when (or (eq ch (char-code #\tab))(char-code-eolp ch))
                (return-from %snarf-buffer-line (values (- spos 2byte) spos (code-char ch))))
              (when (>= spos (the fixnum (- ptr-len 2)))
                (return-from block))
              (let ()               
                (%put-word ptr ch spos)  ; ???                    
                (setq spos (+ 2 spos))
                (setq 2byte (1+ 2byte))
                (setq start (1+ start))))))                       
        (setq chars-left (- chars-left nchars))
        (cond ((= chars-left 0)
               (if cross
                 (let* ((gapend (bf.gapend buf)))
                   (setq start (%ilogand (%i- chunksz 1) gapend))
                   (setq sidx (%iasr shft (%i+ gappos gaplen)))
                   (setq chars-left (- end gappos))
                   (setq cross nil))
                 (return)))
              (t 
               (setq start 0) ; highly unlikely that chunk siz < 128
               (setq sidx (1+ sidx))))))
    ;; returns num chars and num bytes - silly now
    (values (- spos 2byte) spos)))

(defvar font-to-encoding-hash (make-hash-table :test 'eq))

(def-ccl-pointers foohash ()
  (clrhash font-to-encoding-hash))

(defun font-to-encoding-no-error (fontid)
  (or (gethash fontid font-to-encoding-hash)
      (rlet ((encoding :ptr))               
        (let* ((errno (#_FMGetFontFamilyTextEncoding FONTID ENCODING))
               (res (when (eq errno #$noerr)
                      (logand #xffff
                              ;; what is the high half about? #$kMacRomanEuroSignVariant
                              (%get-unsigned-long encoding)))))
          (if res (puthash fontid font-to-encoding-hash res))
          res)))) 

; Return the number of characters that it takes for %snarf-buffer-line to snarf BYTES bytes.
; Ignores tab & return characters.
; If BYTES stops in the middle of a two byte character, count it.
; If the buffer ends before BYTES bytes, return the number of characters up to there.
;; not used today
#+ignore 
(defun %buffer-bytes->chars  (mark start bytes)
  (declare (fixnum start) (optimize (speed 3)(safety 0)))
  (setq start (buffer-position mark start))  
  (let* (;(script (#_FontToScript (ash (buffer-char-font-codes mark start) -16)))
         ;(table (unless (eq script #$smRoman)(get-char-byte-table script)))
         (buf (mark.buffer mark))
         (gappos (bf.gappos buf))
         (shft (bf.logsiz buf))
         (chunkarr (bf.chunkarr buf))
         (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
         ;(char-type (bf-chartype buf))
         (chunksz (bf.chunksz buf))
         (bytes-left bytes)
         (char-count 0)
         (chars-left 0)
         (nchars 0)
         (sidx 0)
         (siz (bf.bufsiz buf))
         (before-gap? nil))
    (declare (fixnum  gappos chunksz shft chars-left gaplen sidx nchars chars-out siz))
    (cond
     ((>= start gappos)
      (setq  chars-left (- siz start))  ; << 6/17/95 - reverse order
      (setq start (+ start gaplen)))
     (t (setq chars-left (- gappos start)
              before-gap? t)))
    (setq sidx (%iasr shft start))
    (setq start (%ilogand (%i- chunksz 1) start))
    (loop
      (setq nchars (- chunksz start))
      (if (< chars-left nchars)(setq nchars chars-left))
      (let* ((bstr (svref chunkarr sidx))
             (base-p (simple-base-string-p bstr))
             (cend (+ start nchars))
             ch)
        (declare (fixnum cend ch))
        (if base-p
          (progn
            (incf start nchars)
            (incf char-count (min nchars bytes-left))
            (when (<= (decf bytes-left nchars) 0)
              (return-from %buffer-bytes->chars char-count)))
          (locally (declare (type (simple-array (unsigned-byte 16)(*)) bstr))
            (while (< start cend)
              (setq ch (aref bstr start))
              (let ((hi (ash ch -8)))
                (cond 
                 ((or (eq 0 hi)) ; (not table) (not (eql 1 (svref table hi))))
                  (decf bytes-left))
                 (t (decf bytes-left 2))))
              (incf char-count)
              (setq start (1+ start))
              (when (<= bytes-left 0) (return-from %buffer-bytes->chars char-count))))))
      (setq chars-left (- chars-left nchars))
      (cond ((= chars-left 0)
             (if before-gap?
               (let* ((gapend (bf.gapend buf)))
                 (setq start (%ilogand (%i- chunksz 1) gapend))
                 (setq sidx (%iasr shft (%i+ gappos gaplen)))
                 (setq chars-left (- siz gappos))
                 (setq before-gap? nil))
               (return)))
            (t 
             (setq start 0) ; highly unlikely that chunk siz < 128
             (setq sidx (1+ sidx)))))
    char-count)) 

(defparameter *uchar-encoding-table* nil)

(def-ccl-pointers uchar-encoding ()
  (setq *uchar-encoding-table* nil))


(defun make-encoding-for-uchar-table ()
  (progn ;; really belongs elsewhere but we have a boot problem
    ;(discard-unicode-runinfo :utf-16)
    ;(setq *preferred-language-order* nil)
    (clrhash *sl-symbols*))    
  (let ((table (make-array 65536 :element-type '(unsigned-byte 8))))
    (dotimes (i 65536)
      (let ((char (%code-char i))
            (encoding))        
        (setq encoding (ignore-errors (find-encoding-for-uchar-slow char)))
        (if (or (null encoding)(> encoding #xff))
          (setf (aref table i) #xff)
          (setf (aref table i) encoding))))
    table))

(defun find-encoding-for-uchar (uchar)
  (let ((char-code (char-code uchar)))
    (declare (fixnum char-code))
    (if (<= char-code #x7f)
     #$kcfstringencodingmacroman
      (progn
        (if (not *uchar-encoding-table*)
          (setq *uchar-encoding-table* (make-encoding-for-uchar-table)))
        (uvref *uchar-encoding-table* char-code)))))

(defun %find-encoding-for-uchar-code (char-code)
   (declare (fixnum char-code))
    (if (<= char-code #x7f)
     #$kcfstringencodingmacroman
      (progn
        (if (not *uchar-encoding-table*)
          (setq *uchar-encoding-table* (make-encoding-for-uchar-table)))
        (uvref *uchar-encoding-table* char-code))))
  

#|
(defun get-font-spec (b n)
  (multiple-value-bind (ff ms)
                       (buffer-font-index-codes b n)
    (let* ((spec (font-spec ff ms))
           (name (car spec))  ;; name is mac encoded -- probably shouldn't be - is no longer
           (encoding (ff-encoding ff)))
      (if  nil ; (two-byte-encoding-p encoding)
        (rplaca spec (convert-string name encoding #$kcfstringencodingunicode)))
      spec)))
      

(defun describe-fontruns (b)
  (let* ((the-buf (mark.buffer b))
         (afonts (bf.afonts the-buf))
         (bfonts (bf.bfonts the-buf))
         (fontruns (bf.fontruns the-buf))
         (len (length fontruns))
         (insert-font (bf-efont the-buf))
         (empty-font (bf-cfont the-buf)))
    (print (list 'empty-font (get-font-spec b (1+ empty-font))))
    (when (neq insert-font 255)
      (print (list 'insert-font insert-font (get-font-spec b insert-font))))
    (dotimes (i bfonts)
      (print (list 'bfont (get-font-spec b (1+ (fontruns-font fontruns i))) 'pos (fontruns-pos fontruns i))))
    (let ((gaplen (- (bf.gapend the-buf)(bf.gapstart the-buf))))
      (dotimes (i afonts)
        (print (list 'afont (get-font-spec b (1+ (fontruns-font fontruns (+ (- len afonts) i))))
                     'pos (- (fontruns-pos fontruns (+ (- len afonts) i) ) gaplen)))))))
|#
    



#|
; should have done this a long time ago
(defun describe-style (style)
  (let* ((nfonts (elt style 0)))    
    (dotimes (i nfonts)
      (format t "~&idx ~s font ~s" ; "face ~s size ~s"
              (1+ i)
              (font-spec (make-point (ash (logand #xff (aref style (+ i i 2))) 8)
                                     (aref style (+ i i 1))) ; font
                         (ash (aref style (+ i i 2)) -8))))
    (let ((len (length style))
          (org (+ nfonts nfonts 1)))
      (loop
        (format t "~&idx ~s pos ~s"
                (ash (aref style org) -8)
                (logior (ash (logand (aref style org) #xff) 16)
                        (aref style (+ org 1))))
        (setq org (+ org 2))
        (when (>= org len) (return))))))
|#

#|
	Change History (most recent last):
	2	12/29/94	akh	merg with d13
	3	1/2/95	akh	add functions for getting and setting insertion font and empty buffer font
				use map-frecs vs do-all-frecs
	4	1/5/95	akh	add buffer-previous-script-change
  5   1/6/95   akh   ff NOT fixnum in buffer-xx-script-change
  6   1/6/95   akh   fix a misplaced paren
|# ;(do not edit past this line!!)
