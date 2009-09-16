(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_port.h"
; at Sunday July 2,2006 7:26:10 pm.
; #ifndef	_mach_port_user_
; #define	_mach_port_user_
;  Module mach_port 

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
; #ifndef	mach_port_MSG_COUNT
(defconstant $mach_port_MSG_COUNT 28)
; #define	mach_port_MSG_COUNT	28

; #endif	/* mach_port_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")

(require-interface "mach_debug/mach_debug_types")
; #ifdef __BeforeMigUserHeader
#| #|
__BeforeMigUserHeader
#endif
|#
 |#
;  __BeforeMigUserHeader 

(require-interface "sys/cdefs")
;  Routine mach_port_names 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_names" 
   ((task :pointer)
    (names (:pointer :mach_port_name_array_t))
    (namesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (types (:pointer :mach_port_type_array_t))
    (typesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine mach_port_type 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_type" 
   ((task :pointer)
    (name :mach_port_name_t)
    (ptype (:pointer :mach_port_type_t))
   )
   :signed-long
() )
;  Routine mach_port_rename 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_rename" 
   ((task :pointer)
    (old_name :mach_port_name_t)
    (new_name :mach_port_name_t)
   )
   :signed-long
() )
;  Routine mach_port_allocate_name 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_allocate_name" 
   ((task :pointer)
    (right :mach_port_right_t)
    (name :mach_port_name_t)
   )
   :signed-long
() )
;  Routine mach_port_allocate 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_allocate" 
   ((task :pointer)
    (right :mach_port_right_t)
    (name (:pointer :mach_port_name_t))
   )
   :signed-long
() )
;  Routine mach_port_destroy 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_destroy" 
   ((task :pointer)
    (name :mach_port_name_t)
   )
   :signed-long
() )
;  Routine mach_port_deallocate 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_deallocate" 
   ((task :pointer)
    (name :mach_port_name_t)
   )
   :signed-long
() )
;  Routine mach_port_get_refs 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_get_refs" 
   ((task :pointer)
    (name :mach_port_name_t)
    (right :mach_port_right_t)
    (refs (:pointer :mach_port_urefs_t))
   )
   :signed-long
() )
;  Routine mach_port_mod_refs 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_mod_refs" 
   ((task :pointer)
    (name :mach_port_name_t)
    (right :mach_port_right_t)
    (delta :mach_port_delta_t)
   )
   :signed-long
() )
;  Routine mach_port_set_mscount 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_set_mscount" 
   ((task :pointer)
    (name :mach_port_name_t)
    (mscount :mach_port_mscount_t)
   )
   :signed-long
() )
;  Routine mach_port_get_set_status 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_get_set_status" 
   ((task :pointer)
    (name :mach_port_name_t)
    (members (:pointer :mach_port_name_array_t))
    (membersCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine mach_port_move_member 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_move_member" 
   ((task :pointer)
    (member :mach_port_name_t)
    (after :mach_port_name_t)
   )
   :signed-long
() )
;  Routine mach_port_request_notification 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_request_notification" 
   ((task :pointer)
    (name :mach_port_name_t)
    (msgid :signed-long)
    (sync :mach_port_mscount_t)
    (notify :pointer)
    (notifyPoly :UInt32)
    (previous (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine mach_port_insert_right 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_insert_right" 
   ((task :pointer)
    (name :mach_port_name_t)
    (poly :pointer)
    (polyPoly :UInt32)
   )
   :signed-long
() )
;  Routine mach_port_extract_right 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_extract_right" 
   ((task :pointer)
    (name :mach_port_name_t)
    (msgt_name :UInt32)
    (poly (:pointer :mach_port_t))
    (polyPoly (:pointer :MACH_MSG_TYPE_NAME_T))
   )
   :signed-long
() )
;  Routine mach_port_set_seqno 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_set_seqno" 
   ((task :pointer)
    (name :mach_port_name_t)
    (seqno :mach_port_seqno_t)
   )
   :signed-long
() )
;  Routine mach_port_get_attributes 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_get_attributes" 
   ((task :pointer)
    (name :mach_port_name_t)
    (flavor :mach_port_flavor_t)
    (port_info_out :mach_port_info_t)
    (port_info_outCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine mach_port_set_attributes 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_set_attributes" 
   ((task :pointer)
    (name :mach_port_name_t)
    (flavor :mach_port_flavor_t)
    (port_info :mach_port_info_t)
    (port_infoCnt :UInt32)
   )
   :signed-long
() )
;  Routine mach_port_allocate_qos 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_allocate_qos" 
   ((task :pointer)
    (right :mach_port_right_t)
    (qos (:pointer :mach_port_qos_t))
    (name (:pointer :mach_port_name_t))
   )
   :signed-long
() )
;  Routine mach_port_allocate_full 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_allocate_full" 
   ((task :pointer)
    (right :mach_port_right_t)
    (proto :pointer)
    (qos (:pointer :mach_port_qos_t))
    (name (:pointer :mach_port_name_t))
   )
   :signed-long
() )
;  Routine task_set_port_space 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_task_set_port_space" 
   ((task :pointer)
    (table_entries :signed-long)
   )
   :signed-long
() )
;  Routine mach_port_get_srights 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_get_srights" 
   ((task :pointer)
    (name :mach_port_name_t)
    (srights (:pointer :mach_port_rights_t))
   )
   :signed-long
() )
;  Routine mach_port_space_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_space_info" 
   ((task :pointer)
    (info (:pointer :IPC_INFO_SPACE_T))
    (table_info (:pointer :IPC_INFO_NAME_ARRAY_T))
    (table_infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (tree_info (:pointer :IPC_INFO_TREE_NAME_ARRAY_T))
    (tree_infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine mach_port_dnrequest_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_dnrequest_info" 
   ((task :pointer)
    (name :mach_port_name_t)
    (total (:pointer :UInt32))
    (used (:pointer :UInt32))
   )
   :signed-long
() )
;  Routine mach_port_kernel_object 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_kernel_object" 
   ((task :pointer)
    (name :mach_port_name_t)
    (object_type (:pointer :UInt32))
    (object_addr (:pointer :vm_offset_t))
   )
   :signed-long
() )
;  Routine mach_port_insert_member 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_insert_member" 
   ((task :pointer)
    (name :mach_port_name_t)
    (pset :mach_port_name_t)
   )
   :signed-long
() )
;  Routine mach_port_extract_member 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_port_extract_member" 
   ((task :pointer)
    (name :mach_port_name_t)
    (pset :mach_port_name_t)
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
; #ifndef __Request__mach_port_subsystem__defined
; #define __Request__mach_port_subsystem__defined
(defrecord __Request__mach_port_names_t
   (Head :MACH_MSG_HEADER_T)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_type_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_rename_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (old_name :mach_port_name_t)
   (new_name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_RIGHT_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_allocate_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (right :mach_port_right_t)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_RIGHT_T
|#
(defrecord __Request__mach_port_allocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (right :mach_port_right_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_deallocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_RIGHT_T
|#
(defrecord __Request__mach_port_get_refs_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (right :mach_port_right_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_RIGHT_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_DELTA_T
|#
(defrecord __Request__mach_port_mod_refs_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (right :mach_port_right_t)
   (delta :mach_port_delta_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_MSCOUNT_T
|#
(defrecord __Request__mach_port_set_mscount_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (mscount :mach_port_mscount_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_get_set_status_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_move_member_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (member :mach_port_name_t)
   (after :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_MSCOUNT_T
|#
(defrecord __Request__mach_port_request_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (notify :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (msgid :signed-long)
   (sync :mach_port_mscount_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_insert_right_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (poly :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_extract_right_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (msgt_name :UInt32)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_SEQNO_T
|#
(defrecord __Request__mach_port_set_seqno_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (seqno :mach_port_seqno_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_FLAVOR_T
|#
(defrecord __Request__mach_port_get_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (flavor :mach_port_flavor_t)
   (port_info_outCnt :UInt32)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_FLAVOR_T
|#
(defrecord __Request__mach_port_set_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (flavor :mach_port_flavor_t)
   (port_infoCnt :UInt32)
   (port_info (:array :signed-long 10))
)
#|
; Warning: type-size: unknown type MACH_PORT_RIGHT_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_QOS_T
|#
(defrecord __Request__mach_port_allocate_qos_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (right :mach_port_right_t)
   (qos :mach_port_qos_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_RIGHT_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_QOS_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_allocate_full_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (proto :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (right :mach_port_right_t)
   (qos :mach_port_qos_t)
   (name :mach_port_name_t)
)
(defrecord __Request__task_set_port_space_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (table_entries :signed-long)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_get_srights_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
(defrecord __Request__mach_port_space_info_t
   (Head :MACH_MSG_HEADER_T)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_dnrequest_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_kernel_object_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_insert_member_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (pset :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_port_extract_member_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
   (pset :mach_port_name_t)
)

; #endif /* !__Request__mach_port_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__mach_port_subsystem__defined
; #define __RequestUnion__mach_port_subsystem__defined
(defrecord __RequestUnion__mach_port_subsystem
   (:variant
   (
   (Request_mach_port_names :__REQUEST__MACH_PORT_NAMES_T)
   )
   (
   (Request_mach_port_type :__REQUEST__MACH_PORT_TYPE_T)
   )
   (
   (Request_mach_port_rename :__REQUEST__MACH_PORT_RENAME_T)
   )
   (
   (Request_mach_port_allocate_name :__REQUEST__MACH_PORT_ALLOCATE_NAME_T)
   )
   (
   (Request_mach_port_allocate :__REQUEST__MACH_PORT_ALLOCATE_T)
   )
   (
   (Request_mach_port_destroy :__REQUEST__MACH_PORT_DESTROY_T)
   )
   (
   (Request_mach_port_deallocate :__REQUEST__MACH_PORT_DEALLOCATE_T)
   )
   (
   (Request_mach_port_get_refs :__REQUEST__MACH_PORT_GET_REFS_T)
   )
   (
   (Request_mach_port_mod_refs :__REQUEST__MACH_PORT_MOD_REFS_T)
   )
   (
   (Request_mach_port_set_mscount :__REQUEST__MACH_PORT_SET_MSCOUNT_T)
   )
   (
   (Request_mach_port_get_set_status :__REQUEST__MACH_PORT_GET_SET_STATUS_T)
   )
   (
   (Request_mach_port_move_member :__REQUEST__MACH_PORT_MOVE_MEMBER_T)
   )
   (
   (Request_mach_port_request_notification :__REQUEST__MACH_PORT_REQUEST_NOTIFICATION_T)
   )
   (
   (Request_mach_port_insert_right :__REQUEST__MACH_PORT_INSERT_RIGHT_T)
   )
   (
   (Request_mach_port_extract_right :__REQUEST__MACH_PORT_EXTRACT_RIGHT_T)
   )
   (
   (Request_mach_port_set_seqno :__REQUEST__MACH_PORT_SET_SEQNO_T)
   )
   (
   (Request_mach_port_get_attributes :__REQUEST__MACH_PORT_GET_ATTRIBUTES_T)
   )
   (
   (Request_mach_port_set_attributes :__REQUEST__MACH_PORT_SET_ATTRIBUTES_T)
   )
   (
   (Request_mach_port_allocate_qos :__REQUEST__MACH_PORT_ALLOCATE_QOS_T)
   )
   (
   (Request_mach_port_allocate_full :__REQUEST__MACH_PORT_ALLOCATE_FULL_T)
   )
   (
   (Request_task_set_port_space :__REQUEST__TASK_SET_PORT_SPACE_T)
   )
   (
   (Request_mach_port_get_srights :__REQUEST__MACH_PORT_GET_SRIGHTS_T)
   )
   (
   (Request_mach_port_space_info :__REQUEST__MACH_PORT_SPACE_INFO_T)
   )
   (
   (Request_mach_port_dnrequest_info :__REQUEST__MACH_PORT_DNREQUEST_INFO_T)
   )
   (
   (Request_mach_port_kernel_object :__REQUEST__MACH_PORT_KERNEL_OBJECT_T)
   )
   (
   (Request_mach_port_insert_member :__REQUEST__MACH_PORT_INSERT_MEMBER_T)
   )
   (
   (Request_mach_port_extract_member :__REQUEST__MACH_PORT_EXTRACT_MEMBER_T)
   )
   )
)

; #endif /* !__RequestUnion__mach_port_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__mach_port_subsystem__defined
; #define __Reply__mach_port_subsystem__defined
(defrecord __Reply__mach_port_names_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (names :MACH_MSG_OOL_DESCRIPTOR_T)
   (types :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (namesCnt :UInt32)
   (typesCnt :UInt32)
)
#|
; Warning: type-size: unknown type MACH_PORT_TYPE_T
|#
(defrecord __Reply__mach_port_type_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (ptype :mach_port_type_t)
)
(defrecord __Reply__mach_port_rename_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_allocate_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Reply__mach_port_allocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (name :mach_port_name_t)
)
(defrecord __Reply__mach_port_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_deallocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type MACH_PORT_UREFS_T
|#
(defrecord __Reply__mach_port_get_refs_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (refs :mach_port_urefs_t)
)
(defrecord __Reply__mach_port_mod_refs_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_set_mscount_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_get_set_status_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (members :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (membersCnt :UInt32)
)
(defrecord __Reply__mach_port_move_member_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_request_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (previous :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__mach_port_insert_right_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_extract_right_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (poly :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__mach_port_set_seqno_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_get_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (port_info_outCnt :UInt32)
   (port_info_out (:array :signed-long 10))
)
(defrecord __Reply__mach_port_set_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type MACH_PORT_QOS_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Reply__mach_port_allocate_qos_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (qos :mach_port_qos_t)
   (name :mach_port_name_t)
)
#|
; Warning: type-size: unknown type MACH_PORT_QOS_T
|#
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Reply__mach_port_allocate_full_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (qos :mach_port_qos_t)
   (name :mach_port_name_t)
)
(defrecord __Reply__task_set_port_space_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type MACH_PORT_RIGHTS_T
|#
(defrecord __Reply__mach_port_get_srights_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (srights :mach_port_rights_t)
)
(defrecord __Reply__mach_port_space_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (table_info :MACH_MSG_OOL_DESCRIPTOR_T)
   (tree_info :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (info :IPC_INFO_SPACE)
   (table_infoCnt :UInt32)
   (tree_infoCnt :UInt32)
)
(defrecord __Reply__mach_port_dnrequest_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (total :UInt32)
   (used :UInt32)
)
(defrecord __Reply__mach_port_kernel_object_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (object_type :UInt32)
   (object_addr :UInt32)
)
(defrecord __Reply__mach_port_insert_member_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_port_extract_member_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__mach_port_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__mach_port_subsystem__defined
; #define __ReplyUnion__mach_port_subsystem__defined
(defrecord __ReplyUnion__mach_port_subsystem
   (:variant
   (
   (Reply_mach_port_names :__REPLY__MACH_PORT_NAMES_T)
   )
   (
   (Reply_mach_port_type :__REPLY__MACH_PORT_TYPE_T)
   )
   (
   (Reply_mach_port_rename :__REPLY__MACH_PORT_RENAME_T)
   )
   (
   (Reply_mach_port_allocate_name :__REPLY__MACH_PORT_ALLOCATE_NAME_T)
   )
   (
   (Reply_mach_port_allocate :__REPLY__MACH_PORT_ALLOCATE_T)
   )
   (
   (Reply_mach_port_destroy :__REPLY__MACH_PORT_DESTROY_T)
   )
   (
   (Reply_mach_port_deallocate :__REPLY__MACH_PORT_DEALLOCATE_T)
   )
   (
   (Reply_mach_port_get_refs :__REPLY__MACH_PORT_GET_REFS_T)
   )
   (
   (Reply_mach_port_mod_refs :__REPLY__MACH_PORT_MOD_REFS_T)
   )
   (
   (Reply_mach_port_set_mscount :__REPLY__MACH_PORT_SET_MSCOUNT_T)
   )
   (
   (Reply_mach_port_get_set_status :__REPLY__MACH_PORT_GET_SET_STATUS_T)
   )
   (
   (Reply_mach_port_move_member :__REPLY__MACH_PORT_MOVE_MEMBER_T)
   )
   (
   (Reply_mach_port_request_notification :__REPLY__MACH_PORT_REQUEST_NOTIFICATION_T)
   )
   (
   (Reply_mach_port_insert_right :__REPLY__MACH_PORT_INSERT_RIGHT_T)
   )
   (
   (Reply_mach_port_extract_right :__REPLY__MACH_PORT_EXTRACT_RIGHT_T)
   )
   (
   (Reply_mach_port_set_seqno :__REPLY__MACH_PORT_SET_SEQNO_T)
   )
   (
   (Reply_mach_port_get_attributes :__REPLY__MACH_PORT_GET_ATTRIBUTES_T)
   )
   (
   (Reply_mach_port_set_attributes :__REPLY__MACH_PORT_SET_ATTRIBUTES_T)
   )
   (
   (Reply_mach_port_allocate_qos :__REPLY__MACH_PORT_ALLOCATE_QOS_T)
   )
   (
   (Reply_mach_port_allocate_full :__REPLY__MACH_PORT_ALLOCATE_FULL_T)
   )
   (
   (Reply_task_set_port_space :__REPLY__TASK_SET_PORT_SPACE_T)
   )
   (
   (Reply_mach_port_get_srights :__REPLY__MACH_PORT_GET_SRIGHTS_T)
   )
   (
   (Reply_mach_port_space_info :__REPLY__MACH_PORT_SPACE_INFO_T)
   )
   (
   (Reply_mach_port_dnrequest_info :__REPLY__MACH_PORT_DNREQUEST_INFO_T)
   )
   (
   (Reply_mach_port_kernel_object :__REPLY__MACH_PORT_KERNEL_OBJECT_T)
   )
   (
   (Reply_mach_port_insert_member :__REPLY__MACH_PORT_INSERT_MEMBER_T)
   )
   (
   (Reply_mach_port_extract_member :__REPLY__MACH_PORT_EXTRACT_MEMBER_T)
   )
   )
)

; #endif /* !__RequestUnion__mach_port_subsystem__defined */

; #ifndef subsystem_to_name_map_mach_port
; #define subsystem_to_name_map_mach_port     { "mach_port_names", 3200 },    { "mach_port_type", 3201 },    { "mach_port_rename", 3202 },    { "mach_port_allocate_name", 3203 },    { "mach_port_allocate", 3204 },    { "mach_port_destroy", 3205 },    { "mach_port_deallocate", 3206 },    { "mach_port_get_refs", 3207 },    { "mach_port_mod_refs", 3208 },    { "mach_port_set_mscount", 3210 },    { "mach_port_get_set_status", 3211 },    { "mach_port_move_member", 3212 },    { "mach_port_request_notification", 3213 },    { "mach_port_insert_right", 3214 },    { "mach_port_extract_right", 3215 },    { "mach_port_set_seqno", 3216 },    { "mach_port_get_attributes", 3217 },    { "mach_port_set_attributes", 3218 },    { "mach_port_allocate_qos", 3219 },    { "mach_port_allocate_full", 3220 },    { "task_set_port_space", 3221 },    { "mach_port_get_srights", 3222 },    { "mach_port_space_info", 3223 },    { "mach_port_dnrequest_info", 3224 },    { "mach_port_kernel_object", 3225 },    { "mach_port_insert_member", 3226 },    { "mach_port_extract_member", 3227 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _mach_port_user_ */


(provide-interface "mach_port")