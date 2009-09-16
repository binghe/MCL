(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:exc_server.h"
; at Sunday July 2,2006 7:25:58 pm.
; #ifndef	_exc_server_
; #define	_exc_server_
;  Module exc 

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
; #ifndef	exc_MSG_COUNT
(defconstant $exc_MSG_COUNT 3)
; #define	exc_MSG_COUNT	3

; #endif	/* exc_MSG_COUNT */


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
;  Routine exception_raise 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_catch_exception_raise" 
   ((exception_port :pointer)
    (thread :pointer)
    (task :pointer)
    (exception :signed-long)
    (code (:pointer :signed-long))
    (codeCnt :UInt32)
   )
   :signed-long
() )
;  Routine exception_raise_state 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_catch_exception_raise_state" 
   ((exception_port :pointer)
    (exception :signed-long)
    (code (:pointer :signed-long))
    (codeCnt :UInt32)
    (flavor (:pointer :int))
    (old_state :thread_state_t)
    (old_stateCnt :UInt32)
    (new_state :thread_state_t)
    (new_stateCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine exception_raise_state_identity 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_catch_exception_raise_state_identity" 
   ((exception_port :pointer)
    (thread :pointer)
    (task :pointer)
    (exception :signed-long)
    (code (:pointer :signed-long))
    (codeCnt :UInt32)
    (flavor (:pointer :int))
    (old_state :thread_state_t)
    (old_stateCnt :UInt32)
    (new_state :thread_state_t)
    (new_stateCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )

(deftrap-inline "_exc_server" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
    (OutHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :signed-long
() )

(deftrap-inline "_exc_server_routine" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :mig_routine_t
() )
;  Description of this subsystem, for use in direct RPC 
(defrecord catch_exc_subsystem
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
   (routine (:array :routine_descriptor 3))
#|
; Warning: type-size: unknown type routine_descriptor
|#
)
;  typedefs for all requests 
; #ifndef __Request__exc_subsystem__defined
; #define __Request__exc_subsystem__defined
(defrecord __Request__exception_raise_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (thread :MACH_MSG_PORT_DESCRIPTOR_T)
   (task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (exception :signed-long)
   (codeCnt :UInt32)
   (code (:array :signed-long 2))
)
(defrecord __Request__exception_raise_state_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (exception :signed-long)
   (codeCnt :UInt32)
   (code (:array :signed-long 2))
   (flavor :signed-long)
   (old_stateCnt :UInt32)
   (old_state (:array :UInt32 144))
)
(defrecord __Request__exception_raise_state_identity_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (thread :MACH_MSG_PORT_DESCRIPTOR_T)
   (task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (exception :signed-long)
   (codeCnt :UInt32)
   (code (:array :signed-long 2))
   (flavor :signed-long)
   (old_stateCnt :UInt32)
   (old_state (:array :UInt32 144))
)

; #endif /* !__Request__exc_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__catch_exc_subsystem__defined
; #define __RequestUnion__catch_exc_subsystem__defined
(defrecord __RequestUnion__catch_exc_subsystem
   (:variant
   (
   (Request_exception_raise :__REQUEST__EXCEPTION_RAISE_T)
   )
   (
   (Request_exception_raise_state :__REQUEST__EXCEPTION_RAISE_STATE_T)
   )
   (
   (Request_exception_raise_state_identity :__REQUEST__EXCEPTION_RAISE_STATE_IDENTITY_T)
   )
   )
)

; #endif /* __RequestUnion__catch_exc_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__exc_subsystem__defined
; #define __Reply__exc_subsystem__defined
(defrecord __Reply__exception_raise_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__exception_raise_state_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (flavor :signed-long)
   (new_stateCnt :UInt32)
   (new_state (:array :UInt32 144))
)
(defrecord __Reply__exception_raise_state_identity_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (flavor :signed-long)
   (new_stateCnt :UInt32)
   (new_state (:array :UInt32 144))
)

; #endif /* !__Reply__exc_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__catch_exc_subsystem__defined
; #define __ReplyUnion__catch_exc_subsystem__defined
(defrecord __ReplyUnion__catch_exc_subsystem
   (:variant
   (
   (Reply_exception_raise :__REPLY__EXCEPTION_RAISE_T)
   )
   (
   (Reply_exception_raise_state :__REPLY__EXCEPTION_RAISE_STATE_T)
   )
   (
   (Reply_exception_raise_state_identity :__REPLY__EXCEPTION_RAISE_STATE_IDENTITY_T)
   )
   )
)

; #endif /* __RequestUnion__catch_exc_subsystem__defined */

; #ifndef subsystem_to_name_map_exc
; #define subsystem_to_name_map_exc     { "exception_raise", 2401 },    { "exception_raise_state", 2402 },    { "exception_raise_state_identity", 2403 }

; #endif

; #ifdef __AfterMigServerHeader
#| #|
__AfterMigServerHeader
#endif
|#
 |#
;  __AfterMigServerHeader 

; #endif	 /* _exc_server_ */


(provide-interface "exc_server")