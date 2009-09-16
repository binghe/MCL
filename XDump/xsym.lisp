;;;-*- Mode: Lisp; Package: CCL -*-


; 02/22/96 bill move xsym-module definition before all uses of it.
; 01/20/96  gb  coerce to SIMPLE-BASE-STRING; :initial-element 
;               in MAKE-ARRAY call.
; 08/16/95  gb  set XSYM creator to "R2Db".

(in-package "CCL")

(defconstant xsym-page-size #x1000)
(defconstant xsym-page-shift #xc)

(defconstant xsym-page-halfword-size (ash xsym-page-size -1))
(defconstant xsym-page-halfword-shift #xb)

(defconstant xsym-frte-halfwords 5)
(defconstant xsym-rte-halfwords 9)
(defconstant xsym-mte-halfwords 22)
(defconstant xsym-cmte-halfwords 3)
(defconstant xsym-cvte-halfwords 13)
(defconstant xsym-csnte-halfwords 4)
(defconstant xsym-clte-halfwords 7)
(defconstant xsym-ctte-halfwords 4)
(defconstant xsym-tte-halfwords 2)
(defconstant xsym-tinfo-halfwords 5)
(defconstant xsym-fite-halfwords 3)

(defconstant xsym-new-entry #xfffe)
(defconstant xsym-end-of-list #xffff)

(defconstant xsym-kmtNone 0)
(defconstant xsym-kmtProgram 1)
(defconstant xsym-kmtUnit 2)
(defconstant xsym-kmtFunction 4)
(defconstant xsym-kmtBlock 6)

(defconstant xsym-kssLocal 0)
(defconstant xsym-kssGlobal 1)

(defun xsym-hash-string (s)
  (let* ((len (length s))
         (hash 0))
    (declare (fixnum hash))
    (dotimes (i len (logand #x3ff (logior hash (ash len 8))))
      (setq hash (logand #xff 
                         (the fixnum (+ (char-code (schar s i)) 
                                        (dpb (ldb (byte 3 0) hash) 
                                             (byte 3 5) 
                                             (ldb (byte 5 3) hash)))))))))

(defun pagebuf-push-halfword (p w)
  (vector-push-extend w p)
  w)

(defun pagebuf-align-to-pagesize (p)
  (let* ((len (length p))
         (new (round-up len xsym-page-halfword-size)))
    (dotimes (i (- new len) new)
      (vector-push-extend 0 p))))

(defun pagebuf-push-fullword (p f)
  (pagebuf-push-halfword p (ldb (byte 16 16) f))
  (pagebuf-push-halfword p (ldb (byte 16 0) f)))

(defun pagebuf-push-ostype (p o)
  (let* ((f (ccl::%stack-block ((ptr 4))
              (setf (ccl::%get-ostype ptr) o)
              (ccl::%get-unsigned-long ptr))))
    (pagebuf-push-fullword p f)))

(defun make-pagebuf (&optional (startword 0))
  (let* ((p (make-array 0 
                        :element-type '(unsigned-byte 16)
                        :adjustable t
                        :fill-pointer 0)))
    (dotimes (i startword)
      (pagebuf-push-halfword p 0))
    p))

(defun pagebuf-byte-size (p)
  (* 2 (length p)))

(defun pagebuf-page-size (p)
  (/ (logand (lognot (1- xsym-page-size))
             (+ (pagebuf-byte-size p) (1- xsym-page-size)))
     xsym-page-size))

(defstruct (xysm (:constructor make-xsym (filename 
                                          file-object
                                          target-mod-date 
                                          &key 
                                          pef-filename
                                          pef-creator 
                                          pef-filetype))
                 (:conc-name xsym-))
  (filename nil)
  (pef-filename nil)
  (pef-creator "????")
  (pef-filetype "shlb")
  (target-mod-date nil)
  (file-object nil)
  (header-page (make-pagebuf))
  (frte nil)
  (frte-count 0)
  (rte nil)
  (rte-count 0)
  (mte nil)
  (mte-count 0)
  (cmte nil)
  (cmte-count 0)
  (cvte nil)
  (cvte-count 0)
  (csnte nil)
  (csnte-count 0)
  (clte nil)
  (clte-count 0)
  (ctte nil)
  (ctte-count 0)
  (tte nil)
  (tte-count 0)
  (nte nil)
  (nte-count 0)
  (tinfo nil)
  (tinfo-count 0)
  (fite nil)
  (fite-count 0)
  (const nil)
  (const-count 0)
  (nameset (make-hash-table :test #'equal))
  (hash-buckets (make-array #x400 :initial-element nil))
  (hash-vector (make-array #x400 :element-type '(unsigned-byte 32) :initial-element 0))
  (rte-vector (make-array 0 :fill-pointer 0 :adjustable t))
  (file-vector (make-array 0 :fill-pointer 0 :adjustable t))
  (modules (xsym-new-module-table)))

(defstruct xsym-file
  name
  mod-date
  module-offset-pairs
  (frte-index 0))

(defun xsym-new-file (xsym name mod-date module-offset-pairs)
  (vector-push-extend (make-xsym-file :name (xsym-register-name xsym name) :mod-date mod-date :module-offset-pairs module-offset-pairs)
                      (xsym-file-vector xsym)))


(defun xsym-register-name (xsym s)
  (let* ((buckets (xsym-hash-buckets xsym))
         (str (coerce s 'simple-base-string))
         (hash (xsym-hash-string str)))
    (car (or (member str (aref buckets hash) :test #'string=)
             (push str (aref buckets hash))))))

(defun xsym-ensure-pagebuf-room (p nwords)
  (declare (fixnum nwords))
  (let* ((i (length p)))
    (declare (fixnum i))
    (if (> (ash (+ nwords i) (- xsym-page-halfword-shift))
           (ash i (- xsym-page-halfword-shift)))
      (pagebuf-align-to-pagesize p)
      i)))

;; Don't let S cross a page boundary in P

(defun xsym-ensure-nte-room (nte-buf s)
  (xsym-ensure-pagebuf-room nte-buf (ash (round-up (1+ (length s)) 2) -1)))

(defun xsym-add-nte (xsym s)
  (let* ((p (or (xsym-nte xsym)
                (setf (xsym-nte xsym) (make-pagebuf 1))))
         (idx (xsym-ensure-nte-room p s))
         (len (length s)))
    (declare (fixnum len idx))
    (if (zerop len)
      0
      (let* ((str (coerce s 'simple-base-string)))
        (pagebuf-push-halfword p (dpb len (byte 8 8) (char-code (schar str 0))))
        (do* ((i 1 (+ i 2))
              (j (1+ i) (1+ i)))
             ((or (= i len)
                  (= j len))
              (unless (= i len) (pagebuf-push-halfword 
                                 p
                                 (dpb (char-code (schar str i)) 
                                      (byte 8 8)
                                      0))))
          (declare (fixnum i j))
          (pagebuf-push-halfword p (dpb (char-code (schar str i)) 
                                        (byte 8 8)
                                        (char-code (schar str j)))))
        (incf (xsym-nte-count xsym))
        (setf (gethash str (xsym-nameset xsym)) idx)))))
        
(defun xsym-add-symlist (xsym l)
  (if l
    (let* ((i (xsym-add-nte xsym (car l))))
      (dolist (s (cdr l)) (xsym-add-nte xsym s))
      (vector-push-extend #x100 (xsym-nte xsym))
      i)
    0))


(defun xsym-name-index (xsym name)
  (if name
    (or (gethash name (xsym-nameset xsym))
        (error "~S: name not registered in SYM file hash table." name))
    0))

(defstruct (rte (:print-function print-rte))
  rclass
  rnum
  name
  size
  (first-mte 0)
  (last-mte 0))
         
(defun print-rte (r s d)
  (declare (ignore d))
  (print-unreadable-object (r s :type t :identity t)
    (format s "~A-~D" (rte-rclass r) (rte-rnum r))))

(defun xsym-new-rte (xsym rclass rnum name size)
  (vector-push-extend
   (make-rte :rclass rclass :rnum rnum :name (xsym-register-name xsym name) :size size)
   (xsym-rte-vector xsym)))

(defun xsym-add-rte (xsym rte)
  (let* ((p (or (xsym-rte xsym)
                (setf (xsym-rte-count xsym) 1
                      (xsym-rte xsym) (make-pagebuf xsym-rte-halfwords))))
         (idx (xsym-rte-count xsym)))
    (xsym-ensure-pagebuf-room p xsym-rte-halfwords)
    (pagebuf-push-ostype p (rte-rclass rte))
    (pagebuf-push-halfword p (rte-rnum rte))
    (pagebuf-push-fullword p (xsym-name-index xsym (rte-name rte)))
    (pagebuf-push-halfword p (rte-first-mte rte))
    (pagebuf-push-halfword p (rte-last-mte rte))
    (pagebuf-push-fullword p (rte-size rte))   
    idx))

(defun xsym-add-rtes (x)
  (let* ((rtes (xsym-rte-vector x))
         (n (length rtes)))
    (dotimes (i (length rtes) (setf (xsym-rte-count x) n))
      (xsym-add-rte x (aref rtes i)))))

(defun xsym-add-frte (xsym type nameidx date)
  (let* ((p (or (xsym-frte xsym)
                (setf (xsym-frte-count xsym) 1
                      (xsym-frte xsym) (make-pagebuf xsym-frte-halfwords))))
         (idx (xsym-frte-count xsym)))
    (xsym-ensure-pagebuf-room p xsym-frte-halfwords)
    (pagebuf-push-halfword p type)
    (pagebuf-push-fullword p nameidx)
    (pagebuf-push-fullword p date)
    (incf (xsym-frte-count xsym))
    idx))

(defun xsym-add-fite (xsym frte-index nameidx)
  (let* ((p (or (xsym-fite xsym)
                (setf (xsym-fite-count xsym) 1 
                      (xsym-fite xsym) (make-pagebuf xsym-fite-halfwords))))
         (idx (xsym-fite-count xsym)))
    (xsym-ensure-pagebuf-room p xsym-fite-halfwords)
    (pagebuf-push-halfword p frte-index)
    (pagebuf-push-fullword p nameidx)
    (incf (xsym-fite-count xsym))
    idx))

(defstruct (xsym-module (:print-function print-xsym-module))
  name
  kind
  scope
  (rte 0)
  (offset 0)
  (length 0)
  (idx (error "Missing module index!"))
  parent
  contains
  (frte-index 0))

(defun xsym-add-files (xsym)
  (let* ((files (xsym-file-vector xsym)))
    (dotimes (i (length files))
      (let* ((file (aref files i))
             (nameidx (xsym-name-index xsym (xsym-file-name file)))
             (frte-index (xsym-add-frte xsym xsym-new-entry nameidx (xsym-file-mod-date file))))
        (xsym-add-fite xsym frte-index nameidx)
        (dolist (mod&offset (xsym-file-module-offset-pairs file))
          (let* ((mod (car mod&offset))
                 (mod-num (xsym-module-idx mod)))
            (xsym-add-frte xsym mod-num  (cdr mod&offset) 0)
            (setf (xsym-module-frte-index mod) frte-index)))       ; or index of FITE, maybe ?
        (xsym-add-frte xsym xsym-end-of-list 0 0)))
    (xsym-add-fite xsym xsym-end-of-list 0)))
        
(defun xsym-add-cmte (xsym mte-index nameidx)
  (let* ((p (or (xsym-cmte xsym)
                (setf (xsym-cmte-count xsym) 1
                      (xsym-cmte xsym) (make-pagebuf xsym-cmte-halfwords))))
         (idx (xsym-cmte-count xsym)))
    (xsym-ensure-pagebuf-room p xsym-cmte-halfwords)
    (pagebuf-push-halfword p mte-index)
    (pagebuf-push-fullword p nameidx)
    (incf (xsym-cmte-count xsym))
    idx))

(defun xsym-new-module-table ()
  (let* ((v (make-array 0 :adjustable t :fill-pointer 0)))
    (vector-push-extend (make-xsym-module :idx 0) v)
    v))

(defun print-xsym-module (xm s d)
  (declare (ignore d))
  (print-unreadable-object (xm s :type t)
    (format s "~s" (xsym-module-name xm))))

(defun xsym-contain-module (parent child)
  (setf (xsym-module-parent child) parent)
  (pushnew child (xsym-module-contains parent))
  nil)

(defun xsym-new-program (xsym name)
  (let* ((v (xsym-modules xsym))
         (rte-num 1)
         (idx (fill-pointer v))
         (p (make-xsym-module 
             :name (xsym-register-name xsym name)
             :kind xsym-kmtProgram
             :rte rte-num
             :scope xsym-kssLocal
             :idx idx)))
    (if (> rte-num 0)
      (let* ((rte (aref (xsym-rte-vector xsym) (1- rte-num))))
        (if (zerop (rte-first-mte rte))
          (setf (rte-first-mte rte) idx))
        (setf (rte-last-mte rte) idx)))    (vector-push-extend p v)
    p))

(defun xsym-new-unit (xsym program unit-name)
  (let* ((v (xsym-modules xsym))
         (rte-num 1)
         (idx (fill-pointer v))
         (u (make-xsym-module 
             :name (xsym-register-name xsym unit-name)
             :kind xsym-kmtUnit
             :rte rte-num
             :scope xsym-kssGlobal
             :idx idx)))
    (if program
      (xsym-contain-module program u))
    (if (> rte-num 0)
      (let* ((rte (aref (xsym-rte-vector xsym) (1- rte-num))))
        (if (zerop (rte-first-mte rte))
          (setf (rte-first-mte rte) idx))
        (setf (rte-last-mte rte) idx)))
    (vector-push-extend u v)
    u))

;; N.B. : all modules which share the same non-zero RTE entry
;; must be added contiguously.
(defun xsym-new-module (xsym unit module-name rte-num offset length)
  (declare (fixnum rte-num))
  (let* ((v (xsym-modules xsym))
         (idx (fill-pointer v))
         (m (make-xsym-module 
             :name (xsym-register-name xsym module-name)
             :rte rte-num
             :offset offset
             :length length
             :kind xsym-kmtFunction #|xsym-kmtNone|#
             :scope xsym-kssGlobal
             :idx idx)))
    (xsym-contain-module unit m)
    (if (> rte-num 0)
      (let* ((rte (aref (xsym-rte-vector xsym) (1- rte-num))))
        (if (zerop (rte-first-mte rte))
          (setf (rte-first-mte rte) idx))
        (setf (rte-last-mte rte) idx)))
    (vector-push-extend m v)
    m))

(defun xsym-add-module-cmte (xsym mod)
  (xsym-add-cmte xsym
                 (xsym-module-idx mod)
                 (xsym-name-index xsym (xsym-module-name mod))))

(defun xsym-add-cmte-list (xsym contained)
  (if contained
    (let* ((head (xsym-add-module-cmte xsym (car contained))))
      (dolist (m (cdr contained) (xsym-add-cmte xsym xsym-end-of-list 0))
        (xsym-add-module-cmte xsym m))
      head)
    0))

(defun xsym-add-modules (xsym)
  (let* ((p (or (xsym-mte xsym)
                (setf (xsym-mte xsym) (make-pagebuf xsym-mte-halfwords))))
         (mods (xsym-modules xsym))
         (nmods (length mods)))
    (do* ((i 1 (1+ i)))
         ((= i nmods) (setf (xsym-mte-count xsym) (1- nmods)))
      (declare (fixnum i nmods))
      (let* ((m (aref mods i)))
        (xsym-ensure-pagebuf-room p xsym-mte-halfwords)
        (pagebuf-push-halfword p (xsym-module-rte m))
        (pagebuf-push-fullword p (xsym-module-offset m))
        (pagebuf-push-fullword p (xsym-module-length m))
        (pagebuf-push-halfword p (dpb (xsym-module-kind m) (byte 8 8) (xsym-module-scope m)))
        (pagebuf-push-halfword p (let* ((parent (xsym-module-parent m)))
                                   (if parent
                                     (xsym-module-idx parent)
                                     0)))
        (pagebuf-push-halfword p (xsym-module-frte-index m))     ; FRTE index of source
        (pagebuf-push-fullword p 0)     ;   source start line
        (pagebuf-push-fullword p 0)     ;   source end line
        (pagebuf-push-fullword p (xsym-name-index xsym (xsym-module-name m)))
        (pagebuf-push-halfword p (xsym-add-cmte-list xsym (xsym-module-contains m)))
        (pagebuf-push-halfword p 0)     ; CVTE
        (pagebuf-push-halfword p 0)     ; CLTE
        (pagebuf-push-halfword p 0)     ; CTTE
        (pagebuf-push-fullword p 0)     ; CSNTE start
        (pagebuf-push-fullword p 0))))) ; CSNTE end

; Should return "next available" page number
(defun write-xsym-pagebuf (xsym pagebuf pageno)
  (if pagebuf
    (let* ((f (xsym-file-object xsym))
           (cureof (file-length f))
           (newpos (* pageno xsym-page-size)))
      (if (< cureof newpos)
        (file-length f newpos))
      (file-position f newpos)
      (let* ((cur-fill (fill-pointer pagebuf))
             (nbytes (* 2 (pagebuf-align-to-pagesize pagebuf)))
             (v16 (ccl::array-data-and-offset pagebuf)))
        (ccl::write-from-vector f v16 :length nbytes)
        (setf (fill-pointer pagebuf) cur-fill)
        (+ pageno (pagebuf-page-size pagebuf))))
    pageno))

(defun xsym-add-symbols (x)
  (setf (gethash "" (xsym-nameset x)) 0)
  (let* ((buckets (xsym-hash-buckets x))
         (vector (xsym-hash-vector x))
         (len (length buckets)))
    (dotimes (i len)
      (setf (aref vector i) (xsym-add-symlist x (aref buckets i))))))

;; Return next available page number after hash page, nte page(s).
(defun xsym-write-symbols (x hash-pageno)
  (let* ((f (xsym-file-object x))
         (vector (xsym-hash-vector x))
         (len (length vector)))
    (file-position f (* hash-pageno xsym-page-size))
    (ccl::write-from-vector f vector :length (* 4 len))
    (/ (file-position f) xsym-page-size)))

(defun write-xsym-file (x)
  (let* ((f (xsym-file-object x)))
    (when f
      (ccl::set-mac-file-type (xsym-filename x) "MPSY")
      (ccl::set-mac-file-creator (xsym-filename x) "R2Db")
      (xsym-add-symbols x)
      (xsym-add-files x)
      (xsym-add-rtes x)
      (xsym-add-modules x)
      (let* ((nte-page 1)
             (hash-page (progn
                          (file-position (xsym-file-object x) (* 1 xsym-page-size))
                          (write-xsym-pagebuf x (xsym-nte x) nte-page)))
             (frte-page (xsym-write-symbols x hash-page))
             (rte-page (write-xsym-pagebuf x (xsym-frte x) frte-page))
             (mte-page (write-xsym-pagebuf x (xsym-rte x) rte-page))
             (cmte-page (write-xsym-pagebuf x (xsym-mte x) mte-page))
             (cvte-page (write-xsym-pagebuf x (xsym-cmte x) cmte-page))
             (csnte-page (write-xsym-pagebuf x (xsym-cvte x) cvte-page))
             (clte-page (write-xsym-pagebuf x (xsym-csnte x) csnte-page))
             (ctte-page (write-xsym-pagebuf x (xsym-clte x) clte-page))
             (tte-page (write-xsym-pagebuf x (xsym-ctte x) ctte-page))
             (tinfo-page (write-xsym-pagebuf x (xsym-tte x) tte-page))
             (fite-page (write-xsym-pagebuf x (xsym-tinfo x) tinfo-page))
             (const-page (write-xsym-pagebuf x (xsym-fite x) fite-page))
             (header (xsym-header-page x)))
        (write-xsym-pagebuf x (xsym-const x) const-page)
        (pagebuf-push-fullword header #x0B566572)         ; .byte 11,'Ver'
        (pagebuf-push-fullword header #x73696F6E)         ; .byte 'sion'
        (pagebuf-push-fullword header #x20332E32)         ; .byte ' 3.2'
        (dotimes (i (- #x10 (fill-pointer header)))
          (vector-push-extend 0 header))
        (pagebuf-push-halfword header xsym-page-size)
        (pagebuf-push-halfword header hash-page)
        (pagebuf-push-halfword header 1)          ; MTE root idx
        (pagebuf-push-fullword header (xsym-target-mod-date x))
        (flet ((push-pagebuf (p start-page object-count)
                 (if p
                   (progn
                     (pagebuf-push-halfword header start-page)
                     (pagebuf-push-halfword header (pagebuf-page-size p))
                     (pagebuf-push-fullword header object-count))
                   (progn
                     (pagebuf-push-fullword header 0)
                     (pagebuf-push-fullword header 0)))))
          (push-pagebuf (xsym-frte x) frte-page (xsym-frte-count x))
          (push-pagebuf (xsym-rte x) rte-page (xsym-rte-count x))
          (push-pagebuf (xsym-mte x) mte-page (xsym-mte-count x))
          (push-pagebuf (xsym-cmte x) cmte-page (xsym-cmte-count x))
          (push-pagebuf (xsym-cvte x) cvte-page (xsym-cvte-count x))
          (push-pagebuf (xsym-csnte x) csnte-page (xsym-csnte-count x))
          (push-pagebuf (xsym-clte x) clte-page (xsym-clte-count x))
          (push-pagebuf (xsym-ctte x) ctte-page (xsym-ctte-count x))
          (push-pagebuf (xsym-tte x) tte-page (xsym-tte-count x))
          (let* ((nnte (pagebuf-page-size (xsym-nte x))))
            (pagebuf-push-halfword header nte-page)
            (pagebuf-push-halfword header nnte)
            (pagebuf-push-fullword header (xsym-nte-count x)))
          (push-pagebuf (xsym-tinfo x) tinfo-page (xsym-tinfo-count x))
          (push-pagebuf (xsym-fite x) fite-page (xsym-fite-count x))
          (push-pagebuf nil 0 0))          ; CONST ???
        (pagebuf-push-ostype header (xsym-pef-creator x))
        (pagebuf-push-ostype header (xsym-pef-filetype x))
        (write-xsym-pagebuf x header 0)
        x))))
