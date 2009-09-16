;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 6/2/97   akh  see below
;;  (do not edit before this line!!)


(in-package :ccl)
;; add some keyboard and processor types, fix machine-type in *environs*
;; create-cfstr2 handles non simple-string
;; fmakunbound return unmangled setf name
;; ------- 5.2b6
;; comment out all the layout-object stuff
;; fiddle with shift amount - only do for monaco or small non monaco 
;; font-codes-string-width - don't need with-port etc unless *use-quickdraw-for-roman*
;; font-codes-string-width - string may not be simple-string
;; add layout-line-justification, formerly known as line-alignment sort of
;; fond-to-atsu-fontid - sys-font-spec -> sys-font-codes
;; increase shift amount for any bold, not just manaco??
;; ------ 5.2b4
;; terminate-when-unreachable of style-object doesn't work so forget it
;; modified create-atsu-style from Takehiko Abe
;; ------ 5.2b3
;; add a bunch of ATSU font stuff from Takehiko Abe - many thanks
;; ----- 5.2b1
;; font-values uses *font-name-number-alist*
;; font-codes-string-width uses xtext-width
;; font-codes-string-width-for-control  uses with-cfstrs-hairy
;; font-codes-string-width-for-control - remove unneeded stuff
;; --------- 5.1 final
;; equalp does encoded-strings - why does this have to be magic?
;; -------- 5.0 final
;; equalp does random-states
;; add some more keyboard types and processor types
;; ------- 4.4b5
;; move sysenvirons to later in file (after make-array-1 defined), so (format nil ...) works.
;; add font-codes-string-width-for-stupid-control
;; ------ 4.4b4
;; akh font-number-from-name
;; 4.4b1
;; akh font-info more pc
;; akh real-font for osx
;; new file - shared parts of sysutils, gestalt stuff, font stuff, some array stuff
;; fix font-number-from-name for OS 8.x and later
;; akh more machine types
;; ------ 4.3f1c1
;; -------------- 4.3b2
;; 03/03/99 akh add powerbook g3 types, keyboard
;; 09/28/98 akh font-codes - modernize 
;; 03/27/98 akh font-codes-string-width was busted for long strings, tried but failed
;; 05/20/97 akh fix result of gestalt for processor type - heuristicate cause :|cput| and:|proc| are different for 68K's, :|cput| may be nil (7.1 or so)
;; 03/01/97 gb  init-uvector-contents-without-calling-ELT-all-the-time.


(queue-fixup
 (defun fmakunbound (name)
   (let ((fname name))
     (when (consp name)
       (unless (eq (%car name) 'setf)
         (return-from fmakunbound (funcall (function-spec-handler name) name nil)))
       (setq fname (setf-function-name (cadr name))))
     (remhash fname %structure-refs%)
     (%unfhave fname)
     name)))

(defun frozen-definition-p (name)
  (if (symbolp name)
    (%ilogbitp $sym_fbit_frozen (%symbol-bits name))))

(defun redefine-kernel-function (name)
  (when (and *warn-if-redefine-kernel*
             (frozen-definition-p name)
             (or (lfunp (fboundp name))
                 (and (not (consp name)) (macro-function name)))
             (or (and (consp name) (neq (car name) 'setf))
                 (let ((pkg (symbol-package (if (consp name) (cadr name) name))))
                   (or (eq *common-lisp-package* pkg) (eq *ccl-package* pkg)))))
    (cerror "Replace the definition of ~S."
            "The function ~S is already defined in the MCL kernel." name)
    (unless (consp name)
      (proclaim-inline nil name))))

(defun fset (name function)
  (setq function (require-type function 'function))
  (when (symbolp name)
    (when (special-form-p name)
      (error "Can not redefine a special-form: ~S ." name))
    (when (macro-function name)
      (cerror "Redefine the macro ~S as a function"
              "The macro ~S is being redefined as a function." name)))
; This lets us redefine %FHAVE.  Big fun.
  (let ((fhave #'%fhave))
    (redefine-kernel-function name)
    (fmakunbound name)
    (funcall fhave name function)
    function))

(defsetf symbol-function fset)
(defsetf fdefinition fset)

(defun set-macro-function (name macro-fun)
  (if (special-form-p name)
    (error "Can not redefine a special-form: ~S ." name))
  (when (and (fboundp name) (not (macro-function name)))
    (cerror "Redefine function ~S as a macro."
            "The function ~S is being redefined as a macro." name))
  (redefine-kernel-function name)
  (fmakunbound name)
  (%macro-have name macro-fun)
  macro-fun)

(defsetf macro-function set-macro-function)

(defun trap-implemented-p (trap)
  (declare (ignore-if-unused trap))
  #-carbon-compat
  (not (%ptr-eql (#_GetToolTrapAddress #xA89F)
                 (if (%ilogbitp 11 trap)
                   (#_GetToolTrapAddress trap)
                   (#_GetOSTrapAddress   trap))))
  #+carbon-compat
  (error "not in carbon"))

(defvar *multifinder* nil)

(defparameter *environs* nil)

(defparameter *known-gestalt-machine-types*
  '((3 . "512KE") (4 . "Plus") (5 . "SE") (6 . "II") (7 . "IIx") (8 . "IIcx")
 (9 . "SE/30") (10 . "Portable") (11 . "IIci") (13 . "IIfx") (17 . "Classic")
 (18 . "IIsi") (19 . "LC") (20 . "Quadra 900") (21 . "PowerBook 170")
 (22 . "Quadra 700") (23 . "Classic II") (24 . "PowerBook 100")
 (25 . "PowerBook 140") (26 . "Quadra 950") (27 . "LCIII")
 (29 . "PowerBook Duo 210") (30 . "Centris 650") (32 . "PowerBook Duo 230")
 (33 . "PowerBook 180") (34 . "PowerBook 160") (35 . "Quadra 800")
 (36 . "Quadra 650") (37 . "LCII") (38 . "PowerBook Duo 250")
 (39 . "AWS 9150/80") (40 . "Power Macintosh 8100/110") (44 . "IIVi")
 (45 . "Performa 600") (48 . "IIVx") (49 . "Color Classic")
 (50 . "PowerBook 165c") (52 . "Centris 610") (53 . "Quadra 610")
 (54 . "PowerBook 145") (56 . "LC520") (57 . "AWS 9150/120") (60 . "Quadra 660AV")
 (62 . "Performa 46x") (71 . "PowerBook 180c") (72 . "PowerBook 540c")
 (77 . "PowerBook Duo 270c") (78 . "Quadra 840AV") (80 . "Performa 550")
 (84 . "PowerBook 165") (89 . "LC475") (94 . "Quadra 605") (98 . "Quadra 630")
 (102 . "PowerBook Duo 280") (103 . "PowerBook Duo 280c")
 (666 . "Macintosh of Doom") (47 . "Power Macintosh 7100/80")
 (55 . "Power Macintosh 8100/100") (65 . "Power Macintosh 8100/80")
 (67 . "Power Macintosh 9500") (68 . "Power Macintosh 7500")
 (69 . "Power Macintosh 8500") (75 . "Power Macintosh 6100/60")
 (85 . "PowerBook 190") (88 . "Macintosh TV") (92 . "LC 575") (99 . "LC 580")
 (100 . "Power Macintosh 6100/66")
 (104 . "Mac LC 475 & PPC Processor Upgrade Card")
 (105 . "Mac LC 575 & PPC Processor Upgrade Card")
 (106 . "Quadra 630 & PPC Processor Upgrade Card")
 (108 . "Power Macintosh 7200") (112 . "Power Macintosh 7100/66")
 (115 . "PowerBook 150") (116 . "Quadra 700 & Power PC Upgrade Card")
 (117 . "Quadra 900 & Power PC Upgrade Card")
 (118 . "Quadra 950 & Power PC Upgrade Card")
 (119 . "Centris 610 & Power PC Upgrade Card")
 (120 . "Centris 650 & Power PC Upgrade Card")
 (121 . "Quadra 610 & Power PC Upgrade Card")
 (122 . "Quadra 650 & Power PC Upgrade Card")
 (123 . "Quadra 800 & Power PC Upgrade Card") (124 . "PowerBook Duo 2300")
 (126 . "PowerBook 5xx PPC Upgrade Card") (128 . "PowerBook 5300")
 (306 . "PowerBook 3400c")
 (307 . "PowerBook 2400")
 
 (310 . "PowerBook 1400")
 (312 . "PowerBook G3 Series")  ; 13/14 inch
 (313 . "PowerBook G3")
 (314 . "PowerBook G3 Series2")  ; 12 inch
 (406 . "PowerMac NewWorld")   ;; includes a G3 PB
 (510 . "PowerMac G3")
 (512 . "20thAnniversary")
 (513 . "PowerMac 650")
 (514 . "PowerMac 4400_160")
 (515 . "PowerMac 4400")
))

(defparameter *known-gestalt-keyboard-types*
  '((1 . "Macintosh keyboard")
    (2 . "Macintosh keyboard with numeric keypad")
    (3 . "Macintosh plus keyboard")
    (4 . "Apple extended keyboard")
    (5 . "Apple standard keyboard")
    (6 . "Portable Keyboard")
    (7 . "Portable Keyboard (ISO)")
    (8 . "Apple Standard Keyboard (ISO)")
    (9 . "Apple Extended Keyboard (ISO)")
    (10 . "Elmer Keyboard (owns a mansion & a yacht)")
    (11 . "Elmer ISO Keyboard (owns an ISO mansion & a yacht")
    (12 . "PowerBook Keyboard")
    (13 . "PowerBook KeyBoard (ISO)")
    (14 . "Apple Adjustable Keypad")
    (15 . "Apple Adjustable Keyboard")
    (16 . "Apple Adjustable Keyboard (ISO)")
    (17 . "Apple Adjustable Keyboard (Japanese)")
    (20 . "PowerBook Extended Keyboard with function keys (ISO)")
    (21 . "PowerBook Extended Keyboard with function keys (Japanese)")
    (24 . "PowerBook Extended Keyboard with function keys")
    (27 . "PS2 keyboard")
    (28 . "PowerBook Subnote Domestic Keyboard with function keys w/  inverted T")
    (29 .  "PowerBook Subnote International Keyboard with function keys w/  inverted T")
    (30 . "PowerBook Subnote Japanese Keyboard with function keys w/ inverted T")
    (31 . "Pro Keyboard w/F16 key Domestic (ANSI) Keyboard")
    (32 . "Pro Keyboard w/F16 key International (ISO) Keyboard")
    (33 . "Pro Keyboard w/F16 key Japanese (JIS) Keyboard")
    (34 . "USB Pro Keyboard w/ F16 key Domestic (ANSI) Keyboard")
    (35 . "USB Pro Keyboard w/ F16 key International (ISO) Keyboard")
    (36 . "USB Pro Keyboard w/ F16 key Japanese (JIS) Keyboard") 

    
    (195 . "PowerBook Domestic Keyboard with Embedded Keypad, function keys & inverted T")	 
    (196 .  "PowerBook International Keyboard with Embedded Keypad, function keys & inverted T") 	 
    (197 .  "PowerBook Japanese Keyboard with Embedded Keypad, function keys & inverted T") 		 
    (198 .  "Cosmo USB Domestic (ANSI) Keyboard")  
    (199 .   "Cosmo USB International (ISO) Keyboard") 
    (200 .   "Cosmo USB Japanese (JIS) Keyboard") 
    (201 .   "'99 PowerBook JIS Keyboard with Embedded Keypad, function keys & inverted T")
    (202 . "PowerBook Domestic Keyboard with function keys and inverted T")
    (203 . "PowerBook and iBook International (ISO) Keyboard with 2nd cmd key right & function key moves.")
    (204 . "USB Pro Keyboard Domestic (ANSI) Keyboard ")                                 
    (205 .  "USB Pro Keyboard International (ISO) Keyboard")    
    (206 . "USB Pro Keyboard Japanese (JIS) Keyboard") 
    (207 .  "PowerBook and iBook Japanese (JIS) Keyboard with function key moves.")
))

(defun ostype-to-long (x)
  (when (symbolp x)
    (let ((str (symbol-name x))
          (num 0))
      (dotimes (i 4)
        (setq num (logior (ash num 8) (%scharcode str i))))
      num)))



; These are the return values for (gestalt #$gestaltNativeCPUtype),
; not (gestalt #$gestaltProcessorType) as before.
(defparameter *known-gestalt-processor-types*
  '((1 . 68000)
    (2 . 68010)
    (3 . 68020)
    (4 . 68030)
    (5 . 68040)
    (#x101 . 601)
    (#x103 . 603)
    (#x104 . 604)
    (#x106 . "603e")
    (#x107 . "603ev")
    
    (#x108 . "G3")  ;; or is it g3
    (#x109 . "604e")
    (#x110 . "G47450") 
    (#x10a . "604ev")
    (#x10c . "G4")
    (#x110 . "VgerAltivec")
    (#x111 .  "G47455" )
    (#x112 . "G47447")
    (#x120 . "SaharaG3" )
    (#x139 .  "CPU970")
    (#.(ostype-to-long :|i486|) . "Intel486")
    (#.(ostype-to-long :|i586|) . "Intel586")
    (#.(ostype-to-long :|i5ii|) . "PentiumII")
    (#.(ostype-to-long :|i5pr|) . "PentiumPro")
    (#.(ostype-to-long :|ixxx|) . "x86")
    ))

(defparameter *known-gestalt-fpu-types*
  '((0 . nil)
    (1 . 68881)
    (2 . 68882)
    (3 . 68040)))

(eval-when (compile eval)
(defconstant $gestalt8BitQD #x100)
(defconstant $gestalt32BitQD #x200)
)



;; font stuff.

; Returns two longs calculated from a font-spec that specify a font's
; font-number/style, and text-mode/size
; And two more longs that are the masks for changed parts of the first two longs.
; (values ff-code ms-code ff-mask ms-mask)
(defun font-codes (font-spec &optional old-ff old-ms
                             &aux 
                             (items font-spec) temp item font face mode size color
                             reset-style-p 
                             (font-mask 0) (face-mask 0) (color-mask 0)
                             (mode-mask 0) (size-mask 0))
  (if (null old-ff) (setq old-ff 0))
  (if (null old-ms) (setq old-ms (make-point 0 (xfer-mode-arg :srcor)))) ;;maybe should be #$transparent?? prob not
  (if (null font-spec)
    (return-from font-codes (values old-ff old-ms 0 0)))
  (setq item (if (consp items) (pop items) items))
  (tagbody
    LOOP
    (cond
     ((fixnump item)
      (if size 
        (error "Font Spec: ~s contains two sizes" font-spec)
        (setq size item
              size-mask -1)))
     ((stringp item)
      (if font (error "Font Spec: ~s contains two strings" font-spec))
      (setq font-mask -1)
      (if (equalp item (car (sys-font-spec)))
        (setq font (ash (car *sys-font-codes*) -16))  ; in OS 8 its the real font-num - earlier it's 0 
        (let ((num (font-number-from-name item)))
          ;; so what do you do if it doesnt exist?
          (setq font
                (or num
                    (ash (car *sys-font-codes*) -16))))))
     ((consp item)
      (ecase (car item)
        (:color-index
         (when color
           (error "Font Spec: ~s contains two color specs" font-spec))
         (setq color (second item))
         (unless (and (fixnump color)
                      (<= 0 color 255))
           (error "~s is not a valid font color" color))
         (setq color-mask 255))
        (:color
         (when color
           (error "Font Spec: ~s contains two color specs" font-spec))
         (setq color (color->ff-index (second item))
               color-mask 255))))
     ((setq temp (xfer-mode-arg item))
      (if mode 
        (error "Font Spec: ~s contains two text-modes" font-spec)
        (setq mode temp
              mode-mask -1)))
     ((setq temp (assq item *style-alist*))
      (when (eq (%car temp) :plain)
        (setq reset-style-p t
              face-mask -1))
      (setq temp (%cdr temp))
      (setq face (if face (%ilogior2 face temp) temp)
            face-mask (%ilogior2 face-mask temp)))
     (t (error "Unrecognized option ~a in font-spec: ~a" item font-spec)))
    (if (consp items) (progn (setq item (pop items)) (go LOOP))))
  (unless font (setq font (point-v old-ff)))
  (unless face (setq face (%ilsr 8 (point-h old-ff))))
  (unless color (setq color (%ilogand 255 (point-h old-ff))))
  (unless reset-style-p
    (setq face (%ilogior2 face (%ilsr 8 (point-h old-ff)))))
  (unless mode (setq mode (point-v old-ms)))
  (unless size (setq size (point-h old-ms)))
  (values (make-point (+ color (%ilsl 8 face)) font)
          (make-point size mode)
          (make-point (logior color-mask (%ilsl 8 face-mask)) font-mask)
          (make-point size-mask mode-mask)))

(defun font-number-from-name (name)
  (let ((number  (font-number-from-name-simple name)))
    (when (eq 0 number)  ;; so maybe it doesn't exist or maybe its the system font
      (with-pstrs ((p name))
        (if (eq (car *sys-font-codes*) 0) ;; in 8.x and later 0 really means does not exist
          (progn
            (#_getfontname 0 p)
            (when (not (equalp name (%get-string p)))
              (setq number nil)))
          (setq  number nil))))
    number))

(defvar *font-name-number-alist* nil)
;; we know the font exists in this case -
;; redefined in elsewhere for boot ?? 
(defun font-number-from-name-simple (name)
  (or ;(and *font-name-number-alist* (cdr (assoc name *font-name-number-alist* :test #'string-equal)))
      (rlet ((fnum :signed-integer))  ;; wrong
        (with-pstrs ((np name))
          (#_GetFNum np fnum))
        (%get-signed-word fnum))))
#|
      (with-cfstrs ((cfstr name))  ;; wrong
        (#_AtsFontFindFromName cfstr 0))))
|#



(defun merge-font-codes (old-ff-code old-ms-code ff-code ms-code &optional ff-mask ms-mask)
  #| (unless (and (integerp old-ff-code) (integerp old-ms-code) ; NO
               (integerp ff-code) (integerp ms-code)
               (or (null ff-mask) (integerp ff-mask))
               (or (null ms-mask) (integerp ms-mask)))
    (error "All args must be fixnums."))|#
  (values
   (if ff-mask
     (logior (logand ff-code ff-mask) (logand old-ff-code (lognot ff-mask)))
     ff-code)
   (if ms-mask
     (logior (logand ms-code ms-mask) (logand old-ms-code (lognot ms-mask)))
     ms-code)))


(defun font-name-from-number (font-code)
  (or (car (rassoc font-code *font-name-number-alist*)) 
      (rlet ((np (:string 256)))  ;; wrong - gets mac encoded name
        (#_GetFontName font-code np)
        (%get-string np))))
  
(defun font-values (ff-code ms-code &aux temp font size mode face color)
  (if (not ff-code) (setq ff-code 0))
  (if (not ms-code) (setq ms-code 0))
  (let ((font-code  (point-v ff-code)))
    (setq font (font-name-from-number font-code)))
  (setq mode (xfer-mode-to-name (point-v ms-code)))
  (setq size (point-h ms-code))
  (setq color (logand 255 ff-code))
  (setq ff-code (%ilsr 8 (point-h ff-code)))
  (if (eq ff-code 0)
      (setq face :plain)
      (dotimes (i 7)
        (declare (fixnum i))
         (if (%ilogbitp i ff-code)
             (progn (setq temp (car (rassoc (%ilsl i 1) *style-alist*)))
                    (if face
                        (if (consp face)
                            (push temp face)
                            (setq face (list temp face)))
                        (setq face temp))))))
  (values font size mode face color))

(defun font-spec (ff-code ms-code)
  (multiple-value-bind (name size mode style color) (font-values ff-code ms-code)
    (if (atom style) (setq style (cons style nil)))
    (nconc (list* name size mode style)
           `((:color-index ,color)))))

;; not used thank heaven
#|
(defun font-size-list (font)
  (without-interrupts
   (with-macptrs (famrec)
     (with-pstrs ((np font))
       (%setf-macptr famrec (#_GetNamedResource "FONT" np)))
     (do* ((count (%hget-word famrec 52) (1- count))
           (offset (+ 54 (* 6 count)) (- offset 6))
           ret)
          ((< count 0) ret)
       (if (eq 0 (%hget-word famrec (+ offset 2)))
         (push (%hget-word famrec offset) ret))))))
|#

;;; Arrays and vectors, including make-array.



(defun make-array (dims &key (element-type t element-type-p)
                        displaced-to
                        displaced-index-offset
                        adjustable
                        fill-pointer
                        (initial-element nil initial-element-p)
                        (initial-contents nil initial-contents-p))
  (when (and initial-element-p initial-contents-p)
        (error "Cannot specify both ~S and ~S" :initial-element-p :initial-contents-p))
  (make-array-1 dims element-type element-type-p
                displaced-to
                displaced-index-offset
                adjustable
                fill-pointer
                initial-element initial-element-p
                initial-contents initial-contents-p
                nil))

(defun make-array-1 (dims element-type element-type-p
                          displaced-to
                          displaced-index-offset
                          adjustable
                          fill-pointer
                          initial-element initial-element-p
                          initial-contents initial-contents-p
                          size)
  (let ((subtype (element-type-subtype element-type)))
    (when (and element-type (null subtype))
      (error "Unknown element-type ~S" element-type))
    (when (null size)
      (cond ((listp dims)
             (setq size 1)
             (dolist (dim dims)
               (when (< dim 0)
                 (report-bad-arg dim '(integer 0 *)))
               (setq size (* size dim))))
            (t (setq size dims)))) ; no need to check vs. array-dimension-limit
    (cond
     (displaced-to
      (when (or initial-element-p initial-contents-p)
        (error "Cannot specify initial values for displaced arrays"))
      (when (and element-type-p
                 (neq (array-element-subtype displaced-to) subtype))
        (error "The ~S array ~S is not of ~S ~S"
               :displaced-to displaced-to :element-type element-type))
      (%make-displaced-array dims displaced-to
                             fill-pointer adjustable displaced-index-offset))
     (t
      (when displaced-index-offset
        (error "Cannot specify ~S for non-displaced-array" :displaced-index-offset))
      (when (null subtype)
        (error "Cannot make an array of empty type ~S" element-type))
      (make-uarray-1 subtype dims adjustable fill-pointer 
                     initial-element initial-element-p
                     initial-contents initial-contents-p
                     nil size)))))

(defun make-uarray-1 (subtype dims adjustable fill-pointer
                              initial-element initial-element-p
                              initial-contents initial-contents-p
                              temporary 
                              size)
  (when (null size)(setq size (if (listp dims)(apply #'* dims) dims)))
  (let ((vector (if temporary
                  (%make-temp-uvector size subtype)
                  #-ppc-target (%make-uvector size subtype)
                  #+ppc-target (%alloc-misc size subtype))))  ; may not get here in that case
    (if initial-element-p
      (dotimes (i (uvsize vector)) (declare (fixnum i))(uvset vector i initial-element))
      (if initial-contents-p
        (if (null dims) (uvset vector 0 initial-contents)
            (init-uvector-contents vector 0 dims initial-contents))))
    (if (and (null fill-pointer)
             (not adjustable)
             dims
             (or (atom dims) (null (%cdr dims))))
      vector
      (let ((array (%make-displaced-array dims vector 
                                          fill-pointer adjustable nil)))
        (when (and (null fill-pointer) (not adjustable))
          #-ppc-target
          (lap-inline ()
            (:variable array)
            (move.l (varg array) atemp0)
            (bset ($ $arh_simple_bit) (svref atemp0 arh.fixnum $arh_bits)))
          #+ppc-target
          (%set-simple-array-p array))
        array))))

(defun init-uvector-contents (vect offset dims contents
                              &aux (len (length contents)))
  "Returns final offset. Assumes dims not ()."
  (unless (eq len (if (atom dims) dims (%car dims)))
    (error "~S doesn't match array dimensions of ~S ."  contents vect))
  (cond ((or (atom dims) (null (%cdr dims)))
         (if (listp contents)
           (let ((contents-tail contents))
             (dotimes (i len)
               (declare (fixnum i))
               (uvset vect offset (pop contents-tail))
               (setq offset (%i+ offset 1))))
           (dotimes (i len)
             (declare (fixnum i))
             (uvset vect offset (elt contents i))
             (setq offset (%i+ offset 1)))))
        (t (setq dims (%cdr dims))
           (if (listp contents)
             (let ((contents-tail contents))
               (dotimes (i len)
                 (declare (fixnum i))
                 (setq offset
                       (init-uvector-contents vect offset dims (pop contents-tail)))))
             (dotimes (i len)
               (declare (fixnum i))
               (setq offset
                     (init-uvector-contents vect offset dims (elt contents i)))))))
  offset)


(defun char (string index)
 (if (stringp string)
  (aref string index)
  (report-bad-arg string 'string)))

(defun set-char (string index new-el)
  (if (stringp string)
    (aset string index new-el)
    (report-bad-arg string 'string)))

(defun equalp (x y)
  "Just like EQUAL, but more liberal in several respects.
  Numbers may be of different types, as long as the values are identical
  after coercion.  Characters may differ in alphabetic case.  Vectors and
  arrays must have identical dimensions and EQUALP elements, but may differ
  in their type restriction.
  If one of x or y is a pathname and one is a string with the name of the
  pathname then this will return T.(Huh)"
  (cond ((eql x y) t)
        ;((equal x y) t) ;; <<< or (if (typep x 'encoded-string)(equal x y)) ?? or ((istructp x) (equal (x y))) ??
        ((characterp x) (and (characterp y) (eq (char-upcase x) (char-upcase y))))
        ((numberp x) (and (numberp y) (= x y)))
        ((consp x)
         (and (consp y)
              (equalp (car x) (car y))
              (equalp (cdr x) (cdr y))))        
        ((istructp x) (equal x y))  ;; does pathnames and encoded strings - why not all istrucs??
        ((vectorp x)
         (and (vectorp y)
              (let ((length (length x)))
                (when (eq length (length y))
                  (dotimes (i length t)
                    (declare (fixnum i))
                    (let ((x-el (aref x i))
                          (y-el (aref y i)))
                      (unless (or (eq x-el y-el) (equalp x-el y-el))
                        (return nil))))))))
        ((arrayp x)
         (and (arrayp y)
              (let ((rank (array-rank x)) x-el y-el)
                (and (eq (array-rank y) rank)
                     (if (%izerop rank) (equalp (aref x) (aref y))
                         (and
                          (dotimes (i rank t)
                            (declare (fixnum i))
                            (unless (eq (array-dimension x i)
                                        (array-dimension y i))
                              (return nil)))
                          (multiple-value-bind (x0 i) (array-data-and-offset x)
                            (multiple-value-bind (y0 j) (array-data-and-offset y)
                              (dotimes (count (array-total-size x) t)
                                (declare (fixnum count))
                                (setq x-el (uvref x0 i) y-el (uvref y0 j))
                                (unless (or (eq x-el y-el) (equalp x-el y-el))
                                  (return nil))
                                (setq i (%i+ i 1) j (%i+ j 1)))))))))))
        ((and (structurep x) (structurep y))
	 (let ((size (uvsize x)))
	   (and (eq size (uvsize y))
	        (dotimes (i size t)
                  (declare (fixnum i))
		  (unless (equalp (uvref x i) (uvref y i))
                    (return nil))))))
        ((and (hash-table-p x) (hash-table-p y))
         (%hash-table-equalp x y))
        ((and (random-state-p x)(random-state-p y))
         (and (= (random.seed-1 x) (random.seed-1 y))
              (= (random.seed-2 x) (random.seed-2 y))))
        (t nil)))

(defun font-info (&optional font-spec &aux ff ms)
  (if font-spec
    (multiple-value-setq (ff ms) (font-codes font-spec))
    (multiple-value-setq (ff ms) (grafport-font-codes)))
  (font-codes-info ff ms))

(defun font-codes-info (ff-code ms-code)
  (with-port %temp-port%
    (with-font-codes ff-code ms-code
      (rlet ((fi :fontinfo))
        (#_GetFontInfo fi)
        (values (rref fi fontinfo.ascent)
                (rref fi fontinfo.descent)
                (rref fi fontinfo.widmax)
                (rref fi fontinfo.leading))))))

(defun font-line-height (&optional font-spec)
  (multiple-value-bind (a d w l) (font-info font-spec)
    (declare (ignore w))
    (%i+ a d l)))

(defun font-codes-line-height (ff ms)
  (multiple-value-bind (a d w l)(font-codes-info ff ms)
    (declare (ignore w))
    (%i+ a d l)))

#|
(defun real-font (&optional font-spec &aux family ff ms)
  (unless font-spec
    (with-macptrs ((port (%getport)))
      #-carbon-compat
      (setq ff (%get-long port 68)
            ms (%get-long port 72))
      #+carbon-compat
      (let* ((font (#_getporttextfont port))
             (face (#_getporttextface port))
             (mode (#_getporttextmode port))
             (size (#_getporttextsize port)))
        (setq ff (logior (ash font 16)(ash face 8))
              ms (logior (ash mode 16) size)))))
  ;; this is stupid I think?
  (let ((port %temp-port%))   ;; %temp-port is a windowrecord not a port!! OSX cares
    (with-port port
      (when font-spec
        (setq family (if (consp font-spec)
                       (dolist (x font-spec) (when (stringp x) (return x)))
                       (when (stringp font-spec) font-spec)))
        (when (and family
                   (eq 0 (rlet ((fnum :integer))
                           (with-pstrs ((np family))
                             (#_GetFNum np fnum))
                           (%get-word fnum)))
                   (not (equalp family (car (sys-font-spec)))))
          (return-from real-font nil))
        (multiple-value-setq (ff ms) (font-codes font-spec)))
      (with-font-codes ff ms
        #-carbon-compat
        (#_RealFont 
         (rref port grafport.txfont)
         (rref port grafport.txsize))
        #+carbon-compat
        (let ((the-port (#_getwindowport port)))
          (#_realfont
           (#_getporttextfont the-port)
           (#_getporttextsize the-port)))))))
|#

(defun real-font (&optional font-spec &aux family ff ms)
  (cond 
   ((null font-spec)
    ;; still stupid but never called this way though is documented
    (with-port-macptr port     
      (let* ((font (#_getporttextfont port))             
             (size (#_getporttextsize port)))
        (#_realfont font size))))
   (t 
    (setq family (if (consp font-spec)
                   (dolist (x font-spec) (when (stringp x) (return x)))
                   (when (stringp font-spec) font-spec)))
    (when (and family
               (eq 0 (rlet ((fnum :integer))
                       (with-pstrs ((np family))
                         (#_GetFNum np fnum))
                       (%get-word fnum)))
               (not (equalp family (car (sys-font-spec)))))
      (return-from real-font nil))
    (multiple-value-setq (ff ms) (font-codes font-spec))
    (#_RealFont (ash ff -16) (logand ms #xff)))))

(defun string-width (string &optional font-spec &aux ff ms)
  (if font-spec
    (multiple-value-setq (ff ms) (font-codes font-spec))
    (with-port-macptr  port     
      (let ((font (#_getporttextfont port ))
            (face (#_getporttextface port))
            (mode (#_getporttextmode port))
            (size (#_getporttextsize port)))
        (setq ff (logior (ash font 16) (ash face 8))
              ms (logior (ash mode 16) size)))
      ))
  (font-codes-string-width string ff ms))


(defun font-codes-string-width (string ff ms &optional
                                       (start 0)
                                       (end (length string)))
  (unless (fixnump start)
    (setq start (require-type start 'fixnum)))  
  (unless (fixnump end)
    (setq end (require-type end 'fixnum)))
  (locally (declare (fixnum start end))
    (let ((size (- end start))
          (chunk 1024))  ;; dont really need this now
      (declare (fixnum size chunk))
      (when (not (simple-string-p string))
        (multiple-value-setq (string start end)(string-start-end string start end)))
      (if (> size chunk)
        (let ((res 0)
              (sub-start start))
          (declare (fixnum sub-start res))
          (dotimes (i (floor size chunk))
            (incf res (font-codes-string-width
                       string ff ms sub-start (the fixnum (+ sub-start chunk))))
            (incf sub-start chunk))
          (unless (eql sub-start end)
            (incf res (font-codes-string-width string ff ms sub-start end)))
          res)          
        (let ((len (- end start)))  
          (declare (fixnum len))
          (%stack-block ((ubuf (%i+ len len)))
            (copy-string-to-ptr string start len ubuf)
            (if *use-quickdraw-for-roman*
              (with-port %temp-port%
                (with-font-codes ff ms                    
                  (xtext-width ubuf len ff ms)))
              (xtext-width ubuf len ff ms))))))))

(defun create-cfstr2 (title ptr &optional start end)
  (let ((my-string title)
        (encoding #$kcfStringEncodingUnicode))
    (if (encoded-stringp title)
      (progn
        (setq my-string (the-string title))
        (setq encoding (the-encoding title))))
    (multiple-value-setq (my-string start end)(string-start-end my-string start end))
    (let ((new-len (- end start)))
      (declare (fixnum new-len))
      (cond ((eq encoding #$kcfstringencodingunicode)
             (%stack-block ((sb (%i+ new-len new-len)))
               (copy-string-to-ptr my-string start new-len sb)               
               (%setf-macptr ptr (#_CFStringCreateWithCharacters (%null-ptr) sb new-len))))
            ((or (eq encoding #$kcfstringencodingutf8)(eq encoding #$kcfStringEncodingMacRoman))
             (%stack-block ((sb new-len))
               (if (base-string-p my-string)
                 (%copy-ivector-to-ptr my-string start sb 0 new-len)
                 (dotimes (i new-len)
                   (%put-byte sb (%scharcode my-string (%i+ i start)) i)))
               (%setf-macptr ptr (#_CFStringCreateWithBytes (%null-ptr) sb new-len encoding nil))))
            (t (error "phooey"))))))

;; use when always drawn with drawthemetextbox
(defun font-codes-string-width-for-control (string ff ms &optional (start 0)(end (length string)))
  (unless (fixnump start)
    (setq start (require-type start 'fixnum)))
  (unless (fixnump end)
    (setq end (require-type end 'fixnum)))  
  (locally (declare (fixnum start end))
    (when (not (simple-string-p string))
        (multiple-value-setq (string start end)(string-start-end string start end)))
    (with-port  %temp-port%
      (with-font-codes ff ms
        (with-cfstrs-hairy ((x string start end))    
          (rlet ((bounds :point)
                 (baseline :signed-integer))
            (#_GetThemeTextDimensions x #$kThemeCurrentPortFont #$kthemestateactive
             nil bounds baseline)
            (point-h (%get-point bounds))))))))
              

;The following functions are redefined correctly in time.lisp
(defun mac-to-universal-time (time-hi &optional time-lo)
  (+ $mac-time-offset
     (if time-lo
       (+ (ash time-hi 16) time-lo)
       time-hi)))

(defun universal-to-mac-time (time)
  (- time $mac-time-offset))

; The compiler (or some transforms) might want to do something more interesting
; with these, but they have to exist as functions anyhow.

(defun constantly (value)
  #'(lambda (&rest ignore)
      (declare (ignore ignore))
      value))

(defun complement (function)
  (let ((f (coerce-to-function function))) ; keep poor compiler from consing value cell
  #'(lambda (&rest args)
      (declare (dynamic-extent args)) ; not tail-recursive anyway
      (not (apply f args)))))

; Special variables are evil, but I can't think of a better way to do this.

(defparameter *outstanding-deferred-warnings* nil)
(def-accessors (deferred-warnings) %svref
  nil
  deferred-warnings.parent
  deferred-warnings.warnings
  deferred-warnings.defs
  deferred-warnings.flags ; might use to distinguish interactive case/compile-file
)

(defun %defer-warnings (override &optional flags)
  (%istruct 'deferred-warnings (unless override *outstanding-deferred-warnings*) nil nil flags))

(defun report-deferred-warnings ()
  (let* ((current *outstanding-deferred-warnings*)
         (parent (deferred-warnings.parent current))
         (defs (deferred-warnings.defs current))
         (warnings (deferred-warnings.warnings current))
         (any nil)
         (harsh nil))
    (if parent
      (setf (deferred-warnings.warnings parent) (append warnings (deferred-warnings.warnings parent))
            (deferred-warnings.defs parent) (append defs (deferred-warnings.defs parent))
            parent t)
      (let* ((file nil)
             (init t))
        (dolist (w warnings)
          (let ((wfname (car (compiler-warning-args w))))
            (when (if (typep w 'undefined-function-reference)
                    (not (or (fboundp wfname)
                             (assq wfname defs))))
              (multiple-value-setq (harsh any file) (signal-compiler-warning w init file harsh any))
              (setq init nil))))))
    (values (values any harsh parent))))

(defun print-nested-name (name-list stream)
  (if (null name-list)
    (princ "a toplevel form" stream)
    (progn
      (if (car name-list)
        (prin1 (%car name-list) stream)
        (princ "an anonymous lambda form" stream))
      (when (%cdr name-list)
        (princ " inside " stream)
        (print-nested-name (%cdr name-list) stream)))))

(defparameter *suppress-compiler-warnings* nil)

(defun signal-compiler-warning (w init-p last-w-file harsh-p any-p &optional eval-p)
  (let ((muffled *suppress-compiler-warnings*)
        (w-file (compiler-warning-file-name w))
        (s *error-output*))
    (unless muffled 
      (restart-case (signal w)
        (muffle-warning () (setq muffled t))))
    (unless muffled
      (setq any-p t)
      (unless (typep w 'style-warning) (setq harsh-p t))
      (when (or init-p (not (equalp w-file last-w-file)))
        (format s "~&;~A warnings " (if (null eval-p) "Compiler" "Interpreter"))
        (if w-file (format s "for ~S :" w-file) (princ ":" s)))
      (format s "~&;   ~A" w))
    (values harsh-p any-p w-file)))

;;;; Assorted mumble-P type predicates. 
;;;; No functions have been in the kernel for the last year or so.
;;;; (Just thought you'd like to know.)

(defun sequencep (form)
  "Not CL. SLISP Returns T if form is a sequence, NIL otherwise."
   (or (listp form) (vectorp form)))

;;; The following are not defined at user level, but are necessary for
;;; internal use by TYPEP.

(defun bitp (form)
  "Not CL. SLISP"
  (or (eq form 0) (eq form 1)))

(defun unsigned-byte-p (form)
  (and (integerp form) (not (< form 0))))

;This is false for internal structures.
;;; ---- look at defenv.structures, not defenv.structrefs

;This is false for internal structures.
(defun structure-class-p (form &optional env)
  (and (symbolp form)
       (let ((sd (or (and env
                          (let ((defenv (definition-environment env)))
                            (and defenv
                                 (%cdr (assq form (defenv.structures defenv))))))
                     (gethash form %defstructs%))))
         (and sd
              (null (sd-type sd))
              sd))))

(defvar *altivec-available* nil)        ; set below.

(defun altivec-available-p () *altivec-available*)

;; also in misc.lisp
(defun %machine-type ()
  (%get-string (%int-to-ptr (gestalt #$gestaltUserVisibleMachineName))))

(def-ccl-pointers sysenvirons ()
  (let* ((sysversion (gestalt :|sysv|))
         ;(minorversion (neq 0 (logand sysversion #xf)))
         (cpu-features (gestalt #$gestaltPowerPCProcessorFeatures)))
    (setq *multifinder* t)
    (setq *altivec-available* (if cpu-features 
                                (logbitp #$gestaltPowerPCHasVectorInstructions cpu-features)))
    (setq *environs*
          (list
           :machine-type           
           (%machine-type)
           :system-version
           (%str-cat (%integer-to-string (ldb (byte 16 8) sysversion) 16)
               "."
               (%integer-to-string (ldb (byte 4 4) sysversion))
               "."
               (%integer-to-string (ldb (byte 4 0) sysversion)))
           :appleevents
           (gestalt #$gestaltAppleEventsAttr #$gestaltAppleEventsPresent)
           :processor
           (let ((processor-number (gestalt #$gestaltNativeCPUtype))
                 (old-processor-number (gestalt :|proc|)))
             (cond ((null processor-number)(setq processor-number old-processor-number))
                   ((and processor-number old-processor-number
                         (neq processor-number old-processor-number)
                         (<= processor-number #$gestaltCPU68040))
                    (setq processor-number old-processor-number)))
                    
             (or (cdr (assq processor-number *known-gestalt-processor-types*))
                 ;(format nil "#~d" processor-number)
                 "Unknown CPU"
                 ))
           :fpu
           (let* ((fpu-number (gestalt :|fpu |)))
             (if (eql #$gestaltNoFPU fpu-number)
               nil
               (or (cdr (assq fpu-number *known-gestalt-fpu-types*))
                   ;(format nil "#~d" fpu-number)
                   "Unknown FPU"
                   )))
           :color-quickdraw
           (let ((res (gestalt :|qd  |)))
             (cond ((not (eql 0 (logand #$gestalt32BitQD res)))
                    (setq *setgworld-available?* t
                          *screen-gdevice* (#_getmaindevice))
                    32)
                   ((not (eql 0 (logand #$gestalt8BitQD res))) 8)))
           :keyboard
           (let ((keyboard-number (gestalt :|kbd |)))
             (or (cdr (assq keyboard-number *known-gestalt-keyboard-types*))
                 ;(format nil "#~d" keyboard-number)
                 "Peculiar new keyboard"))
           :appletalk-version
           (gestalt :|atlk|))))
  )


;;;;; new atsu font stuff - from Takehiko Abe

(defun num-ats-fonts ()
  (rlet ((foo :unsigned-long))
    (#_atsuFontCount foo)
    (%get-unsigned-long foo)))

(defun atsu-fontids ()
  (let ((nfonts (num-ats-fonts)))
    (%stack-block ((ids (* 4 nfonts)))
      (#_atsuGetFontIds ids nfonts (%null-ptr))
      (let ((res nil))
        (dotimes (i nfonts)
          (push (%get-unsigned-long ids (ash i 2)) res))
        res))))



(defun fond-to-atsu-fontid (font face &optional warn-p)
  (rlet ((fmfont :fmfont)
         (intrinsic-style :signed-integer))
    (let ((err (#_FMGetFontFromFontFamilyInstance
                font
                face
                fmfont
                intrinsic-style)))
      (case err
        ((#.#$noerr)
         (values (%get-unsigned-long fmfont)
                 (logandc2 face
                           (%get-signed-word intrinsic-style))))
        ((#.#$kFMInvalidFontErr)
         (when warn-p
           (warn "Invalid Font: ~d" font))
         ;; FIXIT : Fear of the infinite loop
         (fond-to-atsu-fontid (ash (sys-font-codes) -16) face))
        (t (trap-error "FMGetFontFromFontFamilyInstance" err))))))

(defun ff-to-atsu-fontid (ff &optional warn-p)
  (fond-to-atsu-fontid (ash ff -16)
                      (logand #xff (ash ff -8))
                      warn-p))

;; keke's name for it
#+ignore
(defun font-family->fmfont (font-family &optional (font-style 0) warn-p)
  (declare (fixnum font-style))
  (rlet ((fmfont :fmfont)
         (intrinsic-style :signed-integer))
    (let ((err (#_FMGetFontFromFontFamilyInstance
                font-family
                font-style
                fmfont
                intrinsic-style)))
      (case err
        ((#.#$noerr)
         (values (%get-unsigned-long fmfont)
                 (logandc2 font-style
                           (%get-signed-word intrinsic-style))))
        ((#.#$kFMInvalidFontErr)
         (when warn-p
           (warn "Invalid Font: ~d" font-family))
         ;; FIXIT : Fear of the infinite loop
         (font-family->fmfont *default-font-number* font-style))
        (t (trap-error "FMGetFontFromFontFamilyInstance" err))))))


(defun ff->fmfont (ff &optional warn-p)
  (ff-to-atsu-fontid ff warn-p))

(defun fmfont->font-family (fmfont)
  (rlet ((family :fmfontfamily)
         (style :fmfontstyle))
    (let ((err (#_FMGetFontFamilyInstanceFromFont
                fmfont
                family
                style)))
      (if (eq err #$noerr)
        (values (%get-signed-word family)
                (%get-signed-word style))
        (error "FMGetFontFamilyInstanceFromFont error ~d" err)))))

(defun fmfont->ff (fmfont &optional (explicit-style 0) color)
  (declare (fixnum explicit-style))
  (rlet ((family :fmfontfamily)
         (style :fmfontstyle))
    (let ((err (#_FMGetFontFamilyInstanceFromFont
                fmfont
                family
                style)))
      (if (eq err #$noerr)
        (logior (ash (%get-signed-word family) 16)
                (ash (logior (%get-signed-word style) explicit-style) 8)
                (if color
                  (color->ff-index color)
                  0))
        (error "FMGetFontFamilyInstanceFromFont error ~d" err)))))


(defun trap-error (trap-name num)
  (error "Trap ~S got error ~D" trap-name num))

;;; $Id: sysutils.lisp,v 1.14 2006/04/03 00:11:39 alice Exp $




;;; This file defines:
;;;
;;; atsu-layout [class]
;;;
;;;    wrapper class for ats:layout-object
;;;
;;; set-atsu-layout-font-codes [method]
;;;
;;;    set atsu-layout object's font style.
;;;
;;; frec-atsu-layout [function]
;;;   
;;;    returns atsu-layout
;;;
;;; %atsu-text-inserted [function]
;;;
;;; find-atsu-style [function]
;;;
;;;    returns ats:style-object
;;;


;; Monaco 9 kludge:
;; Disable anti-alias when Monaco 9, otherwise enable it.
;; 
;; kATSStyleNoAntiAliasing #x4
;; from ATSLayoutTypes.h
;;
;; This makes Monaco 9 look like familiar Monaco 9.
;; TextEdit.app does this too. It disables anti-aliasing for
;; some fonts such as Courier 9 but not for others. How does it
;; determin when it should disable anti-aliasing?
;;
;; The remaining problem is that ats:text-width returns
;; width 1 pixel short.
;;
;; --> Maybe the value is correct except at the start of line??? <Yes, that was the case.>
;; --> ats:text-width returns 5 instead of the correct 6 when the character #\a
;;     is at the start of a line.
;;
;; --> the culprit was in ats:text-width implementation itself.
;;     Changing from #$katsusedeviceorigins to #$kATSUseFractionalOrigins
;;     has solved the problem.
;;

;; Subject: Re: Apple Garamond and ATSUI
;; Date: Fri, 28 Jan 2005 07:32:30 -0800
;; From: "Opstad, Dave" 
;; To: "Carbon" <carbon-dev@lists.apple.com>
;; Message-ID: <BE1F9B0E.374F%Dave.Opstad@monotypeimaging.com>
;; 
;; On 1/28/05 12:19 AM, "Takehiko Abe" <keke@gol.com> wrote:
;; 
;; > Has anyone had a problem with Apple Garamond family fonts?
;; > My ATSUI text measurement codes doesn't work well for them.
;; > 
;; > I use ATSUGetGlyphBounds to get the text width.
;; > With Apple Garamond, it returns slanted rect like this:
;; > 
;; >      -------
;; >     /      /
;; >    /      /
;; >   /      /
;; >  /      /
;; > /______/
;; > 
;; > while glyphs appears straight up.
;; > ATSUOffsetToPosition reports a wrong value too.
;; 
;; It's possible the version of Apple Garamond you're using has incorrect
;; values in the 'hhea' table's caret angle field. You might try setting the
;; kATSUNoCaretAngleTag in the style and see if the problem goes away.
;; 
;; Dave Opstad


(ccl::defloadvar *atsu-styles* (make-hash-table))
(ccl::defloadvar monaco-ff (logand (font-codes "Monaco") (lognot #xffff)))

; (clrhash *atsu-styles*)

;; should really be initialize-instance :after method for style-object
;; class

#|
(defun %create-atsu-style (ff ms)
  (let ((style (make-instance 'style-object)))
    (set-style-object-font-codes style ff ms)
    ;; disable anti-alias if Monaco 9.
    (when (and (= (logand ff #xFFFF0000) monaco-ff)
               (= (logand ms #xFFFF) 9))
      (rlet ((options :uint32 #$kATSStyleNoAntiAliasing)
             (value :pointer options)
             (tag :atsuattributetag #$kATSUStyleRenderingOptionsTag)
             (size :bytecount 4))
        (#_atsusetattributes (style-ptr style)
         1
         tag
         size
         value)))
    ;; for Apple Garamond and possibly other buggy fonts
    (rlet ((angledp :boolean t)
           (value :pointer angledp)
           (tag :atsuattributetag #$kATSUNoCaretAngleTag)
           (size :bytecount 1))
      (#_atsusetattributes (style-ptr style)
              1
              tag
              size
              value))
    ;; 2005-01-20 turn-off swashes mainly for Apple Chancery
    (set-style-object-font-features style
                                        #$ksmartswashtype
                                        #$kWordInitialSwashesOffSelector
                                        #$kWordFinalSwashesOffSelector
                                        #$kLineInitialSwashesOffSelector
                                        #$kLineFinalSwashesOffSelector
                                        #$kNonFinalSwashesOffSelector)
    style))
|#

;; from Keke may 06
(defun %create-atsu-style (ff ms)
  (let ((style (make-instance 'style-object)))
    (set-style-object-font-codes style ff ms)
    ;; disable anti-alias if Monaco.
    (when (and (= (logand ff (lognot #xffff)) monaco-ff)
               #+ignore
               (= (logand ms #xFFFF) 9))
      (rlet ((options :uint32 #$kATSStyleNoAntiAliasing)
             (value :pointer options)
             (tag :atsuattributetag #$kATSUStyleRenderingOptionsTag)
             (size :bytecount 4))
        (#_atsusetattributes (style-ptr style)
         1
         tag
         size
         value)))
    ;; 2006-04-27
    ;; increase shift amount if bold 
    ;; - akh thinks do for any bold - not just monaco?? - or maybe just roman
    (when (and (logtest #.(ash #$bold 8) ff)
               (or (= (logand ff (lognot #xffff)) monaco-ff) ;; all monaco
                   (and (eql (ff-encoding ff) #$kcfstringencodingmacroman) ;; or roman < 12
                        (< (logand ms #xffff) 12))))
      (rlet ((value :fixed #.(float->fixed 0.5))
             (values (:array :pointer 2))
             (tags (array :atsuattributetag 2))
             (sizes (array :bytecount 2)))
        (%put-ptr values value)
        (%put-ptr values value 4)
        (%put-long tags #$kATSUBeforeWithStreamShiftTag)
        (%put-long tags #$kATSUAfterWithStreamShiftTag 4)
        (%put-long sizes 4)
        (%put-long sizes 4 4)
        (#_atsusetattributes (style-ptr style)
         2
         tags
         sizes
         values)))
    ;; for Apple Garamond and possibly other buggy fonts
    (rlet ((angledp :boolean t)
           (value :pointer angledp)
           (tag :atsuattributetag #$kATSUNoCaretAngleTag)
           (size :bytecount 1))
      (#_atsusetattributes (style-ptr style)
       1
       tag
       size
       value))
    ;; 2005-01-20 turn-off swashes mainly for Apple Chancery   
    (set-style-object-font-features style
                                    #$ksmartswashtype
                                    #$kWordInitialSwashesOffSelector
                                    #$kWordFinalSwashesOffSelector
                                    #$kLineInitialSwashesOffSelector
                                    #$kLineFinalSwashesOffSelector
                                    #$kNonFinalSwashesOffSelector)
    style))

#|

2005-01-20 note
Apple Chancery has annoying 'swashes'. We can turn them off with
ats:set-style-object-font-features . Should turn them off along
with Monaco 9 kludge?

;; turn them off
(let ((style (multiple-value-bind (ff ms)
                                  (font-codes '("Apple Chancery" 24))
               (fred::find-atsu-style ff ms))))
  (set-style-object-font-features style
                                      #$ksmartswashtype
                                      #$kWordInitialSwashesOffSelector
                                      #$kWordFinalSwashesOffSelector
                                      #$kLineInitialSwashesOffSelector
                                      #$kLineFinalSwashesOffSelector
                                      #$kNonFinalSwashesOffSelector))

;; turn on
(let ((style (multiple-value-bind (ff ms)
                                  (font-codes '("Apple Chancery" 24))
               (fred::find-atsu-style ff ms))))
  (set-style-object-font-features style
                                      #$ksmartswashtype
                                      #$kWordFinalSwashesOnSelector
                                      #$kLineInitialSwashesOnSelector
                                      #$kLineFinalSwashesOnSelector
                                      #$kNonFinalSwashesOnSelector))

|#

(defun find-atsu-style (ff ms)
  (setq ms (logand ms #xFFFF))
  (let ((styles (gethash ff *atsu-styles*)))
    (if styles
      (let ((style (assoc ms styles)))
        (if style
          (cdr style)
          (progn
            (setq style (%create-atsu-style ff ms))
            (setf (gethash ff *atsu-styles*)
                  (push (cons ms style) styles))
            style)))
      (let ((style (%create-atsu-style ff ms)))
        (setf (gethash ff *atsu-styles*)
              (list (cons ms style)))
        style))))

;; from l1-edfrec.lisp
#|
(eval-when (:compile-toplevel :execute)
  (defconstant $max-font-run-length 512)
  (defconstant $max-font-changes-per-line 128)
  )
|#

;; not used yet
#|
(defclass atsu-layout (layout-object)
  ((text-buffer :initform nil :reader layout-text-buffer)
   (text-buffer-size :initarg :buffer-size
                     :reader layout-text-buffer-size))
  (:default-initargs
    :buffer-size #.(* $max-font-run-length 2)
    :transient-font-matching t
    :direction :left))
|#

;; Layout option voodoo. Eliminates fractional positioning & uneven spacing.
  ;; 2005-01-12 disable fractional positioning
  ;; 2005-01-14 added kATSLineUseDeviceMetrics

; #x00020000 ; #$kATSLineDisableAllGlyphMorphing
; #x00040000 ; #$kATSLineDisableAllKerningAdjustments



(defparameter *default-layout-options* 
  (logior #$kATSLineDisableAutoAdjustDisplayPos
          #$kATSLineUseDeviceMetrics  
          #$kATSLineFractDisable
          ))

#|
(defmethod initialize-instance :after ((layout atsu-layout)
                                       &key transient-font-matching buffer-size
                                       direction font)
  (require-type  buffer-size 'integer)
  (when (< buffer-size 2)
    (error "buffer-size (~d) is too small.") buffer-size)
  (with-slots ((buffer text-buffer))
              layout
    (setf buffer (#_newptr buffer-size))
    (set-layout-text-ptr layout buffer 0 0 buffer-size))
  (setf (layout-transient-font-matching layout) transient-font-matching)
  (setf (layout-line-direction layout) direction)
  
  (set-layout-line-layout-options layout *default-layout-options*)   
  (when font
    (set-layout-run-style layout
                              (multiple-value-bind (ff ms)
                                                   (font-codes font)
                                (find-atsu-style ff ms))
                              0 0)))


(defmethod terminate :after ((layout atsu-layout))
  (#_disposeptr (layout-text-buffer layout)))

;; no need to be a generic
(defmethod set-atsu-layout-font-codes ((layout atsu-layout) ff ms)
  (set-layout-run-style layout
                            (find-atsu-style ff ms)
                            #$kATSUFromTextBeginning
                            #$kATSUToTextEnd))


;;; 2005-01-13 changed :weak from :value to :key. weak on value was wrong.
;;;            made it defloadvar too
(ccl::defloadvar *atsu-obs* (make-hash-table :test #'eq :weak :key))
|#

#|
;; optional font arg is not really used.
(defun frec-atsu-layout (frec &optional font)
  (or (gethash frec *atsu-obs*)
      (setf (gethash frec *atsu-obs*)
            (make-instance 'atsu-layout
              :buffer-size #.(* $max-font-run-length 2)
              :font font))))

;; Since we reuse the same buffer for an atsui layout object,
;; we need to inform the layout object that we replaced the buffer
;; with new text.
(defun %atsu-text-inserted (layout length)
  (declare (fixnum length))
  (#_atsutextdeleted (layout-ptr layout) #$kATSUFromTextBeginning #$kATSUToTextEnd)
  (#_atsutextinserted (layout-ptr layout) 0 length))


;; this function will be redefined in quartz version.
(defun draw-text (frec layout point)
  (declare (ignore frec))
  (ats:draw-text layout point))
|#


;;;__________________________________________________________________________
;;;
;;; File:	atsui.lisp
;;; Date:	2003-02-20
;;; Author:	Takehiko Abe <keke@gol.com>
;;;__________________________________________________________________________
;;;
;;; $Id: sysutils.lisp,v 1.14 2006/04/03 00:11:39 alice Exp $
;;;
;;; defines layout-object and style-object
;;; Wrappers for atsui layout object and style object
;;;
;;; Note:
;;; * #_ATSUSetLayoutControls and #_ATSUSetLineControls
;;;   controls layout level attributes and individual line level attributes.
;;;
;;; * What is the correct sequence of setting attributes of layout and style?
;;;   for instance calling (setf layout-transient-font-matching) immediately
;;;   after layout creation fails with #$kATSUInvalidTextLayoutErr .
;;;   It only works after style-object is associated with layout-object.
;;;   and so on.. [2005-01-16 note: this is incorrect at least on 10.3.6.
;;;   The layout object must have text associated but not the style object.]
;;;
;;; * What is font variation? [2005-01-16 it is QuickDrawGX technology.
;;;   I think it is obsolete. Few font has 'variations'.
;;;
;;; * layout and style-object both turns into dead-object upon
;;;   termination by change-class. not sure if it's good idea anymore.
;;;

;(in-package :ats)

;;;
;;; style-object
;;;


(defclass style-object ()
  ((style-ptr :reader style-ptr)))


(defclass dead-style-object () ())

(defmethod initialize-instance :after ((self style-object) &key font)
  (rlet ((style :atsustyle))
    (#_ATSUCreateStyle style)
    (setf (slot-value self 'style-ptr)
          (%get-ptr style)))
  (when font
    (set-style-object-font self font))
  ;(terminate-when-unreachable self) ;; this causes error sometimes so forget it for now
  ;; it lives indirectly in a (non weak) hash table and is never removed from the hash table
  ;; so it never becomes unreachable - in theory at least
  )

#|
(defmethod terminate :around ((self style-object))
  (call-next-method)
  (let ((style-ptr (style-ptr self)))
    (if (typep style-ptr 'macptr) ;; maybe dead macptr - how did that happen?
      (#_ATSUDisposeStyle style-ptr))
    (setf (slot-value self 'style-ptr) nil))
  (change-class self 'dead-style-object))
|#

;;;
;;; style-object-font-codes and set-style-object-font-codes
;;;


(defun %get-style-object-qd-face (style-object face-tag)
  (rlet ((face :boolean)
         (size :bytecount 1))
    (let ((err (#_atsugetattribute (style-ptr style-object)
                face-tag ; #$kATSUQDBoldFaceTag
                1
                face
                size)))
      (if (or (eql err #$noerr)
              (= err #$kATSUnotseterr))
        (eq (%get-signed-byte face) 1)
        nil))))

(defun %get-style-object-face-bold-p (style-object)
  (%get-style-object-qd-face style-object #$kATSUQDBoldFaceTag))

(defun %get-style-object-font-face (style-object)
  ;; bahh
  (let ((face 0))
    (declare (fixnum face))
    (when (%get-style-object-qd-face style-object #$kATSUQDBoldfaceTag)
      (setq face #$bold))
    (when (%get-style-object-qd-face style-object #$kATSUQDItalicTag)
      (setq face (logior face #$italic)))
    (when (%get-style-object-qd-face style-object #$kATSUQDUnderlineTag)
      (setq face (logior face #$underline)))
    (when (%get-style-object-qd-face style-object #$kATSUQDCondensedTag)
      (setq face (logior face #$condense)))
    (when (%get-style-object-qd-face style-object #$kATSUQDExtendedTag)
      (setq face (logior face #$extend)))
    face))

(defun %set-style-object-font-face (style-object face)
  (rlet ((bold :boolean (logbitp 0 face))
         (italic :boolean (logbitp 1 face))
         (underline :boolean (logbitp 2 face))
         (condensed :boolean (logbitp 5 face))
         (extended :boolean (logbitp 6 face))
         (faces (array :pointer 5))
         (tags (array :atsuattributetag 5))
         (sizes (array :bytecount 5)))
    (%put-ptr faces bold)
    (%put-ptr faces italic 4)
    (%put-ptr faces underline 8)
    (%put-ptr faces condensed 12)
    (%put-ptr faces extended 16)
    (%put-long tags #$kATSUQDBoldfaceTag)
    (%put-long tags #$kATSUQDItalicTag 4)
    (%put-long tags #$kATSUQDUnderlineTag 8)
    (%put-long tags #$kATSUQDCondensedTag 12)
    (%put-long tags #$kATSUQDExtendedTag 16)
    (%put-long sizes 1)
    (%put-long sizes 1 4)
    (%put-long sizes 1 8)
    (%put-long sizes 1 12)
    (%put-long sizes 1 16)
    (#_atsusetattributes (style-ptr style-object)
     5
     tags
     sizes
     faces)))

(defun %style-object-font-size (style-object)
  (rlet ((out :fixed)
         (size :bytecount))
    (let ((err (#_ATSUGetAttribute (style-ptr style-object)
                #$kATSUSizeTag
                4
                out
                size)))
      (if (or (zerop err)
              (= err #$katsunotseterr))
        (#_fix2long (%get-long out))
        nil))))

(defun %style-object-font-color (style-object)
  (rlet ((out :rgbcolor)
         (size :bytecount))
    (let ((err (#_atsugetattribute (style-ptr style-object)
                #$kATSUcolortag
                6
                out
                size)))
      (if (or (zerop err)
              (= err #$katsunotseterr))
        (rgb-to-color out)
        nil))))

(defun %style-object-atsu-font-id (style-object)
  (rlet ((out :atsufontid)
         (size :bytecount))
    (let ((err (#_ATSUGetAttribute (style-ptr style-object)
                #$kATSUFontTag
                4
                out
                size)))
      (if (or (zerop err)
              (= err #$katsunotseterr))
        (%get-long out)
        nil))))


(defmethod style-object-font-codes ((style style-object))
  (values (fmfont->ff (%style-object-atsu-font-id style)
                      (%get-style-object-font-face style)
                      (%style-object-font-color style))
          (%style-object-font-size style)))


(defmethod set-style-object-font-codes ((style-object style-object) ff ms 
                                        &optional ff-mask ms-mask)
  (setq ms (logand #xFF ms))
  (when (or (or ff-mask ms-mask)
            (zerop ms))
    (multiple-value-bind (old-ff old-ms)
                         (style-object-font-codes style-object)
      (when ff-mask
        (setq ff (logior (logand ff ff-mask)
                         (logand old-ff (lognot ff-mask)))))
      (if ms-mask
        (setq ms (logior (logand ms ms-mask)
                         (logand old-ms (lognot ms-mask))))
        (when (zerop ms)
          (setq ms old-ms)))))
  (let ((color (logand #xFF ff)))
    (declare (fixnum color))
    (multiple-value-bind (fmfont face)
                         (ff->fmfont ff)
      (declare (fixnum face))
      (when fmfont
        (rlet ((font :unsigned-long fmfont)
               (size :unsigned-long (#_long2fix (logand ms #xFF)))
               (rgbcolor :rgbcolor)
               (values-ptr (array :pointer 3))
               (tags (array :atsuattributetag 3))
               (sizes (array :bytecount 3)))
          (ccl::fred-color-index->rgb color rgbcolor)
          (%put-ptr values-ptr font)
          (%put-ptr values-ptr size 4)
          (%put-ptr values-ptr rgbcolor 8)
          (%put-long tags #$kATSUFontTag)
          (%put-long tags #$kATSUSizeTag 4)
          (%put-long tags #$kATSUColorTag 8)
          (%put-long sizes 4)
          (%put-long sizes 4 4)
          (%put-long sizes 6 8)
          ;; FIXIT fail silently?
          (#_atsusetattributes (style-ptr style-object)
           3
           tags
           sizes
           values-ptr)))
      (%set-style-object-font-face style-object face))
    ;; FIXIT
    #+ignore
    (values ff ms)
    nil))


(defmethod set-style-object-font ((self style-object) font-spec)
  (multiple-value-bind (ff ms ff-mask ms-mask)
                       (font-codes font-spec)
    (set-style-object-font-codes self ff ms ff-mask ms-mask)))


;;;
;;; set-style-object-font-features
;;;

;; feature-type: #$kVerticalSubstitutionType
;;               #$kSmartSwashType
;;                etc
;; selectors: #$kSubstituteVerticalFormsOnSelector
;;            #$kSubstituteVerticalFormsOffSelector
;;            #$kWordInitialSwashesOffSelector
;;              etc

(defmethod set-style-object-font-features ((style style-object) feature-type &rest selectors)
  (declare (dynamic-extent selectors))
  (let ((count (length selectors)))
    (declare (fixnum count))
    (%stack-block ((feature-types (* count #.(record-length :atsufontfeaturetype)))
                   (sls (* count #.(record-length :atsufontfeatureselector))))
      (dotimes (i count)
        (declare (fixnum i))
        (%put-word feature-types feature-type (* i 2))
        (%put-word sls (nth i selectors) (* i 2)))
      ;; error handling FIXIT
      (#_atsusetfontfeatures (style-ptr style)
       count
       feature-types
       sls))))


;;;
;;; layout-object
;;;

(defclass layout-object ()
  ((layout-ptr :reader layout-ptr)))

#|
(defclass dead-layout-object () ())

(defmethod initialize-instance :after ((self layout-object) &key)
  (rlet ((layout :atsutextlayout))
    (#_ATSUCreateTextLayout layout)
    (setf (slot-value self 'layout-ptr)
          (%get-ptr layout)))
  (terminate-when-unreachable self))

(defmethod terminate :around ((layout layout-object))
  (call-next-method)
  (#_ATSUDisposeTextLayout (layout-ptr layout))
  (change-class layout 'dead-layout-object))

;; FIXIT error check
(defmethod set-layout-run-style ((layout layout-object) (style style-object)
                                 start length)
  (#_ATSUSetRunStyle (layout-ptr layout)
   (style-ptr style)
   start
   length))
|#

;;;
;;; set-layout-text-ptr
;;;

#|
;; not used
(defmethod layout-text-ptr ((layout layout-object))
  (rlet ((handle-p :boolean)
         (otext :pointer)
         (offset :uint32)
         (length :uint32)
         (buffer-len :uint32))
    (let ((err (#_ATSUGetTextLocation
                (layout-ptr layout)
                otext
                handle-p
                offset
                length
                buffer-len)))
      (if (zerop err)
        (values (%get-ptr otext)
                (%get-long offset)
                (%get-long length)
                (%get-long buffer-len))
        (error "ATSUGetTextLocation returned ~a." err)))))


(defmethod set-layout-text-ptr ((layout layout-object) text-ptr length 
                                &optional (offset 0) (total-length length))
  (declare (fixnum length offset total-length))
  (let ((err (#_ATSUSetTextPointerLocation
              (layout-ptr layout)
              text-ptr
              offset
              length
              total-length)))
    (declare (fixnum err))
    (unless (zerop err)
      (error "ATSUSetTextPointerLocation failed with ~D" err))))


(defmethod layout-transient-font-matching ((layout layout-object))
  (rlet ((bool :boolean))
    (let ((err (#_ATSUGettransientfontmatching (layout-ptr layout) bool)))
      (case err
        ((#.#$noerr) (not (eql (%get-byte bool) 0)))
        ((#.#$kATSUinvalidtextlayouterr)
         (error "layout-object ~S is not yet initialized with text. (#$kATSUinvalidtextlayouterr)" layout))
        (t (error "ATSUGettransientfontmatching failed with ~d" err))))))

(defmethod (setf layout-transient-font-matching) (enabled-p (layout layout-object))
  (let ((err (#_ATSUSetTransientFontMatching (layout-ptr layout) enabled-p)))
    (case err
      ((#.#$noerr) enabled-p)
      ((#.#$kATSUinvalidtextlayouterr)
       (error "layout-object ~S is not yet initialized with text. (#$kATSUinvalidtextlayouterr)" layout))
      (t (error "ATSUGettransientfontmatching failed with ~d" err)))))


(defmethod draw-text ((layout layout-object) h &optional v 
                      &key (start 0) (end #$kATSUToTextEnd))
  (unless v
    (setq v (point-v h)
          h (point-h h)))
  (#_ATSUDrawText (layout-ptr layout)
   start
   end
   (#_long2fix h)
   (#_long2fix v)))

(defmethod layout-line-width ((layout layout-object))
  (rlet ((actual-size :bytecount)
         (width :ATSUTextMeasurement))
    (let ((err (#_atsugetlayoutcontrol (layout-ptr layout)
                #$kATSULineWidthTag
                4
                width
                actual-size)))
      ; (%get-unsigned-long actual-size)
      (case err
        ((#.#$kATSUNotSetErr) nil)
        ((#.#$noerr) (%get-signed-long width))
        (t (trap-error "ATSUGetLayoutControl" err)
            )))))

(defmethod (setf layout-line-width) (new-width (layout layout-object))
  (set-layout-line-width-given-layout (layout-ptr layout) new-width))
|#

(defun set-layout-line-width-given-layout (layout new-width)
  (rlet ((width :ATSUTextMeasurement (#_long2fix new-width))
         (values :pointer width)
         (tag :atsuattributetag #$kATSULineWidthTag)
         (size :bytecount 4))
    (let ((err (#_atsusetlayoutcontrols
                layout
                1
                tag
                size
                values)))
      (case err
        ((#.#$noerr) new-width)
        (t (trap-error "ATSUSetLayoutControls" err)
           )))))

#|
(defmethod layout-line-truncation ((layout layout-object))
  (rlet ((actual-size :bytecount)
         (truncation :atsulinetruncation))
    (let ((err (#_atsugetlayoutcontrol (layout-ptr layout)
                #$kATSULineTruncationTag
                4
                truncation
                actual-size)))
      ; (%get-unsigned-long actual-size)
      (case err
        ((#.#$kATSUNotSetErr) nil)
        ((#.#$noerr) 
         (let ((val (%get-unsigned-long truncation)))
           (values (case (logand val #$kATSUTruncateSpecificationMask)
                     ((0) nil)
                     ((1) :start)
                     ((2) :end)
                     ((3) :middle))
                   (when (> val #x7)
                     t))))
        (t (trap-error "ATSUGetLayoutControl" err)
           )))))
|#


#|
(defmethod set-layout-line-truncation ((layout layout-object) truncation
                                              &optional no-squash-p)
  (let ((trunc (ecase truncation
                 ((:none nil) #$kATSUTruncateNone)
                 ((:start) #$kATSUTruncateStart)
                 ((:end) #$kATSUTruncateEnd)
                 ((:middle) #$kATSUTruncateMiddle))))
    (when no-squash-p
      (setq trunc (logior #$kATSUTruncFeatNoSquishing trunc)))
    (rlet ((truncptr :ATSUTextMeasurement trunc)
           (values :pointer truncptr)
           (tag :atsuattributetag #$kATSULineTruncationTag)
           (size :bytecount 4))
      (let ((err (#_atsusetlayoutcontrols
                  (layout-ptr layout)
                  1
                  tag
                  size
                  values)))
        (case err
          ((#.#$noerr) truncation)
          (t (trap-error "ATSUSetLayoutControl" err)))))))


(defmethod set-layout-line-truncation ((layout layout-object) truncation
                                              &optional no-squash-p)
  (set-layout-line-truncation-given-layout (layout-ptr layout) truncation no-squash-p))
|#


(defun set-layout-line-truncation-given-layout (layout truncation &optional no-squash-p)
  (let ((trunc (ecase truncation
                 ((:none nil) #$kATSUTruncateNone)
                 ((:start :left) #$kATSUTruncateStart)  ;; what if bidi?
                 ((:end :right) #$kATSUTruncateEnd)
                 ((:middle :center) #$kATSUTruncateMiddle))))
    (when no-squash-p
      (setq trunc (logior #$kATSUTruncFeatNoSquishing trunc)))
    (rlet ((truncptr :ATSUTextMeasurement trunc)
           (values :pointer truncptr)
           (tag :atsuattributetag #$kATSULineTruncationTag)
           (size :bytecount 4))
      (let ((err (#_atsusetlayoutcontrols
                  layout
                  1
                  tag
                  size
                  values)))
        (case err
          ((#.#$noerr) truncation)
          (t (trap-error "ATSUSetLayoutControls" err)))))))


(defun set-layout-line-justification-given-layout (layout justification)
  (let ((just (ecase justification
                ((:none nil :left) #$kATSUNoJustification)
                ((:center :middle) #$kATSUCenterAlignment)
                ((:end :right) #$kATSUEndAlignment))))
    (rlet ((justptr :ATSUTextMeasurement just)  ;;??
           (values :pointer justptr)
           (tag :atsuattributetag #$kATSULineFlushFactorTag)
           (size :bytecount 4))
      (let ((err (#_atsusetlayoutcontrols
                  layout
                  1
                  tag
                  size
                  values)))
        (case err
          ((#.#$noerr) justification)
          (t (trap-error "ATSUSetLayoutControls" err)))))))
                 
  
#|
(defmethod get-layout-cg-context ((layout layout-object))
  (rlet ((actual-size :bytecount)
         (context :pointer))
    (let ((err (#_atsugetlayoutcontrol (layout-ptr layout)
                #$katsucgcontexttag
                4
                context
                actual-size)))
      (case err
        ((#.#$katsunotseterr) nil)
        ((#.#$noerr) (%get-ptr context))
        (t (trap-error "ATSUGetLayoutControl" err))))))

(defmethod set-layout-cg-context ((layout layout-object) cg-context)
  (rlet ((context :pointer cg-context)
         (values :pointer context)
         (tag :atsuattributetag #$kATSUCGContextTag)
         (size :bytecount 4))
    (let ((err (#_atsusetlayoutcontrols
                (layout-ptr layout)
                1
                tag
                size
                values)))
      (case err
        ((#.#$noerr) cg-context)
        (t (trap-error "ATSUSetLayoutControl" err))))))

(defmethod layout-line-alignment ((layout layout-object))
  (rlet ((alignment :fract))
    (#_ATSUGetLineControl
     (layout-ptr layout)
     0
     #$kATSULineFlushFactorTag
     #.(record-length :fract)
     alignment
     (%null-ptr))
    (%get-signed-long alignment)))

(defmethod (setf layout-line-alignment) (alignment (layout layout-object))
  (let ((align (ecase alignment
                 ((:left) #$kATSUStartAlignment)
                 ((:right) #$kATSUEndAlignment)
                 ((:center) #$kATSUCenterAlignment))))
    (rlet ((al :fract align)
           (values :pointer al)
           (tag :atsuattributetag #$kATSULineFlushFactorTag)
           (size :bytecount 4))
      (#_ATSUSetLayoutControls
       (layout-ptr layout)
       1
       tag
       size
       values)))
  alignment)

(defmethod layout-line-direction ((layout layout-object))
  (rlet ((direction :byte))
    (#_ATSUGetLineControl (layout-ptr layout)
            0
            #$katsulinedirectiontag
            1
            direction
            (%null-ptr))
    (if (zerop (%get-byte direction))
      :left
      :right)))

(defmethod (setf layout-line-direction) (direction (layout layout-object))
  (let ((direction (ecase direction
                     ((:left) 0)
                     ((:right) 1))))
    (rlet ((dir :byte direction)
           (values :pointer dir)
           (tag :atsuattributetag #$katsulinedirectiontag)
           (size :bytecount 1))
      (#_atsusetlayoutcontrols
       (layout-ptr layout)
       1
       tag
       size
       values)))
  direction)
|#

;;;
;;; line-layout-options
;;;

(defmethod set-layout-line-layout-options ((layout layout-object) options)
  (set-layout-line-layout-options-given-layout (layout-ptr layout) options))

(defun set-layout-line-layout-options-given-layout (layout-ptr options)
  (rlet ((options-ptr :atslinelayoutoptions options)
         (values :pointer options-ptr)
         (tag :atsuattributetag #$kATSULineLayoutOptionsTag)
         (size :bytecount 4))
    (let ((err (#_atsusetlayoutcontrols
                layout-ptr
                1
                tag
                size
                values)))
      (case err
        ((#.#$noerr) options)
        ;; FIXIT
        (t (warn "ATSUSetLayutControls [~D]" err)
           0 )))))

(defun set-layout-line-direction-given-layout (layout-ptr direction)
  (let ((direction (ecase direction
                     ((:left) 0)
                     ((:right) 1))))
    (rlet ((dir :byte direction)
           (values :pointer dir)
           (tag :atsuattributetag #$katsulinedirectiontag)
           (size :bytecount 1))
      (#_atsusetlayoutcontrols
       layout-ptr
       1
       tag
       size
       values)))
  direction)

#|
(defmethod layout-line-layout-options ((layout layout-object))
  (rlet ((actual-size :bytecount)
         (options :atslinelayoutoptions))
    (let ((err (#_atsugetlayoutcontrol (layout-ptr layout)
                #$kATSULineLayoutOptionstag
                4
                options
                actual-size)))
      ; (%get-unsigned-long actual-size)
      (case err
        ((#.#$kATSUNotSetErr) nil)
        ((#.#$noerr) 
         (%get-unsigned-long options))
        (t (trap-error "ATSUGetLayoutControl" err))))))
|#




;;; $Id: sysutils.lisp,v 1.14 2006/04/03 00:11:39 alice Exp $

;;; Defines:
;;;
;;; ats:text-width
;;; ats:layout-offset-to-pixel
;;; ats:layout-pixel-to-offset

;(in-package :ats)

(defgeneric atsu-text-width (layout-object &optional start length)
  (:documentation "returns width, ascent and desent.
length is a number of characters from start to measure.
The characters are counted in UTF-16 format, that is,
surrogate pairs should be counted as 2 chars."))

;; ATSUMeasureTextImage does not measure whitespaces
;; use ATSUMeasureText
; (defmethod atsu-text-width ((layout layout-object) &optional (start 0) end)
;   (declare (fixnum start))
;   (rlet ((r :rect))
;     (#_atsumeasuretextimage (layout-ptr layout)
;      start 
;      (or end #$kATSUtotextend)
;      0 0 r)
;     (- (pref r :rect.right) (pref r :rect.left))))

;; #_atsumeasuretext ignores layout settings e.g. #$kATSLineFractDisable
;; #_ATSUGetGlyphBounds does not. #_ATSUMeasureText is deprecated.
;
; (defmethod atsu-text-width ((layout layout-object) &optional (start 0) length)
;   (declare (fixnum start))
;   (rlet ((left :fixed)
;          (right :fixed)
;          (ascent :fixed)
;          (descent :fixed))
;     (#_atsumeasuretext (layout-ptr layout)
;      start
;      (or length #$katsutotextend)
;      left
;      right
;      ascent
;      descent)
;     ;; fix2long does ceiling/floor 
;     (values (ash (- (%get-long right) (%get-long left))
;                  -16)
;             ; (#_fix2long (- (%get-long right) (%get-long left)))
; 
;             (#_fix2long (%get-long ascent))
;             (#_fix2long (%get-long descent)))))

(defun atsu-text-width-given-layout (layout &optional (start 0) (length #$katsutotextend))
  (declare (fixnum start))
  (rlet ((trapezoid (array :atstrapezoid 1))
         (count :itemcount))
    (#_atsugetglyphbounds layout
     0 0
     start
     length
     ;; 2005-01-15  voodoo
     ;; A monaco 9 string of length 1 returns 5 instead of 6
     ;; without this option.
     ;; The difference is this:
     ;; * When a layout object has text "aaaaa", measuring the first #\a
     ;;   returns 6. But when a layout has text "a", it returns 5.
     ;; * Also measuring first 5 chars of length of 6 string such as "aaaaaa"
     ;;   and measuring 5 chars of length 5 produces a different result
     ;;   without #$kATSUseFractionalOrigins flag.
     ;;
     #$kATSUseFractionalOrigins         ; #$katsusedeviceorigins
     1
     trapezoid
     count)
    ; (print (#_fix2long (pref (pref trapezoid :atstrapezoid.upperright) :fixedpoint.x)))
    ; (print (#_fix2long (pref (pref trapezoid :atstrapezoid.upperleft) :fixedpoint.x)))
    ; (format t "count: ~d~%" (%get-unsigned-long count))
    (values 
     (if (zerop length)
       0
       #+ignore
       (#_fix2long (- (pref (pref trapezoid :atstrapezoid.upperright) :fixedpoint.x)
                      (pref (pref trapezoid :atstrapezoid.upperleft) :fixedpoint.x)))
       (#_fix2long (- (pref (pref trapezoid :atstrapezoid.lowerright) :fixedpoint.x)
                      (pref (pref trapezoid :atstrapezoid.lowerleft) :fixedpoint.x)))
       )
     (- (#_fix2long (pref (pref trapezoid :atstrapezoid.upperleft) :fixedpoint.y)))
     (#_fix2long (pref (pref trapezoid :atstrapezoid.lowerleft) :fixedpoint.y)))))

;; ATSUGetGlyphBounds version
(defmethod atsu-text-width ((layout layout-object) &optional (start 0) (length #$katsutotextend))
  (declare (fixnum start))
  (atsu-text-width-given-layout (layout-ptr layout) start length))  


#|

(defmethod %count-trapezoid ((layout layout-object) &optional (start 0) (length #$katsutotextend))
  (declare (fixnum start))
  (rlet ((count :itemcount))
    (#_atsugetglyphbounds (layout-ptr layout)
     0 0
     start
     length
     #$kATSUseFractionalOrigins
     0
     (%null-ptr)
     count)
    (%get-unsigned-long count)))

|#




;; FIXIT
;; default value of 3 for y is arbitrary. note 0 result in #$kATSUInvalidTextRangeErr
(defmethod layout-pixel-to-offset ((layout layout-object) x &optional (y 3))
  (layout-pixel-to-offset-given-layout (layout-ptr layout) x y))
  

#|
(defun layout-pixel-to-offset-given-layout (layout x &optional (y 3))
  (rlet ((offset1 :unichararrayoffset 0)
         (offset2 :unichararrayoffset)
         (leading-p :unsigned-byte))    ; boolean
    (let ((err (#_atsupositiontoOffset layout
                (#_long2fix x)
                (#_long2fix y)
                offset1
                leading-p
                offset2)))
      (if (eq err #$noerr)
        (values (%get-unsigned-long offset1)
                (= (%get-unsigned-byte leading-p) 1)
                (%get-unsigned-long offset2))
        ;; fixit
        (progn
          (format t "err: ~d~%" err)
          (values 0 nil 0))))))
|#

;; incomprehensible work around?? - use o2 if leading nil now done by caller for size <= 12
(defun layout-pixel-to-offset-given-layout (layout x &optional (y 3))
  (rlet ((offset1 :unichararrayoffset 0)
         (offset2 :unichararrayoffset)
         (leading-p :unsigned-byte))    ; boolean
    (let ((err (#_atsupositionToOffset layout
                (#_long2fix x)
                (#_long2fix y)
                offset1
                leading-p
                offset2)))
      (if (eq err #$noerr)
        (let ((o1 (%get-unsigned-long offset1))
              (leading (= (%get-unsigned-byte leading-p) 1))
              (o2 (%get-unsigned-long offset2)))
          (values o1 leading o2))
        ;; fixit
        (progn
          (format t "err: ~d~%" err)
          (values 0 nil 0))))))

#|
(defmethod layout-offset-to-pixel ((layout layout-object) offset &optional (leading-p t))
  (rlet ((main-caret :atsucaret)
         (second-caret :atsucaret)
         (caret-split-p :unsigned-byte))
    (let ((err (#_ATSUOffsetToPosition (layout-ptr layout)
                offset
                (if leading-p 1 0)
                main-caret
                second-caret
                caret-split-p)))
      (if (eq err #$noerr)
        (values (#_fix2long (pref main-caret :atsucaret.fx))
                (when (= (%get-unsigned-byte caret-split-p) 1)
                  (#_fix2long (pref second-caret :atsucaret.fx))))
        ;; FIXIT
        (progn (format t "error ~d ATSUOffsetToPosition" err)
               0)))))
|#












      
      

