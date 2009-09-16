(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:upl.h"
; at Sunday July 2,2006 7:32:09 pm.
; #ifndef	_upl_user_
; #define	_upl_user_
;  Module upl 

(require-interface "string")

(require-interface "mach/ndr")

(require-interface "mach/boolean")

(require-interface "mach/kern_return")

(require-interface "mach/notify")

(require-interface "mach/mach_types")

(require-interface "mach/message")

(require-interface "mach/mig_errors")

(require-interface "mach/port")
; #ifdef AUTOTEST
#| #|
#ifndefFUNCTION_PTR_T
#define FUNCTION_PTR_T
typedef void (*function_ptr_t)(mach_port_t, char *, mach_msg_type_number_t);
typedef struct {
        char            *name;
        function_ptr_t  function;
} function_table_entry;
typedef function_table_entry 	*function_table_t;
#endif
#endif
|#
 |#
;  AUTOTEST 
; #ifndef	upl_MSG_COUNT
(defconstant $upl_MSG_COUNT 4)
; #define	upl_MSG_COUNT	4

; #endif	/* upl_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")
; #ifdef __BeforeMigUserHeader
#| #|
__BeforeMigUserHeader
#endif
|#
 |#
;  __BeforeMigUserHeader 

(require-interface "sys/cdefs")
;  Routine upl_abort 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_upl_abort" 
   ((upl_object :upl_t)
    (abort_cond :signed-long)
   )
   :signed-long
() )
;  Routine upl_abort_range 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_upl_abort_range" 
   ((upl_object :upl_t)
    (offset :UInt32)
    (size :UInt32)
    (abort_cond :signed-long)
    (empty (:pointer :boolean_t))
   )
   :signed-long
() )
;  Routine upl_commit 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_upl_commit" 
   ((upl_object :upl_t)
    (page_list :upl_page_info_array_t)
    (page_listCnt :UInt32)
   )
   :signed-long
() )
;  Routine upl_commit_range 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_upl_commit_range" 
   ((upl_object :upl_t)
    (offset :UInt32)
    (size :UInt32)
    (cntrl_flags :signed-long)
    (page_list :upl_page_info_array_t)
    (page_listCnt :UInt32)
    (empty (:pointer :boolean_t))
   )
   :signed-long
() )
; ********************* Caution *************************
;  The following data types should be used to calculate  
;  maximum message sizes only. The actual message may be 
;  smaller, and the position of the arguments within the 
;  message layout may vary from what is presented here.  
;  For example, if any of the arguments are variable-    
;  sized, and less than the maximum is sent, the data    
;  will be packed tight in the actual message to reduce  
;  the presence of holes.                                
; ********************* Caution *************************
;  typedefs for all requests 
; #ifndef __Request__upl_subsystem__defined
; #define __Request__upl_subsystem__defined
(defrecord __Request__upl_abort_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (abort_cond :signed-long)
)
(defrecord __Request__upl_abort_range_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :UInt32)
   (size :UInt32)
   (abort_cond :signed-long)
)
#|
; Warning: type-size: unknown type upl_page_info_t
|#
(defrecord __Request__upl_commit_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (page_listCnt :UInt32)
   (page_list (:array :upl_page_info_t 20))
)
#|
; Warning: type-size: unknown type upl_page_info_t
|#
(defrecord __Request__upl_commit_range_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :UInt32)
   (size :UInt32)
   (cntrl_flags :signed-long)
   (page_listCnt :UInt32)
   (page_list (:array :upl_page_info_t 20))
)

; #endif /* !__Request__upl_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__upl_subsystem__defined
; #define __RequestUnion__upl_subsystem__defined
(defrecord __RequestUnion__upl_subsystem
   (:variant
   (
   (Request_upl_abort :__REQUEST__UPL_ABORT_T)
   )
   (
   (Request_upl_abort_range :__REQUEST__UPL_ABORT_RANGE_T)
   )
   (
   (Request_upl_commit :__REQUEST__UPL_COMMIT_T)
   )
   (
   (Request_upl_commit_range :__REQUEST__UPL_COMMIT_RANGE_T)
   )
   )
)

; #endif /* !__RequestUnion__upl_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__upl_subsystem__defined
; #define __Reply__upl_subsystem__defined
(defrecord __Reply__upl_abort_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__upl_abort_range_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (empty :signed-long)
)
(defrecord __Reply__upl_commit_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__upl_commit_range_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (empty :signed-long)
)

; #endif /* !__Reply__upl_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__upl_subsystem__defined
; #define __ReplyUnion__upl_subsystem__defined
(defrecord __ReplyUnion__upl_subsystem
   (:variant
   (
   (Reply_upl_abort :__REPLY__UPL_ABORT_T)
   )
   (
   (Reply_upl_abort_range :__REPLY__UPL_ABORT_RANGE_T)
   )
   (
   (Reply_upl_commit :__REPLY__UPL_COMMIT_T)
   )
   (
   (Reply_upl_commit_range :__REPLY__UPL_COMMIT_RANGE_T)
   )
   )
)

; #endif /* !__RequestUnion__upl_subsystem__defined */

; #ifndef subsystem_to_name_map_upl
; #define subsystem_to_name_map_upl     { "upl_abort", 2050 },    { "upl_abort_range", 2051 },    { "upl_commit", 2052 },    { "upl_commit_range", 2053 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _upl_user_ */


(provide-interface "upl")