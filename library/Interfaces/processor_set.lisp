(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:processor_set.h"
; at Sunday July 2,2006 7:26:20 pm.
; #ifndef	_processor_set_user_
; #define	_processor_set_user_
;  Module processor_set 

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
; #ifndef	processor_set_MSG_COUNT
(defconstant $processor_set_MSG_COUNT 10)
; #define	processor_set_MSG_COUNT	10

; #endif	/* processor_set_MSG_COUNT */


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
;  Routine processor_set_statistics 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_statistics" 
   ((pset :pointer)
    (flavor :processor_set_flavor_t)
    (info_out :processor_set_info_t)
    (info_outCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine processor_set_destroy 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_destroy" 
   ((set :pointer)
   )
   :signed-long
() )
;  Routine processor_set_max_priority 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_max_priority" 
   ((processor_set :pointer)
    (max_priority :signed-long)
    (change_threads :signed-long)
   )
   :signed-long
() )
;  Routine processor_set_policy_enable 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_policy_enable" 
   ((processor_set :pointer)
    (policy :signed-long)
   )
   :signed-long
() )
;  Routine processor_set_policy_disable 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_policy_disable" 
   ((processor_set :pointer)
    (policy :signed-long)
    (change_threads :signed-long)
   )
   :signed-long
() )
;  Routine processor_set_tasks 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_tasks" 
   ((processor_set :pointer)
    (task_list (:pointer :task_array_t))
    (task_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine processor_set_threads 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_threads" 
   ((processor_set :pointer)
    (thread_list (:pointer :thread_act_array_t))
    (thread_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine processor_set_policy_control 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_policy_control" 
   ((pset :pointer)
    (flavor :processor_set_flavor_t)
    (policy_info :processor_set_info_t)
    (policy_infoCnt :UInt32)
    (change :signed-long)
   )
   :signed-long
() )
;  Routine processor_set_stack_usage 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_stack_usage" 
   ((pset :pointer)
    (total (:pointer :UInt32))
    (space (:pointer :VM_SIZE_T))
    (resident (:pointer :VM_SIZE_T))
    (maxusage (:pointer :VM_SIZE_T))
    (maxstack (:pointer :vm_offset_t))
   )
   :signed-long
() )
;  Routine processor_set_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_processor_set_info" 
   ((set_name :pointer)
    (flavor :signed-long)
    (host (:pointer :host_t))
    (info_out :processor_set_info_t)
    (info_outCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
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
; #ifndef __Request__processor_set_subsystem__defined
; #define __Request__processor_set_subsystem__defined
#|
; Warning: type-size: unknown type PROCESSOR_SET_FLAVOR_T
|#
(defrecord __Request__processor_set_statistics_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :processor_set_flavor_t)
   (info_outCnt :UInt32)
)
(defrecord __Request__processor_set_destroy_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__processor_set_max_priority_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (max_priority :signed-long)
   (change_threads :signed-long)
)
(defrecord __Request__processor_set_policy_enable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (policy :signed-long)
)
(defrecord __Request__processor_set_policy_disable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (policy :signed-long)
   (change_threads :signed-long)
)
(defrecord __Request__processor_set_tasks_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__processor_set_threads_t
   (Head :MACH_MSG_HEADER_T)
)
#|
; Warning: type-size: unknown type PROCESSOR_SET_FLAVOR_T
|#
(defrecord __Request__processor_set_policy_control_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :processor_set_flavor_t)
   (policy_infoCnt :UInt32)
   (policy_info (:array :signed-long 5))
   (change :signed-long)
)
(defrecord __Request__processor_set_stack_usage_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__processor_set_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :signed-long)
   (info_outCnt :UInt32)
)

; #endif /* !__Request__processor_set_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__processor_set_subsystem__defined
; #define __RequestUnion__processor_set_subsystem__defined
(defrecord __RequestUnion__processor_set_subsystem
   (:variant
   (
   (Request_processor_set_statistics :__REQUEST__PROCESSOR_SET_STATISTICS_T)
   )
   (
   (Request_processor_set_destroy :__REQUEST__PROCESSOR_SET_DESTROY_T)
   )
   (
   (Request_processor_set_max_priority :__REQUEST__PROCESSOR_SET_MAX_PRIORITY_T)
   )
   (
   (Request_processor_set_policy_enable :__REQUEST__PROCESSOR_SET_POLICY_ENABLE_T)
   )
   (
   (Request_processor_set_policy_disable :__REQUEST__PROCESSOR_SET_POLICY_DISABLE_T)
   )
   (
   (Request_processor_set_tasks :__REQUEST__PROCESSOR_SET_TASKS_T)
   )
   (
   (Request_processor_set_threads :__REQUEST__PROCESSOR_SET_THREADS_T)
   )
   (
   (Request_processor_set_policy_control :__REQUEST__PROCESSOR_SET_POLICY_CONTROL_T)
   )
   (
   (Request_processor_set_stack_usage :__REQUEST__PROCESSOR_SET_STACK_USAGE_T)
   )
   (
   (Request_processor_set_info :__REQUEST__PROCESSOR_SET_INFO_T)
   )
   )
)

; #endif /* !__RequestUnion__processor_set_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__processor_set_subsystem__defined
; #define __Reply__processor_set_subsystem__defined
(defrecord __Reply__processor_set_statistics_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (info_outCnt :UInt32)
   (info_out (:array :signed-long 5))
)
(defrecord __Reply__processor_set_destroy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__processor_set_max_priority_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__processor_set_policy_enable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__processor_set_policy_disable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__processor_set_tasks_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (task_list :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (task_listCnt :UInt32)
)
(defrecord __Reply__processor_set_threads_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (thread_list :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (thread_listCnt :UInt32)
)
(defrecord __Reply__processor_set_policy_control_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__processor_set_stack_usage_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (total :UInt32)
   (space :UInt32)
   (resident :UInt32)
   (maxusage :UInt32)
   (maxstack :UInt32)
)
(defrecord __Reply__processor_set_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (host :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (info_outCnt :UInt32)
   (info_out (:array :signed-long 5))
)

; #endif /* !__Reply__processor_set_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__processor_set_subsystem__defined
; #define __ReplyUnion__processor_set_subsystem__defined
(defrecord __ReplyUnion__processor_set_subsystem
   (:variant
   (
   (Reply_processor_set_statistics :__REPLY__PROCESSOR_SET_STATISTICS_T)
   )
   (
   (Reply_processor_set_destroy :__REPLY__PROCESSOR_SET_DESTROY_T)
   )
   (
   (Reply_processor_set_max_priority :__REPLY__PROCESSOR_SET_MAX_PRIORITY_T)
   )
   (
   (Reply_processor_set_policy_enable :__REPLY__PROCESSOR_SET_POLICY_ENABLE_T)
   )
   (
   (Reply_processor_set_policy_disable :__REPLY__PROCESSOR_SET_POLICY_DISABLE_T)
   )
   (
   (Reply_processor_set_tasks :__REPLY__PROCESSOR_SET_TASKS_T)
   )
   (
   (Reply_processor_set_threads :__REPLY__PROCESSOR_SET_THREADS_T)
   )
   (
   (Reply_processor_set_policy_control :__REPLY__PROCESSOR_SET_POLICY_CONTROL_T)
   )
   (
   (Reply_processor_set_stack_usage :__REPLY__PROCESSOR_SET_STACK_USAGE_T)
   )
   (
   (Reply_processor_set_info :__REPLY__PROCESSOR_SET_INFO_T)
   )
   )
)

; #endif /* !__RequestUnion__processor_set_subsystem__defined */

; #ifndef subsystem_to_name_map_processor_set
; #define subsystem_to_name_map_processor_set     { "processor_set_statistics", 4000 },    { "processor_set_destroy", 4001 },    { "processor_set_max_priority", 4002 },    { "processor_set_policy_enable", 4003 },    { "processor_set_policy_disable", 4004 },    { "processor_set_tasks", 4005 },    { "processor_set_threads", 4006 },    { "processor_set_policy_control", 4007 },    { "processor_set_stack_usage", 4008 },    { "processor_set_info", 4009 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _processor_set_user_ */


(provide-interface "processor_set")