(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cblas.h"
; at Sunday July 2,2006 7:25:22 pm.
; 
;    =================================================================================================
;    Definitions of the Basic Linear Algebra Subprograms (BLAS) as provided Apple Computer.
;    A few additional functions, unique to Mac OS, have also been provided.  
;    These are clearly documented as Apple extensions.
; 
;    Documentation on the BLAS standard, including reference implementations, can be found on the web
;    starting from the BLAS FAQ page at these URLs (verified live as of April 2002):
;         http://www.netlib.org/blas/faq.html
;         http://www.netlib.org/blas/blast-forum/blast-forum.html
;    =================================================================================================
; 
; 
;    =================================================================================================
;    Matrix shape and storage
;    ========================
;    Keeping the various matrix shape and storage parameters straight can be difficult.  The BLAS
;    documentation generally makes a distinction between the concpetual "matrix" and the physical
;    "array".  However there are a number of places where this becomes fuzzy because of the overall
;    bias towards FORTRAN's column major storage.  The confusion is made worse by style differences
;    between the level 2 and level 3 functions.  It is amplified further by the explicit choice of row
;    or column major storage in the C interface.
;    The storage order does not affect the actual computation that is performed.  That is, it does not
;    affect the results other than where they appear in memory.  It does affect the values passed
;    for so-called "leading dimension" parameters, such as lda in sgemv.  These are always the major
;    stride in storage, allowing operations on rectangular subsets of larger matrices.  For row major
;    storage this is the number of columns in the parent matrix, and for column major storage this is
;    the number of rows in the parent matrix.
;    For the level 2 functions, which deal with only a single matrix, the matrix shape parameters are
;    always M and N.  These are the logical shape of the matrix, M rows by N columns.  The transpose
;    parameter, such as transA in sgemv, defines whether the regular matrix or its transpose is used
;    in the operation.  This affects the implicit length of the input and output vectors.  For example,
;    if the regular matrix A is used in sgemv, the input vector X has length N, the number of columns
;    of A, and the output vector Y has length M, the number of rows of A.  The length of the input and
;    output vectors is not affected by the storage order of the matrix.
;    The level 3 functions deal with 2 input matrices and one output matrix, the matrix shape parameters
;    are M, N, and K.  The logical shape of the output matrix is always M by N, while K is the common
;    dimension of the input matrices.  Like level 2, the transpose parameters, such as transA and transB
;    in sgemm, define whether the regular input or its transpose is used in the operation.  However
;    unlike level 2, in level 3 the transpose parameters affect the implicit shape of the input matrix.
;    Consider sgemm, which computes "C = (alpha * A * B) + (beta * C)", where A and B might be regular
;    or transposed.  The logical shape of C is always M rows by N columns.  The physical shape depends
;    on the storage order parameter.  Using column major storage the declaration of C (the array) in C
;    (the language) would be something like "float C[N][M]".  The logical shape of A without transposition
;    is M by K, and B is K by N.  The one storage order parameter affects all three matrices.
;    For those readers still wondering about the style differences between level 2 and level 3, they
;    involve whether the input or output shapes are explicit.  For level 2, the input matrix shape is
;    always M by N.  The input and output vector lengths are implicit and vary according to the
;    transpose parameter.  For level 3, the output matrix shape is always M by N.  The input matrix
;    shapes are implicit and vary according to the transpose parameters.
;    =================================================================================================
; 
; #ifndef CBLAS_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #ifndef CBLAS_ENUM_DEFINED_H
; #define CBLAS_ENUM_DEFINED_H
(def-mactype :CBLAS_ORDER (find-mactype ':sint32))

(defconstant $CblasRowMajor 101)
(defconstant $CblasColMajor 102)
(def-mactype :CBLAS_TRANSPOSE (find-mactype ':sint32))

(defconstant $CblasNoTrans 111)
(defconstant $CblasTrans 112)
(defconstant $CblasConjTrans 113)
(defconstant $AtlasConj 114)
(def-mactype :CBLAS_UPLO (find-mactype ':sint32))

(defconstant $CblasUpper 121)
(defconstant $CblasLower 122)
(def-mactype :CBLAS_DIAG (find-mactype ':sint32))

(defconstant $CblasNonUnit #x83)
(defconstant $CblasUnit #x84)
(def-mactype :CBLAS_SIDE (find-mactype ':sint32))

(defconstant $CblasLeft #x8D)
(defconstant $CblasRight #x8E)

; #endif

; #ifndef CBLAS_ENUM_ONLY
; #define CBLAS_H
; #define CBLAS_INDEX int

(deftrap-inline "_cblas_errprn" 
   ((ierr :signed-long)
    (info :signed-long)
    (form (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )
; 
;  * ===========================================================================
;  * Prototypes for level 1 BLAS functions (complex are recast as routines)
;  * ===========================================================================
;  

(deftrap-inline "_cblas_sdsdot" 
   ((N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :single-float
() )

(deftrap-inline "_cblas_dsdot" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :double-float
() )

(deftrap-inline "_cblas_sdot" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :single-float
() )

(deftrap-inline "_cblas_ddot" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :double-float
() )
; 
;  * Functions having prefixes Z and C only
;  

(deftrap-inline "_cblas_cdotu_sub" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (dotu :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_cdotc_sub" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (dotc :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_zdotu_sub" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (dotu :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_zdotc_sub" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (dotc :pointer)
   )
   :void
() )
; 
;  * Functions having prefixes S D SC DZ
;  

(deftrap-inline "_cblas_snrm2" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :single-float
() )

(deftrap-inline "_cblas_sasum" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :single-float
() )

(deftrap-inline "_cblas_dnrm2" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :double-float
() )

(deftrap-inline "_cblas_dasum" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :double-float
() )

(deftrap-inline "_cblas_scnrm2" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :single-float
() )

(deftrap-inline "_cblas_scasum" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :single-float
() )

(deftrap-inline "_cblas_dznrm2" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :double-float
() )

(deftrap-inline "_cblas_dzasum" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :double-float
() )
; 
;  * Functions having standard 4 prefixes (S D C Z)
;  

(deftrap-inline "_cblas_isamax" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_cblas_idamax" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_cblas_icamax" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_cblas_izamax" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :signed-long
() )
; 
;  * ===========================================================================
;  * Prototypes for level 1 BLAS routines
;  * ===========================================================================
;  
; 
;  * Routines with standard 4 prefixes (s, d, c, z)
;  

(deftrap-inline "_cblas_sswap" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_scopy" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_saxpy" 
   ((N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dswap" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dcopy" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_daxpy" 
   ((N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cswap" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ccopy" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_caxpy" 
   ((N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zswap" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zcopy" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zaxpy" 
   ((N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )
; 
;  * Routines with S and D prefix only
;  

(deftrap-inline "_cblas_srotg" 
   ((a (:pointer :float))
    (b (:pointer :float))
    (c (:pointer :float))
    (s (:pointer :float))
   )
   :void
() )

(deftrap-inline "_cblas_srotmg" 
   ((d1 (:pointer :float))
    (d2 (:pointer :float))
    (b1 (:pointer :float))
    (b2 :single-float)
    (P (:pointer :float))
   )
   :void
() )

(deftrap-inline "_cblas_srot" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
    (c :single-float)
    (s :single-float)
   )
   :void
() )

(deftrap-inline "_cblas_srotm" 
   ((N :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
    (P (:pointer :float))
   )
   :void
() )

(deftrap-inline "_cblas_drotg" 
   ((a (:pointer :double))
    (b (:pointer :double))
    (c (:pointer :double))
    (s (:pointer :double))
   )
   :void
() )

(deftrap-inline "_cblas_drotmg" 
   ((d1 (:pointer :double))
    (d2 (:pointer :double))
    (b1 (:pointer :double))
    (b2 :double-float)
    (P (:pointer :double))
   )
   :void
() )

(deftrap-inline "_cblas_drot" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
    (c :double-float)
    (s :double-float)
   )
   :void
() )

(deftrap-inline "_cblas_drotm" 
   ((N :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
    (P (:pointer :double))
   )
   :void
() )
; 
;  * Routines with S D C Z CS and ZD prefixes
;  

(deftrap-inline "_cblas_sscal" 
   ((N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dscal" 
   ((N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cscal" 
   ((N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zscal" 
   ((N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_csscal" 
   ((N :signed-long)
    (alpha :single-float)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zdscal" 
   ((N :signed-long)
    (alpha :double-float)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )
; 
;  * Extra reference routines provided by ATLAS, but not mandated by the standard
;  

(deftrap-inline "_cblas_crotg" 
   ((a :pointer)
    (b :pointer)
    (c :pointer)
    (s :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_zrotg" 
   ((a :pointer)
    (b :pointer)
    (c :pointer)
    (s :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_csrot" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (c :single-float)
    (s :single-float)
   )
   :void
() )

(deftrap-inline "_cblas_zdrot" 
   ((N :signed-long)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (c :double-float)
    (s :double-float)
   )
   :void
() )
; 
;  * ===========================================================================
;  * Prototypes for level 2 BLAS
;  * ===========================================================================
;  
; 
;  * Routines with standard 4 prefixes (S, D, C, Z)
;  

(deftrap-inline "_cblas_sgemv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (beta :single-float)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_sgbmv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (KL :signed-long)
    (KU :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (beta :single-float)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_strmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_stbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_stpmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap (:pointer :float))
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_strsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_stbsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_stpsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap (:pointer :float))
    (X (:pointer :float))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dgemv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (beta :double-float)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dgbmv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (KL :signed-long)
    (KU :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (beta :double-float)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtrmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtpmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap (:pointer :double))
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtrsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtbsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtpsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap (:pointer :double))
    (X (:pointer :double))
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cgemv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cgbmv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (KL :signed-long)
    (KU :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctrmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctpmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap :pointer)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctrsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctbsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctpsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap :pointer)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zgemv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zgbmv" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (KL :signed-long)
    (KU :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztrmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztpmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap :pointer)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztrsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztbsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (K :signed-long)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztpsv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (N :signed-long)
    (Ap :pointer)
    (X :pointer)
    (incX :signed-long)
   )
   :void
() )
; 
;  * Routines with S and D prefixes only
;  

(deftrap-inline "_cblas_ssymv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (beta :single-float)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ssbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (K :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (X (:pointer :float))
    (incX :signed-long)
    (beta :single-float)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_sspmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (Ap (:pointer :float))
    (X (:pointer :float))
    (incX :signed-long)
    (beta :single-float)
    (Y (:pointer :float))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_sger" 
   ((Order :cblas_order)
    (M :signed-long)
    (N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ssyr" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_sspr" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (Ap (:pointer :float))
   )
   :void
() )

(deftrap-inline "_cblas_ssyr2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
    (A (:pointer :float))
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_sspr2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (X (:pointer :float))
    (incX :signed-long)
    (Y (:pointer :float))
    (incY :signed-long)
    (A (:pointer :float))
   )
   :void
() )

(deftrap-inline "_cblas_dsymv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (beta :double-float)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dsbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (K :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (X (:pointer :double))
    (incX :signed-long)
    (beta :double-float)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dspmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (Ap (:pointer :double))
    (X (:pointer :double))
    (incX :signed-long)
    (beta :double-float)
    (Y (:pointer :double))
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dger" 
   ((Order :cblas_order)
    (M :signed-long)
    (N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dsyr" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dspr" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
    (Ap (:pointer :double))
   )
   :void
() )

(deftrap-inline "_cblas_dsyr2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
    (A (:pointer :double))
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dspr2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (X (:pointer :double))
    (incX :signed-long)
    (Y (:pointer :double))
    (incY :signed-long)
    (A (:pointer :double))
   )
   :void
() )
; 
;  * Routines with C and Z prefixes only
;  

(deftrap-inline "_cblas_chemv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_chbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_chpmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (Ap :pointer)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cgeru" 
   ((Order :cblas_order)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cgerc" 
   ((Order :cblas_order)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cher" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (X :pointer)
    (incX :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_chpr" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :single-float)
    (X :pointer)
    (incX :signed-long)
    (A :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_cher2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_chpr2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (Ap :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_zhemv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zhbmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zhpmv" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (Ap :pointer)
    (X :pointer)
    (incX :signed-long)
    (beta :pointer)
    (Y :pointer)
    (incY :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zgeru" 
   ((Order :cblas_order)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zgerc" 
   ((Order :cblas_order)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zher" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (X :pointer)
    (incX :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zhpr" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :double-float)
    (X :pointer)
    (incX :signed-long)
    (A :pointer)
   )
   :void
() )

(deftrap-inline "_cblas_zher2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (A :pointer)
    (lda :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zhpr2" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (N :signed-long)
    (alpha :pointer)
    (X :pointer)
    (incX :signed-long)
    (Y :pointer)
    (incY :signed-long)
    (Ap :pointer)
   )
   :void
() )
; 
;  * ===========================================================================
;  * Prototypes for level 3 BLAS
;  * ===========================================================================
;  
; 
;  * Routines with standard 4 prefixes (S, D, C, Z)
;  

(deftrap-inline "_cblas_sgemm" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (TransB :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (K :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (B (:pointer :float))
    (ldb :signed-long)
    (beta :single-float)
    (C (:pointer :float))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ssymm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (M :signed-long)
    (N :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (B (:pointer :float))
    (ldb :signed-long)
    (beta :single-float)
    (C (:pointer :float))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ssyrk" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (beta :single-float)
    (C (:pointer :float))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ssyr2k" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (B (:pointer :float))
    (ldb :signed-long)
    (beta :single-float)
    (C (:pointer :float))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_strmm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (B (:pointer :float))
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_strsm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :single-float)
    (A (:pointer :float))
    (lda :signed-long)
    (B (:pointer :float))
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dgemm" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (TransB :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (K :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (B (:pointer :double))
    (ldb :signed-long)
    (beta :double-float)
    (C (:pointer :double))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dsymm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (M :signed-long)
    (N :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (B (:pointer :double))
    (ldb :signed-long)
    (beta :double-float)
    (C (:pointer :double))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dsyrk" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (beta :double-float)
    (C (:pointer :double))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dsyr2k" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (B (:pointer :double))
    (ldb :signed-long)
    (beta :double-float)
    (C (:pointer :double))
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtrmm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (B (:pointer :double))
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_dtrsm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :double-float)
    (A (:pointer :double))
    (lda :signed-long)
    (B (:pointer :double))
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cgemm" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (TransB :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_csymm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_csyrk" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_csyr2k" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctrmm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ctrsm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zgemm" 
   ((Order :cblas_order)
    (TransA :cblas_transpose)
    (TransB :cblas_transpose)
    (M :signed-long)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zsymm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zsyrk" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zsyr2k" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztrmm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_ztrsm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (TransA :cblas_transpose)
    (Diag :cblas_diag)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
   )
   :void
() )
; 
;  * Routines with prefixes C and Z only
;  

(deftrap-inline "_cblas_chemm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cherk" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :single-float)
    (A :pointer)
    (lda :signed-long)
    (beta :single-float)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_cher2k" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :single-float)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zhemm" 
   ((Order :cblas_order)
    (Side :cblas_side)
    (Uplo :cblas_uplo)
    (M :signed-long)
    (N :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :pointer)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zherk" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :double-float)
    (A :pointer)
    (lda :signed-long)
    (beta :double-float)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )

(deftrap-inline "_cblas_zher2k" 
   ((Order :cblas_order)
    (Uplo :cblas_uplo)
    (Trans :cblas_transpose)
    (N :signed-long)
    (K :signed-long)
    (alpha :pointer)
    (A :pointer)
    (lda :signed-long)
    (B :pointer)
    (ldb :signed-long)
    (beta :double-float)
    (C :pointer)
    (ldc :signed-long)
   )
   :void
() )
; 
;    Apple extensions follow.
; 
; 
;    -------------------------------------------------------------------------------------------------
;    The BLAS standard requires that parameter errors be reported and cause the program to terminate.
;    The default behavior for the Mac OS implementation of the BLAS is to print a message in English
;    to stdout using printf and call exit with EXIT_FAILURE as the status.  If this is adequate, then
;    you need do nothing more or worry about error handling.
;    The BLAS standard also mentions a function, cblas_xerbla, suggesting that a program provide its
;    own implementation to override the default error handling.  This will not work in the shared
;    library environment of Mac OS.  Instead the Mac OS implementation provides a means to install
;    an error handler.  There can only be one active error handler, installing a new one causes any
;    previous handler to be forgotten.  Passing a null function pointer installs the default handler.
;    The default handler is automatically installed at startup and implements the default behavior
;    defined above.
;    An error handler may return, it need not abort the program.  If the error handler returns, the
;    BLAS routine also returns immediately without performing any processing.  Level 1 functions that
;    return a numeric value return zero if the error handler returns.
;    -------------------------------------------------------------------------------------------------
; 

(def-mactype :BLASParamErrorProc (find-mactype ':pointer)); (const char * funcName , const char * paramName , const int * paramPos , const int * paramValue)

(deftrap-inline "_SetBLASParamErrorProc" 
   ((ErrorProc :pointer)
   )
   :void
() )

; #if defined(__ppc__)
#| ; #ifdef __VEC__
#|
        typedef vector float			VectorFloat;
        typedef vector float	                ConstVectorFloat; 
    #endif
|#
 |#

; #elif defined(__i386__)
#| 
(def-mactype :__m128 (find-mactype ':signed-long)); __attribute__

(def-mactype :VectorFloat (find-mactype ':__m128))

(def-mactype :ConstVectorFloat (find-mactype ':VectorFloat))
 |#
#| 
; #else

; #error Unknown architecture
 |#

; #endif


; #if defined(__VEC__) || defined(__i386__)
#| 
; 
;    -------------------------------------------------------------------------------------------------
;    These routines provide optimized, SIMD-only support for common small matrix multiplications.
;    They do not check for the availability of SIMD instructions or parameter errors.  They just do
;    the multiplication as fast as possible.  Matrices are presumed to use row major storage.  Because
;    these are all square, column major matrices can be multiplied by simply reversing the parameters.
;    -------------------------------------------------------------------------------------------------
; 
; 
;    -------------------------------------------------------------------------------------------------
;    These routines provide optimized support for common small matrix multiplications. They use
;    the scalar floating point unit and have no dependancy on SIMD instructions. They are intended
;    as complements to the AltiVec-only routines above. They do not check for parameter errors.  They just do
;    the multiplication as fast as possible.  Matrices are presumed to use row major storage.  Because
;    these are all square, column major matrices can be multiplied by simply reversing the parameters.
;    -------------------------------------------------------------------------------------------------
; 
 |#

; #endif /* defined(__VEC__) || defined(__i386__) */


; #endif  /* end #ifdef CBLAS_ENUM_ONLY */

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "cblas")