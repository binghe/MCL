;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; fasl-concatenate.lisp
;;; Copyright 1992-1994, Apple Computer, Inc.
;;; Copyright 1995, Digitool, Inc.
;;;
;;; Concatenate fasl files.

;;; Format of a fasl file as expected by the fasloader.
;;;
;;; #xFF00         2 bytes - File version
;;; Block Count    2 bytes - Number of blocks in the file
;;; addr[0]        4 bytes - address of 0th block
;;; length[0]      4 bytes - length of 0th block
;;; addr[1]        4 bytes - address of 1st block
;;; length[1]      4 bytes - length of 1st block
;;; ...
;;; addr[n-1]      4 bytes
;;; length[n-1]    4 bytes
;;; length[0] + length[1] + ... + length [n-1] bytes of data

; Modification History
;
; akh add gfsl-concatenate
; 10/09/96 slh   move export to inside eval-when
; 11/13/95 slh   Mods. for PPC
; 04/28/93 mwp   Release

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(fasl-concatenate
            pfsl-concatenate)))

(defconstant $fasl-id #xff00)          ; fasl file id

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (fasl-concatenate out-file fasl-files &key :if-exists)
;; (pfsl-concatenate out-file fasl-files &key :if-exists)
;;
;; out-file     name of file in which to store the concatenation
;; fasl-files   list of names of fasl/pfsl files to concatenate
;; if-exists    as for OPEN, defaults to :error
;;
;; function result: pathname to the output file.
;; All file types default to "FASL"/"PFSL"
;; It works to use the output of one invocation of fasl-concatenate
;; as an input of another invocation.
;;
(defun fasl-concatenate (out-file fasl-files &key (if-exists :error))  
  (%fasl-concatenate out-file fasl-files if-exists ".fasl" :fasl))

(defun pfsl-concatenate (out-file fasl-files &key (if-exists :error))
  (%fasl-concatenate out-file fasl-files if-exists ".pfsl" :pfsl))

;; for current fasl type.
(defun gfsl-concatenate (out-file fasl-files &key (if-exists :error))  
  (let* ((ext *.fasl-pathname*)
         (type (intern (string-upcase (pathname-type ext)) :keyword)))
    (%fasl-concatenate out-file fasl-files if-exists ext type)))
    

(defun %fasl-concatenate (out-file fasl-files if-exists file-ext mac-type)
  (let ((count 0)
        (created? nil)
        (finished? nil))
    (declare (fixnum count))
    (dolist (file fasl-files)
      (setq file (merge-pathnames file file-ext))
      (unless (eq (mac-file-type file) mac-type)
        (error "Not a ~A file: ~s" mac-type file))
      (with-open-file (stream file)
        (multiple-value-bind (r ra) (stream-reader stream)
          (unless (eql $fasl-id (reader-read-word r ra))
            (error "Bad ~A file ID in ~s" mac-type file))
          (incf count (reader-read-word r ra)))))
    (unwind-protect
      (with-open-file (stream (setq out-file (merge-pathnames out-file file-ext))
                              :direction :output
                              :if-does-not-exist :create
                              :if-exists if-exists)
        (set-mac-file-creator out-file :ccl2)
        (set-mac-file-type out-file mac-type)
        (setq created? t)
        (multiple-value-bind (w wa) (stream-writer stream)
          (let ((addr-address 4)
                (data-address (+ 4 (* count 8))))
            (writer-write-word 0 w wa)         ;  will be $fasl-id
            (writer-write-word count w wa)
            (dotimes (i (* 2 count))
              (writer-write-long 0 w wa))       ; for addresses/lengths
            (dolist (file fasl-files)
              (with-open-file (in-stream (merge-pathnames file file-ext))
                (multiple-value-bind (r ra) (stream-reader in-stream)
                  (reader-read-word r ra)    ; skip ID
                  (let* ((fasl-count (reader-read-word r ra))
                         (addrs (make-array fasl-count))
                         (sizes (make-array fasl-count))
                         addr0)
                    (declare (fixnum fasl-count)
                             (dynamic-extent addrs sizes))
                    (dotimes (i fasl-count)
                      (setf (svref addrs i) (reader-read-long r ra)
                            (svref sizes i) (reader-read-long r ra)))
                    (setq addr0 (svref addrs 0))
                    (file-position stream addr-address)
                    (dotimes (i fasl-count)
                      (writer-write-long
                       (+ data-address (- (svref addrs i) addr0))
                       w wa)
                      (writer-write-long (svref sizes i) w wa)
                      (incf addr-address 8))
                    (file-position stream data-address)
                    (dotimes (i fasl-count)
                      (file-position in-stream (svref addrs i))
                      (let ((fasl-length (svref sizes i)))
                        (dotimes (j fasl-length)
                          (funcall w wa (funcall r ra)))
                        (incf data-address fasl-length)))))))
            (file-length stream data-address)
            (file-position stream 0)
            (writer-write-word $fasl-id w wa)
            (setq finished? t))))
      (when (and created? (not finished?))
        (delete-file out-file))))
  out-file)


(defun writer-write-byte (byte writer writer-arg)
  (declare (fixnum byte))
  (funcall writer writer-arg (%code-char (logand #xff byte))))

(defun writer-write-word (word writer writer-arg)
  (declare (fixnum word))
  (writer-write-byte (the fixnum (ash word -8)) writer writer-arg)
  (writer-write-byte (the fixnum (logand #xff word)) writer writer-arg))

(defun writer-write-long (long writer writer-arg)
  (writer-write-word (ash long -16) writer writer-arg)
  (writer-write-word (logand #xffff long) writer writer-arg))

(defun reader-read-byte (reader reader-arg)
  (char-code (the character (funcall reader reader-arg))))

(defun reader-read-word (reader reader-arg)
  (the fixnum
       (logior (the fixnum 
                    (ash (the fixnum (reader-read-byte reader reader-arg))
                         8))
               (the fixnum (reader-read-byte reader reader-arg)))))

(defun reader-read-long (reader reader-arg)
  (logior (ash (reader-read-word reader reader-arg) 16)
          (reader-read-word reader reader-arg)))

; End of fasl-concatenate.lisp
