;;; -*- Package: ccl; -*-

(in-package :ccl)

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

  ;; for some reason, stream-writer for an output stream returns sometimes
  ;; the default (stream-tyo . stream) value rather than the (stream-tyo . (column . fblock))
  ;; which is expected.

  (labels ((coerce-to-fblock (object)
             (etypecase object
               (internal-structure 
                (assert (eq (uvref object 0) 'fblock) () "Not an FBLOCK: ~s" object)
                object)
               (cons (coerce-to-fblock (cdr object)))
               (file-stream (coerce-to-fblock (column.fblock object))))))
    (defun fasl-out-ivect (iv &optional 
                              (start 0) 
                              (nb 
                               #-ppc-target (%vect-byte-size iv)
                               #+ppc-target (ppc-subtag-bytes (ppc-typecode iv) (uvsize iv))))
      (%fwrite-from-vector (coerce-to-fblock *fasdump-writer-arg*) iv start nb))
    ))
