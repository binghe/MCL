;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: ppc-subprims.lisp,v $
;; Revision 1.2  2002/11/18 05:36:34  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  7 12/1/95  gb   add .SPmisc-alloc-init, .SPstack-misc-alloc-init
;;  6 11/16/95 bill CCL 3.0x40
;;  2 10/6/95  gb   .SPsetqsym
;;  (do not edit before this line!!)

;;; 07/04/96 bill .SPbreakpoint
;;; 06/10/96 gb   subprims for builtin functions.
;;; ---- 3.9
;;; 03/01/96 bill add .SPffcallslep
;;; 01/19/96 gb  add SPrestorecontext, lexpr-entry.
;;; 12/13/95 gb  progvsave,progvrestore, callbuiltin*, popj;
;;;              save/restore context; udfcall->reset
; 11/11/95 bill  .SPcallback
; 11/10/95 gb    replace duplicate .SPregtrap with .SPstack-misc-alloc

(defstruct ppc-subprimitive-info
  name
  offset
  nailed-down
  argument-mask
  registers-used
  )

(defmethod print-object ((s ppc-subprimitive-info) stream)
  (print-unreadable-object (s stream :type t)
    (format stream "~A @ #x~x" 
            (ppc-subprimitive-info-name s)
            (ppc-subprimitive-info-offset s))))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defparameter *next-subprim-offset* 0)
)

; For now, nothing's nailed down and we don't say anything about
; registers clobbered.
(macrolet ((defppcsubprim (name)
            (let* ((offset *next-subprim-offset*))
              (incf *next-subprim-offset* 4)
              `(progn
                 (makunbound ',name)
                 (defconstant ,name ,offset)
                 (make-ppc-subprimitive-info :name ',name
                                             :offset ,offset)))))
  (setq *next-subprim-offset* 0)
 (defparameter *ppc-subprims*
    (vector
     (defppcsubprim .SPjmpsym)
     (defppcsubprim .SPjmpnfn)
     (defppcsubprim .SPfuncall)
     (defppcsubprim .SPmkcatch1v)
     (defppcsubprim .SPmkunwind)
     (defppcsubprim .SPmkcatchmv)
     (defppcsubprim .SPthrow)
     (defppcsubprim .SPnthrowvalues)
     (defppcsubprim .SPnthrow1value)
     (defppcsubprim .SPbind)
     (defppcsubprim .SPbind-self)
     (defppcsubprim .SPbind-nil)
     (defppcsubprim .SPunbind)
     (defppcsubprim .SPunbind-n)
     (defppcsubprim .SPunbind-to)
     (defppcsubprim .SPconslist)
     (defppcsubprim .SPconslist-star)
     (defppcsubprim .SPstkconslist)
     (defppcsubprim .SPstkconslist-star)
     (defppcsubprim .SPmkstackv)
     (defppcsubprim .SPsubtag-misc-ref)
     (defppcsubprim .SPnewblocktag)
     (defppcsubprim .SPnewgotag)
     (defppcsubprim .SPstack-misc-alloc)
     (defppcsubprim .SPgvector)
     (defppcsubprim .SPnvalret)
     (defppcsubprim .SPmvpass)
     (defppcsubprim .SPfitvals)
     (defppcsubprim .SPnthvalue)
     (defppcsubprim .SPvalues)
     (defppcsubprim .SPdefault-optional-args)
     (defppcsubprim .SPopt-supplied-p)
     (defppcsubprim .SPheap-rest-arg)
     (defppcsubprim .SPreq-heap-rest-arg)
     (defppcsubprim .SPheap-cons-rest-arg)
     (defppcsubprim .SPsimple-keywords)
     (defppcsubprim .SPkeyword-args)
     (defppcsubprim .SPkeyword-bind)
     (defppcsubprim .SPffcall)
     (defppcsubprim .SPffcalladdress)
     (defppcsubprim .SPksignalerr)
     (defppcsubprim .SPstack-rest-arg)
     (defppcsubprim .SPreq-stack-rest-arg)
     (defppcsubprim .SPstack-cons-rest-arg)
     (defppcsubprim .SPstrap)
     (defppcsubprim .SPcall-closure)
     (defppcsubprim .SPgetXlong)
     (defppcsubprim .SPspreadargz)
     (defppcsubprim .SPtfuncallgen)
     (defppcsubprim .SPtfuncallslide)
     (defppcsubprim .SPtfuncallvsp)
     (defppcsubprim .SPtcallsymgen)
     (defppcsubprim .SPtcallsymslide)
     (defppcsubprim .SPtcallsymvsp)
     (defppcsubprim .SPtcallnfngen)
     (defppcsubprim .SPtcallnfnslide)
     (defppcsubprim .SPtcallnfnvsp)
     (defppcsubprim .SPmisc-ref)
     (defppcsubprim .SPmisc-set)
     (defppcsubprim .SPstkconsyz)
     (defppcsubprim .SPstkvcell0)
     (defppcsubprim .SPstkvcellvsp)
     (defppcsubprim .SPmakestackblock)
     (defppcsubprim .SPmakestackblock0)
     (defppcsubprim .SPmakestacklist)
     (defppcsubprim .SPstkgvector)
     (defppcsubprim .SPmisc-alloc)
     (defppcsubprim .SPregtrap)
     (defppcsubprim .SPbind-self-boundp-check)
     (defppcsubprim .SPmacro-bind)
     (defppcsubprim .SPdestructuring-bind)
     (defppcsubprim .SPdestructuring-bind-inner)
     (defppcsubprim .SPrecover-values)
     (defppcsubprim .SPvpopargregs)
     (defppcsubprim .SPinteger-sign)
     (defppcsubprim .SPsubtag-misc-set)
     (defppcsubprim .SPspread-lexpr-z)
     (defppcsubprim .SPsetqsym)
     (defppcsubprim .SPreset)
     (defppcsubprim .SPmvslide)
     (defppcsubprim .SPsave-values)
     (defppcsubprim .SPadd-values)
     (defppcsubprim .SPcallback)
     (defppcsubprim .SPmisc-alloc-init)
     (defppcsubprim .SPstack-misc-alloc-init)
     (defppcsubprim .SPprogvsave)
     (defppcsubprim .SPprogvrestore)
     (defppcsubprim .SPcallbuiltin)
     (defppcsubprim .SPcallbuiltin0)
     (defppcsubprim .SPcallbuiltin1)
     (defppcsubprim .SPcallbuiltin2)
     (defppcsubprim .SPcallbuiltin3)
     (defppcsubprim .SPpopj)
     (defppcsubprim .SPrestorefullcontext)
     (defppcsubprim .SPsavecontextvsp)
     (defppcsubprim .SPsavecontext0)
     (defppcsubprim .SPrestorecontext)
     (defppcsubprim .SPlexpr-entry)
     (defppcsubprim .SPffcallslep)
     (defppcsubprim .SPbuiltin-plus)
     (defppcsubprim .SPbuiltin-minus)
     (defppcsubprim .SPbuiltin-times)
     (defppcsubprim .SPbuiltin-div)
     (defppcsubprim .SPbuiltin-eq)
     (defppcsubprim .SPbuiltin-ne)
     (defppcsubprim .SPbuiltin-gt)
     (defppcsubprim .SPbuiltin-ge)
     (defppcsubprim .SPbuiltin-lt)
     (defppcsubprim .SPbuiltin-le)
     (defppcsubprim .SPbuiltin-eql)
     (defppcsubprim .SPbuiltin-length)
     (defppcsubprim .SPbuiltin-seqtype)
     (defppcsubprim .SPbuiltin-assq)
     (defppcsubprim .SPbuiltin-memq)
     (defppcsubprim .SPbuiltin-logbitp)
     (defppcsubprim .SPbuiltin-logior)
     (defppcsubprim .SPbuiltin-logand)
     (defppcsubprim .SPbuiltin-ash)
     (defppcsubprim .SPbuiltin-negate)
     (defppcsubprim .SPbuiltin-logxor)
     (defppcsubprim .SPbuiltin-aref1)
     (defppcsubprim .SPbuiltin-aset1)
     (defppcsubprim .SPbreakpoint)
     (defppcsubprim .SPxuuo-interr)
     (defppcsubprim .SPxuuo-intcerr)
     (defppcsubprim .SPtrap-wrongnargs)
     (defppcsubprim .SPtrap-toofewargs)
     (defppcsubprim .SPtrap-toomanyargs)
     (defppcsubprim .SPtrap-intpoll)
     (defppcsubprim .SPensure-cons)
     (defppcsubprim .SPensure-heap-space)
     (defppcsubprim .SPfinish-alloc)
     (defppcsubprim .SPleaf-ensure-heap-space)
     (defppcsubprim .SPwrite-barrier)
     (defppcsubprim .SPset-hash-key)
     (defppcsubprim .SPbox-unsigned)
     (defppcsubprim .SPbox-signed)
     (defppcsubprim .SPfixnum-overflow)
     (defppcsubprim .SPudfcall)
     (defppcsubprim .SPuuovectorbounds)
     (defppcsubprim .SPuuoslot-unbound)
     (defppcsubprim .SPuuounbound)
     (defppcsubprim .SPxalloc-handler)
     (defppcsubprim .SPcscheck)
     (defppcsubprim .SPtscheck)
     (defppcsubprim .SPfpu-exception)
 

)))

(defun ppc-subprim-name->offset (name)
  (let* ((sprec (find name *ppc-subprims* 
                      :test #'string-equal 
                      :key #'ppc-subprimitive-info-name)))
    (if sprec
      (ppc-subprimitive-info-offset sprec)
      (error "PPC subprim named ~s not found." name))))

(ccl::provide "PPC-SUBPRIMS")
