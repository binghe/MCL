; -*- Mode:Lisp; Package:CCL; -*-

;; uk-keyboard.lisp
;;
;; On a UK keyboard the sharp sign character ("#") is bloody hard to
;; type to MCL. It requires two keystrokes: <Control>-q <Option>-3.
;; This file removes the need for the <Control>-q. The sharp sign
;; character can now be typed with <Option>-3, just as for any other
;; normal Macintosh application.
;; Thanks to Ralph Martin.

(in-package :ccl)

(def-fred-command (:meta #\3)
  #'(lambda (w) (let ((*current-character* #\#)) (ed-self-insert w))))

;; Some of you will prefer to type the sharp sign with <Shift>-3, and the
;; British pound sign with <Option>-3. Uncomment this code (by commenting
;; out the "#+swap-pounds" line) to set it up that way.

#+swap-pounds
(progn
  (def-fred-command #\243
    #'(lambda (w) (let ((*current-character* #\#)) (ed-self-insert w))))
  
  (def-fred-command (:meta #\3)
    #'(lambda (w) (let ((*current-character* #\243)) (ed-self-insert w))))
  )
