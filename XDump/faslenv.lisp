;;;-*- Mode: Lisp; Package: CCL -*-

;;; stuff for long lists from slh
;;; $Log: faslenv.lisp,v $
;;; Revision 1.4  2003/12/08 08:18:45  gtbyers
;;; Bump the fasl version (and min version, too.)
;;;
;;; 05/05/97 bill  $fasl-library-pointer, $fasl-provide
;;; --- 4.1
;;; 03/06/97 gb    set max to ff31
;;; --- 4.0
;;; 06/16/96 bill  ff30
;;; 06/13/96 gb    ff29
;;; --- 3.9 release ---

(in-package "CCL")

;; Compile-time environment for fasl dumper/loader.

; loader state istruct
(def-accessors (faslstate) %svref
  ()
  faslstate.faslfname
  faslstate.faslevec
  faslstate.faslecnt
  faslstate.fasliopb
  faslstate.faslval
  faslstate.faslstr
  faslstate.oldfaslstr
  faslstate.faslerr
  faslstate.iobuffer
  faslstate.bufcount
  faslstate.faslversion
  faslstate.faslepush
  faslstate.faslgsymbols
  faslstate.fasldispatch)

(defconstant numfaslops 52 "Number of fasl file opcodes, roughly")
(defconstant $fasl-epush-bit 7)
(defconstant $fasl-file-id #xff00)
(defconstant $fasl-file-id1 #xff01)
(defconstant $fasl-vers #x40)
(defconstant $fasl-min-vers #x40)
(defconstant $faslend #xff)
(defconstant $fasl-buf-len 2048)
(defmacro deffaslop (n arglist &body body)
  `(setf (svref *fasl-dispatch-table* ,n)
         #'(lambda ,arglist ,@body)))


(defconstant $fasl-noop 0)              ;<nada:zilch>.  
;(defconstant $fasl-obsolete 1)
(defconstant $fasl-etab-alloc 2)        ;<count:long>. Make a new expression table
                                        ; with count slots.  Current etab gets lost.
(defconstant $fasl-eref 3)              ;<index:word> Get the value from an etab slot.
(defconstant $fasl-lfuncall 4)          ;<lfun:expr> funcall the lfun.
(defconstant $fasl-globals 5)           ;<expr> global symbols vector
(defconstant $fasl-char 6)              ;<char:byte> Make a char
(defconstant $fasl-fixnum 7)            ;<value:long> Make a fixnum
(defconstant $fasl-float 8)             ;<hi:long><lo:long> Make a float
(defconstant $fasl-str 9)               ;<string> Make a string
(defconstant $fasl-word-fixnum 10)      ;<value:word> Make a fixnum
(defconstant $fasl-mksym 11)            ;<string> Make an uninterned sym
(defconstant $fasl-intern 12)           ;<string> Intern in current pkg.
(defconstant $fasl-pkg-intern 13)       ;<pkg:expr><string> Make a sym in pkg.
(defconstant $fasl-pkg 14)              ;<string> Returns the package of given name
(defconstant $fasl-cons 15)             ;<car:expr><cdr:expr> Make a cons
(defconstant $fasl-list 16)             ;<n:word> <data: n+1 exprs> Make a list
(defconstant $fasl-list* 17)            ;<n:word> <data:n+2 exprs> Make an sexpr
(defconstant $fasl-nil 18)              ; Make nil
(defconstant $fasl-timm 19)             ;<n:long>
(defconstant $fasl-lfun 20)             ;<lfunvec:expr> Make lfun
(defconstant $fasl-eref-lfun 21)        ;<index:word> Make lfun from etab lfunvector.
(defconstant $fasl-extern 22)           ;<string> intern in current pkg, then export.
(defconstant $fasl-arch 23)             ;<n:byte> Ensure that file's loadable on arch n.
(defconstant $fasl-a5nodeblk 24)
(defconstant $fasl-a5lfun 25)
(defconstant $fasl-a5ref 26)
(defconstant $fasl-symfn 27)            ;<sym:expr> returns #'sym.
(defconstant $fasl-eval 28)             ;<expr> Eval <expr> and return value.
(defconstant $fasl-ivec 29)             ;<subtype:byte><n:size><n data bytes>
(defconstant $fasl-gvec 30)             ;<subtype:byte><n:size><n exprs>
(defconstant $fasl-lfvec 31)            ;<n:max size><m:size><m words><imms> Make an lfun-vector
(defconstant $fasl-nlfvec 32)           ;<n:size><n bytes><imms> Make an lfun-vector
(defconstant $fasl-xchar 33)            ; extended character
(defconstant $fasl-mkxsym 34)           ;<xstring> uninterned symbol 
(defconstant $fasl-defun 35)            ;<fn:expr><doc:expr>
(defconstant $fasl-macro 37)            ;<fn:expr><doc:expr>
(defconstant $fasl-defconstant 38)      ;<sym:expr><val:expr><doc:expr>
(defconstant $fasl-defparameter 39)     ;<sym:expr><val:expr><doc:expr>
(defconstant $fasl-defvar 40)           ;<sym:expr>
(defconstant $fasl-defvar-init 41)      ;<sym:expr><val:expr><doc:expr>
(defconstant $fasl-skip 42)             ;<expr><expr> - First <expr> is for side-affects only
(defconstant $fasl-prog1 43)            ;<expr><expr> - Second <expr> is for side-affects only
(defconstant $fasl-xintern 44)          ;<xstring> intern in current package
(defconstant $fasl-pkg-xintern 45)      ;<pkg:expr><xstring> Make a sym in pkg.
(defconstant $fasl-xpkg 46)             ;<xstring> Returns the package of given name
(defconstant $fasl-src 47)              ;<expr> - Set *loading-file-source-file * to <expr>.
(defconstant $fasl-library-pointer 48)  ;<offset:long>[<library-name:expr>]
(defconstant $fasl-provide 49)          ;<string:expr>
(defconstant $fasl-xlist  50)            ;<n:long> <data: n+1 exprs> Make a list
(defconstant $fasl-xlist* 51)            ;<n:long> <data:n+2 exprs> Make an sexpr

; <string> means <size><size bytes>
; <size> means either <n:byte> with n<#xFF, or <FF><n:word> with n<#xFFFF or
;   <FFFF><n:long>

(defconstant $fasl-end #xFF)    ;Stop reading.

(defconstant $fasl-epush-mask #x80)  ;Push value on etab if this bit is set in opcode.

(defmacro fasl-epush-op (op) `(%ilogior2 ,$fasl-epush-mask ,op))

(provide "FASLENV")
