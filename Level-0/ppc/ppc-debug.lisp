;;; -*- Mode: Lisp; Package: CCL -*-

; level-0;ppc;ppc-debug.lisp - PPC debugging functions!

;; 01/22/96 gb   add :regsave pseudo-op.
;; 11/28/95 bill breaker takes a rest arg

#+allow-in-package
(in-package "CCL")


; write nbytes bytes from buffer buf to file-descriptor fd.
(defppclapfunction fd-write ((fd arg_x) (buf arg_y) (nbytes arg_z))
  (check-nargs 3)
  (save-lisp-context)
  (stwu sp (- (+ ppc::c-frame.minsize ppc::lisp-frame.size)) sp)
  (unbox-fixnum imm0 fd)
  (lwz imm1 ppc::macptr.address buf)
  (unbox-fixnum imm2 nbytes)
  (stw imm0 ppc::c-frame.param0 sp)
  (stw imm1 ppc::c-frame.param1 sp)
  (stw imm2 ppc::c-frame.param2 sp)
  (ref-global imm3 kernel-imports)
  (lwz arg_z '1 imm3)
  (bla .SPffcalladdress)
  (box-fixnum arg_z imm0)
  (restore-full-lisp-context)
  (blr))

; Write a simple-base-string to stderr's file descriptor (2).
(defppclapfunction %string-to-stderr ((str arg_z))
  (check-nargs 1)
  (save-lisp-context)
  (:regsave save2 0)
  (vpush save0)
  (vpush save1)
  (vpush save2)
  (trap-unless-typecode= str ppc::subtag-simple-base-string)
  (let ((size imm0)
        (header imm1)
        (length save1)
        (ptr save0)
        (string save2))
    (mr string str)
    (vector-size size string header)
    (box-fixnum length size)
    ; we need 8 bytes for tsp header, 8 bytes for macptr, and need to
    ; round size up to a dword boundary.
    (la imm2 (+ 8 8 7) size)
    (clrrwi imm2 imm2 3)                ; align to dword-boundary
    (neg imm2 imm2)
    (stwux tsp tsp imm2)
    (stw tsp 4 tsp)                     ; not-lisp
    (li imm2 (logior (ash 1 ppc::num-subtag-bits) ppc::subtag-macptr))
    (la imm3 16 tsp)
    (stw imm2 8 tsp)
    (stw imm3 12 tsp)
    (la ptr (+ 8 ppc::fulltag-misc) tsp)
    (vpush string)                      ; source ivector
    (vpush rzero)                       ; source-byte-offset
    (mr arg_x ptr)                      ; dest macptr
    (li arg_y 0)                        ; dest-byte-offset
    (mr arg_z length)                   ; nbytes
    (set-nargs 5)
    (call-symbol %copy-ivector-to-ptr)
    (li arg_x '2)
    (mr arg_y ptr)
    (mr arg_z length)
    (set-nargs 3)
    (call-symbol fd-write)
    (lwz tsp 0 tsp)
    (lwz save2 0 vsp)
    (lwz save1 4 vsp)
    (lwz save0 8 vsp)
    (restore-full-lisp-context)
    (blr)))

(defun pdbg (string)
  (%string-to-stderr string)
  (%string-to-stderr "
"))

; set a debugger breakpoint on this dude
(defun breaker (&rest rest)
  (declare (ignore rest))
  nil)

; Alice's cuter name
(defppclapfunction dbg-paws ()
  (blr))

; end
