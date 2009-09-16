(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:memory_object_control.h"
; at Sunday July 2,2006 7:26:15 pm.
; #ifndef	_memory_object_control_user_
; #define	_memory_object_control_user_
;  Module memory_object_control 

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
; #ifndef	memory_object_control_MSG_COUNT
(defconstant $memory_object_control_MSG_COUNT 11)
; #define	memory_object_control_MSG_COUNT	11

; #endif	/* memory_object_control_MSG_COUNT */


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
;  Routine memory_object_get_attributes 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_get_attributes" 
   ((memory_control :memory_object_control_t)
    (flavor :memory_object_flavor_t)
    (attributes :memory_object_info_t)
    (attributesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine memory_object_change_attributes 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_change_attributes" 
   ((memory_control :memory_object_control_t)
    (flavor :memory_object_flavor_t)
    (attributes :memory_object_info_t)
    (attributesCnt :UInt32)
   )
   :signed-long
() )
;  Routine memory_object_synchronize_completed 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_synchronize_completed" 
   ((memory_control :memory_object_control_t)
    (offset :memory_object_offset_t)
    (length :UInt32)
   )
   :signed-long
() )
;  Routine memory_object_lock_request 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_lock_request" 
   ((memory_control :memory_object_control_t)
    (offset :memory_object_offset_t)
    (size :memory_object_size_t)
    (should_return :memory_object_return_t)
    (flags :signed-long)
    (lock_value :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_destroy 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_destroy" 
   ((memory_control :memory_object_control_t)
    (reason :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_upl_request 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_upl_request" 
   ((memory_control :memory_object_control_t)
    (offset :memory_object_offset_t)
    (size :UInt32)
    (upl (:pointer :upl_t))
    (page_list :upl_page_info_array_t)
    (page_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (cntrl_flags :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_super_upl_request 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_super_upl_request" 
   ((memory_control :memory_object_control_t)
    (offset :memory_object_offset_t)
    (size :UInt32)
    (super_size :UInt32)
    (upl (:pointer :upl_t))
    (page_list :upl_page_info_array_t)
    (page_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (cntrl_flags :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_page_op 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_page_op" 
   ((memory_control :memory_object_control_t)
    (offset :memory_object_offset_t)
    (ops :signed-long)
    (phys_entry (:pointer :uint32_t))
    (flags (:pointer :integer_t))
   )
   :signed-long
() )
;  Routine memory_object_recover_named 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_recover_named" 
   ((memory_control :memory_object_control_t)
    (wait_on_terminating :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_release_name 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_release_name" 
   ((memory_control :memory_object_control_t)
    (flags :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_range_op 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_range_op" 
   ((memory_control :memory_object_control_t)
    (offset_beg :memory_object_offset_t)
    (offset_end :memory_object_offset_t)
    (ops :signed-long)
    (range (:pointer :integer_t))
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
; #ifndef __Request__memory_object_control_subsystem__defined
; #define __Request__memory_object_control_subsystem__defined
#|
; Warning: type-size: unknown type MEMORY_OBJECT_FLAVOR_T
|#
(defrecord __Request__memory_object_get_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :memory_object_flavor_t)
   (attributesCnt :UInt32)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_FLAVOR_T
|#
(defrecord __Request__memory_object_change_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :memory_object_flavor_t)
   (attributesCnt :UInt32)
   (attributes (:array :signed-long 6))
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_synchronize_completed_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (length :UInt32)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
#|
; Warning: type-size: unknown type MEMORY_OBJECT_SIZE_T
|#
#|
; Warning: type-size: unknown type MEMORY_OBJECT_RETURN_T
|#
(defrecord __Request__memory_object_lock_request_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :memory_object_size_t)
   (should_return :memory_object_return_t)
   (flags :signed-long)
   (lock_value :signed-long)
)
(defrecord __Request__memory_object_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (reason :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_upl_request_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :UInt32)
   (page_listCnt :UInt32)
   (cntrl_flags :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_super_upl_request_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :UInt32)
   (super_size :UInt32)
   (page_listCnt :UInt32)
   (cntrl_flags :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_page_op_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (ops :signed-long)
)
(defrecord __Request__memory_object_recover_named_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (wait_on_terminating :signed-long)
)
(defrecord __Request__memory_object_release_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flags :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_range_op_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset_beg :memory_object_offset_t)
   (offset_end :memory_object_offset_t)
   (ops :signed-long)
)

; #endif /* !__Request__memory_object_control_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__memory_object_control_subsystem__defined
; #define __RequestUnion__memory_object_control_subsystem__defined
(defrecord __RequestUnion__memory_object_control_subsystem
   (:variant
   (
   (Request_memory_object_get_attributes :__REQUEST__MEMORY_OBJECT_GET_ATTRIBUTES_T)
   )
   (
   (Request_memory_object_change_attributes :__REQUEST__MEMORY_OBJECT_CHANGE_ATTRIBUTES_T)
   )
   (
   (Request_memory_object_synchronize_completed :__REQUEST__MEMORY_OBJECT_SYNCHRONIZE_COMPLETED_T)
   )
   (
   (Request_memory_object_lock_request :__REQUEST__MEMORY_OBJECT_LOCK_REQUEST_T)
   )
   (
   (Request_memory_object_destroy :__REQUEST__MEMORY_OBJECT_DESTROY_T)
   )
   (
   (Request_memory_object_upl_request :__REQUEST__MEMORY_OBJECT_UPL_REQUEST_T)
   )
   (
   (Request_memory_object_super_upl_request :__REQUEST__MEMORY_OBJECT_SUPER_UPL_REQUEST_T)
   )
   (
   (Request_memory_object_page_op :__REQUEST__MEMORY_OBJECT_PAGE_OP_T)
   )
   (
   (Request_memory_object_recover_named :__REQUEST__MEMORY_OBJECT_RECOVER_NAMED_T)
   )
   (
   (Request_memory_object_release_name :__REQUEST__MEMORY_OBJECT_RELEASE_NAME_T)
   )
   (
   (Request_memory_object_range_op :__REQUEST__MEMORY_OBJECT_RANGE_OP_T)
   )
   )
)

; #endif /* !__RequestUnion__memory_object_control_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__memory_object_control_subsystem__defined
; #define __Reply__memory_object_control_subsystem__defined
(defrecord __Reply__memory_object_get_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (attributesCnt :UInt32)
   (attributes (:array :signed-long 6))
)
(defrecord __Reply__memory_object_change_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_synchronize_completed_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_lock_request_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type upl_page_info_t
|#
(defrecord __Reply__memory_object_upl_request_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (upl :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (page_listCnt :UInt32)
   (page_list (:array :upl_page_info_t 20))
)
#|
; Warning: type-size: unknown type upl_page_info_t
|#
(defrecord __Reply__memory_object_super_upl_request_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (upl :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (page_listCnt :UInt32)
   (page_list (:array :upl_page_info_t 20))
)
(defrecord __Reply__memory_object_page_op_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (phys_entry :UInt32)
   (flags :signed-long)
)
(defrecord __Reply__memory_object_recover_named_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_release_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_range_op_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (range :signed-long)
)

; #endif /* !__Reply__memory_object_control_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__memory_object_control_subsystem__defined
; #define __ReplyUnion__memory_object_control_subsystem__defined
(defrecord __ReplyUnion__memory_object_control_subsystem
   (:variant
   (
   (Reply_memory_object_get_attributes :__REPLY__MEMORY_OBJECT_GET_ATTRIBUTES_T)
   )
   (
   (Reply_memory_object_change_attributes :__REPLY__MEMORY_OBJECT_CHANGE_ATTRIBUTES_T)
   )
   (
   (Reply_memory_object_synchronize_completed :__REPLY__MEMORY_OBJECT_SYNCHRONIZE_COMPLETED_T)
   )
   (
   (Reply_memory_object_lock_request :__REPLY__MEMORY_OBJECT_LOCK_REQUEST_T)
   )
   (
   (Reply_memory_object_destroy :__REPLY__MEMORY_OBJECT_DESTROY_T)
   )
   (
   (Reply_memory_object_upl_request :__REPLY__MEMORY_OBJECT_UPL_REQUEST_T)
   )
   (
   (Reply_memory_object_super_upl_request :__REPLY__MEMORY_OBJECT_SUPER_UPL_REQUEST_T)
   )
   (
   (Reply_memory_object_page_op :__REPLY__MEMORY_OBJECT_PAGE_OP_T)
   )
   (
   (Reply_memory_object_recover_named :__REPLY__MEMORY_OBJECT_RECOVER_NAMED_T)
   )
   (
   (Reply_memory_object_release_name :__REPLY__MEMORY_OBJECT_RELEASE_NAME_T)
   )
   (
   (Reply_memory_object_range_op :__REPLY__MEMORY_OBJECT_RANGE_OP_T)
   )
   )
)

; #endif /* !__RequestUnion__memory_object_control_subsystem__defined */

; #ifndef subsystem_to_name_map_memory_object_control
; #define subsystem_to_name_map_memory_object_control     { "memory_object_get_attributes", 2000 },    { "memory_object_change_attributes", 2001 },    { "memory_object_synchronize_completed", 2002 },    { "memory_object_lock_request", 2003 },    { "memory_object_destroy", 2004 },    { "memory_object_upl_request", 2005 },    { "memory_object_super_upl_request", 2006 },    { "memory_object_page_op", 2007 },    { "memory_object_recover_named", 2008 },    { "memory_object_release_name", 2009 },    { "memory_object_range_op", 2010 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _memory_object_control_user_ */


(provide-interface "memory_object_control")