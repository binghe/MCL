(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:memory_object_default_server.h"
; at Sunday July 2,2006 7:26:14 pm.
; #ifndef	_memory_object_default_server_
; #define	_memory_object_default_server_
;  Module memory_object_default 

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
; #ifndef	memory_object_default_MSG_COUNT
(defconstant $memory_object_default_MSG_COUNT 1)
; #define	memory_object_default_MSG_COUNT	1

; #endif	/* memory_object_default_MSG_COUNT */


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
;  Routine memory_object_create 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_memory_object_create" 
   ((default_memory_manager :memory_object_default_t)
    (new_memory_object_size :UInt32)
    (new_memory_object (:pointer :memory_object_t))
   )
   :signed-long
() )

(deftrap-inline "_memory_object_default_server" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
    (OutHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :signed-long
() )

(deftrap-inline "_memory_object_default_server_routine" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :mig_routine_t
() )
;  Description of this subsystem, for use in direct RPC 
(defrecord memory_object_default_subsystem
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
   (routine (:array :routine_descriptor 1))
#|
; Warning: type-size: unknown type routine_descriptor
|#
)
;  typedefs for all requests 
; #ifndef __Request__memory_object_default_subsystem__defined
; #define __Request__memory_object_default_subsystem__defined
(defrecord __Request__memory_object_create_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (new_memory_object_size :UInt32)
)

; #endif /* !__Request__memory_object_default_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__memory_object_default_subsystem__defined
; #define __RequestUnion__memory_object_default_subsystem__defined
(defrecord __RequestUnion__memory_object_default_subsystem
   (:variant
   (
   (Request_memory_object_create :__REQUEST__MEMORY_OBJECT_CREATE_T)
   )
   )
)

; #endif /* __RequestUnion__memory_object_default_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__memory_object_default_subsystem__defined
; #define __Reply__memory_object_default_subsystem__defined
(defrecord __Reply__memory_object_create_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (new_memory_object :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)

; #endif /* !__Reply__memory_object_default_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__memory_object_default_subsystem__defined
; #define __ReplyUnion__memory_object_default_subsystem__defined
(defrecord __ReplyUnion__memory_object_default_subsystem
   (:variant
   (
   (Reply_memory_object_create :__REPLY__MEMORY_OBJECT_CREATE_T)
   )
   )
)

; #endif /* __RequestUnion__memory_object_default_subsystem__defined */

; #ifndef subsystem_to_name_map_memory_object_default
; #define subsystem_to_name_map_memory_object_default     { "memory_object_create", 2250 }

; #endif

; #ifdef __AfterMigServerHeader
#| #|
__AfterMigServerHeader
#endif
|#
 |#
;  __AfterMigServerHeader 

; #endif	 /* _memory_object_default_server_ */


(provide-interface "memory_object_default_server")