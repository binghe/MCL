; make-ccl-pfsl-libraries.lisp
;
; Code to create pfsl-libraries for MCL

(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History

;;; lose l1-traps
;;; ---- 5.1 final
;;;
;;; 05/07/97 bill  New file
;;;

(require "PFSL-LIBRARY" "ccl:xdump;pfsl-library")

(defparameter *level-1-pfsl-library-files*
  '(; Uncomment the following line to enter the debugger when
    ; $fasl-provide is executed. This can help find bootstrapping bugs
    ; "ccl:xdump;fasl-provide-patch"
    "ccl:L1f;L1-cl-package"
    "ccl:L1f;L1-utils"
    ; Uncomment the following line to prevent source file recording
    ; This speeds up loading by quite a bit.
    ; "ccl:xdump;no-record-source-file"
    "ccl:L1f;L1-init"
    "ccl:L1f;L1-symhash"
    "ccl:L1f;L1-numbers"
    "ccl:L1f;L1-aprims"
    "ccl:L1f;PPC-callback-support"
    "ccl:L1f;L1-sort"
    "ccl:L1f;L1-dcode"
    "ccl:L1f;L1-clos"
    "ccl:L1f;L1-streams"
    ;"ccl:L1f;L1-traps"    ; must go before any ff-call trap is called
    "ccl:L1f;L1-files"
    "ccl:L1f;L1-stack-groups"
    "ccl:L1f;PPC-stack-groups"
    "ccl:L1f;L1-processes"
    "ccl:L1f;L1-io"
    "ccl:L1f;L1-menus"
    "ccl:L1f;L1-windows"
    "ccl:L1f;L1-edbuf"
    "ccl:L1f;L1-edcmd"
    "ccl:L1f;script-manager"
    "ccl:L1f;L1-edfrec"
    "ccl:L1f;L1-edwin"
    "ccl:l1f;l1-unicode-to-mac"
    "ccl:l1f;l1-tec"
    "ccl:L1f;L1-ed-lds"                 ; lds only
    "ccl:bin;dialogs"
    "ccl:bin;views"
    "ccl:library;scroll-bar-dialog-items"
    "ccl:library;scrolling-fred-view"
    "ccl:L1f;new-fred-window"
    "ccl:L1f;L1-listener"               ; lds only
    "ccl:L1f;L1-reader"
    "ccl:L1f;L1-readloop"
    "ccl:L1f;L1-readloop-lds"           ; lds only
    "ccl:L1f;L1-error-system"
    "ccl:L1f;L1-events"
    "ccl:L1f;ppc-trap-support"
    ; "ccl:L1f;L1-highlevel-events"
    "ccl:L1f;L1-format"
    "ccl:L1f;L1-initmenus"
    "ccl:L1f;L1-initmenus-lds"          ; lds only
    "ccl:L1f;L1-sysio"
    "ccl:L1f;L1-pathnames"
    "ccl:L1f;version"
    "ccl:L1f;L1-boot-lds"               ; lds only
    
    "ccl:L1f;L1-boot-1"
    ; Loaded by l1-boot-2
    "ccl:bin;sequences"
    "ccl:L1f;l1-typesys"
    "ccl:L1f;SysUtils"
    "ccl:L1f;l1-error-signal"
    ;"ccl:L1f;nx"
    "ccl:L1f;l1-highlevel-events"
    ; end of l1-boot-2
    ; REQUIREd by nx
    "ccl:bin;numbers"
    "ccl:bin;sort"
    "ccl:bin;hash"
    "ccl:bin;defstruct"
    ; End of nx
    "ccl:L1f;L1-boot-3"
    ))

(defparameter *compiler-pfsl-library-files*
  '(
    "ccl:bin;nxenv"
    "ccl:bin;dll-node"
    "ccl:bin;ppc-arch"
    "ccl:bin;vreg"
    "ccl:bin;ppc-asm"
    "ccl:bin;vinsn"
    "ccl:bin;ppc-vinsns"
    "ccl:bin;ppc-reg"
    "ccl:bin;ppc-subprims"
    "ccl:bin;ppc-lap"
    "ccl:l1f;nx"
    ))

(defparameter *lib-pfsl-library-files*
  '("ccl:bin;compile-ccl"
    "ccl:bin;systems"
    "ccl:bin;ppcenv"
    "ccl:bin;ppc-optimizers"
    "ccl:bin;backquote"
    "ccl:library;lispequ"
    "ccl:bin;sysequ"
    ;"ccl:bin;toolequ"
    "ccl:bin;level-2"
    "ccl:bin;trap-support"
    "ccl:bin;ppc-lapmacros"
    "ccl:bin;fredenv"
    "ccl:bin;defstruct-macros"
    "ccl:bin;lists"
    "ccl:bin;chars"
    "ccl:bin;setf"
    "ccl:bin;defstruct-lds"
    "ccl:bin;mactypes"
    "ccl:bin;simple-db"
    "ccl:bin;deftrap"
    "ccl:bin;defrecord"
    "ccl:bin;new-traps"
    "ccl:bin;color"
    "ccl:binppc;optimizers"
    "ccl:bin;nfcomp"
    "ccl:bin;windoids"
    "ccl:bin;ff-call-68k"
    "ccl:bin;fred-misc"
    "ccl:bin;streams"
    "ccl:bin;pathnames"
    "ccl:bin;backtrace"
    "ccl:bin;edhardcopy"
    "ccl:bin;apropos"
    "ccl:library;resources"
    "ccl:bin;dumplisp"
    "ccl:bin;ppc-disassemble"
    "ccl:bin;resident-interfaces"
    "ccl:library;mac-file-io"
    "ccl:bin;boyer-moore"
    "ccl:bin;encapsulate"
    "ccl:bin;read"
    "ccl:bin;misc"
    "ccl:bin;doc-window"
    "ccl:bin;arrays-fry"
    "ccl:bin;method-combination"
    "ccl:bin;case-error"
    "ccl:bin;pprint"
    "ccl:bin;format"
    "ccl:bin;time"
    "ccl:bin;print-db"
    "ccl:bin;eval"
    "ccl:bin;fred-additions"
    "ccl:bin;edit-definition"
    "ccl:bin;fred-help"
    "ccl:bin;list-definitions"
    "ccl:bin;arglist"
    "ccl:library;pop-up-menu"
    "ccl:bin;ccl-menus"
    "ccl:bin;ccl-menus-lds"
    "ccl:library;font-menus"
    "ccl:bin;mcl-extensions"
    "ccl:bin;search-files"
    "ccl:bin;inspector"
    "ccl:bin;inspector-objects"
    "ccl:bin;apropos-dialog"
    "ccl:bin;step"
    "ccl:bin;step-window"
    "ccl:bin;edit-callers"
    "ccl:bin;backtrace-lds"
    "ccl:bin;ccl-export-syms"
    ))

(defun make-level-1-pfsl-library (&optional verbose)
  (make-pfsl-library "ccl:ccl;level-1.lib"
                     (mapcar #'(lambda (x)
                                 (merge-pathnames x ".pfsl"))
                             *level-1-pfsl-library-files*)
                     :if-exists :supersede
                     :provide-modules-p t
                     :verbose verbose))

(defun make-compiler-pfsl-library (&optional verbose)
  (make-pfsl-library "ccl:ccl;compiler.lib"
                     (mapcar #'(lambda (x)
                                 (merge-pathnames x ".pfsl"))
                             *compiler-pfsl-library-files*)
                     :if-exists :supersede
                     :provide-modules-p t
                     :verbose verbose))

(defun make-lib-pfsl-library (&optional verbose)
  (make-pfsl-library "ccl:ccl;lib.lib"
                     (mapcar #'(lambda (x)
                                 (merge-pathnames x ".pfsl"))
                             *lib-pfsl-library-files*)
                     :if-exists :supersede
                     :provide-modules-p t
                     :verbose verbose))

(defun make-ccl-pfsl-libraries ()
  (make-level-1-pfsl-library t)
  (make-compiler-pfsl-library t)
  (make-lib-pfsl-library t))

#|

(make-level-1-pfsl-library t)

(make-compiler-pfsl-library t)

(make-lib-pfsl-library t)

(make-ccl-pfsl-libraries)

|#