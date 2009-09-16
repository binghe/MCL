(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_i386_server.h"
; at Sunday July 2,2006 7:30:20 pm.
; #ifndef	_mach_i386_server_
; #define	_mach_i386_server_
;  Module mach_i386 

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
; #ifndef	mach_i386_MSG_COUNT
(defconstant $mach_i386_MSG_COUNT 5)
; #define	mach_i386_MSG_COUNT	5

; #endif	/* mach_i386_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "kern/ipc_mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")

(require-interface "device/device_types")

(require-interface "mach/i386/mach_i386_types")
; #ifdef __BeforeMigServerHeader
#| #|
__BeforeMigServerHeader
#endif
|#
 |#
;  __BeforeMigServerHeader 
;  Routine i386_io_port_add 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_i386_io_port_add" 
   ((target_act :pointer)
    (device :device_t)
   )
   :signed-long
() )
;  Routine i386_io_port_remove 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_i386_io_port_remove" 
   ((target_act :pointer)
    (device :device_t)
   )
   :signed-long
() )
;  Routine i386_io_port_list 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_i386_io_port_list" 
   ((target_act :pointer)
    (device_list (:pointer :DEVICE_LIST_T))
    (device_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine i386_set_ldt 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_i386_set_ldt" 
   ((target_act :pointer)
    (first_selector :signed-long)
    (desc_list (:pointer :descriptor))
    (desc_listCnt :UInt32)
   )
   :signed-long
() )
;  Routine i386_get_ldt 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_i386_get_ldt" 
   ((target_act :pointer)
    (first_selector :signed-long)
    (selector_count :signed-long)
    (desc_list (:pointer :DESCRIPTOR_LIST_T))
    (desc_listCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )

(deftrap-inline "_mach_i386_server" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
    (OutHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :signed-long
() )

(deftrap-inline "_mach_i386_server_routine" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :mig_routine_t
() )
;  Description of this subsystem, for use in direct RPC 
(defrecord mach_i386_subsystem
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
   (routine (:array :routine_descriptor 5))
#|
; Warning: type-size: unknown type routine_descriptor
|#
)
;  typedefs for all requests 
; #ifndef __Request__mach_i386_subsystem__defined
; #define __Request__mach_i386_subsystem__defined
(defrecord __Request__i386_io_port_add_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (device :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Request__i386_io_port_remove_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (device :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Request__i386_io_port_list_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__i386_set_ldt_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (desc_list :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (first_selector :signed-long)
   (desc_listCnt :UInt32)
)
(defrecord __Request__i386_get_ldt_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (first_selector :signed-long)
   (selector_count :signed-long)
)

; #endif /* !__Request__mach_i386_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__mach_i386_subsystem__defined
; #define __RequestUnion__mach_i386_subsystem__defined
(defrecord __RequestUnion__mach_i386_subsystem
   (:variant
   (
   (Request_i386_io_port_add :__REQUEST__I386_IO_PORT_ADD_T)
   )
   (
   (Request_i386_io_port_remove :__REQUEST__I386_IO_PORT_REMOVE_T)
   )
   (
   (Request_i386_io_port_list :__REQUEST__I386_IO_PORT_LIST_T)
   )
   (
   (Request_i386_set_ldt :__REQUEST__I386_SET_LDT_T)
   )
   (
   (Request_i386_get_ldt :__REQUEST__I386_GET_LDT_T)
   )
   )
)

; #endif /* __RequestUnion__mach_i386_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__mach_i386_subsystem__defined
; #define __Reply__mach_i386_subsystem__defined
(defrecord __Reply__i386_io_port_add_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__i386_io_port_remove_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__i386_io_port_list_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (device_list :MACH_MSG_OOL_PORTS_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (device_listCnt :UInt32)
)
(defrecord __Reply__i386_set_ldt_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__i386_get_ldt_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (desc_list :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (desc_listCnt :UInt32)
)

; #endif /* !__Reply__mach_i386_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__mach_i386_subsystem__defined
; #define __ReplyUnion__mach_i386_subsystem__defined
(defrecord __ReplyUnion__mach_i386_subsystem
   (:variant
   (
   (Reply_i386_io_port_add :__REPLY__I386_IO_PORT_ADD_T)
   )
   (
   (Reply_i386_io_port_remove :__REPLY__I386_IO_PORT_REMOVE_T)
   )
   (
   (Reply_i386_io_port_list :__REPLY__I386_IO_PORT_LIST_T)
   )
   (
   (Reply_i386_set_ldt :__REPLY__I386_SET_LDT_T)
   )
   (
   (Reply_i386_get_ldt :__REPLY__I386_GET_LDT_T)
   )
   )
)

; #endif /* __RequestUnion__mach_i386_subsystem__defined */

; #ifndef subsystem_to_name_map_mach_i386
; #define subsystem_to_name_map_mach_i386     { "i386_io_port_add", 3800 },    { "i386_io_port_remove", 3801 },    { "i386_io_port_list", 3802 },    { "i386_set_ldt", 3803 },    { "i386_get_ldt", 3804 }

; #endif

; #ifdef __AfterMigServerHeader
#| #|
__AfterMigServerHeader
#endif
|#
 |#
;  __AfterMigServerHeader 

; #endif	 /* _mach_i386_server_ */


(provide-interface "mach_i386_server")