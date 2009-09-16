(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:lock_set.h"
; at Sunday July 2,2006 7:26:06 pm.
; #ifndef	_lock_set_user_
; #define	_lock_set_user_
;  Module lock_set 

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
; #ifndef	lock_set_MSG_COUNT
(defconstant $lock_set_MSG_COUNT 6)
; #define	lock_set_MSG_COUNT	6

; #endif	/* lock_set_MSG_COUNT */


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
;  Routine lock_acquire 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_lock_acquire" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )
;  Routine lock_release 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_lock_release" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )
;  Routine lock_try 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_lock_try" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )
;  Routine lock_make_stable 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_lock_make_stable" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )
;  Routine lock_handoff 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_lock_handoff" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )
;  Routine lock_handoff_accept 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_lock_handoff_accept" 
   ((lock_set :pointer)
    (lock_id :signed-long)
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
; #ifndef __Request__lock_set_subsystem__defined
; #define __Request__lock_set_subsystem__defined
(defrecord __Request__lock_acquire_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (lock_id :signed-long)
)
(defrecord __Request__lock_release_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (lock_id :signed-long)
)
(defrecord __Request__lock_try_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (lock_id :signed-long)
)
(defrecord __Request__lock_make_stable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (lock_id :signed-long)
)
(defrecord __Request__lock_handoff_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (lock_id :signed-long)
)
(defrecord __Request__lock_handoff_accept_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (lock_id :signed-long)
)

; #endif /* !__Request__lock_set_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__lock_set_subsystem__defined
; #define __RequestUnion__lock_set_subsystem__defined
(defrecord __RequestUnion__lock_set_subsystem
   (:variant
   (
   (Request_lock_acquire :__REQUEST__LOCK_ACQUIRE_T)
   )
   (
   (Request_lock_release :__REQUEST__LOCK_RELEASE_T)
   )
   (
   (Request_lock_try :__REQUEST__LOCK_TRY_T)
   )
   (
   (Request_lock_make_stable :__REQUEST__LOCK_MAKE_STABLE_T)
   )
   (
   (Request_lock_handoff :__REQUEST__LOCK_HANDOFF_T)
   )
   (
   (Request_lock_handoff_accept :__REQUEST__LOCK_HANDOFF_ACCEPT_T)
   )
   )
)

; #endif /* !__RequestUnion__lock_set_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__lock_set_subsystem__defined
; #define __Reply__lock_set_subsystem__defined
(defrecord __Reply__lock_acquire_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__lock_release_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__lock_try_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__lock_make_stable_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__lock_handoff_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__lock_handoff_accept_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__lock_set_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__lock_set_subsystem__defined
; #define __ReplyUnion__lock_set_subsystem__defined
(defrecord __ReplyUnion__lock_set_subsystem
   (:variant
   (
   (Reply_lock_acquire :__REPLY__LOCK_ACQUIRE_T)
   )
   (
   (Reply_lock_release :__REPLY__LOCK_RELEASE_T)
   )
   (
   (Reply_lock_try :__REPLY__LOCK_TRY_T)
   )
   (
   (Reply_lock_make_stable :__REPLY__LOCK_MAKE_STABLE_T)
   )
   (
   (Reply_lock_handoff :__REPLY__LOCK_HANDOFF_T)
   )
   (
   (Reply_lock_handoff_accept :__REPLY__LOCK_HANDOFF_ACCEPT_T)
   )
   )
)

; #endif /* !__RequestUnion__lock_set_subsystem__defined */

; #ifndef subsystem_to_name_map_lock_set
; #define subsystem_to_name_map_lock_set     { "lock_acquire", 617000 },    { "lock_release", 617001 },    { "lock_try", 617002 },    { "lock_make_stable", 617003 },    { "lock_handoff", 617004 },    { "lock_handoff_accept", 617005 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _lock_set_user_ */


(provide-interface "lock_set")