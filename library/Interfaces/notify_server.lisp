(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:notify_server.h"
; at Sunday July 2,2006 7:26:17 pm.
; #ifndef	_notify_server_
; #define	_notify_server_
;  Module notify 

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
; #ifndef	notify_MSG_COUNT
(defconstant $notify_MSG_COUNT 9)
; #define	notify_MSG_COUNT	9

; #endif	/* notify_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")
; #ifdef __BeforeMigServerHeader
#| #|
__BeforeMigServerHeader
#endif
|#
 |#
;  __BeforeMigServerHeader 
;  SimpleRoutine mach_notify_port_deleted 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_do_mach_notify_port_deleted" 
   ((notify :pointer)
    (name :mach_port_name_t)
   )
   :signed-long
() )
;  SimpleRoutine mach_notify_port_destroyed 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_do_mach_notify_port_destroyed" 
   ((notify :pointer)
    (rights :pointer)
   )
   :signed-long
() )
;  SimpleRoutine mach_notify_no_senders 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_do_mach_notify_no_senders" 
   ((notify :pointer)
    (mscount :mach_port_mscount_t)
   )
   :signed-long
() )
;  SimpleRoutine mach_notify_send_once 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_do_mach_notify_send_once" 
   ((notify :pointer)
   )
   :signed-long
() )
;  SimpleRoutine mach_notify_dead_name 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_do_mach_notify_dead_name" 
   ((notify :pointer)
    (name :mach_port_name_t)
   )
   :signed-long
() )

(deftrap-inline "_notify_server" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
    (OutHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :signed-long
() )

(deftrap-inline "_notify_server_routine" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :mig_routine_t
() )
;  Description of this subsystem, for use in direct RPC 
(defrecord do_notify_subsystem
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
   (routine (:array :routine_descriptor 9))
#|
; Warning: type-size: unknown type routine_descriptor
|#
)
;  typedefs for all requests 
; #ifndef __Request__notify_subsystem__defined
; #define __Request__notify_subsystem__defined
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_notify_port_deleted_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)
(defrecord __Request__mach_notify_port_destroyed_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (rights :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
#|
; Warning: type-size: unknown type MACH_PORT_MSCOUNT_T
|#
(defrecord __Request__mach_notify_no_senders_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (mscount :mach_port_mscount_t)
)
(defrecord __Request__mach_notify_send_once_t
   (Head :MACH_MSG_HEADER_T)
)
#|
; Warning: type-size: unknown type MACH_PORT_NAME_T
|#
(defrecord __Request__mach_notify_dead_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (name :mach_port_name_t)
)

; #endif /* !__Request__notify_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__do_notify_subsystem__defined
; #define __RequestUnion__do_notify_subsystem__defined
(defrecord __RequestUnion__do_notify_subsystem
   (:variant
   (
   (Request_mach_notify_port_deleted :__REQUEST__MACH_NOTIFY_PORT_DELETED_T)
   )
   (
   (Request_mach_notify_port_destroyed :__REQUEST__MACH_NOTIFY_PORT_DESTROYED_T)
   )
   (
   (Request_mach_notify_no_senders :__REQUEST__MACH_NOTIFY_NO_SENDERS_T)
   )
   (
   (Request_mach_notify_send_once :__REQUEST__MACH_NOTIFY_SEND_ONCE_T)
   )
   (
   (Request_mach_notify_dead_name :__REQUEST__MACH_NOTIFY_DEAD_NAME_T)
   )
   )
)

; #endif /* __RequestUnion__do_notify_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__notify_subsystem__defined
; #define __Reply__notify_subsystem__defined
(defrecord __Reply__mach_notify_port_deleted_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_notify_port_destroyed_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_notify_no_senders_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_notify_send_once_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_notify_dead_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__notify_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__do_notify_subsystem__defined
; #define __ReplyUnion__do_notify_subsystem__defined
(defrecord __ReplyUnion__do_notify_subsystem
   (:variant
   (
   (Reply_mach_notify_port_deleted :__REPLY__MACH_NOTIFY_PORT_DELETED_T)
   )
   (
   (Reply_mach_notify_port_destroyed :__REPLY__MACH_NOTIFY_PORT_DESTROYED_T)
   )
   (
   (Reply_mach_notify_no_senders :__REPLY__MACH_NOTIFY_NO_SENDERS_T)
   )
   (
   (Reply_mach_notify_send_once :__REPLY__MACH_NOTIFY_SEND_ONCE_T)
   )
   (
   (Reply_mach_notify_dead_name :__REPLY__MACH_NOTIFY_DEAD_NAME_T)
   )
   )
)

; #endif /* __RequestUnion__do_notify_subsystem__defined */

; #ifndef subsystem_to_name_map_notify
; #define subsystem_to_name_map_notify     { "mach_notify_port_deleted", 65 },    { "mach_notify_port_destroyed", 69 },    { "mach_notify_no_senders", 70 },    { "mach_notify_send_once", 71 },    { "mach_notify_dead_name", 72 }

; #endif

; #ifdef __AfterMigServerHeader
#| #|
__AfterMigServerHeader
#endif
|#
 |#
;  __AfterMigServerHeader 

; #endif	 /* _notify_server_ */


(provide-interface "notify_server")