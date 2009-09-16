(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:memory_object_server.h"
; at Sunday July 2,2006 7:26:12 pm.
; #ifndef	_memory_object_server_
; #define	_memory_object_server_
;  Module memory_object 

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
; #ifndef	memory_object_MSG_COUNT
(defconstant $memory_object_MSG_COUNT 8)
; #define	memory_object_MSG_COUNT	8

; #endif	/* memory_object_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")
; #ifdef __BeforeMigServerHeader
#| #|
__BeforeMigServerHeader
#endif
|#
 |#
;  __BeforeMigServerHeader 
;  Routine memory_object_init 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_init" 
   ((memory_object :memory_object_t)
    (memory_control :memory_object_control_t)
    (memory_object_page_size :UInt32)
   )
   :signed-long
() )
;  Routine memory_object_terminate 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_terminate" 
   ((memory_object :memory_object_t)
   )
   :signed-long
() )
;  Routine memory_object_data_request 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_data_request" 
   ((memory_object :memory_object_t)
    (offset :memory_object_offset_t)
    (length :UInt32)
    (desired_access :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_data_return 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_data_return" 
   ((memory_object :memory_object_t)
    (offset :memory_object_offset_t)
    (size :UInt32)
    (dirty :signed-long)
    (kernel_copy :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_data_initialize 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_data_initialize" 
   ((memory_object :memory_object_t)
    (offset :memory_object_offset_t)
    (size :UInt32)
   )
   :signed-long
() )
;  Routine memory_object_data_unlock 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_data_unlock" 
   ((memory_object :memory_object_t)
    (offset :memory_object_offset_t)
    (size :UInt32)
    (desired_access :signed-long)
   )
   :signed-long
() )
;  Routine memory_object_synchronize 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_synchronize" 
   ((memory_object :memory_object_t)
    (offset :memory_object_offset_t)
    (size :UInt32)
    (sync_flags :UInt32)
   )
   :signed-long
() )
;  Routine memory_object_unmap 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_unmap" 
   ((memory_object :memory_object_t)
   )
   :signed-long
() )

(deftrap-inline "_memory_object_server" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
    (OutHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :signed-long
() )

(deftrap-inline "_memory_object_server_routine" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :mig_routine_t
() )
;  Description of this subsystem, for use in direct RPC 
(defrecord memory_object_subsystem
   (server :mig_server_routine_t)
#|
; Warning: type-size: unknown type MIG_SERVER_ROUTINE_T
|#
                                                ;  Server routine 
   (start :signed-long)
                                                ;  Min routine number 
   (end :signed-long)
                                                ;  Max routine number + 1 
   (maxsize :UInt32)
                                                ;  Max msg size 
   (reserved :vm_address_t)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
                                                ;  Reserved 
                                                ; Array of routine descriptors 
   (routine (:array :routine_descriptor 8))
#|
; Warning: type-size: unknown type routine_descriptor
|#
)
;  typedefs for all requests 
; #ifndef __Request__memory_object_subsystem__defined
; #define __Request__memory_object_subsystem__defined
(defrecord __Request__memory_object_init_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (memory_control :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (memory_object_page_size :UInt32)
)
(defrecord __Request__memory_object_terminate_t
   (Head :MACH_MSG_HEADER_T)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_data_request_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (length :UInt32)
   (desired_access :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_data_return_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :UInt32)
   (dirty :signed-long)
   (kernel_copy :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_data_initialize_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :UInt32)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_data_unlock_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :UInt32)
   (desired_access :signed-long)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__memory_object_synchronize_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :memory_object_offset_t)
   (size :UInt32)
   (sync_flags :UInt32)
)
(defrecord __Request__memory_object_unmap_t
   (Head :MACH_MSG_HEADER_T)
)

; #endif /* !__Request__memory_object_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__memory_object_subsystem__defined
; #define __RequestUnion__memory_object_subsystem__defined
(defrecord __RequestUnion__memory_object_subsystem
   (:variant
   (
   (Request_memory_object_init :__REQUEST__MEMORY_OBJECT_INIT_T)
   )
   (
   (Request_memory_object_terminate :__REQUEST__MEMORY_OBJECT_TERMINATE_T)
   )
   (
   (Request_memory_object_data_request :__REQUEST__MEMORY_OBJECT_DATA_REQUEST_T)
   )
   (
   (Request_memory_object_data_return :__REQUEST__MEMORY_OBJECT_DATA_RETURN_T)
   )
   (
   (Request_memory_object_data_initialize :__REQUEST__MEMORY_OBJECT_DATA_INITIALIZE_T)
   )
   (
   (Request_memory_object_data_unlock :__REQUEST__MEMORY_OBJECT_DATA_UNLOCK_T)
   )
   (
   (Request_memory_object_synchronize :__REQUEST__MEMORY_OBJECT_SYNCHRONIZE_T)
   )
   (
   (Request_memory_object_unmap :__REQUEST__MEMORY_OBJECT_UNMAP_T)
   )
   )
)

; #endif /* __RequestUnion__memory_object_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__memory_object_subsystem__defined
; #define __Reply__memory_object_subsystem__defined
(defrecord __Reply__memory_object_init_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_terminate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_data_request_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_data_return_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_data_initialize_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_data_unlock_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_synchronize_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__memory_object_unmap_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__memory_object_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__memory_object_subsystem__defined
; #define __ReplyUnion__memory_object_subsystem__defined
(defrecord __ReplyUnion__memory_object_subsystem
   (:variant
   (
   (Reply_memory_object_init :__REPLY__MEMORY_OBJECT_INIT_T)
   )
   (
   (Reply_memory_object_terminate :__REPLY__MEMORY_OBJECT_TERMINATE_T)
   )
   (
   (Reply_memory_object_data_request :__REPLY__MEMORY_OBJECT_DATA_REQUEST_T)
   )
   (
   (Reply_memory_object_data_return :__REPLY__MEMORY_OBJECT_DATA_RETURN_T)
   )
   (
   (Reply_memory_object_data_initialize :__REPLY__MEMORY_OBJECT_DATA_INITIALIZE_T)
   )
   (
   (Reply_memory_object_data_unlock :__REPLY__MEMORY_OBJECT_DATA_UNLOCK_T)
   )
   (
   (Reply_memory_object_synchronize :__REPLY__MEMORY_OBJECT_SYNCHRONIZE_T)
   )
   (
   (Reply_memory_object_unmap :__REPLY__MEMORY_OBJECT_UNMAP_T)
   )
   )
)

; #endif /* __RequestUnion__memory_object_subsystem__defined */

; #ifndef subsystem_to_name_map_memory_object
; #define subsystem_to_name_map_memory_object     { "memory_object_init", 2200 },    { "memory_object_terminate", 2201 },    { "memory_object_data_request", 2202 },    { "memory_object_data_return", 2203 },    { "memory_object_data_initialize", 2204 },    { "memory_object_data_unlock", 2205 },    { "memory_object_synchronize", 2206 },    { "memory_object_unmap", 2207 }

; #endif

; #ifdef __AfterMigServerHeader
#| #|
__AfterMigServerHeader
#endif
|#
 |#
;  __AfterMigServerHeader 

; #endif	 /* _memory_object_server_ */


(provide-interface "memory_object_server")