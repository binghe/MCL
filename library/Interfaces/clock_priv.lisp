(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:clock_priv.h"
; at Sunday July 2,2006 7:25:45 pm.
; #ifndef	_clock_priv_user_
; #define	_clock_priv_user_
;  Module clock_priv 

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
; #ifndef	clock_priv_MSG_COUNT
(defconstant $clock_priv_MSG_COUNT 2)
; #define	clock_priv_MSG_COUNT	2

; #endif	/* clock_priv_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")

(require-interface "mach/mach_types")
; #ifdef __BeforeMigUserHeader
#| #|
__BeforeMigUserHeader
#endif
|#
 |#
;  __BeforeMigUserHeader 

(require-interface "sys/cdefs")
;  Routine clock_set_time 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_clock_set_time" 
   ((clock_ctrl :pointer)
    (new_time (:pointer :mach_timespec))
   )
   :signed-long
() )
;  Routine clock_set_attributes 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_clock_set_attributes" 
   ((clock_ctrl :pointer)
    (flavor :signed-long)
    (clock_attr (:pointer :signed-long))
    (clock_attrCnt :UInt32)
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
; #ifndef __Request__clock_priv_subsystem__defined
; #define __Request__clock_priv_subsystem__defined
(defrecord __Request__clock_set_time_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (new_time :mach_timespec)
)
(defrecord __Request__clock_set_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flavor :signed-long)
   (clock_attrCnt :UInt32)
   (clock_attr (:array :signed-long 1))
)

; #endif /* !__Request__clock_priv_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__clock_priv_subsystem__defined
; #define __RequestUnion__clock_priv_subsystem__defined
(defrecord __RequestUnion__clock_priv_subsystem
   (:variant
   (
   (Request_clock_set_time :__REQUEST__CLOCK_SET_TIME_T)
   )
   (
   (Request_clock_set_attributes :__REQUEST__CLOCK_SET_ATTRIBUTES_T)
   )
   )
)

; #endif /* !__RequestUnion__clock_priv_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__clock_priv_subsystem__defined
; #define __Reply__clock_priv_subsystem__defined
(defrecord __Reply__clock_set_time_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__clock_set_attributes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__clock_priv_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__clock_priv_subsystem__defined
; #define __ReplyUnion__clock_priv_subsystem__defined
(defrecord __ReplyUnion__clock_priv_subsystem
   (:variant
   (
   (Reply_clock_set_time :__REPLY__CLOCK_SET_TIME_T)
   )
   (
   (Reply_clock_set_attributes :__REPLY__CLOCK_SET_ATTRIBUTES_T)
   )
   )
)

; #endif /* !__RequestUnion__clock_priv_subsystem__defined */

; #ifndef subsystem_to_name_map_clock_priv
; #define subsystem_to_name_map_clock_priv     { "clock_set_time", 1200 },    { "clock_set_attributes", 1201 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _clock_priv_user_ */


(provide-interface "clock_priv")