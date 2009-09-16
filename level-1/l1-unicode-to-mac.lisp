;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;;__________________________________________________________________________
;;;
;;; File:    unicode-to-mac.lisp
;;; Date:    2003-06-18
;;; Version: 0.9
;;; Author:  Takehiko Abe <keke@gol.com>
;;;
;;;
;;; copyright 2003 Takehiko Abe
;;;__________________________________________________________________________
;;;
;; paste-utxt does maybe-update-debutton
;; fix paste-utxt and paste-styled-utxt for empty - from james anderson
;; fix bug in put-scrap-flavor :|ustl| end test
;; convert-temp-buffer - just handle cases we use today
;; paste-styled-utxt heeds *paste-with-styles*
;; paste-styled-utxt may inherit :bold if listener, fix for replacing selection
;; -------- 5.2b6
;; add copy and paste :|ustl| 
;; ------- 5.2b5
;; %buffer-write-utf-file and %buffer-write-mac-encoded-file - fsclose before signalling error
;; buffer-chars-to-temp-buffer uses %copy-ivector-to-ptr, buffer-write-utf-file doesn't care about fontruns
;; ------- 5.2b4
;; simplify paste-utxt
;; ----- 5.2b3 
;; comment out some unused code in %buffer-insert-utf-file
;; remove some duplicate function defs
;; fix resolve-data-entry-point usage of (all-bundles)
;; ---- 5.2b1
;; fix apple-languges by "fixing" %mac-symbol-ptr
;; no change
;; fix %buffer-write-utf-file and %buffer-insert-utf-file for utf8
;; ----- 5.1 final
;; %buffer-insert-utf-file now returns number of chars read
;; print-object of character to listener restores font
;; def-ccl-pointers to clrhash *sl-symbols*
;; find-fallback-font uses script-to-font-simple
;; %buffer-insert-utf-file reads file in chunks rather than all at once
;; 02/19/05 - only cons 1 string vs 2 in paste-utxt  and no strings in %buffer-insert-utf-file
;; 02/06/05 forget print-object method for base-string
;; 12/17/04 add %buffer-write-utf-file


(in-package :ccl)

(eval-when (:compile-toplevel :execute)

(require "FREDENV")
)


#+ignore
(defparameter *warn-if-fallback* t)


;;; TODO
;;;
;;; * should provide lock for map-unicode-string
;;; -- lock at run-info??
;;; -- or?


;;; Notes:
;;;
;;; * :UnicodeMapping.mappingVersion can take either:
;;;
;;;   #$kUnicodeUseLatestMapping
;;;   #$kUnicodeUseHFSPlusMapping
;;;
;;;   However, query-unicode-mappings returns only mappings with
;;;   #$kUnicodeUseHFSPlusMapping. Why? Is it OK?
;;;
;;; * CreateUnicodeToTextRunInfo may return:
;;;
;;;   #$kTextUnsupportedEncodingerr
;;;

;;; Only the following Mac encodings are supported in OSX:
;;; [From Deborah Goldsmith of Apple]
;;;
;;; #$kTextEncodingMacRoman
;;; #$kTextEncodingMacJapanese
;;; #$kTextEncodingMacChineseTrad
;;; #$kTextEncodingMacKorean
;;; #$kTextEncodingMacCyrillic
;;; #$kTextEncodingMacChineseSimp
;;; #$kTextEncodingMacCentralEurRoman
;;; 
;;; #$kTextEncodingMacSymbol
;;; #$kTextEncodingMacDingbats
;;; #$kTextEncodingMacKeyboardGlyphs 

#|
(defparameter *worldscript-encodings*
  (list #$kTextEncodingMacRoman
        #$kTextEncodingMacJapanese
        #$kTextEncodingMacChineseTrad
        #$kTextEncodingMacKorean
        ; #$kTextEncodingMacArabic
        ; #$kTextEncodingMacHebrew
        ; #$kTextEncodingMacGreek
        #$kTextEncodingMacCyrillic
        ; #$kTextEncodingMacDevanagari
        ; #$kTextEncodingMacGurmukhi
        ; #$kTextEncodingMacGujarati
        ; #$kTextEncodingMacOriya
        ; #$kTextEncodingMacBengali
        ; #$kTextEncodingMacTamil
        ; #$kTextEncodingMacTelugu
        ; #$kTextEncodingMacKannada
        ; #$kTextEncodingMacMalayalam
        ; #$kTextEncodingMacSinhalese
        ; #$kTextEncodingMacBurmese
        ; #$kTextEncodingMacKhmer
        ; #$kTextEncodingMacThai
        ; #$kTextEncodingMacLaotian
        ; #$kTextEncodingMacGeorgian
        ; #$kTextEncodingMacArmenian
        #$kTextEncodingMacChineseSimp
        ; #$kTextEncodingMacTibetan
        ; #$kTextEncodingMacMongolian
        ; #$kTextEncodingMacEthiopic
        #$kTextEncodingMacCentralEurRoman
        ; #$kTextEncodingMacVietnamese
        ; #$kTextEncodingMacExtArabic
        #$kTextEncodingMacSymbol
        #$kTextEncodingMacDingbats
        ; #$kTextEncodingMacTurkish
        ; #$kTextEncodingMacCroatian
        ; #$kTextEncodingMacIcelandic
        ; #$kTextEncodingMacRomanian
        ; #$kTextEncodingMacCeltic
        ; #$kTextEncodingMacGaelic
        #$kTextEncodingMacKeyboardGlyphs 
        ))


(defun count-unicode-mapping (unicode-encoding 
                              &optional 
                              (mask (logior #$kUnicodeMatchUnicodeBaseMask
                                           #$kUnicodeMatchUnicodeVariantMask
                                           #$kUnicodeMatchUnicodeFormatMask )))
  (rlet ((map :unicodemapping
              :unicodeencoding unicode-encoding
              :otherEncoding (create-text-encoding 0))
         (count :itemcount))
    (let ((err (#_countunicodemappings
                mask
                map
                count)))
      (declare (fixnum err))
      (if (zerop err)
        (%get-unsigned-long count)
        (error "CountUnicodeMappings [~A]." err)))))
|#

#|

looks like utf-32 [and utf-7] is not supported.

(count-unicode-mapping
 (tec:create-text-encoding #$kTextEncodingUnicodeDefault
                           :format #$kUnicode32BitFormat))

--> 0

|#

#|
(defun query-unicode-mappings (unicode-encoding &key (world-script-p t)
                                                (mask #.(logior #$kUnicodeMatchUnicodeBaseMask
                                                                #$kUnicodeMatchUnicodeVariantMask
                                                                #$kUnicodeMatchUnicodeFormatMask )))
  (let* ((max-count (count-unicode-mapping unicode-encoding mask))
         (unicode-mappings '()))
    (rlet ((map :unicodemapping
                :unicodeencoding unicode-encoding
                :otherEncoding (create-text-encoding 0)))
      (%stack-block ((map-out (* max-count #.(record-length :unicodemapping)))
                     (count #.(record-length :itemcount)))
        (unless (zerop (#_QueryUnicodeMappings
                        mask
                        map
                        max-count
                        count
                        map-out))
          (return-from query-unicode-mappings nil))
        (dotimes (i (%get-unsigned-long count))
          (let ((encoding (pref map-out :unicodemapping.otherencoding)))
            (when (or (not world-script-p)
                      (member (#_GetTextEncodingBase encoding)
                              *worldscript-encodings*))
              (push (cons (pref map-out :unicodemapping.otherencoding)
                          (pref map-out :unicodemapping.mappingVersion))
                    unicode-mappings)))
          (%incf-ptr map-out #.(record-length :unicodemapping)))))
    (nreverse unicode-mappings)))
|#

#|
(query-unicode-mappings 
 (create-text-encoding #$kTextEncodingUnicodeDefault
                       :format #$kUnicode16BitFormat))
|#

#|
(defun create-unicode-to-textruninfo (unicode-encoding &optional encodings)
  (let* ((mask (logior #$kUnicodeMatchUnicodeBaseMask
                       #$kUnicodeMatchUnicodeVariantMask
                       #$kUnicodeMatchUnicodeFormatMask ))
         (unicode-mappings (query-unicode-mappings unicode-encoding :mask mask)))
    (when encodings
      (setq unicode-mappings 
            (stable-sort unicode-mappings
                         #'(lambda (a b)
                             (let ((pos-a (position a encodings))
                                   (pos-b (position b encodings)))
                               (if (and pos-a pos-b)
                                 (< pos-a pos-b)
                                 pos-a)))
                         :key #'car)))
    (let ((max-count (length unicode-mappings))
          temp-map)
      (%stack-block ((out #.(record-length :pointer))
                     (umap (* max-count #.(record-length :UnicodeMapping))))
        (setq temp-map umap)
        (dolist (map unicode-mappings)
          (setf (pref temp-map :unicodemapping.unicodeEncoding)
                unicode-encoding
                (pref temp-map :unicodemapping.otherencoding)
                (car map)
                (pref temp-map :unicodemapping.mappingVersion)
                (cdr map))
          (setq temp-map (%inc-ptr temp-map #.(record-length :UnicodeMapping))))
        (let ((err (#_CreateUnicodeToTextRunInfo
                    max-count
                    umap
                    out)))
          (declare (fixnum err))
          (if (zerop err)
            (%get-ptr out)
            (error "CreateUnicodeToTextRunInfo [~A]"
                   err)))))))
|#

;; looks like CreateUnicodeToTextRunInfoByScriptCode only works for UTF-16.
;;
; (defun create-unicode-to-textruninfo (&rest scripts)
;   (let ((n (length scripts)))
;     (%stack-block ((out #.(record-length :pointer))
;                    (spt (* n #.(record-length :scriptcode))))
;       (dotimes (i n)
;         (%put-word spt (elt scripts i)
;                    (* i #.(record-length :scriptcode))))
;       (let ((err (#_CreateUnicodeToTextRunInfoByScriptCode
;                   n
;                   spt
;                   out)))
;         (declare (fixnum err))
;         (if (zerop err)
;           (%get-ptr out)
;           (error "CreateUnicodeToTextRunInfoByScriptCode [~A]"
;                  err))))))

#|
(defun dispose-unicode-to-text-runinfo (info-ptr)
  ;; this rlet business is puzzling, but disposeXXX craches 
  ;; if I give ptr itself
  (when (macptrp info-ptr)
    (rlet ((info :pointer info-ptr))
      (#_disposeunicodetotextruninfo info))))
|#

#|
(defclass unicode-to-text-runinfo ()
  ((ptr :initform nil :reader runinfo-ptr)
   (unicode-encoding :initarg :unicode-encoding
                     :reader runinfo-unicode-encoding)
   (lock :initform (make-lock) :reader runinfo-lock)))
|#

#|
(defmethod initialize-instance :after ((runinfo unicode-to-text-runinfo) &key
                                       unicode-encoding
                                       encodings)
  (let ((runinfo-ptr (create-unicode-to-textruninfo unicode-encoding
                                                    encodings)))
    (setf (slot-value runinfo 'ptr)
          runinfo-ptr))
  (terminate-when-unreachable runinfo))

(defmethod terminate ((runinfo unicode-to-text-runinfo))
  (when (runinfo-ptr runinfo)
    (dispose-unicode-to-text-runinfo (runinfo-ptr runinfo))))


;; ugly!
(defparameter *runinfo-16* nil)
(defparameter *runinfo-8* nil)
(defvar *runinfo-16-lock* (make-lock))
(defvar *runinfo-8-lock* (make-lock))

|#


#|  ;; unused today
(add-pascal-upp-alist-macho 'zwnbsp-fallback-handler "NewUnicodeToTextFallbackUPP")


(defpascal zwnbsp-fallback-handler (:ptr str
                                     :bytecount length
                                     :ptr oSrcConvLen
                                     :ptr out-str
                                     :bytecount max-len
                                     :ptr oDstConvLen
                                     :ptr info-ptr
                                     :ptr unicode-mapping
                                     :osstatus)
  (declare (ignore out-str info-ptr unicode-mapping))
  (if (and (> length 1)
           (= (%get-word str) #xFEFF)
           (>= max-len 2))
    (progn
      (%put-long oSrcConvLen 2)
      (%put-long oDstConvLen 0) 
      #$noErr)
    #$kTECUnmappableElementErr))
|#

#|
(defccallable zwnbsp-fallback-handler (:ptr str
                                     :bytecount length
                                     :ptr oSrcConvLen
                                     :ptr out-str
                                     :bytecount max-len
                                     :ptr oDstConvLen
                                     :ptr info-ptr
                                     :ptr unicode-mapping
                                     :osstatus)
  (declare (ignore out-str info-ptr unicode-mapping))
  (if (and (> length 1)
           (= (%get-word str) #xFEFF)
           (>= max-len 2))
    (progn
      (%put-long oSrcConvLen 2)
      (%put-long oDstConvLen 0) 
      #$noErr)
    #$kTECUnmappableElementErr))
|#

#|  ;; unused today
(defun unicode-runinfo (unicode-format)
  (ecase unicode-format
    ((:utf-16)
     (with-lock-grabbed (*runinfo-16-lock*)
       (or *runinfo-16*
           (let ((encodings (mapcar #'locale-to-encoding
                                    (preferred-language-order))))
             (setq *runinfo-16*
                   (make-instance 'unicode-to-text-runinfo
                     :unicode-encoding
                     (create-text-encoding #$kTextEncodingUnicodeDefault
                                           :format #$kUnicode16BitFormat)
                     :encodings encodings))
             ;; This isn't really a good place to set fallback handler..
             ;; FIXIT
             (#_SetFallbackUnicodeToTextRun (runinfo-ptr *runinfo-16*)
              zwnbsp-fallback-handler
              #$kUnicodeFallbackCustomFirst
              (%null-ptr))
             *runinfo-16*))))
    ((:utf-8)
     (with-lock-grabbed (*runinfo-8-lock*)
       (or *runinfo-8*
           (let ((encodings (mapcar #'locale-to-encoding
                                    (preferred-language-order))))
             (setq *runinfo-8*
                   (make-instance 'unicode-to-text-runinfo
                     :unicode-encoding
                     (create-text-encoding #$kTextEncodingUnicodeDefault
                                           :format #$kUnicodeUTF8Format)
                     :encodings encodings))))))))
|#

#| ;; not used today
(defun discard-unicode-runinfo (unicode-format)
  (ecase unicode-format
    ((:utf-16)
     (when *runinfo-16*
       (terminate *runinfo-16*)
       (setq *runinfo-16* nil)))
    ((:utf-8)
     (when *runinfo-8*
       (terminate *runinfo-8*)
       (setq *runinfo-8* nil)))))
|#

#|
(defparameter *mapper-wants-unicode* nil)

(defun %map-unicode-string (function run-info ustr ustr-size
                                     buffer
                                     buffer-size
                                     &optional
                                     (options (logior #$kUnicodeUseFallbacksMask
                                                      #$kUnicodeTextRunMask
                                                      #$kUnicodeKeepSameEncodingMask)))
  (declare (fixnum ustr-size buffer-size))
  (let* ((err 0)
         (rcount 10))
    (declare (fixnum err rcount))
    (loop
      (%stack-block ((script-runs (* #.(record-length :scriptcoderun)
                                     rcount)))
        (rlet ((offset-count :unsigned-long)
               (offset-arr :pointer)
               (read-len :unsigned-long)
               (output-len :unsigned-long)
               (script-count :itemcount))
          (setq err (#_ConvertFromUnicodeToScriptCodeRun run-info ;; maybe use convert... totextrun - gets encoding vs script
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
                     buffer
                     rcount
                     script-count
                     script-runs))
          (case err
            ((#.#$noerr #.#$kTECUsedFallbacksStatus #.#$kTECOutputBufferFullStatus)
             (let ((scount (1- (%get-unsigned-long script-count)))
                   (chars-so-far 0))
               (declare (fixnum scount chars-so-far))
               (dotimes (i (1+ scount))
                 (declare (fixnum i))
                 (let ((macbuf (%inc-ptr buffer (pref script-runs :scriptcoderun.offset)))
                       (script (pref script-runs :scriptcoderun.script))
                       (nbytes (- (if (< i scount)
                                    (pref (%inc-ptr script-runs #.(record-length :scriptcoderun))
                                          :scriptcoderun.offset)
                                    (%get-unsigned-long output-len))
                                  (pref script-runs :scriptcoderun.offset))))
                   (if *mapper-wants-unicode*
                     (progn
                       (let ((nchars (get-num-unicode-chars macbuf nbytes script)))
                         (declare (fixnum nchars))
                         (funcall function (%inc-ptr ustr (%i+ chars-so-far chars-so-far)) nchars script)
                         (setq chars-so-far (+ chars-so-far nchars))))                     
                     (funcall function macbuf nbytes script)))
                 (unless (= i scount)
                   (%incf-ptr script-runs #.(record-length :scriptcoderun)))))
             (when (and (= err #.#$kTECUsedFallbacksStatus)
                        *warn-if-fallback*)
               (warn 'convert-text-fallbacks-warning
                     :trap-name "TECConvertText"))
             (let ((readlen (%get-unsigned-long read-len)))
               (declare (fixnum readlen))
               ;; compare read-len and ustr-size instead of checking
               ;; #$kTECOutputBufferFullStatus. #$kTECUsedFallbacksStatus
               ;; might shadow #$kTECOutputBufferFullStatus...
               (if (< readlen ustr-size)
                 (setq ustr (%inc-ptr ustr readlen)
                       ustr-size (- ustr-size readlen))
                 (return))))
            ((#.#$kTECArrayFullErr)
             (incf rcount 10))
            (t #+keke (cnd:trap-error "ConvertFromUnicodeToScriptCodeRun" err)
               #-keke (error "ConvertFromUnicodeToScriptCodeRun failed with ~A." err))))))))


;; can't figure out how to get this info from ConvertFromUnicode....

(defun get-num-unicode-chars (macbuffer bufsize script)
  (let ((table (and (two-byte-script-p script)(get-char-byte-table script)))
        (idx 0)
        (nchars 0))
    (declare (fixnum idx nchars bufsize))
    (if (not table)
      bufsize
      (progn 
        (while (< idx bufsize)
          (let ((char-code (%get-unsigned-byte macbuffer idx)))
            (if (neq (aref table char-code) #$smSingleByte)
              (incf idx))
            (incf nchars)
            (incf idx)))
        nchars))))
|#

;; does more what I mean - doesn't turn Japanese into Korean, or think some european Latin is chinese
;; and always applies function to unicode buffer
;; not used today
#+ignore
(defun %map-unicode-string (function run-info ustr ustr-bytes
                                     buffer
                                     buffer-size
                                     &optional options)
  (declare (fixnum ustr-size buffer-size))
  (declare (ignore run-info buffer buffer-size options))
  (let* (;(err 0)
         ;(rcount 10)
         (start-idx 0)
         (ustr-size (ash ustr-bytes -1)) 
         (guess nil))
    (declare (fixnum err rcount))
    (dotimes (ustr-idx ustr-size)
      (let ((code (%get-word ustr (%i+ ustr-idx ustr-idx))))
        (let ((encoding (if (> code #x7f)
                          (find-encoding-for-uchar (%code-char cod<e))
                          #$kcfstringencodingmacroman)))
          (if (null guess)
            (setq guess encoding)
            (when (neq guess encoding)
              (funcall function (%inc-ptr ustr (%i+ start-idx start-idx)) 
                       (%i- ustr-idx start-idx) guess)
              (setq start-idx ustr-idx)
              (setq guess encoding))))))
    (funcall function (%inc-ptr ustr (%i+ start-idx start-idx)) 
             (%i- ustr-size start-idx) guess)))

;; not used today
#+ignore
(defun map-unicode-string (function ustr ustr-size format
                                    &optional
                                    buffer
                                    buffer-size
                                    (options (logior #$kUnicodeUseFallbacksMask
                                                     #$kUnicodeTextRunMask
                                                     #$kUnicodeKeepSameEncodingMask)))
  "
map-unicode-string converts unicode string to mac-encoding
strings and calls a function with converted string.

Required arguments:

* function:  a function of 3 arguments: cstr, cstr-size,
             script cstr is not a lisp string. It is a
             macptr. They are meant to be used with
             ccl::%str-from-ptr-in-script.

* ustr:      a pointer to a buffer containing unicode chars.
* ustr-size: the size of the ustr buffer.
* unicode-format: :utf-16 or :utf-8"
  (declare (fixnum str-size))
  (let ((buffer-supplied-p buffer))
    (unless buffer
      (setq buffer-size (max 8 (or buffer-size ustr-size))
            buffer (#_newptr buffer-size)))
    (when (%null-ptr-p buffer)
      (setq buffer (#_newptr 1024)      ; magic number FIXIT
            buffer-size 1024)
      (when (%null-ptr-p buffer)
        #+keke (cnd:memfull-trap-error "NewPtr")
        #-keke (error "NewPtr(1024) failed.")))
    (unwind-protect
      (let ((runinfo (unicode-runinfo format)))
        (with-lock-grabbed ((runinfo-lock runinfo))
          (%map-unicode-string function
                               (runinfo-ptr runinfo)
                               ustr
                               ustr-size
                               buffer
                               buffer-size
                               options)))
      (unless buffer-supplied-p
        (#_DisposePtr buffer)))))

;;; from preferences.lisp

(defvar *preferred-language-order* nil)  ;; fix this

(defvar *sl-symbols* (make-hash-table :test 'equal))


(defun %mac-symbol-ptr (name)
  (or (gethash name *sl-symbols*)
      (setf (gethash name *sl-symbols*)
            ; doesn't work because in MCL 5.1 the connID arg to FindSymbol is :unsigned-long  today it's (connID (:pointer :OpaqueCFragConnectionID))
            ; however this might be fixed we hope it doesn't involve map-over-fixed-and-lazy-shared-libraries
            ; OK its "fixed" but we need a better fix - ok OSX fix works now
            (if t ;(osx-p)
              (resolve-data-entry-point name)              
              (with-pstrs ((name-ptr name))
                (block search
                  (ccl::map-over-fixed-and-lazy-shared-libraries
                   #'(lambda (sld)
                       (let ((conn-id (ccl::resolve-shared-library-connid sld nil)))
                         (when conn-id
                           (rlet ((addr :pointer)
                                  (class :byte))
                             ;; was (#_findsymbol conn-id name-ptr addr class)
                             (when (zerop (ff-call-slep (get-shared-library-entry-point "FindSymbol")
                                                        :unsigned-fullword conn-id
                                                        :address name-ptr
                                                        :address addr
                                                        :address class
                                                        :signed-halfword))
                               (if (= (%get-byte class) #$kDataCFragSymbol)
                                 (return-from search (%get-ptr (%get-ptr addr)))
                                 (return-from %mac-symbol-ptr nil))))))))))))))


(defun resolve-data-entry-point (symbol-name)
  (let ((address nil))    
    (dolist (bundle (all-bundles) nil)
      (let ((real-bundle (or (car bundle)
                             (get-bundle-for-framework-name (cdr bundle)))))
        (setq address (lookup-dataptr-in-bundle symbol-name real-bundle t))
        (when address (return))))    
    address))

(defun lookup-dataptr-in-bundle (symbol-name bundle &optional nil-if-not-found)
  (with-cfstrs ((cfname symbol-name))  
    (with-macptrs ((addr (#_CFBundleGetDataPointerForName bundle cfname)))
      (if (%null-ptr-p addr)
        (if nil-if-not-found
          nil
          (error "Couldn't resolve address of foreign data ~s" symbol-name))
        ;; why get-ptr ??
        (%get-ptr addr)))))


(defun meta-constant (meta-key)
  "meta-key can be one of keywords:

:any-host            [kCFPreferencesAnyHost]
:current-host        [kCFPreferencesCurrentHost]
:any-application     [kCFPreferencesAnyApplication]
:current-application [kCFPreferencesCurrentApplication]
:any-user            [kCFPreferencesAnyUser]
:current-user        [kCFPreferencesCurrentUser]

It searchs an external symbol corresponding to meta-key
and returns a pointer if the symbol exists, or nil if
the symbol is not found."

  (ecase meta-key
    ((:any-host) (%mac-symbol-ptr "kCFPreferencesAnyHost"))
    ((:current-host) (%mac-symbol-ptr "kCFPreferencesCurrentHost"))
    ((:any-application) (%mac-symbol-ptr "kCFPreferencesAnyApplication"))
    ((:current-application) (%mac-symbol-ptr "kCFPreferencesCurrentApplication"))
    ((:any-user) (%mac-symbol-ptr "kCFPreferencesAnyUser"))
    ((:current-user) (%mac-symbol-ptr "kCFPreferencesCurrentUser"))))



       
; ("en" "fr" "ko" "ja" "zh_TW" "da" "nl" "fi" "de" "it" "no" "pt" "es" "sv" "zh_CN" "he" "ar")
(defun apple-languages (&key (app :any-application)
                             (user :current-user)
                             (host :any-host))
  (let ((langs (copy-value "AppleLanguages" :app app :user user :host host)))
    (unless (%null-ptr-p langs)
      (unwind-protect
        (let ((result '()))
          (dotimes (i (#_CFArrayGetCount langs))
            (push (%get-cstring
                   (#_CFStringGetCstringPtr
                    (#_CFArrayGetValueAtIndex langs i)
                    0))
                  result))
          (nreverse result))
        (#_CFRelease langs)))))

(def-ccl-pointers lang-ord ()
  (setq *preferred-language-order* nil)
  (clrhash *sl-symbols*))

(defun preferred-language-order ()
  (or *preferred-language-order*
      (when t ;(osx-p)
        (setq *preferred-language-order*
              (apple-languages)))))

#| ;; fails to boot
(ccl::defloadvar *preferred-language-order*
  (when (osx-p) (apple-languages)))
|#

;; from tec-fred.lisp

;; control-flags ONLY FOR UNICODE.
;;
#+ignore
(defparameter *control-flags*
  (logior #$kUnicodeUseFallbacksMask
          #$kUnicodeTextRunMask
          #+ignore
          #$kUnicodeKeepSameEncodingMask))



#|
(defun create-cfstring (str) ;; same as create-cfstring-simple in l1-init.lisp
  (with-cstrs ((str str))
    (#_CFStringCreateWithCstring (%null-ptr) str 
     #$kCFStringEncodingISOLatin1)))
|#


(defun copy-value (key &key (app :any-application)
                       (user :current-user)
                       (host :any-host)
                       &aux release-app-p release-user-p release-host-p)
  "remember to CFRealse the result."
  (etypecase app
    (keyword (setq app (meta-constant app)))
    (string (setq app (create-cfstring-simple app)
                  release-app-p t)))
  (unwind-protect
    (progn
      (etypecase user
        (keyword (setq user (meta-constant user)))
        (string (setq user (create-cfstring-simple user)
                      release-user-p t)))
      (unwind-protect
        (progn
          (etypecase host
            (keyword (setq host (meta-constant host)))
            (string (setq host (create-cfstring-simple host)
                          release-host-p t)))
          (unwind-protect  
            (progn
              (setq key (create-cfstring-simple key))
              (unwind-protect
                (#_CFPreferencesCopyValue key app user host)
                (#_CFRelease key)))
            (when release-host-p
              (#_CFRelease host))))
        (when release-user-p
          (#_CFRelease user))))
    (when release-app-p
      (#_CFRelease app))))


(defun find-fonts-for-buffer (buffer pos)
  (let ((size (buffer-size buffer))
        (last-encoding nil)
        (encoding nil)
        (ms  (nth-value 1 (font-codes '(10))))
        (n (or pos 0)))
    (loop
      (when (>= n size)(return))
      (let ((char-code (%char-code (buffer-char buffer n))))
        (declare (fixnum char-code))
        (if (<= char-code #x7f)
          (setq encoding 0)
          (setq encoding (%find-encoding-for-uchar-code char-code)))
        (when (neq encoding last-encoding)
          (let ((font (encoding-to-font-simple encoding)))  ;; may error ?
            (buffer-set-font-codes buffer (ash font 16) ms n))
          (setq last-encoding encoding)))
      (incf n)))
  )
            
          

(defun %buffer-insert-utf-file (encoding buffer fname pos)  
  ;(declare (ignore pos))                ; FIXIT
  (cond
   ((eq encoding :utf-16)
    (let ((bytes-read (%buffer-insert-utf16-file buffer fname pos)))
      (when (not (fred-file-p fname))
        (find-fonts-for-buffer buffer pos))
      (ash bytes-read -1)))
   ((eq encoding :utf-8)  ;; looks like TextEdit doesn't add utf8 BOM so we never get here for its supposed utf8 files
    (let ((chars-read (%buffer-insert-utf8-file buffer fname pos)))
      (when (not (fred-file-p fname))
        (find-fonts-for-buffer buffer pos))
      chars-read))   
   (t (error "Unexpected call to %buffer-insert-utf-file") ;; never get here
      )))

(defun fred-file-p (truename)
  (let ((truename (truename truename))
        fredp refnum)                  
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple truename fsref)      
      (unwind-protect 
        (unless (eq -1 (setq refnum (open-resource-file-from-fsref fsref #$fsrdperm)))
          (with-macptrs ((fred2 (#_Get1Resource :FRED 2)))
            (unless (%null-ptr-p fred2)
              (setq fredp t))             ; want to know if Fred wrote this file
            ))
        (unless (eq refnum -1)
          (#_CloseResFile refnum))))
    fredp))

;; this all assumes that fred uses utf16 internally which is currently the case.

(defun %buffer-insert-utf16-file (buffer fname pos)
  (setq pos (buffer-position buffer pos))   
  (let* ((the-buffer (mark.buffer buffer))
         (gappos (bf.gappos the-buffer)))
    (declare (fixnum pos gappos) (optimize (speed 3)(safety 0)))
    ;(print (list 'before (buffer-size buffer)))    
    (when (not (= gappos pos))
      (%move-gap the-buffer (%i- pos gappos))) 
    (with-fsopen-file (pb fname)
      (let* ((size (geteof pb))
             (buf-size (max (bf.chunksz the-buffer) 4096))  ;; fails if < bf.chunksz ???
             (offset 0)
             (total-bytes-read 0))
        (%stack-block ((file-buf buf-size))          
          (let ((bytes-read (fsread pb buf-size file-buf)))
            (if (>= bytes-read 2)
              (if (= (%get-word file-buf) #xFEFF)
                (setq offset 2)))            
            (buffer-insert-from-macptr buffer file-buf bytes-read offset)
            (setq total-bytes-read bytes-read))
          (while (< total-bytes-read size)
            (let ((bytes-read (fsread pb buf-size file-buf)))
              (buffer-insert-from-macptr buffer file-buf bytes-read)
              (setq total-bytes-read (+ total-bytes-read bytes-read))))
          ;(print (list 'after (buffer-size buffer)))
          (- total-bytes-read offset)
          )))))

;; guess what folks - a utf8 file once got screwed up by #\linefeed line endings !!
(defun %buffer-insert-utf8-file (buffer fname pos)
  (setq pos (buffer-position buffer pos))
  (let* ((the-buffer (mark.buffer buffer))
         (gappos (bf.gappos the-buffer)))
    (declare (fixnum pos gappos) (optimize (speed 3)(safety 0)))    
    (when (not (= gappos pos))
      (%move-gap the-buffer (%i- pos gappos))) 
    (with-fsopen-file (pb fname)
      (let* ((size (geteof pb))
             (buf-size (max (bf.chunksz the-buffer) 4096))  ;; fails if < bf.chunksz ???
             (offset 0)
             (chars-read 0)
             (fudge 0)
             (total-bytes-read 0)
             (total-chars-read 0))
        (%stack-block ((file-buf buf-size))          
          (let ((bytes-read (fsread pb buf-size file-buf)))
            (if (>= bytes-read 3)
              (if (and (= (%get-word file-buf) #xEFBB)
                       (= (%get-byte file-buf 2) #xBF))
                (setq offset 3)))            
            (multiple-value-setq (chars-read fudge) (buffer-insert-from-utf8-macptr buffer (%inc-ptr file-buf offset) (- bytes-read offset)))
            ;; if fudge > 0, move fudge bytes from end of current file buf to beginning of "next" file-buf
            (when (> fudge 0)
              (dotimes (i fudge)
                (setf (%get-byte file-buf i)(%get-byte file-buf (+ (- buf-size fudge) i)))))
            (setq total-chars-read chars-read)
            (setq total-bytes-read bytes-read))
          (while (< total-bytes-read size)
            (let* ((bytes-read (fsread pb (- buf-size fudge) (%inc-ptr file-buf fudge))))
              (multiple-value-setq (chars-read fudge) (buffer-insert-from-utf8-macptr buffer file-buf bytes-read))
              (when (> fudge 0)
                (dotimes (i fudge)
                  (setf (%get-byte file-buf i)(%get-byte file-buf (+ (- buf-size fudge) i)))))
              (setq total-bytes-read (+ total-bytes-read bytes-read))
              (setq total-chars-read (+ total-chars-read chars-read))))
        total-chars-read
        )))))

(defun buffer-insert-from-utf8-macptr (buffer file-buf bytes-read) ;; file-buf is stack allocated
  (let ((fudge 0))
    (with-macptrs ((cfstr))
      (loop
        (%setf-macptr cfstr (#_cfstringcreatewithbytes (%null-ptr)
                             file-buf (- bytes-read fudge)
                             #$kcfstringencodingutf8 nil))        
        (if (%null-ptr-p cfstr) (incf fudge) (return))
        (if  (> fudge 6) (error "confused in UTF8")))
      (let ((uni-len (#_CFStringGetLength cfstr) )) ;; number of 16 bit unicode chars - bug if utf8 "logical character" crosses buffer boundary - fixed we hope
        (%stack-block ((outbuf (+ uni-len uni-len)))
          (cfstringgetcharacters cfstr 0 uni-len outbuf) 
          (buffer-insert-from-macptr buffer outbuf (+ uni-len uni-len)))
        (#_cfrelease cfstr)
        (values uni-len fudge)
        ))))


(defun buffer-insert-from-macptr (mark file-buf bytes-read &optional (offset 0) font)
  ;; use %copy-ptr-to-ivector, screw fonts
  (without-interrupts
   #+ignore
   (when (null font)
     (let ((efont (bf-efont the-buffer)))
       (cond ((neq efont %no-font-index)
              (setq font (1+ efont)))
             ((neq 0 posn)
              (setq font (%font-exception the-buffer posn))))))            
   (let ((strlen (ash bytes-read -1)))
     (declare (fixnum strlen))
     (unless (= 0 strlen)      
       (if font 
         (progn 
           (%buf-change-font mark font)
           ;(bf-efont the-buffer %no-font-index)  ; nuked 5/28
           )
         #+ignore
         (when (= 0 (the fixnum (bf.bufsiz the-buffer)))
           (setf (bf.bfonts the-buffer) 1)
           (let ((fontruns (bf.fontruns the-buffer)))              
             (set-fontruns fontruns 0 (bf-cfont the-buffer) 0))))       
       (%buf-insert-macptr-in-gap (mark.buffer mark) file-buf (ash offset -1) strlen)))))

;; pretty much like %buf-insert-in-gap
;; org and len are chars not bytes

(defun %buf-insert-macptr-in-gap (the-buffer macptr org len)
  (declare (fixnum org len)(optimize (speed 3)(safety 0)))
  (let* ((gapstart (bf.gapstart the-buffer))
         (gaplen (%i- (bf.gapend the-buffer) gapstart))
         (chunksz (bf.chunksz the-buffer))
         (bufsiz (bf.bufsiz the-buffer))
         (real-len (- len org))
         )
    (declare (fixnum gapstart gaplen chunksz bufsiz))
    ;(print (list 'before2 bufsiz org len real-len))
    (without-interrupts     
     (when (< gaplen real-len)
       (%buf-grow-gap the-buffer (- real-len gaplen))
       (setq gaplen (%i- (bf.gapend the-buffer) gapstart)))
     (%buf-changed the-buffer)
     (let ((gapchunk (bf.gapchunk the-buffer))) 
       (when (= (bf.chunksz the-buffer) gapstart) ; huh
         (setq gapchunk (bfc.next gapchunk))
         (setq gapstart 0))
       (let* ((chars-left real-len)
              (nchars 0)
              (chars-in-chunk (- chunksz gapstart))
              (dest-org gapstart))
         (declare (fixnum chars-left nchars chars-in-chunk dest-org))
         (loop           
           (setq nchars
                 (if (< chars-left chars-in-chunk) chars-left chars-in-chunk))
           (%copy-ptr-to-ivector macptr (+ org org) (bfc.string gapchunk) (+ dest-org dest-org) (+ nchars nchars))          
           (when (>= 0 (setq chars-left (- chars-left nchars)))
             (return))
           (setq gapchunk (bfc.next gapchunk))
           (setq dest-org 0)
           (setq chars-in-chunk chunksz)
           (setq org (+ org nchars)))
         (setq gapstart (+ dest-org nchars)))
       (setf (bf.gapchunk the-buffer) gapchunk)
       (setf (bf.gapend the-buffer)(%i+ gapstart (%i- gaplen real-len)))
       (setf (bf.gapstart the-buffer) gapstart)
       (setf (bf.gappos the-buffer)(%i+ real-len (bf.gappos the-buffer)))
       (setf (bf.bufsiz the-buffer)(%i+ real-len bufsiz))
       ))))



;; hopefully not used today
#+ignore
(defun get-scriptruns-from-utf-buf (ustr ustr-size)                                 
  (declare (fixnum ustr-size))
 
  (with-macptrs ((cfstr (#_cfStringCreateWithCharacters (%null-ptr) ustr ustr-size)))
    (let ((encoding (#_cfStringGetSmallestEncoding cfstr)))  ;; does this do what we want?? - seems not -or only if one char
      (#_cfrelease cfstr)
      (if (memq encoding '(#.#$kcfstringencodingMacRoman #.#$kcfstringencodingMacJapanese #.#$kCFStringEncodingMacChineseTrad
                             #.#$kCFStringEncodingMacKorean #.#$kCFStringEncodingMacChineseSimp #.#$kCFStringEncodingMacCentralEurRoman))
        
          (return-from get-scriptruns-from-utf-buf encoding))))
  (let ((run-info (unicode-runinfo :utf-16))
        (buffer-size ustr-size)
        (options (logior #$kUnicodeUseFallbacksMask
                         #$kUnicodeTextRunMask
                         #$kUnicodeKeepSameEncodingMask)))
    ;; something is wrong here if more than one run
    (%stack-block ((buffer buffer-size))
      (with-lock-grabbed ((runinfo-lock run-info))
        (let* ((err 0)
               (rcount 10))  ;; or less
          (declare (fixnum err rcount))
          (progn ;; loop
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
                          (scriptruns (make-array (1+ scount) :element-type '(unsigned-byte 32)))
                          script
                          start
                          end)               
                     (declare (fixnum scount))
                     (dotimes (i scount)
                       (declare (fixnum i))
                       (setq start (pref script-runs :scriptcoderun.offset))
                       (setq end (- (if (< i (1- scount))
                                      (pref (%inc-ptr script-runs #.(record-length :scriptcoderun))
                                            :scriptcoderun.offset)
                                      (%get-unsigned-long output-len))
                                    (pref script-runs :scriptcoderun.offset)))
                       (setq script (pref script-runs :scriptcoderun.script))
                       (setf (uvref scriptruns i)(logior (ash script 24) start))  ;; is only 8 bits enuf?
                       (setf (uvref scriptruns (1+ i)) end)
                       (%incf-ptr script-runs #.(record-length :scriptcoderun)))
                     scriptruns))
                  ((#.#$kTECArrayFullErr) ;; huh
                   ;(error "phooey")
                   ;(incf rcount 10)
                   nil  ;; or :too-many-scripts
                   )
                  (t (error "ConvertFromUnicodeToScriptCodeRun failed with ~A." err))))))))))
  )

#|
(defun foop (thing)  
  (let ((buf-len (if (characterp thing) 2
                     (* (length thing) 2))))
    (%stack-block ((my-buf buf-len))
      (if (characterp thing)
        (%put-word my-buf (char-code thing))
        (if (extended-string-p thing)
          (%copy-ivector-to-ptr thing 0 my-buf 0 buf-len)
          (dotimes (i (length thing))
            (%put-word my-buf (%scharcode thing i) (+ i i)))))
      (get-smallest-encoding my-buf buf-len))))

(defun get-smallest-encoding (ustr ustr-size)
  (declare (fixnum ustr-size))
  (with-macptrs ((cfstr (#_cfStringCreateWithCharacters (%null-ptr) ustr ustr-size)))
    (let ((encoding (#_cfStringGetSmallestEncoding cfstr)))  ;; does this do what we want?? - no - always 256 unless 1 char
      (#_cfrelease cfstr)(print encoding)
      (if (memq encoding '(#.#$kcfstringencodingMacRoman #.#$kcfstringencodingMacJapanese #.#$kCFStringEncodingMacChineseTrad
                           #.#$kCFStringEncodingMacKorean #.#$kCFStringEncodingMacChineseSimp #.#$kCFStringEncodingMacCentralEurRoman))
        
        encoding))))
|#



(defmethod print-object ((string string) (stream terminal-io))
  (if (7bit-ascii-p string)
    (call-next-method)
    (let* ((listener (stream-current-listener stream))
           (key-handler (current-key-handler listener)))      
      (multiple-value-bind (ff ms) (view-font-codes key-handler)
        (call-next-method)
        (let* ((buf (fred-buffer key-handler))
               (pos (buffer-position buf)))       ;; hit the terminating quote  with a hammer 
          (buffer-set-font-codes buf ff ms (1- pos)  pos))
        (set-view-font-codes key-handler ff ms)
        string))))

(defmethod print-object ((char character) (stream terminal-io))
  (if (<= (char-code char) #x7f)
    (call-next-method)
    (let* ((listener (stream-current-listener stream))
           (key-handler (current-key-handler listener)))      
      (multiple-value-bind (ff ms) (view-font-codes key-handler)
        (call-next-method)        
        (set-view-font-codes key-handler ff ms)
        char))))


(defun paste-utxt (w)
  (when (ccl::get-scrap-flavor-flags :|utxt|)
    (let ((buff (fred-buffer w)))
      (declare (fixnum last-script))
      (rlet ((rsize :signed-long))
        (let* ((size nil)
               (scrap (ccl::get-current-scrapref))
               (buffpos (buffer-position buff)))
          (let* ((err (#_GetScrapFlavorSize scrap :|utxt| rsize)))
            (when (not (and (eq err #$noerr)
                            (plusp (setq size (%get-signed-long rsize)))))
              (return-from paste-utxt nil)))
          (%stack-block ((dest size))
            (let ((err (#_GetScrapFlavorData scrap :|utxt| rsize dest))
                  (undo-append-p nil)
                  (len (ash size -1)))
                (When (eq err #$noerr)
                  (multiple-value-bind (s e)
                                       (selection-range w)
                    (unless (= s e)
                      (ed-delete-with-undo w s e)
                      (setq undo-append-p t))
                    (let ((string (make-string len :element-type 'extended-character)))
                      (%copy-ptr-to-ivector dest 0 string 0 size)
                      (buffer-insert-substring buff string 0 len)
                      (ed-history-add w buffpos string undo-append-p)
                      (set-key-script (encoding-to-script (%find-encoding-for-uchar-code (%scharcode string (1- len)))))))))))) 
        ;; without this, fr.keyscript may be set to a wrong value preventing
      ;; frec-idle to set the correct font for the next insertion.
      ;; I'm not sure if this is the right way to set the keyscript.
      ;(setf (ccl::fr.keyscript (frec w)) last-script)
      )
    (maybe-update-debutton w)
    (fred-update w)))

;;;;;;;;;;;;;;;;
;; copy and paste :|ustl| from keke
;;;;;;;;;;;;;;;;

;; read it

(defun parse-ustl (&optional (scrap (get-current-scrapref)))
  (when (ccl::get-scrap-flavor-flags :|ustl|) ;#$kScrapFlavorTypeUnicodeStyle)
    (rlet ((rsize :signed-long))
      (when (eq #$noerr (#_getscrapflavorsize scrap
                         :|ustl| rsize)) 
        (let ((data (#_newptr (%get-signed-long rsize))))
          (unwind-protect
            (when (eq #$noerr (#_GetScrapFlavorData scrap
                               :|ustl| rsize data))
              (%parse-ustl data))
            (#_disposeptr data)))))))

(defun %parse-ustl (data)
  (when (= (pref data :ATSFlatDataMainHeaderBlock.version) 2)
    (let* ((offset (pref data :ATSFlatDataMainHeaderBlock.offsettostyleruns))
           (ptr (%inc-ptr data offset))
           (count (%get-long ptr))
           (runinfo '())
           (fonts '()))
      (%incf-ptr ptr 4)                 ; skip count
      (dotimes (i count)
        (push (cons (pref ptr :atsustyleruninfo.runlength)
                    (pref ptr :atsustyleruninfo.styleobjectindex))
              runinfo)
        (%incf-ptr ptr 8))
      (setq runinfo (nreverse runinfo))
      (setq offset 
            (pref data :ATSFlatDataMainHeaderBlock.offsetToStyleList))
      ;; :ATSFlatDataStyleListHeader
      (setq ptr (%inc-ptr data offset))
      (setq count (%get-long ptr))
      (setq ptr (%inc-ptr ptr 4))
      ;; :ATSFlatDataStyleListStyleDataHeader
      (dotimes (i count)
        (setq offset
              (pref ptr :ATSFlatDataStyleListStyleDataHeader.sizeOfStyleInfo))
        (multiple-value-bind (ff ms)
                             (%parse-ATSUAttributeInfo
                              (pref ptr 
                                    :ATSFlatDataStyleListStyleDataHeader.numberOfSetAttributes)
                              (%inc-ptr ptr
                                        #.(record-length :ATSFlatDataStyleListStyleDataHeader)))
          (push (cons ff ms) fonts))
        (%incf-ptr ptr offset))
      (setq fonts (nreverse fonts))
      (dolist (run runinfo)
        (setf (cdr run)
              (elt fonts (cdr run))))
      runinfo)))

(defun %parse-ATSUAttributeInfo (count ptr)
  (let ((font-id nil)
        (font-size 12)                  ; ok?
        (color *black-color*)
        (face 0))
    (dotimes (i count)
      (let ((ftag (pref ptr :ATSUAttributeInfo.ftag))
            (size (pref ptr :ATSUAttributeInfo.fvaluesize)))
        (setq ptr (%inc-ptr ptr 8))
        (case ftag
          ((#.#$kATSUQDBoldfaceTag)       ; Type: Boolean
           (when (= (%get-byte ptr) 1)
             (setq face (logior face #$bold))))
          ((#.#$kATSUQDItalicTag)         ; Type: Boolean
           (when (= (%get-byte ptr) 1)
             (setq face (logior face #$italic))))
          ((#.#$kATSUQDUnderlineTag)      ; Type: Boolean  
           (when (= (%get-byte ptr) 1)
             (setq face (logior face #$underline))))
          ((#.#$kATSUQDCondensedTag)      ; Type: Boolean
           (when (= (%get-byte ptr) 1)
             (setq face (logior face #$condense))))
          ((#. #$kATSUQDExtendedTag)       ; Type: Boolean
           (when (= (%get-byte ptr) 1)
             (setq face (logior face #$extend))))
          ((#.#$kATSUFontTag)             ; Type: ATSUFontID
           (setq font-id (%parse-atsufont-id ptr)))
          ((#.#$kATSUSizeTag)             ; Type: Fixed
           (setq font-size (ash (%get-signed-long ptr) -16))) ;(truncate (unpack-fixed-point (%get-long ptr)))))
          ((#.#$kATSUColorTag)            ; Type: RGBColor    
           (setq color (rgb-to-color ptr))))
        (setq ptr (%inc-ptr ptr 
                            (let ((mod (mod size 4)))
                              (if (zerop mod)
                                size
                                (+ size (- 4 mod))))))))
    (values
     ;; ff
     (logior (if font-id 
               ;; could be nil
               (or (atsu-font-id-to-ff font-id) 0)
               0)
             (logand #xFF00 (ash face 8))
             ;; returns 255 for color black. should be 0. why? - is 0 today
             (fred-palette-closest-entry color))
     ;; ms
     font-size)))

; ;; ATSFlatDataFontNameDataHeader
; 1851878756 --> 6E616D64 --> 'namd' ;; ATSFlatDataFontNameDataHeader.nameSpecifierType
; 44     ;; size ;; ATSFlatDataFontNameDataHeader.nameSpecifierSize
; ;; ATSFlatDataFontSpecRawNameDataHeader
; 1      ;; # of items ;; ATSFlatDataFontSpecRawNameDataHeader.numberOfFlattenedNames
; ;; ATSFlatDataFontSpecRawNameData
; 4  ;; font name type ; ATSFlatDataFontSpecRawNameData.fontNameType
; 1  ;; platform       ; ATSFlatDataFontSpecRawNameData.fontNamePlatform
; 0  ;; script
; 0  ;; language
; 18 ;; name length
; 1282761577 --> #x4c756369 --> L u c i
; 1684086855 --> #x64612047 --> d a   G
; 1918987876 --> #x72616e64 --> r a n d
; 1696612975 --> #x6520426F --> e   B o
; 1818492928 --> #x6c640000 --> l d - -

(defun %parse-atsufont-id (ptr)
  ;; :ATSFlatDataFontNameDataHeader
  (case (%get-ostype ptr) ; FIXIT
    ;; kATSFlattenedFontSpecifierRawNameData
    ((:|namd|)
     ;; skip to ATSFlatDataFontSpecRawNameData
     ;; skip ATSFlatDataFontNameDataHeader [8 bytes]
     ;; and ATSFlatDataFontSpecRawNameDataHeader.numberOfFlattenedNames [4 bytes]
     ;; to ATSFlatDataFontSpecRawNameData ==
     ;; ATSFlatDataFontSpecRawNameDataHeader.nameDataArray[0]
     (%parse-namd (%inc-ptr ptr 12)))
    ;; no other type not yet specified by Apple 2003-06-28
    ))

(defun %parse-namd (ptr)
  "parse ATSFlatDataFontSpecRawNameData and returns ATSUFontID."
  (rlet ((id :fmfont))
    (#_ATSUFindFontFromName
     (%inc-ptr ptr #.(record-length :ATSFlatDataFontSpecRawNameData))
     (pref ptr :ATSFlatDataFontSpecRawNameData.fontNameLength)
     (pref ptr :ATSFlatDataFontSpecRawNameData.fontNameType)
     (pref ptr :ATSFlatDataFontSpecRawNameData.fontNamePlatform)
     (pref ptr :ATSFlatDataFontSpecRawNameData.fontNameScript)
     (pref ptr :ATSFlatDataFontSpecRawNameData.fontNameLanguage)
     id)
    #+ignore
    (print (ccl::%str-from-ptr-in-script
            (%inc-ptr ptr #.(record-length :ATSFlatDataFontSpecRawNameData))
            (pref ptr :ATSFlatDataFontSpecRawNameData.fontNameLength)
            (pref ptr :ATSFlatDataFontSpecRawNameData.fontNameScript)))
    (%get-unsigned-long id)))

;;; ATSUFontIDToFond
;;;
;;; The function ATSUFontIDtoFOND is not recommended for use.
;;; Instead, use the Font Manager functions that translate FMFont
;;; values, which are equivalent to ATSUFontID values, to font
;;; family numbers. Font family numbers were used by QuickDraw to
;;; represent fonts to the Font Manager. Some of these fonts, even
;;; if compatible with ATSUI, may not have font IDs. 
;;;
;;; bah! FMFont = ATSUFontID ??
;;; FMFontFamily = FOND id ??
;;; FMGetFontFromFontFamilyInstance
;;; FMFontFamily [= FNum = FOND ?]  + FMFontStyle --> FMFont + FMFontStyle [intrinsic]



;; fmfont->ff ?
(defun atsu-font-id-to-ff (font-id)
  (rlet ((fond :signed-integer)
         (style :unsigned-byte))
    (when (eq #$noerr (#_ATSUFontIDToFond font-id fond style))  ;; or use #_FMGetFontFamilyInstanceFromFont ie fmfont->ff ?
      (+ (ash (%get-signed-word fond) 16)
         (ash (%get-byte style) 8)))))



(defun unpack-fixed-point (fixed)
  (+ (floor (ash fixed -16)) (/ (logand fixed #xffff) 65536.0)))

;; (parse-ustl (ccl::get-current-scrapref))



(defun paste-styled-utxt (w)
  (when (get-scrap-flavor-flags :|utxt|)
    (let* ((buff (fred-buffer w))
           (start (selection-range w))  ;; << was buffer-position
           (bold-it 0))
      (declare (fixnum bold-it start))
      (when (typep w 'listener-fred-item)
        (let ((old-ff (buffer-font-codes buff))) 
          (if (ff-bold-p old-ff)
            (setq bold-it (ash #$bold 8)))))
      (paste-utxt w)
      (if *paste-with-styles*
        (let ((runs (parse-ustl)))  ;; <<
          (dolist (run runs)
            (let* ((end (+ start (car run)))
                   (ff (car (cdr run)))
                   (ms (cdr (cdr run))))
              (declare (fixnum end ))
              (when (and (>= start 0)
                         (<= end (buffer-size buff))) 
                (buffer-set-font-codes buff (logior bold-it ff) ms start end)
                (setq start end)))))
        (when (neq bold-it 0)
          (multiple-value-bind (ff ms) (buffer-char-font-codes buff start)
            (buffer-set-font-codes buff (logior bold-it ff) ms start
                                   (buffer-position buff)))))
      ;(window-show-range w s (buffer-position buff))      
      (fred-update w))))

;; write it

(defmethod put-scrap-flavor ((type (eql :|ustl|)) style-vector &aux colors)
  (if (listp style-vector)
    (setq colors (cdr style-vector)
          style-vector (car style-vector)))
  (let ((font-count (aref style-vector 0))
        (index 1))
    (declare (fixnum font-count index))
    (%stack-block ((atsu-styles (* font-count #.(record-length :atsustyle))))
      ;; collect atsu style objects
      (dotimes (i font-count)
        (declare (fixnum i))
        (let* ((font (aref style-vector index))
               (size/style (aref style-vector (incf index)))
               (color (if colors
                        (aref colors (1+ i))
                        0)))
          
          (%put-ptr
           atsu-styles
           (style-ptr (find-atsu-style
                           (+ (ash (if (logbitp 15 font)        ; uint16 --> sint16
                                     (1- (- font #xFFFF))
                                     font) 
                                   16)
                              (ash (logand size/style #xFF) 8)
                              color)
                           (ash size/style -8)))
           (* i 4))
          (incf index)))
      (let* ((style-runs '())            ; list of '(cons font-index run-length)
             (index/offset (aref style-vector index))
             (font-index (ash index/offset -8))
             (offset (+ (ash (logand index/offset #xff) 16)
                        (aref style-vector (incf index)))))
        (declare (fixnum font-index offset vect-len) (dynamic-extent style-runs))
        (incf index)
        (loop
          (let* ((next-index/offset (aref style-vector index))
                 (next-offset (+ (ash (logand next-index/offset #xff) 16)
                                 (aref style-vector (incf index)))))
            (declare (fixnum next-offset))
            (push (cons font-index (- next-offset offset))
                  style-runs)
            #+ignore  ;; NO NO fails if offset > 16 bits
            (when (zerop next-index/offset)
              (return))
            (setq font-index (ash next-index/offset -8)
                  offset next-offset))
          (when (eq font-index 0)(return))  ;; << new
          (incf index))
        (setq style-runs (nreverse style-runs))
        (let ((run-count (length style-runs))
              (err #$noerr))
          (declare (fixnum run-count err))
          ;; runinfo is an array of :ATSUStyleRunInfo
          (%stack-block ((runinfo (* run-count #.(record-length :ATSUStyleRunInfo)))
                         (temp #.(record-length :pointer))
                         (size #.(record-length :bytecount)))
            (%setf-macptr temp runinfo)
            (dolist (run style-runs)
              (setf (pref temp :atsustyleruninfo.runlength)
                    (cdr run)
                    (pref temp :atsustyleruninfo.styleObjectIndex)
                    (1- (car run)))
              (%incf-ptr temp #.(record-length :ATSUStyleRunInfo)))
            ;; find the actual size of buffer required.
            (setq err (#_ATSUFlattenStyleRunsToStream
                       #$kATSUDataStreamUnicodeStyledText
                       #$kATSUFlattenOptionNoOptionsMask
                       run-count
                       runinfo
                       font-count
                       atsu-styles
                       0
                       (%null-ptr)
                       size))
            (if (eq err #$noerr)
              (let* ((data-size (%get-unsigned-long size))
                     (data (#_newptr :errchk data-size))
                     (scrap (ccl::get-current-scrapref)))
                (declare (fixnum data-size))
                (unwind-protect
                  (progn
                    (setq err (#_ATSUFlattenStyleRunsToStream
                               #$kATSUDataStreamUnicodeStyledText
                               #$kATSUFlattenOptionNoOptionsMask
                               run-count
                               runinfo
                               font-count
                               atsu-styles
                               data-size
                               data
                               size))
                    (if (eq err #$noerr)
                      ;; FIXIT error check?
                      (#_PutScrapFlavor scrap type 0 data-size data)
                      (error "#_ATSUFlattenStyleRunsToStream [2] err ~D" err)))
                  (#_disposeptr data)))
              (error "#_ATSUFlattenStyleRunsToStream [1] err ~D" err))))))))

;;;;;;  end copy and paste ustl

;; from font-fallback.lisp

#|
(defparameter *internal-font-type-list*
  '((#.#$smRoman
     (:sans-serif
      (0
       #x400                            ; "Lucida Grande"
       #x15                             ; "Helvetica"
       #x7D1                            ; "Arial"
       #x1C23                           ; "Verdana"
       #x124C                           ; "Helvetica Neue"
       #x12EE                           ; "Helvetica Neue Light"
       #x1250                           ; "Helvetica Neue UltraLight"
       #x7D0                            ; "Arial Narrow"
       #xBBF                            ; "Arial Rounded MT Bold"
       #x7D2                            ; "Charcoal"
       #x3FFF                           ; "Chicago"
       #x3                              ; "Geneva"
       #x8B0                            ; "Copperplate"
       #x976                            ; "Copperplate Light"
       #xFDD                            ; "Futura Condensed"
       #x7F8                            ; "Skia"
       #x18E8                           ; "Optima"
       #x1092                           ; "Gill Sans"
       #x1093                           ; "Gill Sans Light"
       #x455))                          ; "Trebuchet MS"
     (:serif
      (0
       #x14                            ; "Times"
       #x7DA                           ; "Times New Roman"
       #x10                            ; "Palatino"
       #x2                             ; "New York"
       #x7DD                           ; "Hoefler Text"
       #x2F8B                          ; "Georgia"
       #xBE4                           ; "American Typewriter"
       #xBE5                           ; "American Typewriter Condensed"
       #xBE6                           ; "American Typewriter Light"
       #xBE7                           ; "American Typewriter Condensed Light"
       #x3267                          ; "AppleGaramond Bk"
       #x3266                          ; "AppleGaramond Lt"
       #x978                           ; "Baskerville"
       #x9AA                           ; "Big Caslon"
       #x393B                          ; "Cochin"
       #x22D4                          ; "Didot"
       #x17                            ; "Symbol"
       ))
     (:fixed
      (0
       #x16           ; "Courier"
       #x7D5          ; "Courier New"
       #x1BBE         ; "Andale Mono"
       #x4            ; "Monaco"
       #x7F0D         ; "VT100"
       #x7D3          ; "Capitals"
       ))
     (:cursive
      (0
       #x907        ; "Apple Chancery"
       #xBC9        ; "Brush Script MT"
       #x1410       ; "Papyrus"
       #x282        ; "Zapfino"
       ))
     (:fun
      (0
       #x7D4            ; "Sand"
       #x11A1           ; "Comic Sans MS"
       #x903            ; "Gadget"
       #x7D6            ; "Techno"
       #x901            ; "Textile"
       #x1080           ; "Herculanum"
       #x7F7            ; "Impact"
       #x7E4            ; "Marker Felt"
       )))
    (#.#$smJapanese
     (:serif
      (0
       #x-380         ; "ÿqÿÿÿMÿmÿÿÿ© Pro W3"
       #x413C         ; "ÿÿÿÂÿÿÿ©"
       #x4118)         ; "ÿÿÿÂÿÿÿ© W3"
      (1 ;; bold
       #x-383))         ; "ÿqÿÿÿMÿmÿÿÿ© Pro W6"
     (:sans-serif
      (0
       #x-43DA    ; "ÿqÿÿÿMÿmÿpÿS Pro W3"
       #x4000    ; "Osaka"
       #x4119)    ; "ÿÿÿÂÿpÿSÿVÿbÿN W5"
      (1  ;; bold
       #x-43DD    ; "ÿqÿÿÿMÿmÿpÿS Pro W6"
       #x-2CF8))    ; "ÿqÿÿÿMÿmÿpÿS Std W8"
     (:fixed
      (0
       #x4034    ; "Osakaÿ|ÿÿÿÿ"
       #x4033))    ; "ÿÿÿÿÿÿÿ©"
     (:fun
      (0
       #x-73A2)))                       ; "ÿqÿÿÿMÿmÿóÿS Pro W4"
    (#.#$smTradChinese
     (:sans-serif
      (0 #x4310)                        ; "Apple LiGothic Medium"
      )
     (:serif
      (0
       #x4312                           ; "Apple LiSung Light"
       #x42BA                           ; "BiauKai"
       ))
     (:fixed
      (0 #x4200                         ; "Taipei"
       )))
    (#.#$smKorean
     (:serif
      (0
       #x4401    ; "AppleMyungjo"
       #x44B6    ; "#PCü’ç¦"
       #x449D    ; "#±ÌÿÿÌÿ"
       ))
     (:sans-serif
      (0
       #x4402    ; "AppleGothic"
       #x4400    ; "Seoul"
       ))
     (:fixed
      (0
       #x4402    ; "AppleGothic"
       ))
     #+ignore
     (:fun
      (0
       #x44A2    ; "#‚“µŒ¦—ËëA"
       ))
     (:fun
      (0
       #x44A3    ; "#‚æ±‰Ìÿ"
       )))
    
    (#.#$smCyrillic
     (:sans-serif
      (0
       #x4C24    ; "Helvetica CY"
       #x4C03    ; "Geneva CY"
       #x4C05    ; "Charcoal CY"
       ))
     (:serif
      (0
       #x4C54    ; "Times CY"
       ))
     (:fixed
      (0
       #x4C04    ; "Monaco CY"
       )))
    (#.#$smSimpChinese
     (:sans-serif
      (0
       #x7103    ; "Kai"
       #x7000    ; "Beijing"
       #x-301E    ; "È»ë€¼òíŒ"
       #x-2C44    ; "È»ë€èëíŒ"
       #x-6499    ; "È»ë€ìü¼ò"
       ))
     (:serif
      (0
       #x7101    ; "Song"
       #x7104    ; "Fang Song"
       #x-5764    ; "È»ë€áåèë"
       #x-4A1E    ; "È»ë€ÀÂíŒ"
       ))
     (:fixed
      (0
       #x7102    ; "Hei"
       )))
    (#.#$smCentralEuroRoman
     (:sans-serif
      (0
       #x7815    ; "Helvetica CE"
       #x7803    ; "Geneva CE"
       ))
     (:serif 
      (0
       #x7814    ; "Times CE"
       ))
     (:fixed
      (0
       #x7816    ; "Courier CE"
       #x7804    ; "Monaco CE"
       )))))
|#

#| ;; unused today
(defun buffer-find-font-in-script-with-fallback (buf script &optional (pos (buffer-position buf)))
  "ccl::buffer-find-font-in-script with font-fallback."
  (let ((cpos pos)
        cff)
    (block find-font
      (loop
        (setq cff (ccl::buffer-char-font-codes buf cpos))
        (when (eql script (ccl::ff-script cff))
          (return-from find-font))
        (unless (setq cpos (ccl::buffer-previous-font-change buf cpos))
          (return)))
      (setq cpos pos)
      (loop
        (unless (setq cpos (buffer-next-font-change buf cpos))
          (return))
        (setq cff (ccl::buffer-char-font-codes buf pos))
        (when (eql script (ccl::ff-script cff))
          (return-from find-font)))
      (setq cff nil))
    (multiple-value-bind (ff ms) (ccl::buffer-char-font-codes buf pos)
      (values
       (if cff
         (make-point (point-h ff)
                     (point-v cff))
         (find-fallback-font ff script))
       ms))))
|#

(defun font-id (font-name)
  (with-pstrs ((name font-name))
    (rlet ((num :integer 0))
      (#_getfnum name num)
      (%get-signed-word num))))

#|
(defun build-font-type-table ()
  (let ((result '()))
    (dolist (script '(#.#$smRoman #.#$smJapanese 
                      #.#$smTradChinese #.#$smKorean
                      #.#$smCyrillic #.#$smSimpChinese
                      #.#$smCentralEuroRoman))
      (let ((typed-fonts (cdr (assoc script *internal-font-type-list*)))
            (temp-result1 '()))
        (dolist (type '(:serif :sans-serif :fixed
                        :cursive :fun))
          (let ((styled-fonts (cdr (assoc type typed-fonts)))
                (temp-result2 '()))
            (when styled-fonts
              (dolist (fonts styled-fonts)
                (let ((style (car fonts))
                      (fonts (cdr fonts)))
                  (dolist (font fonts)
                    (when (member font *font-list* :key #'third)
                      (push (cons style font)
                            temp-result2)
                      (return))))))
            (push (cons type temp-result2)
                  temp-result1)))
        (push (cons script temp-result1)
              result)))
    (nreverse result)))
|#

;; FIXIT
#|
(defvar *font-type-table* (build-font-type-table))
|#

#|
(defparameter *font-type-list*
  '((#x2F2D . (:SANS-SERIF . 1))        ; "Arial Black"
    (#xFDC . (:SANS-SERIF . 1))         ; "Futura"
    (#x1319 . (:SANS-SERIF . 1))        ; "Helvetica Neue Black Condensed"
    (#x124D . (:SANS-SERIF . 1))        ; "Helvetica Neue Bold Condensed"
    (#x103A . (:SANS-SERIF . 1))        ; "Optima ExtraBlack"
    (#x400 . (:SANS-SERIF . 0))         ; "Lucida Grande"
    (#x15 . (:SANS-SERIF . 0))          ; "Helvetica"
    (#x7D1 . (:SANS-SERIF . 0))         ; "Arial"
    (#x1C23 . (:SANS-SERIF . 0))        ; "Verdana"
    (#x124C . (:SANS-SERIF . 0))        ; "Helvetica Neue"
    (#x12EE . (:SANS-SERIF . 0))        ; "Helvetica Neue Light"
    (#x1250 . (:SANS-SERIF . 0))        ; "Helvetica Neue UltraLight"
    (#x7D0 . (:SANS-SERIF . 0))         ; "Arial Narrow"
    (#xBBF . (:SANS-SERIF . 1))         ; "Arial Rounded MT Bold"
    (#x7D2 . (:SANS-SERIF . 0))         ; "Charcoal"
    (#x3FFF . (:SANS-SERIF . 0))        ; "Chicago"
    (#x3 . (:SANS-SERIF . 0))           ; "Geneva"
    (#x8B0 . (:SANS-SERIF . 0))         ; "Copperplate"
    (#x976 . (:SANS-SERIF . 0))         ; "Copperplate Light"
    (#xFDD . (:SANS-SERIF . 0))         ; "Futura Condensed"
    (#x7F8 . (:SANS-SERIF . 0))         ; "Skia"
    (#x18E8 . (:SANS-SERIF . 0))        ; "Optima"
    (#x1092 . (:SANS-SERIF . 0))        ; "Gill Sans"
    (#x1093 . (:SANS-SERIF . 0))        ; "Gill Sans Light"
    (#x455 . (:SANS-SERIF . 0))         ; "Trebuchet MS"
    (#x3785 . (:DINGBATS . 0))          ; "Webdings"
    (#x4D4 . (:DINGBATS . 0))           ; "Zapf Dingbats"
    (#x9D3 . (:DINGBATS . 0))           ; "MT Extra"
    (#x7E2 . (:DINGBATS . 0))           ; "Hoefler Text Ornaments"
    (#x100 . (:DINGBATS . 0))           ; "Dingbats"
    (#xFE1 . (:DINGBATS . 0))           ; "Footnote"
    (#x14 . (:SERIF . 0))               ; "Times"
    (#x7DA . (:SERIF . 0))              ; "Times New Roman"
    (#x10 . (:SERIF . 0))               ; "Palatino"
    (#x2 . (:SERIF . 0))                ; "New York"
    (#x7DD . (:SERIF . 0))              ; "Hoefler Text"
    (#x2F8B . (:SERIF . 0))             ; "Georgia"
    (#xBE4 . (:SERIF . 0))              ; "American Typewriter"
    (#xBE5 . (:SERIF . 0))              ; "American Typewriter Condensed"
    (#xBE6 . (:SERIF . 0))              ; "American Typewriter Light"
    (#xBE7 . (:SERIF . 0))              ; "American Typewriter Condensed Light"
    (#x3267 . (:SERIF . 0))             ; "AppleGaramond Bk"
    (#x3266 . (:SERIF . 0))             ; "AppleGaramond Lt"
    (#x3268 . (:SERIF . 1))             ; "AppleGaramond Bd"
    (#x979 . (:SERIF . 1))              ; "Baskerville Semibold"
    (#x3264 . (:SERIF . 2))             ; "AppleGaramond BkIt"
    (#x3263 . (:SERIF . 2))             ; "AppleGaramond LtIt"
    (#x3265 . (:SERIF . 3))             ; "AppleGaramond BdIt"
    (#x978 . (:SERIF . 0))              ; "Baskerville"
    (#x9AA . (:SERIF . 0))              ; "Big Caslon"
    (#x393B . (:SERIF . 0))             ; "Cochin"
    (#x22D4 . (:SERIF . 0))             ; "Didot"
    (#x17 . (:SERIF . 0))               ; "Symbol"
    (#x16 . (:FIXED . 0))               ; "Courier"
    (#x7D5 . (:FIXED . 0))              ; "Courier New"
    (#x1BBE . (:FIXED . 0))             ; "Andale Mono"
    (#x4 . (:FIXED . 0))                ; "Monaco"
    (#x7F0D . (:FIXED . 0))             ; "VT100"
    (#x7D3 . (:FIXED . 0))              ; "Capitals"
    (#x907 . (:CURSIVE . 0))            ; "Apple Chancery"
    (#xBC9 . (:CURSIVE . 0))            ; "Brush Script MT"
    (#x1410 . (:CURSIVE . 0))           ; "Papyrus"
    (#x282 . (:CURSIVE . 0))            ; "Zapfino"
    (#x7D4 . (:FUN . 0))                ; "Sand"
    (#x11A1 . (:FUN . 0))               ; "Comic Sans MS"
    (#x903 . (:FUN . 0))                ; "Gadget"
    (#x7D6 . (:FUN . 0))                ; "Techno"
    (#x901 . (:FUN . 0))                ; "Textile"
    (#x1080 . (:FUN . 0))               ; "Herculanum"
    (#x7F7 . (:FUN . 0))                ; "Impact"
    (#x7E4 . (:FUN . 0))                ; "Marker Felt"
    (#x-380 . (:SERIF . 0))             ; "ƒqƒ‰ƒMƒm–¾’© Pro W3"
    (#x413C . (:SERIF . 0))             ; "•½¬–¾’©"
    (#x4118 . (:SERIF . 0))             ; "•½¬–¾’© W3"
    (#x-383 . (:SERIF . 1))             ; "ƒqƒ‰ƒMƒm–¾’© Pro W6"
    (#x-43DA . (:SANS-SERIF . 0))       ; "ƒqƒ‰ƒMƒmŠpƒS Pro W3"
    (#x4000 . (:SANS-SERIF . 0))        ; "Osaka"
    (#x4119 . (:SANS-SERIF . 0))        ; "•½¬ŠpƒSƒVƒbƒN W5"
    (#x-43DD . (:SANS-SERIF . 1))       ; "ƒqƒ‰ƒMƒmŠpƒS Pro W6"
    (#x-2CF8 . (:SANS-SERIF . 1))       ; "ƒqƒ‰ƒMƒmŠpƒS Std W8"
    (#x4034 . (:FIXED . 0))             ; "Osaka|“™•"
    (#x4033 . (:FIXED . 0))             ; "“™•–¾’©"
    (#x-73A2 . (:FUN . 0))              ; "ƒqƒ‰ƒMƒmŠÛƒS Pro W4"
    (#x4310 . (:SANS-SERIF . 0))        ; "Apple LiGothic Medium"
    (#x4312 . (:SERIF . 0))             ; "Apple LiSung Light"
    (#x42BA . (:SERIF . 0))             ; "BiauKai"
    (#x4200 . (:FIXED . 0))             ; "Taipei"
    (#x4401 . (:SERIF . 0))             ; "AppleMyungjo"
    (#x44B6 . (:SERIF . 0))             ; "#PC¸íÁ¶"
    (#x449D . (:SERIF . 0))             ; "#±Ã¼­Ã¼"
    (#x4402 . (:SANS-SERIF . 0))        ; "AppleGothic"
    (#x4400 . (:SANS-SERIF . 0))        ; "Seoul"
    (#x44A3 . (:CURSIVE . 0))           ; "#ÇÊ±âÃ¼"
    (#x44A2 . (:SANS-SERIF . 1))               ; "#Çìµå¶óÀÎA"
    (#x4C24 . (:SANS-SERIF . 0))        ; "Helvetica CY"
    (#x4C03 . (:SANS-SERIF . 0))        ; "Geneva CY"
    (#x4C05 . (:SANS-SERIF . 0))        ; "Charcoal CY"
    (#x4C54 . (:SERIF . 0))             ; "Times CY"
    (#x4C04 . (:FIXED . 0))             ; "Monaco CY"
    (#x7103 . (:SANS-SERIF . 0))        ; "Kai"
    (#x7000 . (:SANS-SERIF . 0))        ; "Beijing"
    (#x-301E . (:SANS-SERIF . 0))       ; "»ªÎÄºÚÌå"
    (#x-2C44 . (:SANS-SERIF . 0))       ; "»ªÎÄËÎÌå"
    (#x-6499 . (:SANS-SERIF . 0))       ; "»ªÎÄÏ¸ºÚ"
    (#x7101 . (:SERIF . 0))             ; "Song"
    (#x7104 . (:SERIF . 0))             ; "Fang Song"
    (#x-5764 . (:SERIF . 0))            ; "»ªÎÄ·ÂËÎ"
    (#x-4A1E . (:SERIF . 0))            ; "»ªÎÄ¿¬Ìå"
    (#x7102 . (:FIXED . 0))             ; "Hei"
    (#x7816 . (:FIXED . 0))             ; "Courier CE"
    (#x7804 . (:FIXED . 0))             ; "Monaco CE"
    (#x7815 . (:SANS-SERIF . 0))        ; "Helvetica CE"
    (#x7803 . (:SANS-SERIF . 0))        ; "Geneva CE"
    (#x7814 . (:SERIF . 0))             ; "Times CE"
    ))
|#
     

#|
(defun ff-font-type (ff-code)
  ":serif :sans-serif :fixed :cursive :fun"
  (let ((result (cdr (assoc (ash ff-code -16) *font-type-list*))))
    (if result
      (values (car result)
              (logior (ldb #.(byte 8 8) ff-code)
                      (cdr result)))
      ;; FIXIT
      (values :sans-serif 0))))
|#

#+ignore
(defun find-fallback-font (ff script)
  (multiple-value-bind (type style)
                       (ff-font-type ff)
    (multiple-value-bind (font-id found-style)
                         (%find-font-with-type script type style)
      (if font-id
        (logior (ash font-id 16)
                (ash (logandc1 found-style style) 8)
                (logand #xFF ff))
        ;; FIXIT
        (let ((font-id (script-to-font-simple script)))
          (logior (ash font-id 16)
                  (logand #xFFFF ff)))))))

#|
(defun %find-font-with-type (script type style)
  (let ((fonts (cdr (assoc type
                           (cdr (assoc script *font-type-table*))))))
    (when fonts
      (let ((font (assoc style fonts)))
        (if font
          (values (cdr font)
                  style)
          (let ((found-style 0))
            (dolist (font fonts)
              (setq found-style
                    (max found-style (logand style (car font)))))
            (values (cdr (assoc found-style fonts))
                    found-style)))))))
|#

;;;
;;; converter
;;;

#|
(defclass converter ()
  ((ptr :initform nil :reader converter-ptr)
   (input-text-encoding :initarg :input-text-encoding :reader input-text-encoding)
   (output-text-encoding :initarg :output-text-encoding :reader output-text-encoding)
   (lock :initform (make-lock) :reader converter-lock))
  (:default-initargs
    :input-text-encoding nil
    :output-text-encoding nil))

(defmethod initialize-instance :after ((converter converter)
                                       &key
                                       input-text-encoding
                                       output-text-encoding)
  (unless (and input-text-encoding
               output-text-encoding)
    (error "You must provide both source and destination text-encoding objects
to create text encoding converter."))
  (initialize-converter converter)
  (terminate-when-unreachable converter))

(defun %create-converter (input-encoding output-encoding)
  (rlet ((out :pointer))
    (let ((err (#_TECCreateConverter
                out
                input-encoding
                output-encoding)))
      (unless (zerop err)
        (error 'create-converter-error
               :error-code err
               :trap-name "#_TECCreateConverter"
               :input-encoding input-encoding
               :output-encoding output-encoding)))
    (%get-ptr out)))

(defmethod initialize-converter ((converter converter))
  (with-lock-grabbed ((converter-lock converter))
    (when (converter-ptr converter)
      (dispose-converter converter))
    (setf (slot-value converter 'ptr)
          (%create-converter (input-text-encoding converter)
                             (output-text-encoding converter)))
    converter))

(defmethod dispose-converter ((converter converter))
  (with-lock-grabbed ((converter-lock converter))
    (when (converter-ptr converter)
      (prog1
        (#_tecdisposeconverter (converter-ptr converter))
        (setf (slot-value converter 'ptr) nil)))))

(defmethod terminate ((converter converter))
  (dispose-converter converter))

#+keke
(defmethod u:discard ((converter converter))
  (dispose-converter converter))

(defun create-converter (input-encoding output-encoding)
  "create and returns tec:converter May signal TEC:CREATE-CONVERTER-ERROR."
  (make-instance 'converter
    :input-text-encoding input-encoding
    :output-text-encoding output-encoding))


;;;
;;; 2003-06-18
;;; find-converter
;;;
;;; FIXIT
;;;
;;; * is hash-table apropriate here?


(ccl::defloadvar *converters* (make-hash-table))
(defvar *+converter-table-lock+* (make-lock))

(defun find-converter (input-encoding output-encoding)
  "search and returns tec:converter suitable for converting
string from input-encoding to output-encoding. If search
fails it creates a new conveter object and returns it.

Arguments:

* input-encoding/output-encoding:

  text-encoding created by tec:create-text-encoding."
  (with-lock-grabbed (*+converter-table-lock+*)
    (let* ((converters (gethash input-encoding *converters*))
           (converter (when converters
                        (find output-encoding converters 
                              :key #'output-text-encoding))))
      (if converter
        (if (converter-ptr converter) ;; might be disposed
          converter
          (initialize-converter converter))
        (let ((new-converter (create-converter input-encoding output-encoding)))
          (setf (gethash input-encoding *converters*)
                (if converters
                  (push new-converter converters)
                  (list new-converter)))
          new-converter)))))

; (defmethod drop-converter (converter)
;   (with-lock-grabbed (*+converter-table-lock+*)
;     (let* ((input-encoding (input-text-encoding converter))
;            (output-encoding (output-text-encoding converter))
;            (converters (gethash input-encoding *converters*))
;            (conv (when converters
;                    (find output-encoding converters 
;                          :key #'output-text-encoding))))
;       (when conv
;         (setf (gethash input-encoding *converters*)
;               (remove conv converters))
;         t))))
  

;; good enough?
(defun clear-converter-cache ()
  (with-lock-grabbed (*+converter-table-lock+*)
    (maphash #'(lambda (key value)
                 (declare (ignore key))
                 (mapc #'dispose-converter value))
             *converters*)
    (clrhash *converters*)))


;;;
;;; clear-converter-context
;;;


;; 2003-03-27 Do I really need this?
(defmethod clear-converter-context ((converter converter))
  (when (converter-ptr converter)
    (#_TECClearConverterContextInfo (converter-ptr converter))))

;;;
;;; call-with-converted-string
;;;

(defun %convert (converter-ptr in-string in-size out-buffer buffer-size)
  (declare (fixnum in-size buffer-size))
  (rlet ((actual-input-len :uint32)
         (actual-output-len :uint32))
    (values (the fixnum (#_TECConvertText
                         converter-ptr
                         in-string
                         in-size
                         actual-input-len
                         out-buffer
                         buffer-size
                         actual-output-len))
            (%get-long actual-output-len)
            (%get-long actual-input-len))))

(defun %flush (converter-ptr buffer buffer-size)
  (rlet ((actual-output-len :uint32))
    (values (the fixnum (#_tecflushtext
                         converter-ptr
                         buffer
                         buffer-size
                         actual-output-len))
            (%get-long actual-output-len))))
|#

#|
(defparameter *warn-if-fallback* nil)  ;; nyi for t
(defparameter *default-buffer-size* #.(expt 2 10))
|#

#| ;; unused today
(defun call-with-converted-string (fn converter in-string in-string-size
                                      &optional buffer buffer-size)
  "
call-with-converted-string calls the function fn with
converted str. The function is called as many times as
necessary until all in-string is converted.

Arguments:

* fn: fn is a function of two arguments; converted str
      [macptr] and size.
* converter: converter must be an instance of
             tec:converter. See tec:find-converter.

* in-string: a mactpr to a source string.
* in-string-size: a size of the in-string [in 8bit bytes]."
  (declare (fixnum in-string-size))
  (with-lock-grabbed ((converter-lock converter))
    (let* ((converter-ptr (converter-ptr converter))
           (buffer-supplied-p buffer)
           ;; control can be transfered from fn. if that happens, we
           ;; need to flush converter for next use.
           (may-need-flush-p t))
      (unless buffer-supplied-p
        (setq buffer-size (max 8 (or buffer-size *default-buffer-size*))
              buffer (#_newptr buffer-size))
        (when (%null-ptr-p buffer)
          #+keke
          (cnd:memfull-trap-error "NewPtr"
                                  (format nil "NewPtr(~A) failed." buffer-size))
          #-keke
          (error "NewPtr(~A) failed." buffer-size)))
      (unwind-protect
        (progn
          (loop
            (multiple-value-bind (err length input-done-size)
                                 (%convert converter-ptr in-string in-string-size
                                           buffer buffer-size)
              (declare (fixnum err length input-done-size))
              (case err
                ((#.#$noerr #.#$kTECOutputBufferFullStatus
                  #.#$kTECUsedFallbacksStatus)
                 (when (and (= err #.#$kTECUsedFallbacksStatus)
                            *warn-if-fallback*)
                   (warn 'convert-text-fallbacks-warning
                         :trap-name "TECConvertText"))
                 (funcall fn buffer length))
                (t 
                 (error 'convert-text-error
                        :error-code err
                        :converter converter)))
              (if (< input-done-size in-string-size)
                (progn
                  (setq in-string (%inc-ptr in-string input-done-size))
                  (setq in-string-size (- in-string-size input-done-size)))
                (return))))
          (loop
            (multiple-value-bind (err length)
                                 (%flush converter-ptr buffer buffer-size)
              (declare (fixnum err length))
              (case err
                ((#.#$noerr #.#$kTECOutputBufferFullStatus
                  #.#$kTECUsedFallbacksStatus)
                 (when (and (= err #.#$kTECUsedFallbacksStatus)
                            *warn-if-fallback*)
                   (warn 'convert-text-fallbacks-warning
                         :trap-name "TECConvertText"))
                 (when (plusp length)       ; could it be negative?
                   (funcall fn buffer length))
                 (unless (= err #.#$kTECOutputBufferFullStatus)
                   (setq may-need-flush-p nil)
                   (return)))
                (t 
                 (error 'convert-text-error
                        :trap-name "TECFlushText"
                        :error-code err
                        :converter converter))))))
        (progn
          (when may-need-flush-p
            (loop 
              (when (zerop (%flush converter-ptr buffer buffer-size))
                (return))))
          (unless buffer-supplied-p
            (#_disposeptr buffer))
          (clear-converter-context converter))))))
|#


#|

(defparameter *con*
  (create-converter #$kTextEncodingISO_2022_JP
                    #$kTextEncodingMacJapanese))

(let ((string "$B?M4V$N4i$=$C$/$j$N!\"Gv5$L#0-$$%9%W%j%s%/%i!<$@!#(J"))
    (with-cstrs ((str string))
      (call-with-converted-string #'(lambda (str size)
                                      (print (ccl::%str-from-ptr str size)))
                                  *con*
                                  str
                                  (length string))))

(block foo
  (let ((string "$B?M4V$N4i$=$C$/$j$N!\"Gv5$L#0-$$%9%W%j%s%/%i!<$@!#(J"))
    (with-cstrs ((str string))
      (call-with-converted-string #'(lambda (str size)
                                      (return-from foo (ccl::%str-from-ptr str size)))
                                  *con*
                                  str
                                  (length string)
                                  nil
                                  10
                                  ))))


(progn (dispose-converter *con*)
       (setq *con* nil))

|#

;; from encoding-table.lisp

#+ignore
(defparameter *encodings-alist*
  (list (cons :utf-8
              (cons #.(create-text-encoding #.#$kTextEncodingUnicodeDefault
                                              :format #.#$kUnicodeUTF8Format)
                    nil))
        (cons :utf-16
              (cons #.(create-text-encoding #.#$kTextEncodingUnicodeDefault
                                              :format #.#$kUnicode16bitFormat)
                    nil))
        
        #+ignore
        (cons :utf-32
              (cons (tec:create-text-encoding #.#$kTextEncodingUnicodeDefault
                                              :format #.#$kUnicode32bitFormat)
                    nil))
        (cons :latin-1 (cons #.#$kTextEncodingISOLatin1 0))
        (cons :iso-2022-jp (cons #.#$kTextEncodingISO_2022_JP 1))
        (cons :euc-jp (cons #.#$kTextEncodingEUC_JP 1))
        (cons :euc-tw (cons #.#$kTextEncodingEUC_TW 2))
        (cons :big-5 (cons #.#$kTextEncodingBig5 2))
        (cons :iso-2022-kr (cons #.#$kTextEncodingISO_2022_KR 3))
        (cons :euc-kr (cons #.#$kTextEncodingEUC_KR 3))
        (cons :iso-8859-5 (cons #.#$kTextEncodingISOLatinCyrillic
                                #.#$kTextEncodingMacCyrillic))
        (cons :koi-8 (cons #.#$kTextEncodingKOI8_R 
                           #.#$kTextEncodingMacCyrillic))
        (cons :euc-cn (cons #.#$kTextEncodingEUC_CN
                            #.#$kTextEncodingMacSimpChinese))
        (cons :iso-2022-cn (cons #.#$kTextEncodingISO_2022_CN
                                 #.#$kTextEncodingMacSimpChinese))
        (cons :latin-2 (cons #.#$kTextEncodingISOLatin2 
                             #.#$kTextEncodingMacCentralEurRoman))
        (cons :latin-4 (cons #.#$kTextEncodingISOLatin4 
                             #.#$kTextEncodingMacCentralEurRoman))
        (cons :gb-18030 (cons #.#$kTextEncodingGB_18030_2000
                              #.#$kTextEncodingMacSimpChinese))))


#|
(defmethod keyword-to-encoding (keyword)
  (car (cdr (assoc keyword *encodings-alist*))))

;; (keyword-to-encoding :utf-16)
;; (keyword-to-encoding :iso-2022-jp)

(defmethod encoding-to-keyword (encoding)
  (car (rassoc encoding *encodings-alist* :key #'car)))
|#

;; (encoding-to-keyword #$kTextEncodingISO_2022_JP)
;; (encoding-to-keyword (keyword-to-encoding :utf-16))

#|
;; not used

(defmethod mac-encoding (encoding)
  (cdr (cdr (rassoc encoding *encodings-alist* :key #'car))))

;; (mac-encoding #$kTextEncodingISO_2022_JP)

|#

#|
(defmethod keyword-to-mac-encoding (keyword)
  (cdr (cdr (assoc keyword *encodings-alist*))))

;; (keyword-to-mac-encoding :koi-8)
|#

;; -----------------



;; dont even think about fontruns
(defun %buffer-write-utf-file (fred-buffer name external-format)
  (with-fsopen-file-no-error-on-close (pb name t)
    (handler-bind ((error #'(lambda (c)
                              (fsclose pb nil)
                              (signal c))))
      (fix-pb-for-writing pb name)
      (let* ((file-buf-pos 0)
             file-buf
             another-buf
             chunk-buffer
             (file-buf-size (* 2 (bf.chunksz (mark-buffer fred-buffer))))
             (to-encoding))
        (unwind-protect
          (progn
            (setq chunk-buffer (get-chunk-buffer file-buf-size)
                  file-buf (car chunk-buffer)
                  another-buf (third chunk-buffer))          
            (cond ((eq external-format :utf-16)
                   (%put-word file-buf #xFEFF)
                   (setq file-buf-pos 2)
                   (setq to-encoding #$kcfstringencodingunicode))
                  ((eq external-format :utf-8)
                   (%put-word file-buf #xEFBB)
                   (%put-byte file-buf #xBF 2)
                   (setq file-buf-pos 3)
                   (setq to-encoding #$kCFStringEncodingUTF8))          
                  (t (error "phooey")))
            (fswrite pb file-buf-pos file-buf)
            (let ((start 0)
                  (end (buffer-size fred-buffer)))
              (buffer-write-utf-encoded pb fred-buffer start end file-buf file-buf-size to-encoding another-buf)))
          (when chunk-buffer (free-chunk-buffer chunk-buffer))
          )))))

;; fixit so new file length is correct if file previously existed - UGH
(defun fix-pb-for-writing (pb name)
  (setf (pref pb :FSForkIOParam.positionOffset.hi) 0
        (pref pb :FSForkIOParam.positionOffset.lo) 0)
  (setf (pref pb :FSForkIOParam.permissions) #$fswrperm)
  (setf (pref pb :FSForkIOParam.positionMode) #$fsFromStart) ;;?? did this already
  (file-errchk (#_PBSetForkSizeSync pb) name)  ;; huh
  (file-errchk (#_PBSetForkPositionSync pb) name))

;; NIL if broke, T if OK
#|
(defun check-fontruns (buffer)
  (handler-bind ((error 
                  #'(lambda (c)
                      ;(print (list 'fontruns-wrong c))
                      (report-condition c t)
                      (return-from check-fontruns nil))))
    (map-fontruns #'(lambda (a b c d)(declare (ignore a b c d))) buffer))
  t) 
|#



(defun %buffer-write-mac-encoded-file (fred-buffer name) 
  (let ((encoding-runs (buffer-get-scriptruns-slow fred-buffer)))
    ;; simpler if this error is detected before opening the file
    (dotimes (i (1- (length encoding-runs)))
      (let ((thing (aref encoding-runs i)))
        (when (eq #xff (ash thing -24))
          (error "No Mac encoding exists for some content"))))
    (with-fsopen-file-no-error-on-close (pb name t)
      (handler-bind ((error #'(lambda (c)
                                (fsclose pb nil)
                                (signal c))))
        (fix-pb-for-writing pb name)
        (let* (file-buf
               another-buf
               chunk-buffer
               (file-buf-size (* 2 (bf.chunksz (mark-buffer fred-buffer)))))
          (unwind-protect
            (progn
              (setq chunk-buffer (get-chunk-buffer file-buf-size)
                    file-buf (car chunk-buffer)
                    another-buf (third chunk-buffer))
              (dotimes (i (1- (length encoding-runs)))
                (let* ((thing (aref encoding-runs i))
                       (encoding (ash thing -24))
                       (start (logand thing #xffffff))
                       (end (logand (aref encoding-runs (1+ i)) #xffffff)))
                  (buffer-write-mac-encoding-run pb fred-buffer encoding start end 
                                                 file-buf file-buf-size another-buf)))) 
            (when chunk-buffer (free-chunk-buffer chunk-buffer))))))    
    encoding-runs  ;; return it
    ))

(defun buffer-write-mac-encoding-run (pb fred-buffer to-encoding start end file-buf file-buf-size another-buf)
  (declare (fixnum start end))
  (let ((from-encoding #$kcfstringencodingunicode))
    (if (eq to-encoding #xff) (error "no Mac encoding exists for some characters in the buffer."))
    (progn ;%stack-block ((from-buffer file-buf-size)) ;; big enuf
      (while (< start end)
        (let* ((nchars (min (- end start)(ash file-buf-size -2)))
               (from-len (buffer-chars-to-temp-buffer fred-buffer start (+ start nchars) another-buf)))
          (let* ((to-len (convert-temp-buffer-to-mac another-buf from-len from-encoding file-buf file-buf-size  to-encoding)))              
            (fswrite pb to-len file-buf)            
            (setq start (+ start nchars))))))))


;; start and end are character positions
(defun buffer-write-utf-encoded (pb fred-buffer  start end file-buf file-buf-size to-encoding another-buf)
  (declare (fixnum start end))
  (let ((from-encoding #$kcfstringencodingunicode))
    (progn ;%stack-block ((from-buffer file-buf-size)) ;; big enuf
      (while (< start end)
        (let* ((nchars (min (- end start)(ash file-buf-size -2)))  ;; or -1 ??
               (from-len (buffer-chars-to-temp-buffer fred-buffer start (+ start nchars) another-buf))
               to-len)
         (if (eq to-encoding #$kcfstringencodingunicode)
           (setq file-buf another-buf
                 to-len from-len)
           (progn
             (setq to-len (convert-temp-buffer another-buf from-len from-encoding file-buf file-buf-size  to-encoding))))
         (fswrite pb to-len file-buf)            
         (setq start (+ start nchars)))))))



;; from buf contains utf16 today
;; to-buf gets utf-16 or utf-8
;; returns number of bytes in to-buf



(defun convert-temp-buffer (from-buf from-length from-encoding
                                     to-buf to-length to-encoding)
  (when (neq from-encoding #$kcfstringencodingunicode) (error "phooey"))
  (cond 
   ((eql from-encoding to-encoding)  ;; usual case - well if to-enc is utf16
    (#_blockmovedata from-buf to-buf from-length) ;; silly - not called in this case
    from-length)
   (t 
    (let ((loss-byte #xff)
          (uni-len (ash from-length -1)))
      (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) from-buf uni-len)))
        (unwind-protect
          (rlet ((used-len :signed-long)) ;; signed??
            (cond ((eql to-encoding #$kCFStringEncodingUTF8)
                   (cfstringgetbytes cfstr 0 uni-len to-encoding loss-byte nil (%null-ptr) 0 used-len)
                   (let* ((to-len (%get-signed-long used-len)))
                     (when (> to-len to-length)(error "phooey"))
                     (CFStringGetBytes cfstr 0 uni-len to-encoding loss-byte nil to-buf to-len used-len)
                     to-len))
                  (t (error "phooey"))))
          (#_cfrelease cfstr)))))))

;; this isn't done yet - sort out bytes vs chars and buffer sizes
;; from-encoding always utf-16 today
(defun convert-temp-buffer-to-mac (from-buf from-length from-encoding
                                            to-buf to-length to-encoding)
  ;; from-length is bytes
  (when (neq from-encoding #$kcfstringencodingunicode)(error "confused"))
  (let ((from-chars (ash from-length -1)))
    (rlet ((used-len :signed-long))
      (let ((loss-byte #xff))
        (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) from-buf from-chars)))
          (when (%null-ptr-p cfstr)(error "#_CFStringCreateWithCharacters failed"))
          (let ()                                   
            (CFStringGetBytes cfstr 0 from-chars to-encoding loss-byte nil to-buf to-length used-len)
            (#_cfrelease cfstr)
            (%get-signed-long used-len)))))))



;; now assume utf-16 buffer
(defun buffer-chars-to-temp-buffer (mark start end to-buf) ;; assume to-buf at least twice as big as (- end start)
  (locally (declare (fixnum start end)(optimize (speed 3)(safety 0)))
    (let* ((buf (mark.buffer mark))
           (gappos (bf.gappos buf))
           ;(type (bf-chartype buf))
           (shft (bf.logsiz buf))
           (chunkarr (bf.chunkarr buf))
           (gaplen (%i- (bf.gapend buf)(bf.gapstart buf)))
           (chunksz (bf.chunksz buf))
           (chars-left (- end start))
           ;(spos 0)
           (buf-pos 0)
           (nchars 0)
           (sidx 0)
           cross)
      (declare (fixnum  gappos chunksz mask spos chars-left gaplen sidx nchars buf-pos))      
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
        (let ((chunk-str (svref chunkarr sidx))) 
          (%copy-ivector-to-ptr chunk-str (%i+ start start) to-buf buf-pos (%i+ nchars nchars))
          (setq buf-pos (+ buf-pos nchars nchars)))
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
               (setq sidx (1+ sidx)))))
      buf-pos)))

#+ignore ;; unused
(defun map-fontruns (function mark)
  (let* ((buf (mark-buffer mark))
         (fontruns (bf.fontruns buf))
         (afonts (bf.afonts buf))
         (bfonts (bf.bfonts buf))
         (gaplen (- (bf.gapend buf)(bf.gapstart buf)))
         (len (length fontruns))
         (first-a (- len afonts)))
    (declare (fixnum bfonts afonts len first-a))
    (DOTIMES (i bfonts)
      (declare (fixnum i))
      (let ((font (fontruns-font fontruns i))
            (pos (fontruns-pos fontruns i))                   
            (end (if (= i (1- bfonts))                   
                   (if (eq 0 afonts)(buffer-size mark)
                       (- (fontruns-pos fontruns first-a) gaplen))
                   (fontruns-pos fontruns (%i+ 1 i)))))        
        (multiple-value-bind (ff ms)(buffer-font-index-codes mark (1+ font))
          (when  (< end pos)(error "Fontruns wrong: pos ~S end ~S" pos end))
          (funcall function ff ms pos end))))
    (dotimes (i afonts)
      (declare (fixnum i))
      (let* ((idx (+ first-a i))
             (font (fontruns-font fontruns idx))
             (pos (- (fontruns-pos fontruns idx) gaplen))
             (end (if (= i (1- afonts))
                    (buffer-size mark)
                    (- (fontruns-pos fontruns (%i+ 1 idx)) gaplen))))
        (declare (fixnum idx))        
        (multiple-value-bind (ff ms)(buffer-font-index-codes mark (1+ font))
          (when (< end pos)(error "Fontruns wrong: pos ~S end ~S" pos end))
          (funcall function ff ms pos end))))))


#|
(defun poop (ff ms pos end)(print (list (font-spec ff ms) pos end)))

(map-fontruns #'poop (fred-buffer (target)))

;; NIL if broke, T if OK
(defun check-fontruns (buffer)
  (handler-bind ((error 
                  #'(lambda (c)
                      ;(print (list 'fontruns-wrong c))
                      (report-condition c t)
                      (return-from check-fontruns nil))))
    (map-fontruns #'(lambda (a b c d)(declare (ignore a b c d))) buffer))
  t)
|#


