(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:host_security.h"
; at Sunday July 2,2006 7:26:04 pm.
; #ifndef	_host_security_user_
; #define	_host_security_user_
;  Module host_security 

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
; #ifndef	host_security_MSG_COUNT
(defconstant $host_security_MSG_COUNT 2)
; #define	host_security_MSG_COUNT	2

; #endif	/* host_security_MSG_COUNT */


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
;  Routine host_security_create_task_token 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_security_create_task_token" 
   ((host_security :pointer)
    (parent_task :pointer)
    (sec_token (:pointer :SECURITY_TOKEN_T))
    (audit_token (:pointer :AUDIT_TOKEN_T))
    (host :pointer)
    (ledgers (:pointer :pointer))
    (ledgersCnt :UInt32)
    (inherit_memory :signed-long)
    (child_task (:pointer :task_t))
   )
   :signed-long
() )
;  Routine host_security_set_task_token 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_host_security_set_task_token" 
   ((host_security :pointer)
    (target_task :pointer)
    (sec_token (:pointer :SECURITY_TOKEN_T))
    (audit_token (:pointer :AUDIT_TOKEN_T))
    (host :pointer)
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
; #ifndef __Request__host_security_subsystem__defined
; #define __Request__host_security_subsystem__defined
(defrecord __Request__host_security_create_task_token_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (parent_task :MACH_MSG_PORT_DESCRIPTOR_T)
   (host :MACH_MSG_PORT_DESCRIPTOR_T)
   (ledgers :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (sec_token :SECURITY_TOKEN_T)
   (audit_token :AUDIT_TOKEN_T)
   (ledgersCnt :UInt32)
   (inherit_memory :signed-long)
)
(defrecord __Request__host_security_set_task_token_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (target_task :MACH_MSG_PORT_DESCRIPTOR_T)
   (host :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (sec_token :SECURITY_TOKEN_T)
   (audit_token :AUDIT_TOKEN_T)
)

; #endif /* !__Request__host_security_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__host_security_subsystem__defined
; #define __RequestUnion__host_security_subsystem__defined
(defrecord __RequestUnion__host_security_subsystem
   (:variant
   (
   (Request_host_security_create_task_token :__REQUEST__HOST_SECURITY_CREATE_TASK_TOKEN_T)
   )
   (
   (Request_host_security_set_task_token :__REQUEST__HOST_SECURITY_SET_TASK_TOKEN_T)
   )
   )
)

; #endif /* !__RequestUnion__host_security_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__host_security_subsystem__defined
; #define __Reply__host_security_subsystem__defined
(defrecord __Reply__host_security_create_task_token_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (child_task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__host_security_set_task_token_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__host_security_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__host_security_subsystem__defined
; #define __ReplyUnion__host_security_subsystem__defined
(defrecord __ReplyUnion__host_security_subsystem
   (:variant
   (
   (Reply_host_security_create_task_token :__REPLY__HOST_SECURITY_CREATE_TASK_TOKEN_T)
   )
   (
   (Reply_host_security_set_task_token :__REPLY__HOST_SECURITY_SET_TASK_TOKEN_T)
   )
   )
)

; #endif /* !__RequestUnion__host_security_subsystem__defined */

; #ifndef subsystem_to_name_map_host_security
; #define subsystem_to_name_map_host_security     { "host_security_create_task_token", 600 },    { "host_security_set_task_token", 601 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _host_security_user_ */


(provide-interface "host_security")