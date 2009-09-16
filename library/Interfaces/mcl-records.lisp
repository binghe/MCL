
;; This form has been added from patch file OSX Drive:Users:bburns:Desktop:interface-translator:Patches:mcl-records.patch;;; mcl-records.lisp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 03/28/97 bill  Merge back in changes that shipped with 4.0
;; 02/23/97 bill  fix xframe-list record definition
;; -------------  4.0
;; 07/08/96 bill  Update gc-area, add protected-area
;; ------------   MCL-PPC 3.9
;; 01/26/96 bill  add  gc-area and xframe-list
;;


;; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:mcl-records.patch
(DEFRECORD STACKSEG
           (PTR :POINTER)
           (OLDER (:POINTER :STACKSEG))
           (YOUNGER (:POINTER :STACKSEG))
           (FIRST :POINTER)
           (LAST :POINTER)
           (LASTUSED :POINTER)
           (TOTALSIZE :LONG))
;; This form has been added from patch file OSX Drive:Users:bburns:Desktop:interface-translator:Patches:mcl-records.patch
;; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:mcl-records.patch 

#|
(DEFRECORD REGBUF
           (RD0 POINTER)
           (RD1 POINTER)
           (RD2 POINTER)
           (RD3 POINTER)
           (RD4 POINTER)
           (RD5 POINTER)
           (RD6 POINTER)
           (RD7 POINTER)
           (RA0 POINTER)
           (RA1 POINTER)
           (RA2 POINTER)
           (RA3 POINTER)
           (RA4 POINTER)
           (RA5 POINTER)
           (RA6 POINTER)
           (RA7 POINTER)
           (RSR INTEGER))
|#
;; This form has been added from patch file OSX Drive:Users:bburns:Desktop:interface-translator:Patches:mcl-records.patch
;; This form has been added from patch file HD:CCL3.0d17:Interface Translator:legacies:mcl-records.patch 

#| ;; this is wrong - defined correctly in l1-events.lisp
(DEFRECORD PTASKSTATE
           (NEXTTICK UNSIGNED-LONG)
           (INTERVAL UNSIGNED-LONG)
           (PRIVATE POINTER)
           (FLAGS UNSIGNED-INTEGER))
|#
;; This form has been added from patch file OSX Drive:Users:bburns:Desktop:interface-translator:Patches:mcl-records.patch

; This matches the (define-storage-layout area ...) form in "ccl:compiler;ppc;ppc-arch.lisp"
(defrecord gc-area
  (pred (:pointer :gc-area))
  (succ (:pointer :gc-area))
  (low :ptr)
  (high :ptr)
  (active :ptr)
  (softlimit :ptr)
  (hardlimit :ptr)
  (code :long)
  (markbits :ptr)
  (ndwords :long)
  (older (:pointer :gc-area))
  (younger (:pointer :gc-area))
  (h :ptr)
  (softprot (:pointer :protected-area))
  (hardprot (:pointer :protected-area))
  (owner :long)
  (refbits :ptr)
  (threshold :ptr)
  (gc-count :long))
;; This form has been added from patch file OSX Drive:Users:bburns:Desktop:interface-translator:Patches:mcl-records.patch

(defrecord protected-area
  (next (:pointer protected-area))
  (start :ptr)                          ; first byte (page-aligned) that might be protected
  (end :ptr)                            ; last byte (page-aligned) that could be protected
  (nprot :unsigned-long)                ; Might be 0
  (protsize :unsigned-long)             ; number of bytes to protect
  (why :long))
;; This form has been added from patch file OSX Drive:Users:bburns:Desktop:interface-translator:Patches:mcl-records.patch

; This matches the xframe-list struct definition in "ccl:pmcl;constants.h"
(defrecord xframe-list
  (this (:pointer :ExceptionInformation))
  (prev (:pointer :xframe-list)))