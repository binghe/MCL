; level-1.lisp
;
; This version of level-1.lisp loads the pfsl libraries

(%fasload ":level-1.lib")

(let ((*warn-if-redefine* nil))
  (load "ccl:ccl;compiler.lib")
  (load "ccl:ccl;lib.lib"))
