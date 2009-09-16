;-*- Mode: Lisp; Package: CCL -*-
; Helpmap.lisp
(cl:in-package :ccl)

(if (eql (ignore-errors (with-open-file (s "ccl:MCL Help") (file-length s)))
         #.(with-open-file (s "ccl:MCL Help") (file-length s)))
  (setq *fast-help* '#.*fast-help*)
  (setq *fast-help* "Length mismatch"))

