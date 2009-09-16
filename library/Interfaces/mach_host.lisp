(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_host.h"
; at Sunday July 2,2006 7:26:08 pm.
; #ifndef	_mach_host_user_
; #define	_mach_host_user_
;  Module mach_host 

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
; #ifndef	mach_host_MSG_COUNT
(defconstant $mach_host_MSG_COUNT 18)
; #define	mach_host_MSG_COUNT	18

; #endif	/* mach_host_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")

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
;  Routine host_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_info" 
   ((host :pointer)
    (flavor :signed-long)
    (host_info_out (:pointer :signed-long))
    (host_info_outCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_kernel_version 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_kernel_version" 
   ((host :pointer)
    (kernel_version (:pointer :KERNEL_VERSION_T))
   )
   :signed-long
() )
;  Routine host_page_size 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_page_size" 
   ((host :pointer)
    (page_size (:pointer :VM_SIZE_T))
   )
   :signed-long
() )
;  Routine mach_memory_object_memory_entry 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_memory_object_memory_entry" 
   ((host :pointer)
    (internal :signed-long)
    (size :UInt32)
    (permission :signed-long)
    (pager :memory_object_t)
    (entry_handle (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine host_processor_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_processor_info" 
   ((host :pointer)
    (flavor :processor_flavor_t)
    (processor_count (:pointer :natural_t))
    (processor_info (:pointer :processor_info_array_t))
    (processor_infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_get_io_master 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_io_master" 
   ((host :pointer)
    (io_master (:pointer :IO_MASTER_T))
   )
   :signed-long
() )
;  Routine host_get_clock_service 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_clock_service" 
   ((host :pointer)
    (clock_id :signed-long)
    (clock_serv (:pointer :clock_serv_t))
   )
   :signed-long
() )
;  Routine kmod_get_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_kmod_get_info" 
   ((host :pointer)
    (modules (:pointer :kmod_args_t))
    (modulesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_zone_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_zone_info" 
   ((host :pointer)
    (names (:pointer :ZONE_NAME_ARRAY_T))
    (namesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (info (:pointer :ZONE_INFO_ARRAY_T))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_virtual_physical_table_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_virtual_physical_table_info" 
   ((host :pointer)
    (info (:pointer :HASH_INFO_BUCKET_ARRAY_T))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_ipc_hash_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_ipc_hash_info" 
   ((host :pointer)
    (info (:pointer :HASH_INFO_BUCKET_ARRAY_T))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine enable_bluebox 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_enable_bluebox" 
   ((host :pointer)
    (taskID :UInt32)
    (TWI_TableStart :UInt32)
    (Desc_TableStart :UInt32)
   )
   :signed-long
() )
;  Routine disable_bluebox 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_disable_bluebox" 
   ((host :pointer)
   )
   :signed-long
() )
;  Routine processor_set_default 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_default" 
   ((host :pointer)
    (default_set (:pointer :PROCESSOR_SET_NAME_T))
   )
   :signed-long
() )
;  Routine processor_set_create 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_create" 
   ((host :pointer)
    (new_set (:pointer :processor_set_t))
    (new_name (:pointer :PROCESSOR_SET_NAME_T))
   )
   :signed-long
() )
;  Routine mach_memory_object_memory_entry_64 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_memory_object_memory_entry_64" 
   ((host :pointer)
    (internal :signed-long)
    (size :memory_object_size_t)
    (permission :signed-long)
    (pager :memory_object_t)
    (entry_handle (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine host_statistics 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_statistics" 
   ((host_priv :pointer)
    (flavor :signed-long)
    (host_info_out (:pointer :signed-long))
    (host_info_outCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_request_notification 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_request_notification" 
   ((host :pointer)
    (notify_type :signed-long)
    (notify_port :pointer)
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
; #ifndef __Request__mach_host_subsystem__defined
; #define __Request__mach_host_subsystem__defined
(defrecord __Request__host_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :signed-long)
   (host_info_outCnt :UInt32)
)
(defrecord __Request__host_kernel_version_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_page_size_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__mach_memory_object_memory_entry_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (pager :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (internal :signed-long)
   (size :UInt32)
   (permission :signed-long)
)
#|
; Warning: type-size: unknown type PROCESSOR_FLAVOR_T
|#
(defrecord __Request__host_processor_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :processor_flavor_t)
)
(defrecord __Request__host_get_io_master_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_get_clock_service_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (clock_id :signed-long)
)
(defrecord __Request__kmod_get_info_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_zone_info_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_virtual_physical_table_info_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_ipc_hash_info_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__enable_bluebox_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (taskID :UInt32)
   (TWI_TableStart :UInt32)
   (Desc_TableStart :UInt32)
)
(defrecord __Request__disable_bluebox_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__processor_set_default_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__processor_set_create_t
   (Head :MACH_MSG_HEADER_T)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_SIZE_T
|#
(defrecord __Request__mach_memory_object_memory_entry_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (pager :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (internal :signed-long)
   (size :memory_object_size_t)
   (permission :signed-long)
)
(defrecord __Request__host_statistics_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :signed-long)
   (host_info_outCnt :UInt32)
)
(defrecord __Request__host_request_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (notify_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (notify_type :signed-long)
)

; #endif /* !__Request__mach_host_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__mach_host_subsystem__defined
; #define __RequestUnion__mach_host_subsystem__defined
(defrecord __RequestUnion__mach_host_subsystem
   (:variant
   (
   (Request_host_info :__REQUEST__HOST_INFO_T)
   )
   (
   (Request_host_kernel_version :__REQUEST__HOST_KERNEL_VERSION_T)
   )
   (
   (Request_host_page_size :__REQUEST__HOST_PAGE_SIZE_T)
   )
   (
   (Request_mach_memory_object_memory_entry :__REQUEST__MACH_MEMORY_OBJECT_MEMORY_ENTRY_T)
   )
   (
   (Request_host_processor_info :__REQUEST__HOST_PROCESSOR_INFO_T)
   )
   (
   (Request_host_get_io_master :__REQUEST__HOST_GET_IO_MASTER_T)
   )
   (
   (Request_host_get_clock_service :__REQUEST__HOST_GET_CLOCK_SERVICE_T)
   )
   (
   (Request_kmod_get_info :__REQUEST__KMOD_GET_INFO_T)
   )
   (
   (Request_host_zone_info :__REQUEST__HOST_ZONE_INFO_T)
   )
   (
   (Request_host_virtual_physical_table_info :__REQUEST__HOST_VIRTUAL_PHYSICAL_TABLE_INFO_T)
   )
   (
   (Request_host_ipc_hash_info :__REQUEST__HOST_IPC_HASH_INFO_T)
   )
   (
   (Request_enable_bluebox :__REQUEST__ENABLE_BLUEBOX_T)
   )
   (
   (Request_disable_bluebox :__REQUEST__DISABLE_BLUEBOX_T)
   )
   (
   (Request_processor_set_default :__REQUEST__PROCESSOR_SET_DEFAULT_T)
   )
   (
   (Request_processor_set_create :__REQUEST__PROCESSOR_SET_CREATE_T)
   )
   (
   (Request_mach_memory_object_memory_entry_64 :__REQUEST__MACH_MEMORY_OBJECT_MEMORY_ENTRY_64_T)
   )
   (
   (Request_host_statistics :__REQUEST__HOST_STATISTICS_T)
   )
   (
   (Request_host_request_notification :__REQUEST__HOST_REQUEST_NOTIFICATION_T)
   )
   )
)

; #endif /* !__RequestUnion__mach_host_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__mach_host_subsystem__defined
; #define __Reply__mach_host_subsystem__defined
(defrecord __Reply__host_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (host_info_outCnt :UInt32)
   (host_info_out (:array :signed-long 12))
)
(defrecord __Reply__host_kernel_version_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (kernel_versionOffset :UInt32)               ;  MiG doesn't use it 
   (kernel_versionCnt :UInt32)
   (kernel_version (:array :character 512))
)
(defrecord __Reply__host_page_size_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (page_size :UInt32)
)
(defrecord __Reply__mach_memory_object_memory_entry_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (entry_handle :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__host_processor_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (processor_info :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (processor_count :UInt32)
   (processor_infoCnt :UInt32)
)
(defrecord __Reply__host_get_io_master_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (io_master :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__host_get_clock_service_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (clock_serv :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__kmod_get_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (modules :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (modulesCnt :UInt32)
)
(defrecord __Reply__host_zone_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (names :MACH_MSG_OOL_DESCRIPTOR_T)
   (info :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (namesCnt :UInt32)
   (infoCnt :UInt32)
)
(defrecord __Reply__host_virtual_physical_table_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (info :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (infoCnt :UInt32)
)
(defrecord __Reply__host_ipc_hash_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (info :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (infoCnt :UInt32)
)
(defrecord __Reply__enable_bluebox_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__disable_bluebox_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__processor_set_default_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (default_set :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__processor_set_create_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (new_set :MACH_MSG_PORT_DESCRIPTOR_T)
   (new_name :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__mach_memory_object_memory_entry_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (entry_handle :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__host_statistics_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (host_info_outCnt :UInt32)
   (host_info_out (:array :signed-long 12))
)
(defrecord __Reply__host_request_notification_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__mach_host_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__mach_host_subsystem__defined
; #define __ReplyUnion__mach_host_subsystem__defined
(defrecord __ReplyUnion__mach_host_subsystem
   (:variant
   (
   (Reply_host_info :__REPLY__HOST_INFO_T)
   )
   (
   (Reply_host_kernel_version :__REPLY__HOST_KERNEL_VERSION_T)
   )
   (
   (Reply_host_page_size :__REPLY__HOST_PAGE_SIZE_T)
   )
   (
   (Reply_mach_memory_object_memory_entry :__REPLY__MACH_MEMORY_OBJECT_MEMORY_ENTRY_T)
   )
   (
   (Reply_host_processor_info :__REPLY__HOST_PROCESSOR_INFO_T)
   )
   (
   (Reply_host_get_io_master :__REPLY__HOST_GET_IO_MASTER_T)
   )
   (
   (Reply_host_get_clock_service :__REPLY__HOST_GET_CLOCK_SERVICE_T)
   )
   (
   (Reply_kmod_get_info :__REPLY__KMOD_GET_INFO_T)
   )
   (
   (Reply_host_zone_info :__REPLY__HOST_ZONE_INFO_T)
   )
   (
   (Reply_host_virtual_physical_table_info :__REPLY__HOST_VIRTUAL_PHYSICAL_TABLE_INFO_T)
   )
   (
   (Reply_host_ipc_hash_info :__REPLY__HOST_IPC_HASH_INFO_T)
   )
   (
   (Reply_enable_bluebox :__REPLY__ENABLE_BLUEBOX_T)
   )
   (
   (Reply_disable_bluebox :__REPLY__DISABLE_BLUEBOX_T)
   )
   (
   (Reply_processor_set_default :__REPLY__PROCESSOR_SET_DEFAULT_T)
   )
   (
   (Reply_processor_set_create :__REPLY__PROCESSOR_SET_CREATE_T)
   )
   (
   (Reply_mach_memory_object_memory_entry_64 :__REPLY__MACH_MEMORY_OBJECT_MEMORY_ENTRY_64_T)
   )
   (
   (Reply_host_statistics :__REPLY__HOST_STATISTICS_T)
   )
   (
   (Reply_host_request_notification :__REPLY__HOST_REQUEST_NOTIFICATION_T)
   )
   )
)

; #endif /* !__RequestUnion__mach_host_subsystem__defined */

; #ifndef subsystem_to_name_map_mach_host
; #define subsystem_to_name_map_mach_host     { "host_info", 200 },    { "host_kernel_version", 201 },    { "host_page_size", 202 },    { "mach_memory_object_memory_entry", 203 },    { "host_processor_info", 204 },    { "host_get_io_master", 205 },    { "host_get_clock_service", 206 },    { "kmod_get_info", 207 },    { "host_zone_info", 208 },    { "host_virtual_physical_table_info", 209 },    { "host_ipc_hash_info", 210 },    { "enable_bluebox", 211 },    { "disable_bluebox", 212 },    { "processor_set_default", 213 },    { "processor_set_create", 214 },    { "mach_memory_object_memory_entry_64", 215 },    { "host_statistics", 216 },    { "host_request_notification", 217 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _mach_host_user_ */


(provide-interface "mach_host")