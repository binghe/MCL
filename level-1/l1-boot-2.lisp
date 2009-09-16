;;;-*- Mode: Lisp; Package: CCL -*-

;; l1-boot-2.lisp
;; Second part of l1-boot

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 04/16/97 bill  New file. Broken out of l1-boot.lisp
;;

(eval-when (:compile-toplevel)

(defmacro %load-binary (path)
  `(load
    ,(concatenate 'simple-base-string
                  path
                  "."
                  (pathname-type 
                   #+ppc-target *.pfsl-pathname*
                   #-ppc-target *.fasl-pathname*))))
)

(catch :toplevel
  ;(dbg 64) ;; got here
    #+ppc-clos
    (%load-binary "ccl:L1f;l1-typesys")
    ;(dbg 65)
    (%load-binary "ccl:L1f;SysUtils")
    #+ppc-clos
    (%load-binary "ccl:L1f;l1-error-signal")
    #-ppc-target
    (lds (load (if (probe-file "ccl:L1f;nx.fasl")
               "ccl:L1f;nx.fasl"
               "ccl:compiler.fasl"))
       :module compiler
       (load "ccl:L1f;nx-base-app.fasl"))
    #+ppc-target    
    (%load-binary "ccl:l1f;nx") ;; temp for now
    ;(dbg 64)
    (%load-binary "ccl:L1f;l1-highlevel-events")
    ;(dbg 65)
    )