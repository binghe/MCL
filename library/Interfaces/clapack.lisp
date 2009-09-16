(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:clapack.h"
; at Sunday July 2,2006 7:25:23 pm.
; 
;    =================================================================================================
;    Definitions and prototypes for LAPACK as provided Apple Computer.
; 
;    Documentation of the LAPACK interfaces, including reference implementations, can be found on the web
;    starting from the LAPACK FAQ page at this URL (verified live as of April 2002):
;         http://netlib.org/lapack/faq.html
;         
;    A hardcopy maanual is:
;         LAPACK Users' Guide, Third Edition. 
;         @BOOK{laug,
;             AUTHOR = {Anderson, E. and Bai, Z. and Bischof, C. and
;                         Blackford, S. and Demmel, J. and Dongarra, J. and
;                         Du Croz, J. and Greenbaum, A. and Hammarling, S. and
;                         McKenney, A. and Sorensen, D.},
;             TITLE = {{LAPACK} Users' Guide},
;             EDITION = {Third},
;             PUBLISHER = {Society for Industrial and Applied Mathematics},
;             YEAR = {1999},
;             ADDRESS = {Philadelphia, PA},
;             ISBN = {0-89871-447-8 (paperback)} }
; 
;    =================================================================================================
; 
; #ifndef __CLAPACK_H
; #define __CLAPACK_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(def-mactype :int (find-mactype ':signed-long)) ; __CLPK_integer

(def-mactype :int (find-mactype ':signed-long)) ; __CLPK_logical

(def-mactype :__CLPK_real (find-mactype ':single-float))

(def-mactype :__CLPK_doublereal (find-mactype ':double-float))

(def-mactype :__CLPK_L_fp (find-mactype ':pointer))

(def-mactype :int (find-mactype ':signed-long)) ; __CLPK_ftnlen
(defrecord __CLPK_complex
   (r :single-float)
   (i :single-float))
(defrecord __CLPK_doublecomplex
   (r :double-float)
   (i :double-float))
;  Subroutine 

(deftrap-inline "_cbdsqr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ncvt (:pointer :__clpk_integer))
    (nru (:pointer :__clpk_integer))
    (ncc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (vt (:pointer :__CLPK_COMPLEX))
    (ldvt (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_COMPLEX))
    (ldu (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbbrd_" 
   ((vect (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ncc (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (pt (:pointer :__CLPK_COMPLEX))
    (ldpt (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbequ_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_COMPLEX))
    (ldafb (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbsv_" 
   ((n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_COMPLEX))
    (ldafb (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbtf2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbtrf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgbtrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgebak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgebal_" 
   ((job (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgebd2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tauq (:pointer :__CLPK_COMPLEX))
    (taup (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgebrd_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tauq (:pointer :__CLPK_COMPLEX))
    (taup (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgecon_" 
   ((norm (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeequ_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgees_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (vs (:pointer :__CLPK_COMPLEX))
    (ldvs (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeesx_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (vs (:pointer :__CLPK_COMPLEX))
    (ldvs (:pointer :__clpk_integer))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (abnrm (:pointer :__CLPK_REAL))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgegs_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (vsl (:pointer :__CLPK_COMPLEX))
    (ldvsl (:pointer :__clpk_integer))
    (vsr (:pointer :__CLPK_COMPLEX))
    (ldvsr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgegv_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgehd2_" 
   ((n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgehrd_" 
   ((n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgelq2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgelqf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgels_" 
   ((trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgelsx_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgelsy_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeql2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeqlf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeqp3_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeqpf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeqr2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgeqrf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgerfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgerq2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgerqf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgesc2_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (rhs (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (jpiv (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgesv_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgesvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgetc2_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (jpiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgetf2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgetrf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgetri_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgetrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggbak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (lscale (:pointer :__CLPK_REAL))
    (rscale (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggbal_" 
   ((job (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (lscale (:pointer :__CLPK_REAL))
    (rscale (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgges_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (selctg :pointer)
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (vsl (:pointer :__CLPK_COMPLEX))
    (ldvsl (:pointer :__clpk_integer))
    (vsr (:pointer :__CLPK_COMPLEX))
    (ldvsr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggesx_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (selctg :pointer)
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (vsl (:pointer :__CLPK_COMPLEX))
    (ldvsl (:pointer :__clpk_integer))
    (vsr (:pointer :__CLPK_COMPLEX))
    (ldvsr (:pointer :__clpk_integer))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (lscale (:pointer :__CLPK_REAL))
    (rscale (:pointer :__CLPK_REAL))
    (abnrm (:pointer :__CLPK_REAL))
    (bbnrm (:pointer :__CLPK_REAL))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggglm_" 
   ((n (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (y (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgghrd_" 
   ((compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgglse_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggqrf_" 
   ((n (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (taua (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (taub (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggrqf_" 
   ((m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (taua (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (taub (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggsvd_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_COMPLEX))
    (ldu (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cggsvp_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (tola (:pointer :__CLPK_REAL))
    (tolb (:pointer :__CLPK_REAL))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_COMPLEX))
    (ldu (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgtcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (du2 (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgtrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (dlf (:pointer :__CLPK_COMPLEX))
    (df (:pointer :__CLPK_COMPLEX))
    (duf (:pointer :__CLPK_COMPLEX))
    (du2 (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgtsv_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgtsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (dlf (:pointer :__CLPK_COMPLEX))
    (df (:pointer :__CLPK_COMPLEX))
    (duf (:pointer :__CLPK_COMPLEX))
    (du2 (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgttrf_" 
   ((n (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (du2 (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgttrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (du2 (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cgtts2_" 
   ((itrans (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (du2 (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbgst_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_COMPLEX))
    (ldbb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbgv_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_COMPLEX))
    (ldbb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbgvx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_COMPLEX))
    (ldbb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chbtrd_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_checon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cheev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cheevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cheevr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cheevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chegs2_" 
   ((itype (:pointer :__clpk_integer))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chegst_" 
   ((itype (:pointer :__clpk_integer))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chegv_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chegvd_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chegvx_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cherfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chesv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chesvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chetf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chetrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chetrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chetri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chetrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chgeqz_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpgst_" 
   ((itype (:pointer :__clpk_integer))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (bp (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpgv_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (bp (:pointer :__CLPK_COMPLEX))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpgvd_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (bp (:pointer :__CLPK_COMPLEX))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpgvx_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (bp (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (afp (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chpsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (afp (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chptrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chsein_" 
   ((side (:pointer :char))
    (eigsrc (:pointer :char))
    (initv (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_COMPLEX))
    (ldh (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (ifaill (:pointer :__clpk_integer))
    (ifailr (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_chseqr_" 
   ((job (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_COMPLEX))
    (ldh (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clabrd_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tauq (:pointer :__CLPK_COMPLEX))
    (taup (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_COMPLEX))
    (ldy (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clacgv_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clacon_" 
   ((n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (est (:pointer :__CLPK_REAL))
    (kase (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clacp2_" 
   ((uplo (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clacpy_" 
   ((uplo (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clacrm_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clacrt_" 
   ((n (:pointer :__clpk_integer))
    (cx (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (cy (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (s (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claed0_" 
   ((qsiz (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (qstore (:pointer :__CLPK_COMPLEX))
    (ldqs (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claed7_" 
   ((n (:pointer :__clpk_integer))
    (cutpnt (:pointer :__clpk_integer))
    (qsiz (:pointer :__clpk_integer))
    (tlvls (:pointer :__clpk_integer))
    (curlvl (:pointer :__clpk_integer))
    (curpbm (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_REAL))
    (indxq (:pointer :__clpk_integer))
    (qstore (:pointer :__CLPK_REAL))
    (qptr (:pointer :__clpk_integer))
    (prmptr (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claed8_" 
   ((k (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (qsiz (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (rho (:pointer :__CLPK_REAL))
    (cutpnt (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_REAL))
    (dlamda (:pointer :__CLPK_REAL))
    (q2 (:pointer :__CLPK_COMPLEX))
    (ldq2 (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (indxp (:pointer :__clpk_integer))
    (indx (:pointer :__clpk_integer))
    (indxq (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claein_" 
   ((rightv (:pointer :__clpk_logical))
    (noinit (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_COMPLEX))
    (ldh (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (v (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (eps3 (:pointer :__CLPK_REAL))
    (smlnum (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claesy_" 
   ((a (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (rt1 (:pointer :__CLPK_COMPLEX))
    (rt2 (:pointer :__CLPK_COMPLEX))
    (evscal (:pointer :__CLPK_COMPLEX))
    (cs1 (:pointer :__CLPK_COMPLEX))
    (sn1 (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claev2_" 
   ((a (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (rt1 (:pointer :__CLPK_REAL))
    (rt2 (:pointer :__CLPK_REAL))
    (cs1 (:pointer :__CLPK_REAL))
    (sn1 (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clags2_" 
   ((upper (:pointer :__clpk_logical))
    (a1 (:pointer :__CLPK_REAL))
    (a2 (:pointer :__CLPK_COMPLEX))
    (a3 (:pointer :__CLPK_REAL))
    (b1 (:pointer :__CLPK_REAL))
    (b2 (:pointer :__CLPK_COMPLEX))
    (b3 (:pointer :__CLPK_REAL))
    (csu (:pointer :__CLPK_REAL))
    (snu (:pointer :__CLPK_COMPLEX))
    (csv (:pointer :__CLPK_REAL))
    (snv (:pointer :__CLPK_COMPLEX))
    (csq (:pointer :__CLPK_REAL))
    (snq (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clagtm_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_REAL))
    (dl (:pointer :__CLPK_COMPLEX))
    (d__ (:pointer :__CLPK_COMPLEX))
    (du (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (beta (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clahef_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (ldw (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clahqr_" 
   ((wantt (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_COMPLEX))
    (ldh (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (iloz (:pointer :__clpk_integer))
    (ihiz (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clahrd_" 
   ((n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_COMPLEX))
    (ldy (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claic1_" 
   ((job (:pointer :__clpk_integer))
    (j (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (sest (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_COMPLEX))
    (gamma (:pointer :__CLPK_COMPLEX))
    (sestpr (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clals0_" 
   ((icompq (:pointer :__clpk_integer))
    (nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (bx (:pointer :__CLPK_COMPLEX))
    (ldbx (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_REAL))
    (ldgnum (:pointer :__clpk_integer))
    (poles (:pointer :__CLPK_REAL))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (k (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clalsa_" 
   ((icompq (:pointer :__clpk_integer))
    (smlsiz (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (bx (:pointer :__CLPK_COMPLEX))
    (ldbx (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_REAL))
    (k (:pointer :__clpk_integer))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (poles (:pointer :__CLPK_REAL))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (rwork (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clapll_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
    (ssmin (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clapmt_" 
   ((forwrd (:pointer :__clpk_logical))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqgb_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqge_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqhb_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqhe_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqhp_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqp2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (offset (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (vn1 (:pointer :__CLPK_REAL))
    (vn2 (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqps_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (offset (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (vn1 (:pointer :__CLPK_REAL))
    (vn2 (:pointer :__CLPK_REAL))
    (auxv (:pointer :__CLPK_COMPLEX))
    (f (:pointer :__CLPK_COMPLEX))
    (ldf (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqsb_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqsp_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claqsy_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clar1v_" 
   ((n (:pointer :__clpk_integer))
    (b1 (:pointer :__clpk_integer))
    (bn (:pointer :__clpk_integer))
    (sigma (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (l (:pointer :__CLPK_REAL))
    (ld (:pointer :__CLPK_REAL))
    (lld (:pointer :__CLPK_REAL))
    (gersch (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ztz (:pointer :__CLPK_REAL))
    (mingma (:pointer :__CLPK_REAL))
    (r__ (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clar2v_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (y (:pointer :__CLPK_COMPLEX))
    (z__ (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_COMPLEX))
    (incc (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarcm_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarf_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (incv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarfb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (ldwork (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarfg_" 
   ((n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarft_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarfx_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clargv_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (incc (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarnv_" 
   ((idist (:pointer :__clpk_integer))
    (iseed (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarrv_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (l (:pointer :__CLPK_REAL))
    (isplit (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (iblock (:pointer :__clpk_integer))
    (gersch (:pointer :__CLPK_REAL))
    (tol (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clartg_" 
   ((f (:pointer :__CLPK_COMPLEX))
    (g (:pointer :__CLPK_COMPLEX))
    (cs (:pointer :__CLPK_REAL))
    (sn (:pointer :__CLPK_COMPLEX))
    (r__ (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clartv_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_COMPLEX))
    (incc (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarz_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (incv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarzb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (ldwork (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clarzt_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clascl_" 
   ((type__ (:pointer :char))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (cfrom (:pointer :__CLPK_REAL))
    (cto (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claset_" 
   ((uplo (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clasr_" 
   ((side (:pointer :char))
    (pivot (:pointer :char))
    (direct (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_classq_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (sumsq (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_claswp_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (k1 (:pointer :__clpk_integer))
    (k2 (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (incx (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clasyf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (ldw (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatbs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (scale (:pointer :__CLPK_REAL))
    (cnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatdf_" 
   ((ijob (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (rhs (:pointer :__CLPK_COMPLEX))
    (rdsum (:pointer :__CLPK_REAL))
    (rdscal (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__clpk_integer))
    (jpiv (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatps_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (scale (:pointer :__CLPK_REAL))
    (cnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_COMPLEX))
    (w (:pointer :__CLPK_COMPLEX))
    (ldw (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (scale (:pointer :__CLPK_REAL))
    (cnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatrz_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clatzm_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (incv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c1 (:pointer :__CLPK_COMPLEX))
    (c2 (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clauu2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_clauum_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_COMPLEX))
    (ldafb (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbstf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_COMPLEX))
    (ldafb (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbtf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbtrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpbtrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpocon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpoequ_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cporfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cposv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cposvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpotf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpotrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpotri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpotrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cppcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cppequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (afp (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cppsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cppsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (afp (:pointer :__CLPK_COMPLEX))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cptcon_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cptrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (df (:pointer :__CLPK_REAL))
    (ef (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cptsv_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cptsvx_" 
   ((fact (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (df (:pointer :__CLPK_REAL))
    (ef (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpttrf_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cpttrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cptts2_" 
   ((iuplo (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_crot_" 
   ((n (:pointer :__clpk_integer))
    (cx (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (cy (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cspcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cspmv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (ap (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (beta (:pointer :__CLPK_COMPLEX))
    (y (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cspr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (afp (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cspsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cspsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (afp (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csrot_" 
   ((n (:pointer :__clpk_integer))
    (cx (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (cy (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csrscl_" 
   ((n (:pointer :__clpk_integer))
    (sa (:pointer :__CLPK_REAL))
    (sx (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cstedc_" 
   ((compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (lrwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cstein_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_REAL))
    (iblock (:pointer :__clpk_integer))
    (isplit (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csteqr_" 
   ((compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csycon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csymv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (beta (:pointer :__CLPK_COMPLEX))
    (y (:pointer :__CLPK_COMPLEX))
    (incy (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csyr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (x (:pointer :__CLPK_COMPLEX))
    (incx (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csyrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csysv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csysvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_COMPLEX))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csytf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csytrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csytri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_csytrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctbcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctbrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctbtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_COMPLEX))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgex2_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (j1 (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgexc_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (ifst (:pointer :__clpk_integer))
    (ilst (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgsen_" 
   ((ijob (:pointer :__clpk_integer))
    (wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_COMPLEX))
    (beta (:pointer :__CLPK_COMPLEX))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_COMPLEX))
    (ldz (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (pl (:pointer :__CLPK_REAL))
    (pr (:pointer :__CLPK_REAL))
    (dif (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgsja_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (tola (:pointer :__CLPK_REAL))
    (tolb (:pointer :__CLPK_REAL))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_COMPLEX))
    (ldu (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_COMPLEX))
    (ldv (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (ncycle (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (dif (:pointer :__CLPK_REAL))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgsy2_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_COMPLEX))
    (ldd (:pointer :__clpk_integer))
    (e (:pointer :__CLPK_COMPLEX))
    (lde (:pointer :__clpk_integer))
    (f (:pointer :__CLPK_COMPLEX))
    (ldf (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (rdsum (:pointer :__CLPK_REAL))
    (rdscal (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctgsyl_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_COMPLEX))
    (ldd (:pointer :__clpk_integer))
    (e (:pointer :__CLPK_COMPLEX))
    (lde (:pointer :__clpk_integer))
    (f (:pointer :__CLPK_COMPLEX))
    (ldf (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (dif (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctpcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctprfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctptri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctptrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrexc_" 
   ((compq (:pointer :char))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (ifst (:pointer :__clpk_integer))
    (ilst (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_COMPLEX))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrsen_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_COMPLEX))
    (m (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (sep (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_COMPLEX))
    (ldt (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_COMPLEX))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_COMPLEX))
    (ldvr (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_REAL))
    (sep (:pointer :__CLPK_REAL))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (ldwork (:pointer :__clpk_integer))
    (rwork (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrsyl_" 
   ((trana (:pointer :char))
    (tranb (:pointer :char))
    (isgn (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_REAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrti2_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrtri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctrtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_COMPLEX))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctzrqf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ctzrzf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cung2l_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cung2r_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungbr_" 
   ((vect (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunghr_" 
   ((n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungl2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunglq_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungql_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungqr_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungr2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungrq_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cungtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunm2l_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunm2r_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmbr_" 
   ((vect (:pointer :char))
    (side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmhr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunml2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmlq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmql_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmqr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmr2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmr3_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmrq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmrz_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cunmtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_COMPLEX))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cupgtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (tau (:pointer :__CLPK_COMPLEX))
    (q (:pointer :__CLPK_COMPLEX))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_cupmtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_COMPLEX))
    (tau (:pointer :__CLPK_COMPLEX))
    (c__ (:pointer :__CLPK_COMPLEX))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_COMPLEX))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dbdsdc_" 
   ((uplo (:pointer :char))
    (compq (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (iq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dbdsqr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ncvt (:pointer :__clpk_integer))
    (nru (:pointer :__clpk_integer))
    (ncc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ddisna_" 
   ((job (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (sep (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbbrd_" 
   ((vect (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ncc (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (pt (:pointer :__CLPK_DOUBLEREAL))
    (ldpt (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbequ_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_DOUBLEREAL))
    (ldafb (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbsv_" 
   ((n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_DOUBLEREAL))
    (ldafb (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbtf2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbtrf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgbtrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgebak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgebal_" 
   ((job (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgebd2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tauq (:pointer :__CLPK_DOUBLEREAL))
    (taup (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgebrd_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tauq (:pointer :__CLPK_DOUBLEREAL))
    (taup (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgecon_" 
   ((norm (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeequ_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgees_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (vs (:pointer :__CLPK_DOUBLEREAL))
    (ldvs (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeesx_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (vs (:pointer :__CLPK_DOUBLEREAL))
    (ldvs (:pointer :__clpk_integer))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (abnrm (:pointer :__CLPK_DOUBLEREAL))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgegs_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (vsl (:pointer :__CLPK_DOUBLEREAL))
    (ldvsl (:pointer :__clpk_integer))
    (vsr (:pointer :__CLPK_DOUBLEREAL))
    (ldvsr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgegv_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgehd2_" 
   ((n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgehrd_" 
   ((n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgelq2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgelqf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgels_" 
   ((trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgelsd_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgelss_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgelsx_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgelsy_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeql2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeqlf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeqp3_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeqpf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeqr2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgeqrf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgerfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_DOUBLEREAL))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgerq2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgerqf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgesc2_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (rhs (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (jpiv (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgesdd_" 
   ((jobz (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgesv_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgesvd_" 
   ((jobu (:pointer :char))
    (jobvt (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgesvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_DOUBLEREAL))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgetc2_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (jpiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgetf2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgetrf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgetri_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgetrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggbak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (lscale (:pointer :__CLPK_DOUBLEREAL))
    (rscale (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggbal_" 
   ((job (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (lscale (:pointer :__CLPK_DOUBLEREAL))
    (rscale (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgges_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (delctg :pointer)
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (vsl (:pointer :__CLPK_DOUBLEREAL))
    (ldvsl (:pointer :__clpk_integer))
    (vsr (:pointer :__CLPK_DOUBLEREAL))
    (ldvsr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggesx_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (delctg :pointer)
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (sdim (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (vsl (:pointer :__CLPK_DOUBLEREAL))
    (ldvsl (:pointer :__clpk_integer))
    (vsr (:pointer :__CLPK_DOUBLEREAL))
    (ldvsr (:pointer :__clpk_integer))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (lscale (:pointer :__CLPK_DOUBLEREAL))
    (rscale (:pointer :__CLPK_DOUBLEREAL))
    (abnrm (:pointer :__CLPK_DOUBLEREAL))
    (bbnrm (:pointer :__CLPK_DOUBLEREAL))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggglm_" 
   ((n (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgghrd_" 
   ((compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgglse_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggqrf_" 
   ((n (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (taua (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (taub (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggrqf_" 
   ((m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (taua (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (taub (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggsvd_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dggsvp_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (tola (:pointer :__CLPK_DOUBLEREAL))
    (tolb (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgtcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (du2 (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgtrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (dlf (:pointer :__CLPK_DOUBLEREAL))
    (df (:pointer :__CLPK_DOUBLEREAL))
    (duf (:pointer :__CLPK_DOUBLEREAL))
    (du2 (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgtsv_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgtsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (dlf (:pointer :__CLPK_DOUBLEREAL))
    (df (:pointer :__CLPK_DOUBLEREAL))
    (duf (:pointer :__CLPK_DOUBLEREAL))
    (du2 (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgttrf_" 
   ((n (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (du2 (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgttrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (du2 (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dgtts2_" 
   ((itrans (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (du2 (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dhgeqz_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dhsein_" 
   ((side (:pointer :char))
    (eigsrc (:pointer :char))
    (initv (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_DOUBLEREAL))
    (ldh (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (ifaill (:pointer :__clpk_integer))
    (ifailr (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dhseqr_" 
   ((job (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_DOUBLEREAL))
    (ldh (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlabad_" 
   ((small (:pointer :__CLPK_DOUBLEREAL))
    (large (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlabrd_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tauq (:pointer :__CLPK_DOUBLEREAL))
    (taup (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (ldy (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlacon_" 
   ((n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (isgn (:pointer :__clpk_integer))
    (est (:pointer :__CLPK_DOUBLEREAL))
    (kase (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlacpy_" 
   ((uplo (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dladiv_" 
   ((a (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (p (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlae2_" 
   ((a (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rt1 (:pointer :__CLPK_DOUBLEREAL))
    (rt2 (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaebz_" 
   ((ijob (:pointer :__clpk_integer))
    (nitmax (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (mmax (:pointer :__clpk_integer))
    (minp (:pointer :__clpk_integer))
    (nbmin (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (reltol (:pointer :__CLPK_DOUBLEREAL))
    (pivmin (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (e2 (:pointer :__CLPK_DOUBLEREAL))
    (nval (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (mout (:pointer :__clpk_integer))
    (nab (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed0_" 
   ((icompq (:pointer :__clpk_integer))
    (qsiz (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (qstore (:pointer :__CLPK_DOUBLEREAL))
    (ldqs (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed1_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (indxq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (cutpnt (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed2_" 
   ((k (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (n1 (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (indxq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (dlamda (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (q2 (:pointer :__CLPK_DOUBLEREAL))
    (indx (:pointer :__clpk_integer))
    (indxc (:pointer :__clpk_integer))
    (indxp (:pointer :__clpk_integer))
    (coltyp (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed3_" 
   ((k (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (n1 (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (dlamda (:pointer :__CLPK_DOUBLEREAL))
    (q2 (:pointer :__CLPK_DOUBLEREAL))
    (indx (:pointer :__clpk_integer))
    (ctot (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed4_" 
   ((n (:pointer :__clpk_integer))
    (i__ (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (delta (:pointer :__CLPK_DOUBLEREAL))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (dlam (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed5_" 
   ((i__ (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (delta (:pointer :__CLPK_DOUBLEREAL))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (dlam (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed6_" 
   ((kniter (:pointer :__clpk_integer))
    (orgati (:pointer :__clpk_logical))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (finit (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed7_" 
   ((icompq (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (qsiz (:pointer :__clpk_integer))
    (tlvls (:pointer :__clpk_integer))
    (curlvl (:pointer :__clpk_integer))
    (curpbm (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (indxq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (cutpnt (:pointer :__clpk_integer))
    (qstore (:pointer :__CLPK_DOUBLEREAL))
    (qptr (:pointer :__clpk_integer))
    (prmptr (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed8_" 
   ((icompq (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (qsiz (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (indxq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (cutpnt (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (dlamda (:pointer :__CLPK_DOUBLEREAL))
    (q2 (:pointer :__CLPK_DOUBLEREAL))
    (ldq2 (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (indxp (:pointer :__clpk_integer))
    (indx (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaed9_" 
   ((k (:pointer :__clpk_integer))
    (kstart (:pointer :__clpk_integer))
    (kstop (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (dlamda (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (lds (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaeda_" 
   ((n (:pointer :__clpk_integer))
    (tlvls (:pointer :__clpk_integer))
    (curlvl (:pointer :__clpk_integer))
    (curpbm (:pointer :__clpk_integer))
    (prmptr (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (qptr (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ztemp (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaein_" 
   ((rightv (:pointer :__clpk_logical))
    (noinit (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_DOUBLEREAL))
    (ldh (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (vi (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (eps3 (:pointer :__CLPK_DOUBLEREAL))
    (smlnum (:pointer :__CLPK_DOUBLEREAL))
    (bignum (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaev2_" 
   ((a (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rt1 (:pointer :__CLPK_DOUBLEREAL))
    (rt2 (:pointer :__CLPK_DOUBLEREAL))
    (cs1 (:pointer :__CLPK_DOUBLEREAL))
    (sn1 (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaexc_" 
   ((wantq (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (j1 (:pointer :__clpk_integer))
    (n1 (:pointer :__clpk_integer))
    (n2 (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlag2_" 
   ((a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (safmin (:pointer :__CLPK_DOUBLEREAL))
    (scale1 (:pointer :__CLPK_DOUBLEREAL))
    (scale2 (:pointer :__CLPK_DOUBLEREAL))
    (wr1 (:pointer :__CLPK_DOUBLEREAL))
    (wr2 (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlags2_" 
   ((upper (:pointer :__clpk_logical))
    (a1 (:pointer :__CLPK_DOUBLEREAL))
    (a2 (:pointer :__CLPK_DOUBLEREAL))
    (a3 (:pointer :__CLPK_DOUBLEREAL))
    (b1 (:pointer :__CLPK_DOUBLEREAL))
    (b2 (:pointer :__CLPK_DOUBLEREAL))
    (b3 (:pointer :__CLPK_DOUBLEREAL))
    (csu (:pointer :__CLPK_DOUBLEREAL))
    (snu (:pointer :__CLPK_DOUBLEREAL))
    (csv (:pointer :__CLPK_DOUBLEREAL))
    (snv (:pointer :__CLPK_DOUBLEREAL))
    (csq (:pointer :__CLPK_DOUBLEREAL))
    (snq (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlagtf_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lambda (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (tol (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (in (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlagtm_" 
   ((trans (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (dl (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (du (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlagts_" 
   ((job (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (in (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (tol (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlagv2_" 
   ((a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (csl (:pointer :__CLPK_DOUBLEREAL))
    (snl (:pointer :__CLPK_DOUBLEREAL))
    (csr (:pointer :__CLPK_DOUBLEREAL))
    (snr (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlahqr_" 
   ((wantt (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (h__ (:pointer :__CLPK_DOUBLEREAL))
    (ldh (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (iloz (:pointer :__clpk_integer))
    (ihiz (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlahrd_" 
   ((n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (ldy (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaic1_" 
   ((job (:pointer :__clpk_integer))
    (j (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (sest (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (gamma (:pointer :__CLPK_DOUBLEREAL))
    (sestpr (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaln2_" 
   ((ltrans (:pointer :__clpk_logical))
    (na (:pointer :__clpk_integer))
    (nw (:pointer :__clpk_integer))
    (smin (:pointer :__CLPK_DOUBLEREAL))
    (ca (:pointer :__CLPK_DOUBLEREAL))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (d1 (:pointer :__CLPK_DOUBLEREAL))
    (d2 (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (xnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlals0_" 
   ((icompq (:pointer :__clpk_integer))
    (nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (bx (:pointer :__CLPK_DOUBLEREAL))
    (ldbx (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (ldgnum (:pointer :__clpk_integer))
    (poles (:pointer :__CLPK_DOUBLEREAL))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlalsa_" 
   ((icompq (:pointer :__clpk_integer))
    (smlsiz (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (bx (:pointer :__CLPK_DOUBLEREAL))
    (ldbx (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__clpk_integer))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (poles (:pointer :__CLPK_DOUBLEREAL))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlalsd_" 
   ((uplo (:pointer :char))
    (smlsiz (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlamc1_" 
   ((beta (:pointer :__clpk_integer))
    (t (:pointer :__clpk_integer))
    (rnd (:pointer :__clpk_logical))
    (ieee1 (:pointer :__clpk_logical))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlamc2_" 
   ((beta (:pointer :__clpk_integer))
    (t (:pointer :__clpk_integer))
    (rnd (:pointer :__clpk_logical))
    (eps (:pointer :__CLPK_DOUBLEREAL))
    (emin (:pointer :__clpk_integer))
    (rmin (:pointer :__CLPK_DOUBLEREAL))
    (emax (:pointer :__clpk_integer))
    (rmax (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlamc4_" 
   ((emin (:pointer :__clpk_integer))
    (start (:pointer :__CLPK_DOUBLEREAL))
    (base (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlamc5_" 
   ((beta (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (emin (:pointer :__clpk_integer))
    (ieee (:pointer :__clpk_logical))
    (emax (:pointer :__clpk_integer))
    (rmax (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlamrg_" 
   ((n1 (:pointer :__clpk_integer))
    (n2 (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (dtrd1 (:pointer :__clpk_integer))
    (dtrd2 (:pointer :__clpk_integer))
    (index (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlanv2_" 
   ((a (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (rt1r (:pointer :__CLPK_DOUBLEREAL))
    (rt1i (:pointer :__CLPK_DOUBLEREAL))
    (rt2r (:pointer :__CLPK_DOUBLEREAL))
    (rt2i (:pointer :__CLPK_DOUBLEREAL))
    (cs (:pointer :__CLPK_DOUBLEREAL))
    (sn (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlapll_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (incy (:pointer :__clpk_integer))
    (ssmin (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlapmt_" 
   ((forwrd (:pointer :__clpk_logical))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqgb_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqge_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqp2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (offset (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (vn1 (:pointer :__CLPK_DOUBLEREAL))
    (vn2 (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqps_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (offset (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (jpvt (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (vn1 (:pointer :__CLPK_DOUBLEREAL))
    (vn2 (:pointer :__CLPK_DOUBLEREAL))
    (auxv (:pointer :__CLPK_DOUBLEREAL))
    (f (:pointer :__CLPK_DOUBLEREAL))
    (ldf (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqsb_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqsp_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqsy_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaqtr_" 
   ((ltran (:pointer :__clpk_logical))
    (lreal (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlar1v_" 
   ((n (:pointer :__clpk_integer))
    (b1 (:pointer :__clpk_integer))
    (bn (:pointer :__clpk_integer))
    (sigma (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (l (:pointer :__CLPK_DOUBLEREAL))
    (ld (:pointer :__CLPK_DOUBLEREAL))
    (lld (:pointer :__CLPK_DOUBLEREAL))
    (gersch (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ztz (:pointer :__CLPK_DOUBLEREAL))
    (mingma (:pointer :__CLPK_DOUBLEREAL))
    (r__ (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlar2v_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (incc (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarf_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (incv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarfb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (ldwork (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarfg_" 
   ((n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarft_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarfx_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlargv_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (incc (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarnv_" 
   ((idist (:pointer :__clpk_integer))
    (iseed (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarrb_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (l (:pointer :__CLPK_DOUBLEREAL))
    (ld (:pointer :__CLPK_DOUBLEREAL))
    (lld (:pointer :__CLPK_DOUBLEREAL))
    (ifirst (:pointer :__clpk_integer))
    (ilast (:pointer :__clpk_integer))
    (sigma (:pointer :__CLPK_DOUBLEREAL))
    (reltol (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (wgap (:pointer :__CLPK_DOUBLEREAL))
    (werr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarre_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tol (:pointer :__CLPK_DOUBLEREAL))
    (nsplit (:pointer :__clpk_integer))
    (isplit (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (woff (:pointer :__CLPK_DOUBLEREAL))
    (gersch (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarrf_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (l (:pointer :__CLPK_DOUBLEREAL))
    (ld (:pointer :__CLPK_DOUBLEREAL))
    (lld (:pointer :__CLPK_DOUBLEREAL))
    (ifirst (:pointer :__clpk_integer))
    (ilast (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (dplus (:pointer :__CLPK_DOUBLEREAL))
    (lplus (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarrv_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (l (:pointer :__CLPK_DOUBLEREAL))
    (isplit (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (iblock (:pointer :__clpk_integer))
    (gersch (:pointer :__CLPK_DOUBLEREAL))
    (tol (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlartg_" 
   ((f (:pointer :__CLPK_DOUBLEREAL))
    (g (:pointer :__CLPK_DOUBLEREAL))
    (cs (:pointer :__CLPK_DOUBLEREAL))
    (sn (:pointer :__CLPK_DOUBLEREAL))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlartv_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
    (y (:pointer :__CLPK_DOUBLEREAL))
    (incy (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (incc (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaruv_" 
   ((iseed (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarz_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (incv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarzb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (ldwork (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlarzt_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlas2_" 
   ((f (:pointer :__CLPK_DOUBLEREAL))
    (g (:pointer :__CLPK_DOUBLEREAL))
    (h__ (:pointer :__CLPK_DOUBLEREAL))
    (ssmin (:pointer :__CLPK_DOUBLEREAL))
    (ssmax (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlascl_" 
   ((type__ (:pointer :char))
    (kl (:pointer :__clpk_integer))
    (ku (:pointer :__clpk_integer))
    (cfrom (:pointer :__CLPK_DOUBLEREAL))
    (cto (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd0_" 
   ((n (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (smlsiz (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd1_" 
   ((nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (idxq (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd2_" 
   ((nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (dsigma (:pointer :__CLPK_DOUBLEREAL))
    (u2 (:pointer :__CLPK_DOUBLEREAL))
    (ldu2 (:pointer :__clpk_integer))
    (vt2 (:pointer :__CLPK_DOUBLEREAL))
    (ldvt2 (:pointer :__clpk_integer))
    (idxp (:pointer :__clpk_integer))
    (idx (:pointer :__clpk_integer))
    (idxc (:pointer :__clpk_integer))
    (idxq (:pointer :__clpk_integer))
    (coltyp (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd3_" 
   ((nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (dsigma (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (u2 (:pointer :__CLPK_DOUBLEREAL))
    (ldu2 (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (vt2 (:pointer :__CLPK_DOUBLEREAL))
    (ldvt2 (:pointer :__clpk_integer))
    (idxc (:pointer :__clpk_integer))
    (ctot (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd4_" 
   ((n (:pointer :__clpk_integer))
    (i__ (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (delta (:pointer :__CLPK_DOUBLEREAL))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (sigma (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd5_" 
   ((i__ (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (delta (:pointer :__CLPK_DOUBLEREAL))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (dsigma (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd6_" 
   ((icompq (:pointer :__clpk_integer))
    (nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (vf (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (idxq (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (ldgnum (:pointer :__clpk_integer))
    (poles (:pointer :__CLPK_DOUBLEREAL))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd7_" 
   ((icompq (:pointer :__clpk_integer))
    (nl (:pointer :__clpk_integer))
    (nr (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (zw (:pointer :__CLPK_DOUBLEREAL))
    (vf (:pointer :__CLPK_DOUBLEREAL))
    (vfw (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vlw (:pointer :__CLPK_DOUBLEREAL))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (dsigma (:pointer :__CLPK_DOUBLEREAL))
    (idx (:pointer :__clpk_integer))
    (idxp (:pointer :__clpk_integer))
    (idxq (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (ldgnum (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd8_" 
   ((icompq (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (vf (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (lddifr (:pointer :__clpk_integer))
    (dsigma (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasd9_" 
   ((icompq (:pointer :__clpk_integer))
    (ldu (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (vf (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (dsigma (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasda_" 
   ((icompq (:pointer :__clpk_integer))
    (smlsiz (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (sqre (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__clpk_integer))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (poles (:pointer :__CLPK_DOUBLEREAL))
    (givptr (:pointer :__clpk_integer))
    (givcol (:pointer :__clpk_integer))
    (ldgcol (:pointer :__clpk_integer))
    (perm (:pointer :__clpk_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasdq_" 
   ((uplo (:pointer :char))
    (sqre (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ncvt (:pointer :__clpk_integer))
    (nru (:pointer :__clpk_integer))
    (ncc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (ldvt (:pointer :__clpk_integer))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasdt_" 
   ((n (:pointer :__clpk_integer))
    (lvl (:pointer :__clpk_integer))
    (nd (:pointer :__clpk_integer))
    (inode (:pointer :__clpk_integer))
    (ndiml (:pointer :__clpk_integer))
    (ndimr (:pointer :__clpk_integer))
    (msub (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaset_" 
   ((uplo (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasq1_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasq2_" 
   ((n (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasq3_" 
   ((i0 (:pointer :__clpk_integer))
    (n0 (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (pp (:pointer :__clpk_integer))
    (dmin__ (:pointer :__CLPK_DOUBLEREAL))
    (sigma (:pointer :__CLPK_DOUBLEREAL))
    (desig (:pointer :__CLPK_DOUBLEREAL))
    (qmax (:pointer :__CLPK_DOUBLEREAL))
    (nfail (:pointer :__clpk_integer))
    (iter (:pointer :__clpk_integer))
    (ndiv (:pointer :__clpk_integer))
    (ieee (:pointer :__clpk_logical))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasq4_" 
   ((i0 (:pointer :__clpk_integer))
    (n0 (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (pp (:pointer :__clpk_integer))
    (n0in (:pointer :__clpk_integer))
    (dmin__ (:pointer :__CLPK_DOUBLEREAL))
    (dmin1 (:pointer :__CLPK_DOUBLEREAL))
    (dmin2 (:pointer :__CLPK_DOUBLEREAL))
    (dn (:pointer :__CLPK_DOUBLEREAL))
    (dn1 (:pointer :__CLPK_DOUBLEREAL))
    (dn2 (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (ttype (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasq5_" 
   ((i0 (:pointer :__clpk_integer))
    (n0 (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (pp (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (dmin__ (:pointer :__CLPK_DOUBLEREAL))
    (dmin1 (:pointer :__CLPK_DOUBLEREAL))
    (dmin2 (:pointer :__CLPK_DOUBLEREAL))
    (dn (:pointer :__CLPK_DOUBLEREAL))
    (dnm1 (:pointer :__CLPK_DOUBLEREAL))
    (dnm2 (:pointer :__CLPK_DOUBLEREAL))
    (ieee (:pointer :__clpk_logical))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasq6_" 
   ((i0 (:pointer :__clpk_integer))
    (n0 (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (pp (:pointer :__clpk_integer))
    (dmin__ (:pointer :__CLPK_DOUBLEREAL))
    (dmin1 (:pointer :__CLPK_DOUBLEREAL))
    (dmin2 (:pointer :__CLPK_DOUBLEREAL))
    (dn (:pointer :__CLPK_DOUBLEREAL))
    (dnm1 (:pointer :__CLPK_DOUBLEREAL))
    (dnm2 (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasr_" 
   ((side (:pointer :char))
    (pivot (:pointer :char))
    (direct (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasrt_" 
   ((id (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlassq_" 
   ((n (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (sumsq (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasv2_" 
   ((f (:pointer :__CLPK_DOUBLEREAL))
    (g (:pointer :__CLPK_DOUBLEREAL))
    (h__ (:pointer :__CLPK_DOUBLEREAL))
    (ssmin (:pointer :__CLPK_DOUBLEREAL))
    (ssmax (:pointer :__CLPK_DOUBLEREAL))
    (snr (:pointer :__CLPK_DOUBLEREAL))
    (csr (:pointer :__CLPK_DOUBLEREAL))
    (snl (:pointer :__CLPK_DOUBLEREAL))
    (csl (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlaswp_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (k1 (:pointer :__clpk_integer))
    (k2 (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (incx (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasy2_" 
   ((ltranl (:pointer :__clpk_logical))
    (ltranr (:pointer :__clpk_logical))
    (isgn (:pointer :__clpk_integer))
    (n1 (:pointer :__clpk_integer))
    (n2 (:pointer :__clpk_integer))
    (tl (:pointer :__CLPK_DOUBLEREAL))
    (ldtl (:pointer :__clpk_integer))
    (tr (:pointer :__CLPK_DOUBLEREAL))
    (ldtr (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (xnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlasyf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (ldw (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatbs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (cnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatdf_" 
   ((ijob (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (rhs (:pointer :__CLPK_DOUBLEREAL))
    (rdsum (:pointer :__CLPK_DOUBLEREAL))
    (rdscal (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (jpiv (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatps_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (cnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nb (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (ldw (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (cnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatrz_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlatzm_" 
   ((side (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (incv (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c1 (:pointer :__CLPK_DOUBLEREAL))
    (c2 (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlauu2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dlauum_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dopgtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dopmtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorg2l_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorg2r_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgbr_" 
   ((vect (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorghr_" 
   ((n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgl2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorglq_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgql_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgqr_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgr2_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgrq_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorgtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorm2l_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorm2r_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormbr_" 
   ((vect (:pointer :char))
    (side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormhr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (ilo (:pointer :__clpk_integer))
    (ihi (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dorml2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormlq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormql_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormqr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormr2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormr3_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormrq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormrz_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dormtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_DOUBLEREAL))
    (ldafb (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbstf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (afb (:pointer :__CLPK_DOUBLEREAL))
    (ldafb (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbtf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbtrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpbtrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpocon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpoequ_" 
   ((n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dporfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_DOUBLEREAL))
    (ldaf (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dposv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dposvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_DOUBLEREAL))
    (ldaf (:pointer :__clpk_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpotf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpotrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpotri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpotrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dppcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dppequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (afp (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dppsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dppsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (afp (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dptcon_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpteqr_" 
   ((compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dptrfs_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (df (:pointer :__CLPK_DOUBLEREAL))
    (ef (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dptsv_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dptsvx_" 
   ((fact (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (df (:pointer :__CLPK_DOUBLEREAL))
    (ef (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpttrf_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dpttrs_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dptts2_" 
   ((n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_drscl_" 
   ((n (:pointer :__clpk_integer))
    (sa (:pointer :__CLPK_DOUBLEREAL))
    (sx (:pointer :__CLPK_DOUBLEREAL))
    (incx (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbgst_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_DOUBLEREAL))
    (ldbb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbgv_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_DOUBLEREAL))
    (ldbb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbgvd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_DOUBLEREAL))
    (ldbb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbgvx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ka (:pointer :__clpk_integer))
    (kb (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (bb (:pointer :__CLPK_DOUBLEREAL))
    (ldbb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsbtrd_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspgst_" 
   ((itype (:pointer :__clpk_integer))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (bp (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspgv_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (bp (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspgvd_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (bp (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspgvx_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (bp (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (afp (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dspsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (afp (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsptrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstebz_" 
   ((range (:pointer :char))
    (order (:pointer :char))
    (n (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (nsplit (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (iblock (:pointer :__clpk_integer))
    (isplit (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstedc_" 
   ((compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstegr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstein_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (iblock (:pointer :__clpk_integer))
    (isplit (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsteqr_" 
   ((compz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsterf_" 
   ((n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstev_" 
   ((jobz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstevd_" 
   ((jobz (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstevr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dstevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (n (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsycon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsyev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsyevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsyevr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (isuppz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsyevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsygs2_" 
   ((itype (:pointer :__clpk_integer))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsygst_" 
   ((itype (:pointer :__clpk_integer))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsygv_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsygvd_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsygvx_" 
   ((itype (:pointer :__clpk_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__clpk_integer))
    (iu (:pointer :__clpk_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (ifail (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsyrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_DOUBLEREAL))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsysv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsysvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (af (:pointer :__CLPK_DOUBLEREAL))
    (ldaf (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsytd2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsytf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsytrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsytrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsytri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dsytrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (ipiv (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtbcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtbrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtbtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (kd (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ab (:pointer :__CLPK_DOUBLEREAL))
    (ldab (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgex2_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (j1 (:pointer :__clpk_integer))
    (n1 (:pointer :__clpk_integer))
    (n2 (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgexc_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (ifst (:pointer :__clpk_integer))
    (ilst (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgsen_" 
   ((ijob (:pointer :__clpk_integer))
    (wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (alphar (:pointer :__CLPK_DOUBLEREAL))
    (alphai (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (ldz (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (pl (:pointer :__CLPK_DOUBLEREAL))
    (pr (:pointer :__CLPK_DOUBLEREAL))
    (dif (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgsja_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__clpk_integer))
    (p (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (k (:pointer :__clpk_integer))
    (l (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (tola (:pointer :__CLPK_DOUBLEREAL))
    (tolb (:pointer :__CLPK_DOUBLEREAL))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__clpk_integer))
    (v (:pointer :__CLPK_DOUBLEREAL))
    (ldv (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (ncycle (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (dif (:pointer :__CLPK_DOUBLEREAL))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgsy2_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (ldd (:pointer :__clpk_integer))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (lde (:pointer :__clpk_integer))
    (f (:pointer :__CLPK_DOUBLEREAL))
    (ldf (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (rdsum (:pointer :__CLPK_DOUBLEREAL))
    (rdscal (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (pq (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtgsyl_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (ldd (:pointer :__clpk_integer))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (lde (:pointer :__clpk_integer))
    (f (:pointer :__CLPK_DOUBLEREAL))
    (ldf (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (dif (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtpcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtprfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtptri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtptrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (ap (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrexc_" 
   ((compq (:pointer :char))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (ifst (:pointer :__clpk_integer))
    (ilst (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (x (:pointer :__CLPK_DOUBLEREAL))
    (ldx (:pointer :__clpk_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrsen_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (q (:pointer :__CLPK_DOUBLEREAL))
    (ldq (:pointer :__clpk_integer))
    (wr (:pointer :__CLPK_DOUBLEREAL))
    (wi (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (sep (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (liwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__clpk_integer))
    (t (:pointer :__CLPK_DOUBLEREAL))
    (ldt (:pointer :__clpk_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (ldvl (:pointer :__clpk_integer))
    (vr (:pointer :__CLPK_DOUBLEREAL))
    (ldvr (:pointer :__clpk_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (sep (:pointer :__CLPK_DOUBLEREAL))
    (mm (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (ldwork (:pointer :__clpk_integer))
    (iwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrsyl_" 
   ((trana (:pointer :char))
    (tranb (:pointer :char))
    (isgn (:pointer :__clpk_integer))
    (m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (ldc (:pointer :__clpk_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrti2_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrtri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtrtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__clpk_integer))
    (nrhs (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtzrqf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_dtzrzf_" 
   ((m (:pointer :__clpk_integer))
    (n (:pointer :__clpk_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__clpk_integer))
    (tau (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (lwork (:pointer :__clpk_integer))
    (info (:pointer :__clpk_integer))
   )
   :signed-long
() )
#|
 confused about __CLPK_INTEGER __CLPK_integer * n2 #\, __CLPK_integer * n3 #\, __CLPK_integer * n4 #\, __CLPK_ftnlen name_len #\, __CLPK_ftnlen opts_len #\)
|#
;  Subroutine 

(deftrap-inline "_sbdsdc_" 
   ((uplo (:pointer :char))
    (compq (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (iq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sbdsqr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ncvt (:pointer :__CLPK_integer))
    (nru (:pointer :__CLPK_integer))
    (ncc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sdisna_" 
   ((job (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (sep (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbbrd_" 
   ((vect (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ncc (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (pt (:pointer :__CLPK_REAL))
    (ldpt (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbequ_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_REAL))
    (ldafb (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbsv_" 
   ((n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_REAL))
    (ldafb (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbtf2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbtrf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgbtrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgebak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgebal_" 
   ((job (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgebd2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tauq (:pointer :__CLPK_REAL))
    (taup (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgebrd_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tauq (:pointer :__CLPK_REAL))
    (taup (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgecon_" 
   ((norm (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeequ_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgees_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (vs (:pointer :__CLPK_REAL))
    (ldvs (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeesx_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (vs (:pointer :__CLPK_REAL))
    (ldvs (:pointer :__CLPK_integer))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (abnrm (:pointer :__CLPK_REAL))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgegs_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (vsl (:pointer :__CLPK_REAL))
    (ldvsl (:pointer :__CLPK_integer))
    (vsr (:pointer :__CLPK_REAL))
    (ldvsr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgegv_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgehd2_" 
   ((n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgehrd_" 
   ((n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgelq2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgelqf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgels_" 
   ((trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgelsd_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgelss_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgelsx_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgelsy_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeql2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeqlf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeqp3_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeqpf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeqr2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgeqrf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgerfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_REAL))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgerq2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgerqf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgesc2_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (rhs (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (jpiv (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgesdd_" 
   ((jobz (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgesv_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgesvd_" 
   ((jobu (:pointer :char))
    (jobvt (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgesvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_REAL))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgetc2_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (jpiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgetf2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgetrf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgetri_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgetrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggbak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (lscale (:pointer :__CLPK_REAL))
    (rscale (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggbal_" 
   ((job (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (lscale (:pointer :__CLPK_REAL))
    (rscale (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgges_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (selctg :pointer)
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (vsl (:pointer :__CLPK_REAL))
    (ldvsl (:pointer :__CLPK_integer))
    (vsr (:pointer :__CLPK_REAL))
    (ldvsr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggesx_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (selctg :pointer)
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (vsl (:pointer :__CLPK_REAL))
    (ldvsl (:pointer :__CLPK_integer))
    (vsr (:pointer :__CLPK_REAL))
    (ldvsr (:pointer :__CLPK_integer))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (lscale (:pointer :__CLPK_REAL))
    (rscale (:pointer :__CLPK_REAL))
    (abnrm (:pointer :__CLPK_REAL))
    (bbnrm (:pointer :__CLPK_REAL))
    (rconde (:pointer :__CLPK_REAL))
    (rcondv (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggglm_" 
   ((n (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (y (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgghrd_" 
   ((compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgglse_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggqrf_" 
   ((n (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (taua (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (taub (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggrqf_" 
   ((m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (taua (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (taub (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggsvd_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sggsvp_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (tola (:pointer :__CLPK_REAL))
    (tolb (:pointer :__CLPK_REAL))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgtcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (du2 (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgtrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (dlf (:pointer :__CLPK_REAL))
    (df (:pointer :__CLPK_REAL))
    (duf (:pointer :__CLPK_REAL))
    (du2 (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgtsv_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgtsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (dlf (:pointer :__CLPK_REAL))
    (df (:pointer :__CLPK_REAL))
    (duf (:pointer :__CLPK_REAL))
    (du2 (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgttrf_" 
   ((n (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (du2 (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgttrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (du2 (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sgtts2_" 
   ((itrans (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (du2 (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_shgeqz_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_shsein_" 
   ((side (:pointer :char))
    (eigsrc (:pointer :char))
    (initv (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_REAL))
    (ldh (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (ifaill (:pointer :__CLPK_integer))
    (ifailr (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_shseqr_" 
   ((job (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_REAL))
    (ldh (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slabad_" 
   ((small (:pointer :__CLPK_REAL))
    (large (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slabrd_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tauq (:pointer :__CLPK_REAL))
    (taup (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_REAL))
    (ldy (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slacon_" 
   ((n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (isgn (:pointer :__CLPK_integer))
    (est (:pointer :__CLPK_REAL))
    (kase (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slacpy_" 
   ((uplo (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sladiv_" 
   ((a (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (p (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slae2_" 
   ((a (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rt1 (:pointer :__CLPK_REAL))
    (rt2 (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaebz_" 
   ((ijob (:pointer :__CLPK_integer))
    (nitmax (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (mmax (:pointer :__CLPK_integer))
    (minp (:pointer :__CLPK_integer))
    (nbmin (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (reltol (:pointer :__CLPK_REAL))
    (pivmin (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (e2 (:pointer :__CLPK_REAL))
    (nval (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (mout (:pointer :__CLPK_integer))
    (nab (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed0_" 
   ((icompq (:pointer :__CLPK_integer))
    (qsiz (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (qstore (:pointer :__CLPK_REAL))
    (ldqs (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed1_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (indxq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_REAL))
    (cutpnt (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed2_" 
   ((k (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (n1 (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (indxq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (dlamda (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (q2 (:pointer :__CLPK_REAL))
    (indx (:pointer :__CLPK_integer))
    (indxc (:pointer :__CLPK_integer))
    (indxp (:pointer :__CLPK_integer))
    (coltyp (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed3_" 
   ((k (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (n1 (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_REAL))
    (dlamda (:pointer :__CLPK_REAL))
    (q2 (:pointer :__CLPK_REAL))
    (indx (:pointer :__CLPK_integer))
    (ctot (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed4_" 
   ((n (:pointer :__CLPK_integer))
    (i__ (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (delta (:pointer :__CLPK_REAL))
    (rho (:pointer :__CLPK_REAL))
    (dlam (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed5_" 
   ((i__ (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (delta (:pointer :__CLPK_REAL))
    (rho (:pointer :__CLPK_REAL))
    (dlam (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed6_" 
   ((kniter (:pointer :__CLPK_integer))
    (orgati (:pointer :__clpk_logical))
    (rho (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (finit (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed7_" 
   ((icompq (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (qsiz (:pointer :__CLPK_integer))
    (tlvls (:pointer :__CLPK_integer))
    (curlvl (:pointer :__CLPK_integer))
    (curpbm (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (indxq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_REAL))
    (cutpnt (:pointer :__CLPK_integer))
    (qstore (:pointer :__CLPK_REAL))
    (qptr (:pointer :__CLPK_integer))
    (prmptr (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed8_" 
   ((icompq (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (qsiz (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (indxq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_REAL))
    (cutpnt (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (dlamda (:pointer :__CLPK_REAL))
    (q2 (:pointer :__CLPK_REAL))
    (ldq2 (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (indxp (:pointer :__CLPK_integer))
    (indx (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaed9_" 
   ((k (:pointer :__CLPK_integer))
    (kstart (:pointer :__CLPK_integer))
    (kstop (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_REAL))
    (dlamda (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (lds (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaeda_" 
   ((n (:pointer :__CLPK_integer))
    (tlvls (:pointer :__CLPK_integer))
    (curlvl (:pointer :__CLPK_integer))
    (curpbm (:pointer :__CLPK_integer))
    (prmptr (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (qptr (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ztemp (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaein_" 
   ((rightv (:pointer :__clpk_logical))
    (noinit (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_REAL))
    (ldh (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (vr (:pointer :__CLPK_REAL))
    (vi (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (eps3 (:pointer :__CLPK_REAL))
    (smlnum (:pointer :__CLPK_REAL))
    (bignum (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaev2_" 
   ((a (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rt1 (:pointer :__CLPK_REAL))
    (rt2 (:pointer :__CLPK_REAL))
    (cs1 (:pointer :__CLPK_REAL))
    (sn1 (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaexc_" 
   ((wantq (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (j1 (:pointer :__CLPK_integer))
    (n1 (:pointer :__CLPK_integer))
    (n2 (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slag2_" 
   ((a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (safmin (:pointer :__CLPK_REAL))
    (scale1 (:pointer :__CLPK_REAL))
    (scale2 (:pointer :__CLPK_REAL))
    (wr1 (:pointer :__CLPK_REAL))
    (wr2 (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slags2_" 
   ((upper (:pointer :__clpk_logical))
    (a1 (:pointer :__CLPK_REAL))
    (a2 (:pointer :__CLPK_REAL))
    (a3 (:pointer :__CLPK_REAL))
    (b1 (:pointer :__CLPK_REAL))
    (b2 (:pointer :__CLPK_REAL))
    (b3 (:pointer :__CLPK_REAL))
    (csu (:pointer :__CLPK_REAL))
    (snu (:pointer :__CLPK_REAL))
    (csv (:pointer :__CLPK_REAL))
    (snv (:pointer :__CLPK_REAL))
    (csq (:pointer :__CLPK_REAL))
    (snq (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slagtf_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lambda (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (tol (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (in (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slagtm_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_REAL))
    (dl (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (du (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (beta (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slagts_" 
   ((job (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (in (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_REAL))
    (tol (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slagv2_" 
   ((a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (csl (:pointer :__CLPK_REAL))
    (snl (:pointer :__CLPK_REAL))
    (csr (:pointer :__CLPK_REAL))
    (snr (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slahqr_" 
   ((wantt (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_REAL))
    (ldh (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (iloz (:pointer :__CLPK_integer))
    (ihiz (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slahrd_" 
   ((n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_REAL))
    (ldy (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaic1_" 
   ((job (:pointer :__CLPK_integer))
    (j (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (sest (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (gamma (:pointer :__CLPK_REAL))
    (sestpr (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaln2_" 
   ((ltrans (:pointer :__clpk_logical))
    (na (:pointer :__CLPK_integer))
    (nw (:pointer :__CLPK_integer))
    (smin (:pointer :__CLPK_REAL))
    (ca (:pointer :__CLPK_REAL))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (d1 (:pointer :__CLPK_REAL))
    (d2 (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (xnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slals0_" 
   ((icompq (:pointer :__CLPK_integer))
    (nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (bx (:pointer :__CLPK_REAL))
    (ldbx (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (ldgnum (:pointer :__CLPK_integer))
    (poles (:pointer :__CLPK_REAL))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (k (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slalsa_" 
   ((icompq (:pointer :__CLPK_integer))
    (smlsiz (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (bx (:pointer :__CLPK_REAL))
    (ldbx (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (k (:pointer :__CLPK_integer))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (poles (:pointer :__CLPK_REAL))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slalsd_" 
   ((uplo (:pointer :char))
    (smlsiz (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slamc1_" 
   ((beta (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_integer))
    (rnd (:pointer :__clpk_logical))
    (ieee1 (:pointer :__clpk_logical))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slamc2_" 
   ((beta (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_integer))
    (rnd (:pointer :__clpk_logical))
    (eps (:pointer :__CLPK_REAL))
    (emin (:pointer :__CLPK_integer))
    (rmin (:pointer :__CLPK_REAL))
    (emax (:pointer :__CLPK_integer))
    (rmax (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slamc4_" 
   ((emin (:pointer :__CLPK_integer))
    (start (:pointer :__CLPK_REAL))
    (base (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slamc5_" 
   ((beta (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (emin (:pointer :__CLPK_integer))
    (ieee (:pointer :__clpk_logical))
    (emax (:pointer :__CLPK_integer))
    (rmax (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slamrg_" 
   ((n1 (:pointer :__CLPK_integer))
    (n2 (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (strd1 (:pointer :__CLPK_integer))
    (strd2 (:pointer :__CLPK_integer))
    (index (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slanv2_" 
   ((a (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (rt1r (:pointer :__CLPK_REAL))
    (rt1i (:pointer :__CLPK_REAL))
    (rt2r (:pointer :__CLPK_REAL))
    (rt2i (:pointer :__CLPK_REAL))
    (cs (:pointer :__CLPK_REAL))
    (sn (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slapll_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_REAL))
    (incy (:pointer :__CLPK_integer))
    (ssmin (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slapmt_" 
   ((forwrd (:pointer :__clpk_logical))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqgb_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqge_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (rowcnd (:pointer :__CLPK_REAL))
    (colcnd (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqp2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (offset (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (vn1 (:pointer :__CLPK_REAL))
    (vn2 (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqps_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (offset (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (vn1 (:pointer :__CLPK_REAL))
    (vn2 (:pointer :__CLPK_REAL))
    (auxv (:pointer :__CLPK_REAL))
    (f (:pointer :__CLPK_REAL))
    (ldf (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqsb_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqsp_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqsy_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaqtr_" 
   ((ltran (:pointer :__clpk_logical))
    (lreal (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (scale (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slar1v_" 
   ((n (:pointer :__CLPK_integer))
    (b1 (:pointer :__CLPK_integer))
    (bn (:pointer :__CLPK_integer))
    (sigma (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (l (:pointer :__CLPK_REAL))
    (ld (:pointer :__CLPK_REAL))
    (lld (:pointer :__CLPK_REAL))
    (gersch (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ztz (:pointer :__CLPK_REAL))
    (mingma (:pointer :__CLPK_REAL))
    (r__ (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slar2v_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (y (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (incc (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarf_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (incv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarfb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (ldwork (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarfg_" 
   ((n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarft_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarfx_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slargv_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_REAL))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (incc (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarnv_" 
   ((idist (:pointer :__CLPK_integer))
    (iseed (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarrb_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (l (:pointer :__CLPK_REAL))
    (ld (:pointer :__CLPK_REAL))
    (lld (:pointer :__CLPK_REAL))
    (ifirst (:pointer :__CLPK_integer))
    (ilast (:pointer :__CLPK_integer))
    (sigma (:pointer :__CLPK_REAL))
    (reltol (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (wgap (:pointer :__CLPK_REAL))
    (werr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarre_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tol (:pointer :__CLPK_REAL))
    (nsplit (:pointer :__CLPK_integer))
    (isplit (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (woff (:pointer :__CLPK_REAL))
    (gersch (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarrf_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (l (:pointer :__CLPK_REAL))
    (ld (:pointer :__CLPK_REAL))
    (lld (:pointer :__CLPK_REAL))
    (ifirst (:pointer :__CLPK_integer))
    (ilast (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (dplus (:pointer :__CLPK_REAL))
    (lplus (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarrv_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (l (:pointer :__CLPK_REAL))
    (isplit (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (iblock (:pointer :__CLPK_integer))
    (gersch (:pointer :__CLPK_REAL))
    (tol (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slartg_" 
   ((f (:pointer :__CLPK_REAL))
    (g (:pointer :__CLPK_REAL))
    (cs (:pointer :__CLPK_REAL))
    (sn (:pointer :__CLPK_REAL))
    (r__ (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slartv_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_REAL))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (incc (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaruv_" 
   ((iseed (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarz_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (incv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarzb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (ldwork (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slarzt_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slas2_" 
   ((f (:pointer :__CLPK_REAL))
    (g (:pointer :__CLPK_REAL))
    (h__ (:pointer :__CLPK_REAL))
    (ssmin (:pointer :__CLPK_REAL))
    (ssmax (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slascl_" 
   ((type__ (:pointer :char))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (cfrom (:pointer :__CLPK_REAL))
    (cto (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd0_" 
   ((n (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (smlsiz (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd1_" 
   ((nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (idxq (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd2_" 
   ((nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (dsigma (:pointer :__CLPK_REAL))
    (u2 (:pointer :__CLPK_REAL))
    (ldu2 (:pointer :__CLPK_integer))
    (vt2 (:pointer :__CLPK_REAL))
    (ldvt2 (:pointer :__CLPK_integer))
    (idxp (:pointer :__CLPK_integer))
    (idx (:pointer :__CLPK_integer))
    (idxc (:pointer :__CLPK_integer))
    (idxq (:pointer :__CLPK_integer))
    (coltyp (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd3_" 
   ((nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (dsigma (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (u2 (:pointer :__CLPK_REAL))
    (ldu2 (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (vt2 (:pointer :__CLPK_REAL))
    (ldvt2 (:pointer :__CLPK_integer))
    (idxc (:pointer :__CLPK_integer))
    (ctot (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd4_" 
   ((n (:pointer :__CLPK_integer))
    (i__ (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (delta (:pointer :__CLPK_REAL))
    (rho (:pointer :__CLPK_REAL))
    (sigma (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd5_" 
   ((i__ (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (delta (:pointer :__CLPK_REAL))
    (rho (:pointer :__CLPK_REAL))
    (dsigma (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd6_" 
   ((icompq (:pointer :__CLPK_integer))
    (nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (vf (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (idxq (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (ldgnum (:pointer :__CLPK_integer))
    (poles (:pointer :__CLPK_REAL))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (k (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd7_" 
   ((icompq (:pointer :__CLPK_integer))
    (nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (zw (:pointer :__CLPK_REAL))
    (vf (:pointer :__CLPK_REAL))
    (vfw (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (vlw (:pointer :__CLPK_REAL))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (dsigma (:pointer :__CLPK_REAL))
    (idx (:pointer :__CLPK_integer))
    (idxp (:pointer :__CLPK_integer))
    (idxq (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (ldgnum (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd8_" 
   ((icompq (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (vf (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (lddifr (:pointer :__CLPK_integer))
    (dsigma (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasd9_" 
   ((icompq (:pointer :__CLPK_integer))
    (ldu (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (vf (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (dsigma (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasda_" 
   ((icompq (:pointer :__CLPK_integer))
    (smlsiz (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_REAL))
    (k (:pointer :__CLPK_integer))
    (difl (:pointer :__CLPK_REAL))
    (difr (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (poles (:pointer :__CLPK_REAL))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasdq_" 
   ((uplo (:pointer :char))
    (sqre (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ncvt (:pointer :__CLPK_integer))
    (nru (:pointer :__CLPK_integer))
    (ncc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (vt (:pointer :__CLPK_REAL))
    (ldvt (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasdt_" 
   ((n (:pointer :__CLPK_integer))
    (lvl (:pointer :__CLPK_integer))
    (nd (:pointer :__CLPK_integer))
    (inode (:pointer :__CLPK_integer))
    (ndiml (:pointer :__CLPK_integer))
    (ndimr (:pointer :__CLPK_integer))
    (msub (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaset_" 
   ((uplo (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasq1_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasq2_" 
   ((n (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasq3_" 
   ((i0 (:pointer :__CLPK_integer))
    (n0 (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (pp (:pointer :__CLPK_integer))
    (dmin__ (:pointer :__CLPK_REAL))
    (sigma (:pointer :__CLPK_REAL))
    (desig (:pointer :__CLPK_REAL))
    (qmax (:pointer :__CLPK_REAL))
    (nfail (:pointer :__CLPK_integer))
    (iter (:pointer :__CLPK_integer))
    (ndiv (:pointer :__CLPK_integer))
    (ieee (:pointer :__clpk_logical))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasq4_" 
   ((i0 (:pointer :__CLPK_integer))
    (n0 (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (pp (:pointer :__CLPK_integer))
    (n0in (:pointer :__CLPK_integer))
    (dmin__ (:pointer :__CLPK_REAL))
    (dmin1 (:pointer :__CLPK_REAL))
    (dmin2 (:pointer :__CLPK_REAL))
    (dn (:pointer :__CLPK_REAL))
    (dn1 (:pointer :__CLPK_REAL))
    (dn2 (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (ttype (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasq5_" 
   ((i0 (:pointer :__CLPK_integer))
    (n0 (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (pp (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (dmin__ (:pointer :__CLPK_REAL))
    (dmin1 (:pointer :__CLPK_REAL))
    (dmin2 (:pointer :__CLPK_REAL))
    (dn (:pointer :__CLPK_REAL))
    (dnm1 (:pointer :__CLPK_REAL))
    (dnm2 (:pointer :__CLPK_REAL))
    (ieee (:pointer :__clpk_logical))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasq6_" 
   ((i0 (:pointer :__CLPK_integer))
    (n0 (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (pp (:pointer :__CLPK_integer))
    (dmin__ (:pointer :__CLPK_REAL))
    (dmin1 (:pointer :__CLPK_REAL))
    (dmin2 (:pointer :__CLPK_REAL))
    (dn (:pointer :__CLPK_REAL))
    (dnm1 (:pointer :__CLPK_REAL))
    (dnm2 (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasr_" 
   ((side (:pointer :char))
    (pivot (:pointer :char))
    (direct (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasrt_" 
   ((id (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slassq_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (sumsq (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasv2_" 
   ((f (:pointer :__CLPK_REAL))
    (g (:pointer :__CLPK_REAL))
    (h__ (:pointer :__CLPK_REAL))
    (ssmin (:pointer :__CLPK_REAL))
    (ssmax (:pointer :__CLPK_REAL))
    (snr (:pointer :__CLPK_REAL))
    (csr (:pointer :__CLPK_REAL))
    (snl (:pointer :__CLPK_REAL))
    (csl (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slaswp_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (k1 (:pointer :__CLPK_integer))
    (k2 (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (incx (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasy2_" 
   ((ltranl (:pointer :__clpk_logical))
    (ltranr (:pointer :__clpk_logical))
    (isgn (:pointer :__CLPK_integer))
    (n1 (:pointer :__CLPK_integer))
    (n2 (:pointer :__CLPK_integer))
    (tl (:pointer :__CLPK_REAL))
    (ldtl (:pointer :__CLPK_integer))
    (tr (:pointer :__CLPK_REAL))
    (ldtr (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (xnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slasyf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (ldw (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatbs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (scale (:pointer :__CLPK_REAL))
    (cnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatdf_" 
   ((ijob (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (rhs (:pointer :__CLPK_REAL))
    (rdsum (:pointer :__CLPK_REAL))
    (rdscal (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (jpiv (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatps_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (x (:pointer :__CLPK_REAL))
    (scale (:pointer :__CLPK_REAL))
    (cnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (ldw (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (scale (:pointer :__CLPK_REAL))
    (cnorm (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatrz_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slatzm_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (incv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c1 (:pointer :__CLPK_REAL))
    (c2 (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slauu2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_slauum_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sopgtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sopmtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorg2l_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorg2r_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgbr_" 
   ((vect (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorghr_" 
   ((n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgl2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorglq_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgql_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgqr_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgr2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgrq_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorgtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorm2l_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorm2r_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormbr_" 
   ((vect (:pointer :char))
    (side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormhr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sorml2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormlq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormql_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormqr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormr2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormr3_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormrq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormrz_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sormtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_REAL))
    (ldafb (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbstf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_REAL))
    (ldafb (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbtf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbtrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spbtrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spocon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spoequ_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sporfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_REAL))
    (ldaf (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sposv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sposvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_REAL))
    (ldaf (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spotf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spotrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spotri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spotrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sppcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sppequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (s (:pointer :__CLPK_REAL))
    (scond (:pointer :__CLPK_REAL))
    (amax (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (afp (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sppsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sppsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (afp (:pointer :__CLPK_REAL))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sptcon_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spteqr_" 
   ((compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sptrfs_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (df (:pointer :__CLPK_REAL))
    (ef (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sptsv_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sptsvx_" 
   ((fact (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (df (:pointer :__CLPK_REAL))
    (ef (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spttrf_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_spttrs_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sptts2_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_srscl_" 
   ((n (:pointer :__CLPK_integer))
    (sa (:pointer :__CLPK_REAL))
    (sx (:pointer :__CLPK_REAL))
    (incx (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbgst_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_REAL))
    (ldbb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbgv_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_REAL))
    (ldbb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbgvd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_REAL))
    (ldbb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbgvx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_REAL))
    (ldbb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssbtrd_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspgst_" 
   ((itype (:pointer :__CLPK_integer))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (bp (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspgv_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (bp (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspgvd_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (bp (:pointer :__CLPK_REAL))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspgvx_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (bp (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (afp (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sspsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (afp (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssptrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstebz_" 
   ((range (:pointer :char))
    (order (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (nsplit (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (iblock (:pointer :__CLPK_integer))
    (isplit (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstedc_" 
   ((compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstegr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstein_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (iblock (:pointer :__CLPK_integer))
    (isplit (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssteqr_" 
   ((compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssterf_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstev_" 
   ((jobz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstevd_" 
   ((jobz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstevr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_sstevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssycon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssyev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssyevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssyevr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssyevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssygs2_" 
   ((itype (:pointer :__CLPK_integer))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssygst_" 
   ((itype (:pointer :__CLPK_integer))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssygv_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssygvd_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssygvx_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (vu (:pointer :__CLPK_REAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_REAL))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssyrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_REAL))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssysv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssysvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_REAL))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssytd2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssytf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssytrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (e (:pointer :__CLPK_REAL))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssytrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssytri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ssytrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stbcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stbrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stbtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_REAL))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgex2_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (j1 (:pointer :__CLPK_integer))
    (n1 (:pointer :__CLPK_integer))
    (n2 (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgexc_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (ifst (:pointer :__CLPK_integer))
    (ilst (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgsen_" 
   ((ijob (:pointer :__CLPK_integer))
    (wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (alphar (:pointer :__CLPK_REAL))
    (alphai (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_REAL))
    (ldz (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (pl (:pointer :__CLPK_REAL))
    (pr (:pointer :__CLPK_REAL))
    (dif (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgsja_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (tola (:pointer :__CLPK_REAL))
    (tolb (:pointer :__CLPK_REAL))
    (alpha (:pointer :__CLPK_REAL))
    (beta (:pointer :__CLPK_REAL))
    (u (:pointer :__CLPK_REAL))
    (ldu (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_REAL))
    (ldv (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (ncycle (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (dif (:pointer :__CLPK_REAL))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgsy2_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (ldd (:pointer :__CLPK_integer))
    (e (:pointer :__CLPK_REAL))
    (lde (:pointer :__CLPK_integer))
    (f (:pointer :__CLPK_REAL))
    (ldf (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (rdsum (:pointer :__CLPK_REAL))
    (rdscal (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (pq (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stgsyl_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_REAL))
    (ldd (:pointer :__CLPK_integer))
    (e (:pointer :__CLPK_REAL))
    (lde (:pointer :__CLPK_integer))
    (f (:pointer :__CLPK_REAL))
    (ldf (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (dif (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stpcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stprfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stptri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stptrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_REAL))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strexc_" 
   ((compq (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (ifst (:pointer :__CLPK_integer))
    (ilst (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_REAL))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_REAL))
    (berr (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strsen_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_REAL))
    (ldq (:pointer :__CLPK_integer))
    (wr (:pointer :__CLPK_REAL))
    (wi (:pointer :__CLPK_REAL))
    (m (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (sep (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_REAL))
    (ldt (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_REAL))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_REAL))
    (ldvr (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_REAL))
    (sep (:pointer :__CLPK_REAL))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_REAL))
    (ldwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strsyl_" 
   ((trana (:pointer :char))
    (tranb (:pointer :char))
    (isgn (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_REAL))
    (ldc (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strti2_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strtri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_strtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_REAL))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stzrqf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_stzrzf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_REAL))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_REAL))
    (work (:pointer :__CLPK_REAL))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_xerbla_" 
   ((srname (:pointer :char))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zbdsqr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ncvt (:pointer :__CLPK_integer))
    (nru (:pointer :__CLPK_integer))
    (ncc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (vt (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvt (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldu (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zdrot_" 
   ((n (:pointer :__CLPK_integer))
    (cx (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (cy (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zdrscl_" 
   ((n (:pointer :__CLPK_integer))
    (sa (:pointer :__CLPK_DOUBLEREAL))
    (sx (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbbrd_" 
   ((vect (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ncc (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (pt (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldpt (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbequ_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldafb (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbsv_" 
   ((n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldafb (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbtf2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbtrf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgbtrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgebak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgebal_" 
   ((job (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgebd2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tauq (:pointer :__CLPK_DOUBLECOMPLEX))
    (taup (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgebrd_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tauq (:pointer :__CLPK_DOUBLECOMPLEX))
    (taup (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgecon_" 
   ((norm (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeequ_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgees_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (vs (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvs (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeesx_" 
   ((jobvs (:pointer :char))
    (sort (:pointer :char))
    (select :pointer)
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (vs (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvs (:pointer :__CLPK_integer))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (abnrm (:pointer :__CLPK_DOUBLEREAL))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgegs_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (vsl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvsl (:pointer :__CLPK_integer))
    (vsr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvsr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgegv_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgehd2_" 
   ((n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgehrd_" 
   ((n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgelq2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgelqf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgels_" 
   ((trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgelsx_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgelsy_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rank (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeql2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeqlf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeqp3_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeqpf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeqr2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgeqrf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgerfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgerq2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgerqf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgesc2_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (rhs (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (jpiv (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgesv_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgesvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgetc2_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (jpiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgetf2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgetrf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgetri_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgetrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggbak_" 
   ((job (:pointer :char))
    (side (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (lscale (:pointer :__CLPK_DOUBLEREAL))
    (rscale (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggbal_" 
   ((job (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (lscale (:pointer :__CLPK_DOUBLEREAL))
    (rscale (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgges_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (delctg :pointer)
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (vsl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvsl (:pointer :__CLPK_integer))
    (vsr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvsr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggesx_" 
   ((jobvsl (:pointer :char))
    (jobvsr (:pointer :char))
    (sort (:pointer :char))
    (delctg :pointer)
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (sdim (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (vsl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvsl (:pointer :__CLPK_integer))
    (vsr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvsr (:pointer :__CLPK_integer))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggev_" 
   ((jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggevx_" 
   ((balanc (:pointer :char))
    (jobvl (:pointer :char))
    (jobvr (:pointer :char))
    (sense (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (lscale (:pointer :__CLPK_DOUBLEREAL))
    (rscale (:pointer :__CLPK_DOUBLEREAL))
    (abnrm (:pointer :__CLPK_DOUBLEREAL))
    (bbnrm (:pointer :__CLPK_DOUBLEREAL))
    (rconde (:pointer :__CLPK_DOUBLEREAL))
    (rcondv (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (bwork (:pointer :__clpk_logical))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggglm_" 
   ((n (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgghrd_" 
   ((compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgglse_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggqrf_" 
   ((n (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (taua (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (taub (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggrqf_" 
   ((m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (taua (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (taub (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggsvd_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldu (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zggsvp_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (tola (:pointer :__CLPK_DOUBLEREAL))
    (tolb (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldu (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgtcon_" 
   ((norm (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (du2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgtrfs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (dlf (:pointer :__CLPK_DOUBLECOMPLEX))
    (df (:pointer :__CLPK_DOUBLECOMPLEX))
    (duf (:pointer :__CLPK_DOUBLECOMPLEX))
    (du2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgtsv_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgtsvx_" 
   ((fact (:pointer :char))
    (trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (dlf (:pointer :__CLPK_DOUBLECOMPLEX))
    (df (:pointer :__CLPK_DOUBLECOMPLEX))
    (duf (:pointer :__CLPK_DOUBLECOMPLEX))
    (du2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgttrf_" 
   ((n (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (du2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgttrs_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (du2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zgtts2_" 
   ((itrans (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (du2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbgst_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldbb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbgv_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldbb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbgvx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ka (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (bb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldbb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhbtrd_" 
   ((vect (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhecon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zheev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zheevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zheevr_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zheevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhegs2_" 
   ((itype (:pointer :__CLPK_integer))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhegst_" 
   ((itype (:pointer :__CLPK_integer))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhegv_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhegvd_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhegvx_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zherfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhesv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhesvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhetf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhetrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhetrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhetri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhetrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhgeqz_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpev_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpevd_" 
   ((jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpevx_" 
   ((jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpgst_" 
   ((itype (:pointer :__CLPK_integer))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (bp (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpgv_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (bp (:pointer :__CLPK_DOUBLECOMPLEX))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpgvd_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (bp (:pointer :__CLPK_DOUBLECOMPLEX))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpgvx_" 
   ((itype (:pointer :__CLPK_integer))
    (jobz (:pointer :char))
    (range (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (bp (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLEREAL))
    (vu (:pointer :__CLPK_DOUBLEREAL))
    (il (:pointer :__CLPK_integer))
    (iu (:pointer :__CLPK_integer))
    (abstol (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (afp (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhpsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (afp (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhptrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhsein_" 
   ((side (:pointer :char))
    (eigsrc (:pointer :char))
    (initv (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldh (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (ifaill (:pointer :__CLPK_integer))
    (ifailr (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zhseqr_" 
   ((job (:pointer :char))
    (compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldh (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlabrd_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tauq (:pointer :__CLPK_DOUBLECOMPLEX))
    (taup (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldy (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlacgv_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlacon_" 
   ((n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (est (:pointer :__CLPK_DOUBLEREAL))
    (kase (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlacp2_" 
   ((uplo (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlacpy_" 
   ((uplo (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlacrm_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLEREAL))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlacrt_" 
   ((n (:pointer :__CLPK_integer))
    (cx (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (cy (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (s (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaed0_" 
   ((qsiz (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (qstore (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldqs (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaed7_" 
   ((n (:pointer :__CLPK_integer))
    (cutpnt (:pointer :__CLPK_integer))
    (qsiz (:pointer :__CLPK_integer))
    (tlvls (:pointer :__CLPK_integer))
    (curlvl (:pointer :__CLPK_integer))
    (curpbm (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (indxq (:pointer :__CLPK_integer))
    (qstore (:pointer :__CLPK_DOUBLEREAL))
    (qptr (:pointer :__CLPK_integer))
    (prmptr (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaed8_" 
   ((k (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (qsiz (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (rho (:pointer :__CLPK_DOUBLEREAL))
    (cutpnt (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (dlamda (:pointer :__CLPK_DOUBLEREAL))
    (q2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq2 (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (indxp (:pointer :__CLPK_integer))
    (indx (:pointer :__CLPK_integer))
    (indxq (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaein_" 
   ((rightv (:pointer :__clpk_logical))
    (noinit (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldh (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (eps3 (:pointer :__CLPK_DOUBLEREAL))
    (smlnum (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaesy_" 
   ((a (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (rt1 (:pointer :__CLPK_DOUBLECOMPLEX))
    (rt2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (evscal (:pointer :__CLPK_DOUBLECOMPLEX))
    (cs1 (:pointer :__CLPK_DOUBLECOMPLEX))
    (sn1 (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaev2_" 
   ((a (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (rt1 (:pointer :__CLPK_DOUBLEREAL))
    (rt2 (:pointer :__CLPK_DOUBLEREAL))
    (cs1 (:pointer :__CLPK_DOUBLEREAL))
    (sn1 (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlags2_" 
   ((upper (:pointer :__clpk_logical))
    (a1 (:pointer :__CLPK_DOUBLEREAL))
    (a2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (a3 (:pointer :__CLPK_DOUBLEREAL))
    (b1 (:pointer :__CLPK_DOUBLEREAL))
    (b2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (b3 (:pointer :__CLPK_DOUBLEREAL))
    (csu (:pointer :__CLPK_DOUBLEREAL))
    (snu (:pointer :__CLPK_DOUBLECOMPLEX))
    (csv (:pointer :__CLPK_DOUBLEREAL))
    (snv (:pointer :__CLPK_DOUBLECOMPLEX))
    (csq (:pointer :__CLPK_DOUBLEREAL))
    (snq (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlagtm_" 
   ((trans (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (dl (:pointer :__CLPK_DOUBLECOMPLEX))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (du (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlahef_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldw (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlahqr_" 
   ((wantt (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (h__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldh (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (iloz (:pointer :__CLPK_integer))
    (ihiz (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlahrd_" 
   ((n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldy (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaic1_" 
   ((job (:pointer :__CLPK_integer))
    (j (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (sest (:pointer :__CLPK_DOUBLEREAL))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (gamma (:pointer :__CLPK_DOUBLECOMPLEX))
    (sestpr (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlals0_" 
   ((icompq (:pointer :__CLPK_integer))
    (nl (:pointer :__CLPK_integer))
    (nr (:pointer :__CLPK_integer))
    (sqre (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (bx (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldbx (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (ldgnum (:pointer :__CLPK_integer))
    (poles (:pointer :__CLPK_DOUBLEREAL))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlalsa_" 
   ((icompq (:pointer :__CLPK_integer))
    (smlsiz (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (bx (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldbx (:pointer :__CLPK_integer))
    (u (:pointer :__CLPK_DOUBLEREAL))
    (ldu (:pointer :__CLPK_integer))
    (vt (:pointer :__CLPK_DOUBLEREAL))
    (k (:pointer :__CLPK_integer))
    (difl (:pointer :__CLPK_DOUBLEREAL))
    (difr (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLEREAL))
    (poles (:pointer :__CLPK_DOUBLEREAL))
    (givptr (:pointer :__CLPK_integer))
    (givcol (:pointer :__CLPK_integer))
    (ldgcol (:pointer :__CLPK_integer))
    (perm (:pointer :__CLPK_integer))
    (givnum (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlapll_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
    (ssmin (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlapmt_" 
   ((forwrd (:pointer :__clpk_logical))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqgb_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqge_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (r__ (:pointer :__CLPK_DOUBLEREAL))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (rowcnd (:pointer :__CLPK_DOUBLEREAL))
    (colcnd (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqhb_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqhe_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqhp_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqp2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (offset (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (vn1 (:pointer :__CLPK_DOUBLEREAL))
    (vn2 (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqps_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (offset (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (jpvt (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (vn1 (:pointer :__CLPK_DOUBLEREAL))
    (vn2 (:pointer :__CLPK_DOUBLEREAL))
    (auxv (:pointer :__CLPK_DOUBLECOMPLEX))
    (f (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldf (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqsb_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqsp_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaqsy_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (equed (:pointer :char))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlar1v_" 
   ((n (:pointer :__CLPK_integer))
    (b1 (:pointer :__CLPK_integer))
    (bn (:pointer :__CLPK_integer))
    (sigma (:pointer :__CLPK_DOUBLEREAL))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (l (:pointer :__CLPK_DOUBLEREAL))
    (ld (:pointer :__CLPK_DOUBLEREAL))
    (lld (:pointer :__CLPK_DOUBLEREAL))
    (gersch (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ztz (:pointer :__CLPK_DOUBLEREAL))
    (mingma (:pointer :__CLPK_DOUBLEREAL))
    (r__ (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlar2v_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLECOMPLEX))
    (incc (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarcm_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLEREAL))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarf_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (incv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarfb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldwork (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarfg_" 
   ((n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarft_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarfx_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlargv_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (incc (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarnv_" 
   ((idist (:pointer :__CLPK_integer))
    (iseed (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarrv_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (l (:pointer :__CLPK_DOUBLEREAL))
    (isplit (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (iblock (:pointer :__CLPK_integer))
    (gersch (:pointer :__CLPK_DOUBLEREAL))
    (tol (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (isuppz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlartg_" 
   ((f (:pointer :__CLPK_DOUBLECOMPLEX))
    (g (:pointer :__CLPK_DOUBLECOMPLEX))
    (cs (:pointer :__CLPK_DOUBLEREAL))
    (sn (:pointer :__CLPK_DOUBLECOMPLEX))
    (r__ (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlartv_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLECOMPLEX))
    (incc (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarz_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (incv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarzb_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (direct (:pointer :char))
    (storev (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldwork (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlarzt_" 
   ((direct (:pointer :char))
    (storev (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlascl_" 
   ((type__ (:pointer :char))
    (kl (:pointer :__CLPK_integer))
    (ku (:pointer :__CLPK_integer))
    (cfrom (:pointer :__CLPK_DOUBLEREAL))
    (cto (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaset_" 
   ((uplo (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlasr_" 
   ((side (:pointer :char))
    (pivot (:pointer :char))
    (direct (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlassq_" 
   ((n (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (sumsq (:pointer :__CLPK_DOUBLEREAL))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlaswp_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (k1 (:pointer :__CLPK_integer))
    (k2 (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (incx (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlasyf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (kb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldw (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatbs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (cnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatdf_" 
   ((ijob (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (rhs (:pointer :__CLPK_DOUBLECOMPLEX))
    (rdsum (:pointer :__CLPK_DOUBLEREAL))
    (rdscal (:pointer :__CLPK_DOUBLEREAL))
    (ipiv (:pointer :__CLPK_integer))
    (jpiv (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatps_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (cnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatrd_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nb (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldw (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (normin (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (cnorm (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatrz_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlatzm_" 
   ((side (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (incv (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c1 (:pointer :__CLPK_DOUBLECOMPLEX))
    (c2 (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlauu2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zlauum_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldafb (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbstf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (afb (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldafb (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbtf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbtrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpbtrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpocon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpoequ_" 
   ((n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zporfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zposv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zposvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpotf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpotrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpotri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpotrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zppcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zppequ_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (scond (:pointer :__CLPK_DOUBLEREAL))
    (amax (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (afp (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zppsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zppsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (afp (:pointer :__CLPK_DOUBLECOMPLEX))
    (equed (:pointer :char))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zptcon_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zptrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (df (:pointer :__CLPK_DOUBLEREAL))
    (ef (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zptsv_" 
   ((n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zptsvx_" 
   ((fact (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (df (:pointer :__CLPK_DOUBLEREAL))
    (ef (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpttrf_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zpttrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zptts2_" 
   ((iuplo (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zrot_" 
   ((n (:pointer :__CLPK_integer))
    (cx (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (cy (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLEREAL))
    (s (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zspcon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zspmv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zspr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsprfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (afp (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zspsv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zspsvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (afp (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsptrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsptri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsptrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zstedc_" 
   ((compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (lrwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zstein_" 
   ((n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (m (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLEREAL))
    (iblock (:pointer :__CLPK_integer))
    (isplit (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (iwork (:pointer :__CLPK_integer))
    (ifail (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsteqr_" 
   ((compz (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLEREAL))
    (e (:pointer :__CLPK_DOUBLEREAL))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsycon_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (anorm (:pointer :__CLPK_DOUBLEREAL))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsymv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (y (:pointer :__CLPK_DOUBLECOMPLEX))
    (incy (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsyr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (incx (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsyrfs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsysv_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsysvx_" 
   ((fact (:pointer :char))
    (uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (af (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldaf (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsytf2_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsytrf_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsytri_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zsytrs_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (ipiv (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztbcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztbrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztbtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (kd (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ab (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldab (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgex2_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (j1 (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgexc_" 
   ((wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (ifst (:pointer :__CLPK_integer))
    (ilst (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgsen_" 
   ((ijob (:pointer :__CLPK_integer))
    (wantq (:pointer :__clpk_logical))
    (wantz (:pointer :__clpk_logical))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (alpha (:pointer :__CLPK_DOUBLECOMPLEX))
    (beta (:pointer :__CLPK_DOUBLECOMPLEX))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (z__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldz (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (pl (:pointer :__CLPK_DOUBLEREAL))
    (pr (:pointer :__CLPK_DOUBLEREAL))
    (dif (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (liwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgsja_" 
   ((jobu (:pointer :char))
    (jobv (:pointer :char))
    (jobq (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (p (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (tola (:pointer :__CLPK_DOUBLEREAL))
    (tolb (:pointer :__CLPK_DOUBLEREAL))
    (alpha (:pointer :__CLPK_DOUBLEREAL))
    (beta (:pointer :__CLPK_DOUBLEREAL))
    (u (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldu (:pointer :__CLPK_integer))
    (v (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldv (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (ncycle (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (dif (:pointer :__CLPK_DOUBLEREAL))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgsy2_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldd (:pointer :__CLPK_integer))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (lde (:pointer :__CLPK_integer))
    (f (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldf (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (rdsum (:pointer :__CLPK_DOUBLEREAL))
    (rdscal (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztgsyl_" 
   ((trans (:pointer :char))
    (ijob (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (d__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldd (:pointer :__CLPK_integer))
    (e (:pointer :__CLPK_DOUBLECOMPLEX))
    (lde (:pointer :__CLPK_integer))
    (f (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldf (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (dif (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (iwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztpcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztprfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztptri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztptrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrcon_" 
   ((norm (:pointer :char))
    (uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (rcond (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrevc_" 
   ((side (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrexc_" 
   ((compq (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (ifst (:pointer :__CLPK_integer))
    (ilst (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrrfs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (x (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldx (:pointer :__CLPK_integer))
    (ferr (:pointer :__CLPK_DOUBLEREAL))
    (berr (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrsen_" 
   ((job (:pointer :char))
    (compq (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (w (:pointer :__CLPK_DOUBLECOMPLEX))
    (m (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (sep (:pointer :__CLPK_DOUBLEREAL))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrsna_" 
   ((job (:pointer :char))
    (howmny (:pointer :char))
    (select (:pointer :__clpk_logical))
    (n (:pointer :__CLPK_integer))
    (t (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldt (:pointer :__CLPK_integer))
    (vl (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvl (:pointer :__CLPK_integer))
    (vr (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldvr (:pointer :__CLPK_integer))
    (s (:pointer :__CLPK_DOUBLEREAL))
    (sep (:pointer :__CLPK_DOUBLEREAL))
    (mm (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldwork (:pointer :__CLPK_integer))
    (rwork (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrsyl_" 
   ((trana (:pointer :char))
    (tranb (:pointer :char))
    (isgn (:pointer :__CLPK_integer))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (scale (:pointer :__CLPK_DOUBLEREAL))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrti2_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrtri_" 
   ((uplo (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztrtrs_" 
   ((uplo (:pointer :char))
    (trans (:pointer :char))
    (diag (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (nrhs (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (b (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldb (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztzrqf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_ztzrzf_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zung2l_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zung2r_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungbr_" 
   ((vect (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunghr_" 
   ((n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungl2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunglq_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungql_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungqr_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungr2_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungrq_" 
   ((m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zungtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunm2l_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunm2r_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmbr_" 
   ((vect (:pointer :char))
    (side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmhr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ilo (:pointer :__CLPK_integer))
    (ihi (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunml2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmlq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmql_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmqr_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmr2_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmr3_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmrq_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmrz_" 
   ((side (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (k (:pointer :__CLPK_integer))
    (l (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zunmtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (a (:pointer :__CLPK_DOUBLECOMPLEX))
    (lda (:pointer :__CLPK_integer))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (lwork (:pointer :__CLPK_integer))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zupgtr_" 
   ((uplo (:pointer :char))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (q (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldq (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
;  Subroutine 

(deftrap-inline "_zupmtr_" 
   ((side (:pointer :char))
    (uplo (:pointer :char))
    (trans (:pointer :char))
    (m (:pointer :__CLPK_integer))
    (n (:pointer :__CLPK_integer))
    (ap (:pointer :__CLPK_DOUBLECOMPLEX))
    (tau (:pointer :__CLPK_DOUBLECOMPLEX))
    (c__ (:pointer :__CLPK_DOUBLECOMPLEX))
    (ldc (:pointer :__CLPK_integer))
    (work (:pointer :__CLPK_DOUBLECOMPLEX))
    (info (:pointer :__CLPK_integer))
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CLAPACK_H */


(provide-interface "clapack")