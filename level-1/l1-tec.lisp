;;;-*- Mode: Lisp; Package: CCL -*-

;;;________________________________________________________________________________
;;;
;;;  File:	tec.lisp
;;;  Date:	2002-01-21
;;;  Author:	Takehiko Abe <keke@gol.com>
;;;
;;;  Copyright 2002 Takehiko Abe <keke@gol.com>
;;;
;;;  Use and copying of this software and preparation of derivative works
;;;  based upon this software are permitted. The author makes no warranties
;;;  about the software or its performance.
;;;
;;;  --
;;;
;;;  * Please send your comment, improvement/bug report to keke@gol.com
;;;__________________________________________________________________________
;;;
;;; Defined here are tec:converter class, tec:convert-text and etc. They are
;;; wrappers for part of Text Encoding Converter functions of the Text Encoding
;;; Conversion Manager.
;;;
;;;

;;; Problem:
;;; Once #_TECConvertText fails, the converter is rendered unusable and there
;;; seems to be no way to clean it up. #_TECFlushText doesn't work nor does
;;; #_TECClearConverterContextInfo.
;;; 
;;; And calling #_TECDisposeConverter on the rotten converter results in
;;; #$kTECNeedFlushStatus .
;;; 
;;; Don't know what to do with #$kTECNeedFlushStatus.
;;;
;;; --> [2003-03-27] This no longer seem to be a problem in OSX.


(in-package :ccl)


#|
(defun create-text-encoding (base &key 
                                  (variant #$kTextEncodingDefaultVariant)
                                  (format #$kTextEncodingDefaultFormat))
  "create and returns text-encoding."
  (#_createtextencoding base variant format))
|#


#|
(create-text-encoding #$kTextEncodingMacJapanese
                      :variant #$kJapaneseNoOneByteKanaOption)

(create-text-encoding #$kTextEncodingMacJapanese
                      :variant #$kMacJapaneseStdNoVerticalsVariant)
|#


;;;
;;; count-destination-text-encodings and get-destination-text-encodings
;;;

#|
(defun count-destination-text-encodings (text-encoding)
  (rlet ((count :uint32))
    (#_TECCountDestinationTextEncodings         ; FIXIT error check
     text-encoding
     count)
    (%get-unsigned-long count)))

;;; (count-destination-text-encodings #$kTextEncodingISOLatin3)

(defun get-destination-text-encodings (text-encoding)
  (let ((max (count-destination-text-encodings text-encoding)))
    (declare (fixnum max))
    (%stack-block ((encodings (* max 4))
                   (actual-count 4))    ; uint32
      (#_TECGetDestinationTextEncodings         ; error check FIXIT
       text-encoding
       encodings
       max
       actual-count)
      (let ((result '()))
        (dotimes (c (%get-unsigned-long actual-count))
          (push (%get-unsigned-long encodings (* c 4))
                result))
        (nreverse result)))))
|#

#|
(get-destination-text-encodings #$kTextEncodingISOLatin5)

(mapcar #'text-encoding-name
        (get-destination-text-encodings #$kTextEncodingISOLatin5))

(mapcar #'text-encoding-name
        (get-destination-text-encodings #$kTextEncodingMacTurkish))

(mapcar #'text-encoding-name
        (get-destination-text-encodings #$kTextEncodingMacJapanese))

(mapcar #'text-encoding-name
        (get-destination-text-encodings #$kTextEncodingEUC_JP))
|#

;;;
;;; count-available-encodings and text-encoding-name
;;;

#|
(defun count-available-encodings ()
  "returns the number of available text encodings"
  (rlet ((count :long))
    (#_TECCountAvailableTextEncodings count)
    (%get-long count)))

;; (tec:version)
;; (tec:count-available-encodings)


(defun text-encoding-name (text-encoding &key (if-failed nil))
  "returns name of the text-encoding."
  (%stack-block ((text-ptr 40))
    (rlet ((outlen :uint32)
           (outregion :sint16)
           (encoding :textencoding))
      (let ((err (#_GetTextEncodingName
                  text-encoding
                  #$kTextEncodingFullName
                  0
                  0
                  40
                  outlen
                  outregion
                  encoding
                  text-ptr)))
        (declare (fixnum err))          ; sure?
        (if (zerop err)
          (with-output-to-string (str)
            (dotimes (i (%get-long outlen))
              (write-char (code-char (%get-byte text-ptr i))
                          str)))
          (ecase if-failed
            ((:error) (error 'tec-error
                             :error-code err
                             :trap-name "#_GetTextEncodingName"))
            ((nil) (values nil err))))))))
|#

;; (text-encoding-name #$kTextEncodingMultiRun :if-failed :error)

;;;
;;; do-available-encodings
;;;

#|
(defmacro do-available-encodings (var &body body)
  "executes the body once for every available text encodings with var bound
to a text encoding on each iteration."
  (let ((max (gensym "MAX"))
        (block (gensym "BLOCK"))
        (count (gensym "COUNT"))
        (c (gensym))
        (record-length (record-length :textencoding)))
    (declare (fixnum record-length))
    `(let ((,max (count-available-encodings))
           (,var 0))
       (declare (fixnum ,max ,var))
       (%stack-block ((,block (* ,record-length ,max)))
         (rlet ((,count :long))
           (require-trap #_TECGetAvailableTextEncodings ,block ,max ,count)
           (dotimes (,c (%get-long ,count))
             (declare (fixnum ,c))
             (setq ,var (%get-long ,block (* ,c ,record-length)))
             (progn
               ,@body)))))))
|#

#|
(let ((encs '()))
  (do-available-encodings enc
    (push (list (text-encoding-name enc)
                (#_gettextencodingbase enc)
                (#_gettextencodingvariant enc)
                (#_gettextencodingformat enc))
          encs)
    )
  (dolist (enc (sort encs #'> :key #'cadr))
    (print enc)))

|#

#|
(defun available-text-encoding-names ()
  (let ((names '())
        name)
    (do-available-encodings encoding
      (setq name (text-encoding-name encoding :if-failed nil))
      (when name
        (pushnew name names :test #'string=)))
    (nreverse names)))

(defun available-text-encodings ()
  (let ((encodings '()))
    (do-available-encodings enc
      (push enc encodings))
    (nreverse encodings)))

;; (available-text-encodings)
;; (available-text-encoding-names)


(defun count-subencodings (text-encoding)
  "returns the number of available text _sub_ encodings"
  (rlet ((count :long))
    (#_TECCountSubTextEncodings text-encoding count)
    (%get-long count)))

;; (count-subencodings #$kTextEncodingISO_2022_JP)

(defun get-subencodings (text-encoding)
  (let ((count (count-subencodings text-encoding))
        (result '()))
    (declare (fixnum count))
    (%stack-block ((encodings (* 4 count))
                   (actual-count 4))
      (#_TECGetSubTextEncodings
       text-encoding
       encodings
       count
       actual-count)
      (dotimes (i (%get-long actual-count))
        (declare (fixnum i))
        (push (%get-long encodings (* i 4))
              result)))
    (nreverse result)))

;; (get-subencodings #$kTextEncodingISO_2022_JP)

(let ((encodings '()))
  (defun encoding-available-p (encoding &optional refresh-p)
    "returns T if encoding is available in the system."
    (when (or refresh-p
              (not encodings))
      (setq encodings (available-text-encodings)))
    (when (member encoding encodings)
      T)))
|#

;; (encoding-available-p #$kTextEncodingISO_2022_JP)

#|

:tecinfo
(rlet ((ptr :pointer))
  (#_tecgetinfo ptr)
  (let ((handle (%get-ptr ptr)))
    (unwind-protect
      (with-dereferenced-handles ((ptr handle))
        (pref ptr :tecinfo.tecTextEncodingsFolderName))
      (#_disposehandle handle))))
  
|#

;; unused by us today
(defun script-to-encoding (script)
  "returns text-encoding. May return nil."
  (declare (fixnum script))
  (rlet ((encoding :unsigned-long))
    (when (zerop (#_UpgradeScriptInfoToTextEncoding script
                  #$ktextlanguagedontcare
                  #$ktextregiondontcare
                  (%null-ptr)
                  encoding))
      (%get-unsigned-long encoding))))

(defun encoding-to-script (encoding)
  "returns script code. May retunr nil."
  (rlet ((script :scriptcode))
    (when (zerop (#_RevertTextEncodingToScriptInfo 
                  encoding
                  script (%null-ptr) (%null-ptr)))
      (%get-signed-word script))))


;; (script-to-encoding (u:font-script (appr:get-theme-font :views-font)))
;; (encoding-to-script #$kTextEncodingISO_2022_JP)

; (defun font-name-to-encoding (name)
;   (rlet ((encoding :unsigned-long))
;     (with-pstrs ((nameptr name))
;       (when (zerop (#_UpgradeScriptInfoToTextEncoding
;                     #$kTextScriptDontCare
;                     #$ktextlanguagedontcare
;                     #$ktextregiondontcare
;                     nameptr
;                     encoding))
;         (%get-unsigned-long encoding)))))
;
;; (font-name-to-encoding "Webdings")
;; (font-name-to-encoding "Zapf Dingbats") --> #$kTextEncodingMacDingbats
;; (font-name-to-encoding "MT Extra")
;; (font-name-to-encoding "Hoefler Text Ornaments")
;; (font-name-to-encoding "Dingbats")
;; (font-name-to-encoding "Footnote")
;; #x20000 ???
;; (encoding-to-script #x20000)
;; (#_gettextencodingvariant #x20000) --> #$kMacRomanEuroSignVariant
;; ah. all roman fonts now are #$kMacRomanEuroSignVariant!
;; (font-name-to-encoding "Symbol")


;; previously in file locale.lisp

#|
(defun locale-to-langcode (locale-string)
  "returns language code and region code. may return nil"
  (with-cstrs ((locale locale-string))
    (rlet ((lang :langcode)
           (reg :regioncode))
      (when (zerop (#_LocaleStringToLangAndRegionCodes locale lang reg))
        (values (%get-signed-word lang)
                (%get-signed-word reg))))))

(defun locale-to-encoding (locale-string)
  (multiple-value-bind (lang region)
                       (locale-to-langcode locale-string)
    (when lang
      (rlet ((encoding :textencoding))
        (when (zerop (#_UpgradeScriptInfoToTextEncoding #$kTextScriptDontCare
                      lang
                      region
                      (%null-ptr)
                      encoding))
          (%get-unsigned-long encoding))))))

;; what a mess.
;; locale->encoding->script
(defun locale-to-script (locale-string)
  "returns script code. may return nil."
  (let ((encoding (locale-to-encoding locale-string)))
    (when encoding
      (rlet ((script :scriptcode))
        (when (zerop (#_RevertTextEncodingToScriptInfo 
                      encoding
                      script (%null-ptr) (%null-ptr)))
          (%get-signed-word script))))))
|#

;; (locale-to-script "en")

#|  ;; unused today
(defun script-to-langcode (script)
  (rlet ((lang :langcode)
         (ignore-stupid :scriptcode))
    (when (zerop (#_RevertTextEncodingToScriptInfo
                  (script-to-encoding script)
                  ignore-stupid
                  lang
                  (%null-ptr)))
      (%get-signed-word lang))))

(defun langcode-to-locale (lang)
  (rlet ((ref :localeRef))
    (#_LocaleRefFromLangOrRegionCode lang #$kTextRegionDontCare ref)
    (%stack-block ((str 20))
      (#_LocaleRefGetPartString (%get-ptr ref)
       #$kLocaleAllPartsMask 
       ; #$kLocaleRegionMask
       #+ignore
       (logior #$kLocaleLanguageMask
               #$kLocaleRegionMask
               #$kLocaleScriptMask
               #$kLocaleScriptVariantMask)
       
       20
       str)
      (%get-cstring str))))
|#

; (rlet ((ref :localeRef))
;   (#_LocaleRefFromLangOrRegionCode #$kTextLanguageDontCare 53 ref)
;   (%stack-block ((str 20))
;     (#_LocaleRefGetPartString (%get-ptr ref)
;      #$kLocaleAllPartsMask 
;      ; #$kLocaleRegionMask
;      #+ignore
;      (logior #$kLocaleLanguageMask
;              #$kLocaleRegionMask
;              #$kLocaleScriptMask
;              #$kLocaleScriptVariantMask)
;      20
;      str)
;     (%get-cstring str)))

#|

(locale-to-script "zh_TW")

(locale-to-langcode "en")
(locale-to-langcode "en_US")
(locale-to-script "en_US")

(locale-to-langcode "zh_TW")


(mapcar #'locale-to-encoding
        (cf-prefs:apple-languages))

(mapcar #'(lambda (locale)
            (text-encoding-name (locale-to-encoding locale)))
        (cf-prefs:apple-languages))

(langcode-to-locale (script-to-langcode 25))

|#