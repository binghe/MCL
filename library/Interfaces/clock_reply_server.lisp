(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:clock_reply_server.h"
; at Sunday July 2,2006 7:25:56 pm.
; #ifndef	_clock_reply_server_
; #define	_clock_reply_server_
;  Module clock_reply 

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
; #ifndef	clock_reply_MSG_COUNT
(defconstant $clock_reply_MSG_COUNT 1)
; #define	clock_reply_MSG_COUNT	1

; #endif	/* clock_reply_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mach_types")
; #ifdef __BeforeMigServerHeader
#| #|
__BeforeMigServerHeader
#endif
|#
 |#
;  __BeforeMigServerHeader 
;  SimpleRoutine clock_alarm_reply 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_clock_alarm_reply" 
   ((alarm_port :pointer)
    (alarm_code :signed-long)
    (alarm_type :signed-long)
    (alarm_time (:pointer :mach_timespec))
   )
   :signed-long
() )

(deftrap-inline "_clock_reply_server" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
    (OutHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :signed-long
() )

(deftrap-inline "_clock_reply_server_routine" 
   ((InHeadP (:pointer :MACH_MSG_HEADER_T))
   )
   :mig_routine_t
() )
;  Description of this subsystem, for use in direct RPC 
(defrecord clock_reply_subsystem
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
; #ifndef __Request__clock_reply_subsystem__defined
; #define __Request__clock_reply_subsystem__defined
(defrecord __Request__clock_alarm_reply_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (alarm_code :signed-long)
   (alarm_type :signed-long)
   (alarm_time :mach_timespec)
)

; #endif /* !__Request__clock_reply_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__clock_reply_subsystem__defined
; #define __RequestUnion__clock_reply_subsystem__defined
(defrecord __RequestUnion__clock_reply_subsystem
   (:variant
   (
   (Request_clock_alarm_reply :__REQUEST__CLOCK_ALARM_REPLY_T)
   )
   )
)

; #endif /* __RequestUnion__clock_reply_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__clock_reply_subsystem__defined
; #define __Reply__clock_reply_subsystem__defined
(defrecord __Reply__clock_alarm_reply_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__clock_reply_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__clock_reply_subsystem__defined
; #define __ReplyUnion__clock_reply_subsystem__defined
(defrecord __ReplyUnion__clock_reply_subsystem
   (:variant
   (
   (Reply_clock_alarm_reply :__REPLY__CLOCK_ALARM_REPLY_T)
   )
   )
)

; #endif /* __RequestUnion__clock_reply_subsystem__defined */

; #ifndef subsystem_to_name_map_clock_reply
; #define subsystem_to_name_map_clock_reply     { "clock_alarm_reply", 3125107 }

; #endif

; #ifdef __AfterMigServerHeader
#| #|
__AfterMigServerHeader
#endif
|#
 |#
;  __AfterMigServerHeader 

; #endif	 /* _clock_reply_server_ */


(provide-interface "clock_reply_server")