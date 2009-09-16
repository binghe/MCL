;;;-*-Mode: LISP; Package: CCL -*-

;; $Log: ansi-make-load-form.lisp,v $
;; Revision 1.4  2003/12/08 08:16:37  gtbyers
;; Lose most of this; it was already mostly defined elsewhere.
;;

(in-package :ccl)

#+ppc-target
(pushnew :ansi-make-load-form *features*)
#+ppc-target
(pushnew :ansi-cl *features*)
#+ppc-target
(provide :ANSI-MAKE-LOAD-FORM)

