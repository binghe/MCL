(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:host_priv.h"
; at Sunday July 2,2006 7:25:59 pm.
; #ifndef	_host_priv_user_
; #define	_host_priv_user_
;  Module host_priv 

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
; #ifndef	host_priv_MSG_COUNT
(defconstant $host_priv_MSG_COUNT 25)
; #define	host_priv_MSG_COUNT	25

; #endif	/* host_priv_MSG_COUNT */


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
;  Routine host_get_boot_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_boot_info" 
   ((host_priv :pointer)
    (boot_info (:pointer :KERNEL_BOOT_INFO_T))
   )
   :signed-long
() )
;  Routine host_reboot 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_reboot" 
   ((host_priv :pointer)
    (options :signed-long)
   )
   :signed-long
() )
;  Routine host_priv_statistics 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_priv_statistics" 
   ((host_priv :pointer)
    (flavor :signed-long)
    (host_info_out (:pointer :signed-long))
    (host_info_outCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_default_memory_manager 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_default_memory_manager" 
   ((host_priv :pointer)
    (default_manager (:pointer :memory_object_default_t))
    (cluster_size :UInt32)
   )
   :signed-long
() )
;  Routine vm_wire 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_wire" 
   ((host_priv :pointer)
    (task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (access :signed-long)
   )
   :signed-long
() )
;  Routine thread_wire 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_thread_wire" 
   ((host_priv :pointer)
    (thread :pointer)
    (wired :signed-long)
   )
   :signed-long
() )
;  Routine vm_allocate_cpm 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_allocate_cpm" 
   ((host_priv :pointer)
    (task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size :UInt32)
    (anywhere :signed-long)
   )
   :signed-long
() )
;  Routine host_processors 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_processors" 
   ((host_priv :pointer)
    (processor_list (:pointer :processor_array_t))
    (processor_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_get_clock_control 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_clock_control" 
   ((host_priv :pointer)
    (clock_id :signed-long)
    (clock_ctrl (:pointer :clock_ctrl_t))
   )
   :signed-long
() )
;  Routine kmod_create 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_kmod_create" 
   ((host_priv :pointer)
    (info :vm_address_t)
    (module (:pointer :kmod_t))
   )
   :signed-long
() )
;  Routine kmod_destroy 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_kmod_destroy" 
   ((host_priv :pointer)
    (module :kmod_t)
   )
   :signed-long
() )
;  Routine kmod_control 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_kmod_control" 
   ((host_priv :pointer)
    (module :kmod_t)
    (flavor :kmod_control_flavor_t)
    (data (:pointer :kmod_args_t))
    (dataCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_get_special_port 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_special_port" 
   ((host_priv :pointer)
    (node :signed-long)
    (which :signed-long)
    (port (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine host_set_special_port 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_set_special_port" 
   ((host_priv :pointer)
    (which :signed-long)
    (port :pointer)
   )
   :signed-long
() )
;  Routine host_set_exception_ports 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_set_exception_ports" 
   ((host_priv :pointer)
    (exception_mask :UInt32)
    (new_port :pointer)
    (behavior :signed-long)
    (new_flavor :thread_state_flavor_t)
   )
   :signed-long
() )
;  Routine host_get_exception_ports 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_exception_ports" 
   ((host_priv :pointer)
    (exception_mask :UInt32)
    (masks (:pointer :UInt32))
    (masksCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (old_handlers (:pointer :pointer))
    (old_behaviors (:pointer :signed-long))
    (old_flavors (:pointer :thread_state_flavor_t))
   )
   :signed-long
() )
;  Routine host_swap_exception_ports 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_swap_exception_ports" 
   ((host_priv :pointer)
    (exception_mask :UInt32)
    (new_port :pointer)
    (behavior :signed-long)
    (new_flavor :thread_state_flavor_t)
    (masks (:pointer :UInt32))
    (masksCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (old_handlerss (:pointer :pointer))
    (old_behaviors (:pointer :signed-long))
    (old_flavors (:pointer :thread_state_flavor_t))
   )
   :signed-long
() )
;  Routine host_load_symbol_table 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_load_symbol_table" 
   ((host :pointer)
    (task :pointer)
    (name (:pointer :SYMTAB_NAME_T))
    (symtab :UInt32)
    (symtabCnt :UInt32)
   )
   :signed-long
() )
;  Routine task_swappable 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_task_swappable" 
   ((host_priv :pointer)
    (target_task :pointer)
    (make_swappable :signed-long)
   )
   :signed-long
() )
;  Routine host_processor_sets 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_processor_sets" 
   ((host_priv :pointer)
    (processor_sets (:pointer :PROCESSOR_SET_NAME_ARRAY_T))
    (processor_setsCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine host_processor_set_priv 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_processor_set_priv" 
   ((host_priv :pointer)
    (set_name :pointer)
    (set (:pointer :processor_set_t))
   )
   :signed-long
() )
;  Routine set_dp_control_port 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_set_dp_control_port" 
   ((host :pointer)
    (control_port :pointer)
   )
   :signed-long
() )
;  Routine get_dp_control_port 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_get_dp_control_port" 
   ((host :pointer)
    (contorl_port (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine host_set_UNDServer 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_set_UNDServer" 
   ((host :pointer)
    (server :pointer)
   )
   :signed-long
() )
;  Routine host_get_UNDServer 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_get_UNDServer" 
   ((host :pointer)
    (server (:pointer :UNDSERVERREF))
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
; #ifndef __Request__host_priv_subsystem__defined
; #define __Request__host_priv_subsystem__defined
(defrecord __Request__host_get_boot_info_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_reboot_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (options :signed-long)
)
(defrecord __Request__host_priv_statistics_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :signed-long)
   (host_info_outCnt :UInt32)
)
(defrecord __Request__host_default_memory_manager_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (default_manager :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (cluster_size :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_wire_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (access :signed-long)
)
(defrecord __Request__thread_wire_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (thread :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (wired :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_allocate_cpm_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (anywhere :signed-long)
)
(defrecord __Request__host_processors_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_get_clock_control_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (clock_id :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__kmod_create_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (info :vm_address_t)
)
#|
; Warning: type-size: unknown type KMOD_T
|#
(defrecord __Request__kmod_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (module :kmod_t)
)
#|
; Warning: type-size: unknown type KMOD_T
|#
#|
; Warning: type-size: unknown type KMOD_CONTROL_FLAVOR_T
|#
(defrecord __Request__kmod_control_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (data :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (module :kmod_t)
   (flavor :kmod_control_flavor_t)
   (dataCnt :UInt32)
)
(defrecord __Request__host_get_special_port_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (node :signed-long)
   (which :signed-long)
)
(defrecord __Request__host_set_special_port_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (which :signed-long)
)
#|
; Warning: type-size: unknown type THREAD_STATE_FLAVOR_T
|#
(defrecord __Request__host_set_exception_ports_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (new_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (exception_mask :UInt32)
   (behavior :signed-long)
   (new_flavor :thread_state_flavor_t)
)
(defrecord __Request__host_get_exception_ports_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (exception_mask :UInt32)
)
#|
; Warning: type-size: unknown type THREAD_STATE_FLAVOR_T
|#
(defrecord __Request__host_swap_exception_ports_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (new_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (exception_mask :UInt32)
   (behavior :signed-long)
   (new_flavor :thread_state_flavor_t)
)
(defrecord __Request__host_load_symbol_table_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (task :MACH_MSG_PORT_DESCRIPTOR_T)
   (symtab :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (nameOffset :UInt32)                         ;  MiG doesn't use it 
   (nameCnt :UInt32)
   (name (:array :character 32))
   (symtabCnt :UInt32)
)
(defrecord __Request__task_swappable_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (target_task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (make_swappable :signed-long)
)
(defrecord __Request__host_processor_sets_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_processor_set_priv_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (set_name :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Request__set_dp_control_port_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (control_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Request__get_dp_control_port_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__host_set_UNDServer_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (server :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Request__host_get_UNDServer_t
   (Head :MACH_MSG_HEADER_T)
)

; #endif /* !__Request__host_priv_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__host_priv_subsystem__defined
; #define __RequestUnion__host_priv_subsystem__defined
(defrecord __RequestUnion__host_priv_subsystem
   (:variant
   (
   (Request_host_get_boot_info :__REQUEST__HOST_GET_BOOT_INFO_T)
   )
   (
   (Request_host_reboot :__REQUEST__HOST_REBOOT_T)
   )
   (
   (Request_host_priv_statistics :__REQUEST__HOST_PRIV_STATISTICS_T)
   )
   (
   (Request_host_default_memory_manager :__REQUEST__HOST_DEFAULT_MEMORY_MANAGER_T)
   )
   (
   (Request_vm_wire :__REQUEST__VM_WIRE_T)
   )
   (
   (Request_thread_wire :__REQUEST__THREAD_WIRE_T)
   )
   (
   (Request_vm_allocate_cpm :__REQUEST__VM_ALLOCATE_CPM_T)
   )
   (
   (Request_host_processors :__REQUEST__HOST_PROCESSORS_T)
   )
   (
   (Request_host_get_clock_control :__REQUEST__HOST_GET_CLOCK_CONTROL_T)
   )
   (
   (Request_kmod_create :__REQUEST__KMOD_CREATE_T)
   )
   (
   (Request_kmod_destroy :__REQUEST__KMOD_DESTROY_T)
   )
   (
   (Request_kmod_control :__REQUEST__KMOD_CONTROL_T)
   )
   (
   (Request_host_get_special_port :__REQUEST__HOST_GET_SPECIAL_PORT_T)
   )
   (
   (Request_host_set_special_port :__REQUEST__HOST_SET_SPECIAL_PORT_T)
   )
   (
   (Request_host_set_exception_ports :__REQUEST__HOST_SET_EXCEPTION_PORTS_T)
   )
   (
   (Request_host_get_exception_ports :__REQUEST__HOST_GET_EXCEPTION_PORTS_T)
   )
   (
   (Request_host_swap_exception_ports :__REQUEST__HOST_SWAP_EXCEPTION_PORTS_T)
   )
   (
   (Request_host_load_symbol_table :__REQUEST__HOST_LOAD_SYMBOL_TABLE_T)
   )
   (
   (Request_task_swappable :__REQUEST__TASK_SWAPPABLE_T)
   )
   (
   (Request_host_processor_sets :__REQUEST__HOST_PROCESSOR_SETS_T)
   )
   (
   (Request_host_processor_set_priv :__REQUEST__HOST_PROCESSOR_SET_PRIV_T)
   )
   (
   (Request_set_dp_control_port :__REQUEST__SET_DP_CONTROL_PORT_T)
   )
   (
   (Request_get_dp_control_port :__REQUEST__GET_DP_CONTROL_PORT_T)
   )
   (
   (Request_host_set_UNDServer :__REQUEST__HOST_SET_UNDSERVER_T)
   )
   (
   (Request_host_get_UNDServer :__REQUEST__HOST_GET_UNDSERVER_T)
   )
   )
)

; #endif /* !__RequestUnion__host_priv_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__host_priv_subsystem__defined
; #define __Reply__host_priv_subsystem__defined
(defrecord __Reply__host_get_boot_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (boot_infoOffset :UInt32)                    ;  MiG doesn't use it 
   (boot_infoCnt :UInt32)
   (boot_info (:array :character 4096))
)
(defrecord __Reply__host_reboot_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__host_priv_statistics_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (host_info_outCnt :UInt32)
   (host_info_out (:array :signed-long 12))
)
(defrecord __Reply__host_default_memory_manager_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (default_manager :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__vm_wire_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__thread_wire_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_allocate_cpm_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
)
(defrecord __Reply__host_processors_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (processor_list :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (processor_listCnt :UInt32)
)
(defrecord __Reply__host_get_clock_control_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (clock_ctrl :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
#|
; Warning: type-size: unknown type KMOD_T
|#
(defrecord __Reply__kmod_create_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (module :kmod_t)
)
(defrecord __Reply__kmod_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__kmod_control_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (data :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (dataCnt :UInt32)
)
(defrecord __Reply__host_get_special_port_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__host_set_special_port_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__host_set_exception_ports_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type thread_state_flavor_t
|#
(defrecord __Reply__host_get_exception_ports_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (old_handlers (:array :MACH_MSG_PORT_DESCRIPTOR_T 32))
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (masksCnt :UInt32)
   (masks (:array :UInt32 32))
   (old_behaviors (:array :signed-long 32))
   (old_flavors (:array :thread_state_flavor_t 32))
)
#|
; Warning: type-size: unknown type thread_state_flavor_t
|#
(defrecord __Reply__host_swap_exception_ports_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (old_handlerss (:array :MACH_MSG_PORT_DESCRIPTOR_T 32))
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (masksCnt :UInt32)
   (masks (:array :UInt32 32))
   (old_behaviors (:array :signed-long 32))
   (old_flavors (:array :thread_state_flavor_t 32))
)
(defrecord __Reply__host_load_symbol_table_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__task_swappable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__host_processor_sets_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (processor_sets :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (processor_setsCnt :UInt32)
)
(defrecord __Reply__host_processor_set_priv_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (set :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__set_dp_control_port_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__get_dp_control_port_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (contorl_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__host_set_UNDServer_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__host_get_UNDServer_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (server :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)

; #endif /* !__Reply__host_priv_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__host_priv_subsystem__defined
; #define __ReplyUnion__host_priv_subsystem__defined
(defrecord __ReplyUnion__host_priv_subsystem
   (:variant
   (
   (Reply_host_get_boot_info :__REPLY__HOST_GET_BOOT_INFO_T)
   )
   (
   (Reply_host_reboot :__REPLY__HOST_REBOOT_T)
   )
   (
   (Reply_host_priv_statistics :__REPLY__HOST_PRIV_STATISTICS_T)
   )
   (
   (Reply_host_default_memory_manager :__REPLY__HOST_DEFAULT_MEMORY_MANAGER_T)
   )
   (
   (Reply_vm_wire :__REPLY__VM_WIRE_T)
   )
   (
   (Reply_thread_wire :__REPLY__THREAD_WIRE_T)
   )
   (
   (Reply_vm_allocate_cpm :__REPLY__VM_ALLOCATE_CPM_T)
   )
   (
   (Reply_host_processors :__REPLY__HOST_PROCESSORS_T)
   )
   (
   (Reply_host_get_clock_control :__REPLY__HOST_GET_CLOCK_CONTROL_T)
   )
   (
   (Reply_kmod_create :__REPLY__KMOD_CREATE_T)
   )
   (
   (Reply_kmod_destroy :__REPLY__KMOD_DESTROY_T)
   )
   (
   (Reply_kmod_control :__REPLY__KMOD_CONTROL_T)
   )
   (
   (Reply_host_get_special_port :__REPLY__HOST_GET_SPECIAL_PORT_T)
   )
   (
   (Reply_host_set_special_port :__REPLY__HOST_SET_SPECIAL_PORT_T)
   )
   (
   (Reply_host_set_exception_ports :__REPLY__HOST_SET_EXCEPTION_PORTS_T)
   )
   (
   (Reply_host_get_exception_ports :__REPLY__HOST_GET_EXCEPTION_PORTS_T)
   )
   (
   (Reply_host_swap_exception_ports :__REPLY__HOST_SWAP_EXCEPTION_PORTS_T)
   )
   (
   (Reply_host_load_symbol_table :__REPLY__HOST_LOAD_SYMBOL_TABLE_T)
   )
   (
   (Reply_task_swappable :__REPLY__TASK_SWAPPABLE_T)
   )
   (
   (Reply_host_processor_sets :__REPLY__HOST_PROCESSOR_SETS_T)
   )
   (
   (Reply_host_processor_set_priv :__REPLY__HOST_PROCESSOR_SET_PRIV_T)
   )
   (
   (Reply_set_dp_control_port :__REPLY__SET_DP_CONTROL_PORT_T)
   )
   (
   (Reply_get_dp_control_port :__REPLY__GET_DP_CONTROL_PORT_T)
   )
   (
   (Reply_host_set_UNDServer :__REPLY__HOST_SET_UNDSERVER_T)
   )
   (
   (Reply_host_get_UNDServer :__REPLY__HOST_GET_UNDSERVER_T)
   )
   )
)

; #endif /* !__RequestUnion__host_priv_subsystem__defined */

; #ifndef subsystem_to_name_map_host_priv
; #define subsystem_to_name_map_host_priv     { "host_get_boot_info", 400 },    { "host_reboot", 401 },    { "host_priv_statistics", 402 },    { "host_default_memory_manager", 403 },    { "vm_wire", 404 },    { "thread_wire", 405 },    { "vm_allocate_cpm", 406 },    { "host_processors", 407 },    { "host_get_clock_control", 408 },    { "kmod_create", 409 },    { "kmod_destroy", 410 },    { "kmod_control", 411 },    { "host_get_special_port", 412 },    { "host_set_special_port", 413 },    { "host_set_exception_ports", 414 },    { "host_get_exception_ports", 415 },    { "host_swap_exception_ports", 416 },    { "host_load_symbol_table", 417 },    { "task_swappable", 418 },    { "host_processor_sets", 419 },    { "host_processor_set_priv", 420 },    { "set_dp_control_port", 421 },    { "get_dp_control_port", 422 },    { "host_set_UNDServer", 423 },    { "host_get_UNDServer", 424 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _host_priv_user_ */


(provide-interface "host_priv")