
;; $Log: ppcenv.lisp,v $
;; Revision 1.2  2002/11/18 05:36:59  gtbyers
;; Add CVS log marker
;;
;; 03/21/97   gb  $ppc-return, etc.
;; ---- 4.1b1

(defconstant $numppcsaveregs 8)
(defconstant $numppcargregs 3)


(defconstant ppc-nonvolatile-registers-mask
  (logior (ash 1 ppc::save0)
          (ash 1 ppc::save1)
          (ash 1 ppc::save2)
          (ash 1 ppc::save3)
          (ash 1 ppc::save4)
          (ash 1 ppc::save5)
          (ash 1 ppc::save6)
          (ash 1 ppc::save7)))

(defconstant ppc-arg-registers-mask
  (logior (ash 1 ppc::arg_z)
          (ash 1 ppc::arg_y)
          (ash 1 ppc::arg_x)))

(defconstant ppc-temp-registers-mask
  (logior (ash 1 ppc::temp0)
          (ash 1 ppc::temp1)
          (ash 1 ppc::temp2)
          (ash 1 ppc::temp3)))


(defconstant ppc-tagged-registers-mask
  (logior ppc-temp-registers-mask
          ppc-arg-registers-mask
          ppc-nonvolatile-registers-mask))

(defconstant $undo-ppc-c-frame 16)

(defconstant $ppc-compound-branch-target-bit 28)
(defconstant $ppc-compound-branch-target-mask (ash 1 $ppc-compound-branch-target-bit))

(defconstant $ppc-mvpass-bit 29)
(defconstant $ppc-mvpass-mask (ash -1 $ppc-mvpass-bit))

(defconstant $ppc-return (- (ash 1 14) 1))
(defconstant $ppc-mvpass (- (ash 1 14) 2))

(defconstant $ppc-compound-branch-false-byte (byte 14 0))
(defconstant $ppc-compound-branch-true-byte (byte 14 14))
