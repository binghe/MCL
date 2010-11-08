;;-*- mode: lisp; package: ccl -*-
;; Makes MCL evaluate form on shift-Return like it does on Enter and fn-Return, for the benefit of portables without separate enter key.
;;
; Terje Norderhaug, July 2010. 
;; Public domain, no copyright nor warranty. Use as you please and at your own risk.


(in-package :ccl) ; l1-ed-lds.lisp

; new (but are these required?)

(comtab-set-key %initial-comtab%  '(:shift #\return)             'ed-eval-or-compile-current-sexp)
(comtab-set-key *comtab*  '(:shift #\return)             'ed-eval-or-compile-current-sexp)

;;  see def-fred-command
;; modification for event-keystroke:

(advise event-keystroke
        ;; same as deleting the (neq ch 13) from #'event-keystroke
        (destructuring-bind (message modifiers) arglist 
          (if (and (eql (logand #xFF message) #.(char-code #\return))
                   (logbitp #$ShiftKeyBit modifiers))
            '(:shift #\return)
            (:do-it)))
        :when :around :name override-event-keystroke)

