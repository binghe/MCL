(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:iokitmig_c.h"
; at Sunday July 2,2006 7:29:26 pm.
; #ifndef	_iokit_user_
; #define	_iokit_user_
;  Module iokit 

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
; #ifndef	iokit_MSG_COUNT
(defconstant $iokit_MSG_COUNT 60)
; #define	iokit_MSG_COUNT	60

; #endif	/* iokit_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")

(require-interface "mach/mach_types")

(require-interface "device/device_types")
; #ifdef __BeforeMigUserHeader
#| #|
__BeforeMigUserHeader
#endif
|#
 |#
;  __BeforeMigUserHeader 

(require-interface "sys/cdefs")
;  Routine io_object_get_class 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_object_get_class" 
   ((object :pointer)
    (className (:pointer :IO_NAME_T))
   )
   :signed-long
() )
;  Routine io_object_conforms_to 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_object_conforms_to" 
   ((object :pointer)
    (className (:pointer :IO_NAME_T))
    (conforms (:pointer :boolean_t))
   )
   :signed-long
() )
;  Routine io_iterator_next 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_iterator_next" 
   ((iterator :pointer)
    (object (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_iterator_reset 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_iterator_reset" 
   ((iterator :pointer)
   )
   :signed-long
() )
;  Routine io_service_get_matching_services 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_get_matching_services" 
   ((master_port :pointer)
    (matching (:pointer :IO_STRING_T))
    (existing (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_property 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_property" 
   ((registry_entry :pointer)
    (property_name (:pointer :IO_NAME_T))
    (properties (:pointer :IO_BUF_PTR_T))
    (propertiesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_registry_create_iterator 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_create_iterator" 
   ((master_port :pointer)
    (plane (:pointer :IO_NAME_T))
    (options :signed-long)
    (iterator (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_registry_iterator_enter_entry 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_iterator_enter_entry" 
   ((iterator :pointer)
   )
   :signed-long
() )
;  Routine io_registry_iterator_exit_entry 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_iterator_exit_entry" 
   ((iterator :pointer)
   )
   :signed-long
() )
;  Routine io_registry_entry_from_path 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_from_path" 
   ((master_port :pointer)
    (path (:pointer :IO_STRING_T))
    (registry_entry (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_name 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_name" 
   ((registry_entry :pointer)
    (name (:pointer :IO_NAME_T))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_properties 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_properties" 
   ((registry_entry :pointer)
    (properties (:pointer :IO_BUF_PTR_T))
    (propertiesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_property_bytes 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_property_bytes" 
   ((registry_entry :pointer)
    (property_name (:pointer :IO_NAME_T))
    (data (:pointer :IO_STRUCT_INBAND_T))
    (dataCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_child_iterator 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_child_iterator" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (iterator (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_parent_iterator 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_parent_iterator" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (iterator (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_service_open 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_open" 
   ((service :pointer)
    (owningTask :pointer)
    (connect_type :signed-long)
    (connection (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_service_close 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_close" 
   ((connection :pointer)
   )
   :signed-long
() )
;  Routine io_connect_get_service 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_get_service" 
   ((connection :pointer)
    (service (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_connect_set_notification_port 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_set_notification_port" 
   ((connection :pointer)
    (notification_type :signed-long)
    (port :pointer)
    (reference :signed-long)
   )
   :signed-long
() )
;  Routine io_connect_map_memory 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_map_memory" 
   ((connection :pointer)
    (memory_type :signed-long)
    (into_task :pointer)
    (address (:pointer :vm_address_t))
    (size (:pointer :VM_SIZE_T))
    (flags :signed-long)
   )
   :signed-long
() )
;  Routine io_connect_add_client 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_add_client" 
   ((connection :pointer)
    (connect_to :pointer)
   )
   :signed-long
() )
;  Routine io_connect_set_properties 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_set_properties" 
   ((connection :pointer)
    (properties (:pointer :character))
    (propertiesCnt :UInt32)
    (result (:pointer :natural_t))
   )
   :signed-long
() )
;  Routine io_connect_method_scalarI_scalarO 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_method_scalarI_scalarO" 
   ((connection :pointer)
    (selector :signed-long)
    (input (:pointer :IO_SCALAR_INBAND_T))
    (inputCnt :UInt32)
    (output (:pointer :IO_SCALAR_INBAND_T))
    (outputCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_connect_method_scalarI_structureO 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_method_scalarI_structureO" 
   ((connection :pointer)
    (selector :signed-long)
    (input (:pointer :IO_SCALAR_INBAND_T))
    (inputCnt :UInt32)
    (output (:pointer :IO_STRUCT_INBAND_T))
    (outputCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_connect_method_scalarI_structureI 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_method_scalarI_structureI" 
   ((connection :pointer)
    (selector :signed-long)
    (input (:pointer :IO_SCALAR_INBAND_T))
    (inputCnt :UInt32)
    (inputStruct (:pointer :IO_STRUCT_INBAND_T))
    (inputStructCnt :UInt32)
   )
   :signed-long
() )
;  Routine io_connect_method_structureI_structureO 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_method_structureI_structureO" 
   ((connection :pointer)
    (selector :signed-long)
    (input (:pointer :IO_STRUCT_INBAND_T))
    (inputCnt :UInt32)
    (output (:pointer :IO_STRUCT_INBAND_T))
    (outputCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_path 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_path" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (path (:pointer :IO_STRING_T))
   )
   :signed-long
() )
;  Routine io_registry_get_root_entry 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_get_root_entry" 
   ((master_port :pointer)
    (root (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_registry_entry_set_properties 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_set_properties" 
   ((registry_entry :pointer)
    (properties (:pointer :character))
    (propertiesCnt :UInt32)
    (result (:pointer :natural_t))
   )
   :signed-long
() )
;  Routine io_registry_entry_in_plane 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_in_plane" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (inPlane (:pointer :boolean_t))
   )
   :signed-long
() )
;  Routine io_object_get_retain_count 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_object_get_retain_count" 
   ((object :pointer)
    (retainCount (:pointer :int))
   )
   :signed-long
() )
;  Routine io_service_get_busy_state 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_get_busy_state" 
   ((service :pointer)
    (busyState (:pointer :int))
   )
   :signed-long
() )
;  Routine io_service_wait_quiet 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_wait_quiet" 
   ((service :pointer)
    (wait_time (:pointer :mach_timespec))
   )
   :signed-long
() )
;  Routine io_registry_entry_create_iterator 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_create_iterator" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (options :signed-long)
    (iterator (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_iterator_is_valid 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_iterator_is_valid" 
   ((iterator :pointer)
    (is_valid (:pointer :boolean_t))
   )
   :signed-long
() )
;  Routine io_make_matching 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_make_matching" 
   ((master_port :pointer)
    (of_type :signed-long)
    (options :signed-long)
    (input (:pointer :IO_STRUCT_INBAND_T))
    (inputCnt :UInt32)
    (matching (:pointer :IO_STRING_T))
   )
   :signed-long
() )
;  Routine io_catalog_send_data 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_catalog_send_data" 
   ((master_port :pointer)
    (flag :signed-long)
    (inData (:pointer :character))
    (inDataCnt :UInt32)
    (result (:pointer :natural_t))
   )
   :signed-long
() )
;  Routine io_catalog_terminate 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_catalog_terminate" 
   ((master_port :pointer)
    (flag :signed-long)
    (name (:pointer :IO_NAME_T))
   )
   :signed-long
() )
;  Routine io_catalog_get_data 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_catalog_get_data" 
   ((master_port :pointer)
    (flag :signed-long)
    (outData (:pointer :IO_BUF_PTR_T))
    (outDataCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_catalog_get_gen_count 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_catalog_get_gen_count" 
   ((master_port :pointer)
    (genCount (:pointer :int))
   )
   :signed-long
() )
;  Routine io_catalog_module_loaded 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_catalog_module_loaded" 
   ((master_port :pointer)
    (name (:pointer :IO_NAME_T))
   )
   :signed-long
() )
;  Routine io_catalog_reset 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_catalog_reset" 
   ((master_port :pointer)
    (flag :signed-long)
   )
   :signed-long
() )
;  Routine io_service_request_probe 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_request_probe" 
   ((service :pointer)
    (options :signed-long)
   )
   :signed-long
() )
;  Routine io_registry_entry_get_name_in_plane 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_name_in_plane" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (name (:pointer :IO_NAME_T))
   )
   :signed-long
() )
;  Routine io_service_match_property_table 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_match_property_table" 
   ((service :pointer)
    (matching (:pointer :IO_STRING_T))
    (matches (:pointer :boolean_t))
   )
   :signed-long
() )
;  Routine io_async_method_scalarI_scalarO 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_async_method_scalarI_scalarO" 
   ((connection :pointer)
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (selector :signed-long)
    (input (:pointer :IO_SCALAR_INBAND_T))
    (inputCnt :UInt32)
    (output (:pointer :IO_SCALAR_INBAND_T))
    (outputCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_async_method_scalarI_structureO 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_async_method_scalarI_structureO" 
   ((connection :pointer)
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (selector :signed-long)
    (input (:pointer :IO_SCALAR_INBAND_T))
    (inputCnt :UInt32)
    (output (:pointer :IO_STRUCT_INBAND_T))
    (outputCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_async_method_scalarI_structureI 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_async_method_scalarI_structureI" 
   ((connection :pointer)
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (selector :signed-long)
    (input (:pointer :IO_SCALAR_INBAND_T))
    (inputCnt :UInt32)
    (inputStruct (:pointer :IO_STRUCT_INBAND_T))
    (inputStructCnt :UInt32)
   )
   :signed-long
() )
;  Routine io_async_method_structureI_structureO 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_async_method_structureI_structureO" 
   ((connection :pointer)
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (selector :signed-long)
    (input (:pointer :IO_STRUCT_INBAND_T))
    (inputCnt :UInt32)
    (output (:pointer :IO_STRUCT_INBAND_T))
    (outputCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_service_add_notification 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_add_notification" 
   ((master_port :pointer)
    (notification_type (:pointer :IO_NAME_T))
    (matching (:pointer :IO_STRING_T))
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (notification (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_service_add_interest_notification 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_add_interest_notification" 
   ((service :pointer)
    (type_of_interest (:pointer :IO_NAME_T))
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (notification (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_service_acknowledge_notification 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_acknowledge_notification" 
   ((service :pointer)
    (notify_ref :UInt32)
    (response :UInt32)
   )
   :signed-long
() )
;  Routine io_connect_get_notification_semaphore 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_get_notification_semaphore" 
   ((connection :pointer)
    (notification_type :UInt32)
    (semaphore (:pointer :semaphore_t))
   )
   :signed-long
() )
;  Routine io_connect_unmap_memory 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_connect_unmap_memory" 
   ((connection :pointer)
    (memory_type :signed-long)
    (into_task :pointer)
    (address :vm_address_t)
   )
   :signed-long
() )
;  Routine io_registry_entry_get_location_in_plane 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_location_in_plane" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (location (:pointer :IO_NAME_T))
   )
   :signed-long
() )
;  Routine io_registry_entry_get_property_recursively 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_registry_entry_get_property_recursively" 
   ((registry_entry :pointer)
    (plane (:pointer :IO_NAME_T))
    (property_name (:pointer :IO_NAME_T))
    (options :signed-long)
    (properties (:pointer :IO_BUF_PTR_T))
    (propertiesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine io_service_get_state 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_get_state" 
   ((service :pointer)
    (state (:pointer :uint64_t))
   )
   :signed-long
() )
;  Routine io_service_get_matching_services_ool 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_get_matching_services_ool" 
   ((master_port :pointer)
    (matching (:pointer :character))
    (matchingCnt :UInt32)
    (result (:pointer :natural_t))
    (existing (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine io_service_match_property_table_ool 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_match_property_table_ool" 
   ((service :pointer)
    (matching (:pointer :character))
    (matchingCnt :UInt32)
    (result (:pointer :natural_t))
    (matches (:pointer :boolean_t))
   )
   :signed-long
() )
;  Routine io_service_add_notification_ool 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_io_service_add_notification_ool" 
   ((master_port :pointer)
    (notification_type (:pointer :IO_NAME_T))
    (matching (:pointer :character))
    (matchingCnt :UInt32)
    (wake_port :pointer)
    (reference (:pointer :IO_ASYNC_REF_T))
    (referenceCnt :UInt32)
    (result (:pointer :natural_t))
    (notification (:pointer :mach_port_t))
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
; #ifndef __Request__iokit_subsystem__defined
; #define __Request__iokit_subsystem__defined
(defrecord __Request__io_object_get_class_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_object_conforms_to_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (classNameOffset :UInt32)                    ;  MiG doesn't use it 
   (classNameCnt :UInt32)
   (className (:array :character 128))
)
(defrecord __Request__io_iterator_next_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_iterator_reset_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_service_get_matching_services_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (matchingOffset :UInt32)                     ;  MiG doesn't use it 
   (matchingCnt :UInt32)
   (matching (:array :character 512))
)
(defrecord __Request__io_registry_entry_get_property_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (property_nameOffset :UInt32)                ;  MiG doesn't use it 
   (property_nameCnt :UInt32)
   (property_name (:array :character 128))
)
(defrecord __Request__io_registry_create_iterator_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
   (options :signed-long)
)
(defrecord __Request__io_registry_iterator_enter_entry_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_registry_iterator_exit_entry_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_registry_entry_from_path_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (pathOffset :UInt32)                         ;  MiG doesn't use it 
   (pathCnt :UInt32)
   (path (:array :character 512))
)
(defrecord __Request__io_registry_entry_get_name_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_registry_entry_get_properties_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_registry_entry_get_property_bytes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (property_nameOffset :UInt32)                ;  MiG doesn't use it 
   (property_nameCnt :UInt32)
   (property_name (:array :character 128))
   (dataCnt :UInt32)
)
(defrecord __Request__io_registry_entry_get_child_iterator_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
)
(defrecord __Request__io_registry_entry_get_parent_iterator_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
)
(defrecord __Request__io_service_open_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (owningTask :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (connect_type :signed-long)
)
(defrecord __Request__io_service_close_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_connect_get_service_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_connect_set_notification_port_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (notification_type :signed-long)
   (reference :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__io_connect_map_memory_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (into_task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (memory_type :signed-long)
   (address :vm_address_t)
   (size :UInt32)
   (flags :signed-long)
)
(defrecord __Request__io_connect_add_client_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (connect_to :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Request__io_connect_set_properties_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (properties :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (propertiesCnt :UInt32)
)
(defrecord __Request__io_connect_method_scalarI_scalarO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :signed-long 16))
   (outputCnt :UInt32)
)
(defrecord __Request__io_connect_method_scalarI_structureO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :signed-long 16))
   (outputCnt :UInt32)
)
(defrecord __Request__io_connect_method_scalarI_structureI_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :signed-long 16))
   (inputStructCnt :UInt32)
   (inputStruct (:array :character 4096))
)
(defrecord __Request__io_connect_method_structureI_structureO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :character 4096))
   (outputCnt :UInt32)
)
(defrecord __Request__io_registry_entry_get_path_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
)
(defrecord __Request__io_registry_get_root_entry_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_registry_entry_set_properties_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (properties :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (propertiesCnt :UInt32)
)
(defrecord __Request__io_registry_entry_in_plane_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
)
(defrecord __Request__io_object_get_retain_count_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_service_get_busy_state_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_service_wait_quiet_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (wait_time :mach_timespec)
)
(defrecord __Request__io_registry_entry_create_iterator_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
   (options :signed-long)
)
(defrecord __Request__io_iterator_is_valid_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_make_matching_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (of_type :signed-long)
   (options :signed-long)
   (inputCnt :UInt32)
   (input (:array :character 4096))
)
(defrecord __Request__io_catalog_send_data_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (inData :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (flag :signed-long)
   (inDataCnt :UInt32)
)
(defrecord __Request__io_catalog_terminate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flag :signed-long)
   (nameOffset :UInt32)                         ;  MiG doesn't use it 
   (nameCnt :UInt32)
   (name (:array :character 128))
)
(defrecord __Request__io_catalog_get_data_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flag :signed-long)
)
(defrecord __Request__io_catalog_get_gen_count_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_catalog_module_loaded_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (nameOffset :UInt32)                         ;  MiG doesn't use it 
   (nameCnt :UInt32)
   (name (:array :character 128))
)
(defrecord __Request__io_catalog_reset_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (flag :signed-long)
)
(defrecord __Request__io_service_request_probe_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (options :signed-long)
)
(defrecord __Request__io_registry_entry_get_name_in_plane_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
)
(defrecord __Request__io_service_match_property_table_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (matchingOffset :UInt32)                     ;  MiG doesn't use it 
   (matchingCnt :UInt32)
   (matching (:array :character 512))
)
(defrecord __Request__io_async_method_scalarI_scalarO_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :signed-long 16))
   (outputCnt :UInt32)
)
(defrecord __Request__io_async_method_scalarI_structureO_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :signed-long 16))
   (outputCnt :UInt32)
)
(defrecord __Request__io_async_method_scalarI_structureI_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :signed-long 16))
   (inputStructCnt :UInt32)
   (inputStruct (:array :character 4096))
)
(defrecord __Request__io_async_method_structureI_structureO_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
   (selector :signed-long)
   (inputCnt :UInt32)
   (input (:array :character 4096))
   (outputCnt :UInt32)
)
(defrecord __Request__io_service_add_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (notification_typeOffset :UInt32)            ;  MiG doesn't use it 
   (notification_typeCnt :UInt32)
   (notification_type (:array :character 128))
   (matchingOffset :UInt32)                     ;  MiG doesn't use it 
   (matchingCnt :UInt32)
   (matching (:array :character 512))
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
)
(defrecord __Request__io_service_add_interest_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (type_of_interestOffset :UInt32)             ;  MiG doesn't use it 
   (type_of_interestCnt :UInt32)
   (type_of_interest (:array :character 128))
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
)
(defrecord __Request__io_service_acknowledge_notification_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (notify_ref :UInt32)
   (response :UInt32)
)
(defrecord __Request__io_connect_get_notification_semaphore_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (notification_type :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__io_connect_unmap_memory_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (into_task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (memory_type :signed-long)
   (address :vm_address_t)
)
(defrecord __Request__io_registry_entry_get_location_in_plane_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
)
(defrecord __Request__io_registry_entry_get_property_recursively_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (planeOffset :UInt32)                        ;  MiG doesn't use it 
   (planeCnt :UInt32)
   (plane (:array :character 128))
   (property_nameOffset :UInt32)                ;  MiG doesn't use it 
   (property_nameCnt :UInt32)
   (property_name (:array :character 128))
   (options :signed-long)
)
(defrecord __Request__io_service_get_state_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__io_service_get_matching_services_ool_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (matching :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (matchingCnt :UInt32)
)
(defrecord __Request__io_service_match_property_table_ool_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (matching :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (matchingCnt :UInt32)
)
(defrecord __Request__io_service_add_notification_ool_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (matching :MACH_MSG_OOL_DESCRIPTOR_T)
   (wake_port :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (notification_typeOffset :UInt32)            ;  MiG doesn't use it 
   (notification_typeCnt :UInt32)
   (notification_type (:array :character 128))
   (matchingCnt :UInt32)
   (referenceCnt :UInt32)
   (reference (:array :UInt32 8))
)

; #endif /* !__Request__iokit_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__iokit_subsystem__defined
; #define __RequestUnion__iokit_subsystem__defined
(defrecord __RequestUnion__iokit_subsystem
   (:variant
   (
   (Request_io_object_get_class :__REQUEST__IO_OBJECT_GET_CLASS_T)
   )
   (
   (Request_io_object_conforms_to :__REQUEST__IO_OBJECT_CONFORMS_TO_T)
   )
   (
   (Request_io_iterator_next :__REQUEST__IO_ITERATOR_NEXT_T)
   )
   (
   (Request_io_iterator_reset :__REQUEST__IO_ITERATOR_RESET_T)
   )
   (
   (Request_io_service_get_matching_services :__REQUEST__IO_SERVICE_GET_MATCHING_SERVICES_T)
   )
   (
   (Request_io_registry_entry_get_property :__REQUEST__IO_REGISTRY_ENTRY_GET_PROPERTY_T)
   )
   (
   (Request_io_registry_create_iterator :__REQUEST__IO_REGISTRY_CREATE_ITERATOR_T)
   )
   (
   (Request_io_registry_iterator_enter_entry :__REQUEST__IO_REGISTRY_ITERATOR_ENTER_ENTRY_T)
   )
   (
   (Request_io_registry_iterator_exit_entry :__REQUEST__IO_REGISTRY_ITERATOR_EXIT_ENTRY_T)
   )
   (
   (Request_io_registry_entry_from_path :__REQUEST__IO_REGISTRY_ENTRY_FROM_PATH_T)
   )
   (
   (Request_io_registry_entry_get_name :__REQUEST__IO_REGISTRY_ENTRY_GET_NAME_T)
   )
   (
   (Request_io_registry_entry_get_properties :__REQUEST__IO_REGISTRY_ENTRY_GET_PROPERTIES_T)
   )
   (
   (Request_io_registry_entry_get_property_bytes :__REQUEST__IO_REGISTRY_ENTRY_GET_PROPERTY_BYTES_T)
   )
   (
   (Request_io_registry_entry_get_child_iterator :__REQUEST__IO_REGISTRY_ENTRY_GET_CHILD_ITERATOR_T)
   )
   (
   (Request_io_registry_entry_get_parent_iterator :__REQUEST__IO_REGISTRY_ENTRY_GET_PARENT_ITERATOR_T)
   )
   (
   (Request_io_service_open :__REQUEST__IO_SERVICE_OPEN_T)
   )
   (
   (Request_io_service_close :__REQUEST__IO_SERVICE_CLOSE_T)
   )
   (
   (Request_io_connect_get_service :__REQUEST__IO_CONNECT_GET_SERVICE_T)
   )
   (
   (Request_io_connect_set_notification_port :__REQUEST__IO_CONNECT_SET_NOTIFICATION_PORT_T)
   )
   (
   (Request_io_connect_map_memory :__REQUEST__IO_CONNECT_MAP_MEMORY_T)
   )
   (
   (Request_io_connect_add_client :__REQUEST__IO_CONNECT_ADD_CLIENT_T)
   )
   (
   (Request_io_connect_set_properties :__REQUEST__IO_CONNECT_SET_PROPERTIES_T)
   )
   (
   (Request_io_connect_method_scalarI_scalarO :__REQUEST__IO_CONNECT_METHOD_SCALARI_SCALARO_T)
   )
   (
   (Request_io_connect_method_scalarI_structureO :__REQUEST__IO_CONNECT_METHOD_SCALARI_STRUCTUREO_T)
   )
   (
   (Request_io_connect_method_scalarI_structureI :__REQUEST__IO_CONNECT_METHOD_SCALARI_STRUCTUREI_T)
   )
   (
   (Request_io_connect_method_structureI_structureO :__REQUEST__IO_CONNECT_METHOD_STRUCTUREI_STRUCTUREO_T)
   )
   (
   (Request_io_registry_entry_get_path :__REQUEST__IO_REGISTRY_ENTRY_GET_PATH_T)
   )
   (
   (Request_io_registry_get_root_entry :__REQUEST__IO_REGISTRY_GET_ROOT_ENTRY_T)
   )
   (
   (Request_io_registry_entry_set_properties :__REQUEST__IO_REGISTRY_ENTRY_SET_PROPERTIES_T)
   )
   (
   (Request_io_registry_entry_in_plane :__REQUEST__IO_REGISTRY_ENTRY_IN_PLANE_T)
   )
   (
   (Request_io_object_get_retain_count :__REQUEST__IO_OBJECT_GET_RETAIN_COUNT_T)
   )
   (
   (Request_io_service_get_busy_state :__REQUEST__IO_SERVICE_GET_BUSY_STATE_T)
   )
   (
   (Request_io_service_wait_quiet :__REQUEST__IO_SERVICE_WAIT_QUIET_T)
   )
   (
   (Request_io_registry_entry_create_iterator :__REQUEST__IO_REGISTRY_ENTRY_CREATE_ITERATOR_T)
   )
   (
   (Request_io_iterator_is_valid :__REQUEST__IO_ITERATOR_IS_VALID_T)
   )
   (
   (Request_io_make_matching :__REQUEST__IO_MAKE_MATCHING_T)
   )
   (
   (Request_io_catalog_send_data :__REQUEST__IO_CATALOG_SEND_DATA_T)
   )
   (
   (Request_io_catalog_terminate :__REQUEST__IO_CATALOG_TERMINATE_T)
   )
   (
   (Request_io_catalog_get_data :__REQUEST__IO_CATALOG_GET_DATA_T)
   )
   (
   (Request_io_catalog_get_gen_count :__REQUEST__IO_CATALOG_GET_GEN_COUNT_T)
   )
   (
   (Request_io_catalog_module_loaded :__REQUEST__IO_CATALOG_MODULE_LOADED_T)
   )
   (
   (Request_io_catalog_reset :__REQUEST__IO_CATALOG_RESET_T)
   )
   (
   (Request_io_service_request_probe :__REQUEST__IO_SERVICE_REQUEST_PROBE_T)
   )
   (
   (Request_io_registry_entry_get_name_in_plane :__REQUEST__IO_REGISTRY_ENTRY_GET_NAME_IN_PLANE_T)
   )
   (
   (Request_io_service_match_property_table :__REQUEST__IO_SERVICE_MATCH_PROPERTY_TABLE_T)
   )
   (
   (Request_io_async_method_scalarI_scalarO :__REQUEST__IO_ASYNC_METHOD_SCALARI_SCALARO_T)
   )
   (
   (Request_io_async_method_scalarI_structureO :__REQUEST__IO_ASYNC_METHOD_SCALARI_STRUCTUREO_T)
   )
   (
   (Request_io_async_method_scalarI_structureI :__REQUEST__IO_ASYNC_METHOD_SCALARI_STRUCTUREI_T)
   )
   (
   (Request_io_async_method_structureI_structureO :__REQUEST__IO_ASYNC_METHOD_STRUCTUREI_STRUCTUREO_T)
   )
   (
   (Request_io_service_add_notification :__REQUEST__IO_SERVICE_ADD_NOTIFICATION_T)
   )
   (
   (Request_io_service_add_interest_notification :__REQUEST__IO_SERVICE_ADD_INTEREST_NOTIFICATION_T)
   )
   (
   (Request_io_service_acknowledge_notification :__REQUEST__IO_SERVICE_ACKNOWLEDGE_NOTIFICATION_T)
   )
   (
   (Request_io_connect_get_notification_semaphore :__REQUEST__IO_CONNECT_GET_NOTIFICATION_SEMAPHORE_T)
   )
   (
   (Request_io_connect_unmap_memory :__REQUEST__IO_CONNECT_UNMAP_MEMORY_T)
   )
   (
   (Request_io_registry_entry_get_location_in_plane :__REQUEST__IO_REGISTRY_ENTRY_GET_LOCATION_IN_PLANE_T)
   )
   (
   (Request_io_registry_entry_get_property_recursively :__REQUEST__IO_REGISTRY_ENTRY_GET_PROPERTY_RECURSIVELY_T)
   )
   (
   (Request_io_service_get_state :__REQUEST__IO_SERVICE_GET_STATE_T)
   )
   (
   (Request_io_service_get_matching_services_ool :__REQUEST__IO_SERVICE_GET_MATCHING_SERVICES_OOL_T)
   )
   (
   (Request_io_service_match_property_table_ool :__REQUEST__IO_SERVICE_MATCH_PROPERTY_TABLE_OOL_T)
   )
   (
   (Request_io_service_add_notification_ool :__REQUEST__IO_SERVICE_ADD_NOTIFICATION_OOL_T)
   )
   )
)

; #endif /* !__RequestUnion__iokit_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__iokit_subsystem__defined
; #define __Reply__iokit_subsystem__defined
(defrecord __Reply__io_object_get_class_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (classNameOffset :UInt32)                    ;  MiG doesn't use it 
   (classNameCnt :UInt32)
   (className (:array :character 128))
)
(defrecord __Reply__io_object_conforms_to_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (conforms :signed-long)
)
(defrecord __Reply__io_iterator_next_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_iterator_reset_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_service_get_matching_services_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (existing :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_registry_entry_get_property_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (properties :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (propertiesCnt :UInt32)
)
(defrecord __Reply__io_registry_create_iterator_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (iterator :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_registry_iterator_enter_entry_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_registry_iterator_exit_entry_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_registry_entry_from_path_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (registry_entry :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_registry_entry_get_name_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (nameOffset :UInt32)                         ;  MiG doesn't use it 
   (nameCnt :UInt32)
   (name (:array :character 128))
)
(defrecord __Reply__io_registry_entry_get_properties_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (properties :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (propertiesCnt :UInt32)
)
(defrecord __Reply__io_registry_entry_get_property_bytes_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (dataCnt :UInt32)
   (data (:array :character 4096))
)
(defrecord __Reply__io_registry_entry_get_child_iterator_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (iterator :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_registry_entry_get_parent_iterator_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (iterator :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_service_open_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (connection :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_service_close_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_connect_get_service_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (service :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_connect_set_notification_port_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__io_connect_map_memory_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
   (size :UInt32)
)
(defrecord __Reply__io_connect_add_client_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_connect_set_properties_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (result :UInt32)
)
(defrecord __Reply__io_connect_method_scalarI_scalarO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outputCnt :UInt32)
   (output (:array :signed-long 16))
)
(defrecord __Reply__io_connect_method_scalarI_structureO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outputCnt :UInt32)
   (output (:array :character 4096))
)
(defrecord __Reply__io_connect_method_scalarI_structureI_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_connect_method_structureI_structureO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outputCnt :UInt32)
   (output (:array :character 4096))
)
(defrecord __Reply__io_registry_entry_get_path_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (pathOffset :UInt32)                         ;  MiG doesn't use it 
   (pathCnt :UInt32)
   (path (:array :character 512))
)
(defrecord __Reply__io_registry_get_root_entry_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (root :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_registry_entry_set_properties_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (result :UInt32)
)
(defrecord __Reply__io_registry_entry_in_plane_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (inPlane :signed-long)
)
(defrecord __Reply__io_object_get_retain_count_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (retainCount :signed-long)
)
(defrecord __Reply__io_service_get_busy_state_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (busyState :signed-long)
)
(defrecord __Reply__io_service_wait_quiet_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_registry_entry_create_iterator_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (iterator :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_iterator_is_valid_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (is_valid :signed-long)
)
(defrecord __Reply__io_make_matching_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (matchingOffset :UInt32)                     ;  MiG doesn't use it 
   (matchingCnt :UInt32)
   (matching (:array :character 512))
)
(defrecord __Reply__io_catalog_send_data_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (result :UInt32)
)
(defrecord __Reply__io_catalog_terminate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_catalog_get_data_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (outData :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (outDataCnt :UInt32)
)
(defrecord __Reply__io_catalog_get_gen_count_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (genCount :signed-long)
)
(defrecord __Reply__io_catalog_module_loaded_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_catalog_reset_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_service_request_probe_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_registry_entry_get_name_in_plane_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (nameOffset :UInt32)                         ;  MiG doesn't use it 
   (nameCnt :UInt32)
   (name (:array :character 128))
)
(defrecord __Reply__io_service_match_property_table_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (matches :signed-long)
)
(defrecord __Reply__io_async_method_scalarI_scalarO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outputCnt :UInt32)
   (output (:array :signed-long 16))
)
(defrecord __Reply__io_async_method_scalarI_structureO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outputCnt :UInt32)
   (output (:array :character 4096))
)
(defrecord __Reply__io_async_method_scalarI_structureI_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_async_method_structureI_structureO_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outputCnt :UInt32)
   (output (:array :character 4096))
)
(defrecord __Reply__io_service_add_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (notification :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_service_add_interest_notification_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (notification :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_service_acknowledge_notification_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_connect_get_notification_semaphore_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (semaphore :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
(defrecord __Reply__io_connect_unmap_memory_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__io_registry_entry_get_location_in_plane_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (locationOffset :UInt32)                     ;  MiG doesn't use it 
   (locationCnt :UInt32)
   (location (:array :character 128))
)
(defrecord __Reply__io_registry_entry_get_property_recursively_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (properties :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (propertiesCnt :UInt32)
)
(defrecord __Reply__io_service_get_state_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (state :uint64_t)
)
(defrecord __Reply__io_service_get_matching_services_ool_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (existing :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (result :UInt32)
)
(defrecord __Reply__io_service_match_property_table_ool_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (result :UInt32)
   (matches :signed-long)
)
(defrecord __Reply__io_service_add_notification_ool_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (notification :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (result :UInt32)
)

; #endif /* !__Reply__iokit_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__iokit_subsystem__defined
; #define __ReplyUnion__iokit_subsystem__defined
(defrecord __ReplyUnion__iokit_subsystem
   (:variant
   (
   (Reply_io_object_get_class :__REPLY__IO_OBJECT_GET_CLASS_T)
   )
   (
   (Reply_io_object_conforms_to :__REPLY__IO_OBJECT_CONFORMS_TO_T)
   )
   (
   (Reply_io_iterator_next :__REPLY__IO_ITERATOR_NEXT_T)
   )
   (
   (Reply_io_iterator_reset :__REPLY__IO_ITERATOR_RESET_T)
   )
   (
   (Reply_io_service_get_matching_services :__REPLY__IO_SERVICE_GET_MATCHING_SERVICES_T)
   )
   (
   (Reply_io_registry_entry_get_property :__REPLY__IO_REGISTRY_ENTRY_GET_PROPERTY_T)
   )
   (
   (Reply_io_registry_create_iterator :__REPLY__IO_REGISTRY_CREATE_ITERATOR_T)
   )
   (
   (Reply_io_registry_iterator_enter_entry :__REPLY__IO_REGISTRY_ITERATOR_ENTER_ENTRY_T)
   )
   (
   (Reply_io_registry_iterator_exit_entry :__REPLY__IO_REGISTRY_ITERATOR_EXIT_ENTRY_T)
   )
   (
   (Reply_io_registry_entry_from_path :__REPLY__IO_REGISTRY_ENTRY_FROM_PATH_T)
   )
   (
   (Reply_io_registry_entry_get_name :__REPLY__IO_REGISTRY_ENTRY_GET_NAME_T)
   )
   (
   (Reply_io_registry_entry_get_properties :__REPLY__IO_REGISTRY_ENTRY_GET_PROPERTIES_T)
   )
   (
   (Reply_io_registry_entry_get_property_bytes :__REPLY__IO_REGISTRY_ENTRY_GET_PROPERTY_BYTES_T)
   )
   (
   (Reply_io_registry_entry_get_child_iterator :__REPLY__IO_REGISTRY_ENTRY_GET_CHILD_ITERATOR_T)
   )
   (
   (Reply_io_registry_entry_get_parent_iterator :__REPLY__IO_REGISTRY_ENTRY_GET_PARENT_ITERATOR_T)
   )
   (
   (Reply_io_service_open :__REPLY__IO_SERVICE_OPEN_T)
   )
   (
   (Reply_io_service_close :__REPLY__IO_SERVICE_CLOSE_T)
   )
   (
   (Reply_io_connect_get_service :__REPLY__IO_CONNECT_GET_SERVICE_T)
   )
   (
   (Reply_io_connect_set_notification_port :__REPLY__IO_CONNECT_SET_NOTIFICATION_PORT_T)
   )
   (
   (Reply_io_connect_map_memory :__REPLY__IO_CONNECT_MAP_MEMORY_T)
   )
   (
   (Reply_io_connect_add_client :__REPLY__IO_CONNECT_ADD_CLIENT_T)
   )
   (
   (Reply_io_connect_set_properties :__REPLY__IO_CONNECT_SET_PROPERTIES_T)
   )
   (
   (Reply_io_connect_method_scalarI_scalarO :__REPLY__IO_CONNECT_METHOD_SCALARI_SCALARO_T)
   )
   (
   (Reply_io_connect_method_scalarI_structureO :__REPLY__IO_CONNECT_METHOD_SCALARI_STRUCTUREO_T)
   )
   (
   (Reply_io_connect_method_scalarI_structureI :__REPLY__IO_CONNECT_METHOD_SCALARI_STRUCTUREI_T)
   )
   (
   (Reply_io_connect_method_structureI_structureO :__REPLY__IO_CONNECT_METHOD_STRUCTUREI_STRUCTUREO_T)
   )
   (
   (Reply_io_registry_entry_get_path :__REPLY__IO_REGISTRY_ENTRY_GET_PATH_T)
   )
   (
   (Reply_io_registry_get_root_entry :__REPLY__IO_REGISTRY_GET_ROOT_ENTRY_T)
   )
   (
   (Reply_io_registry_entry_set_properties :__REPLY__IO_REGISTRY_ENTRY_SET_PROPERTIES_T)
   )
   (
   (Reply_io_registry_entry_in_plane :__REPLY__IO_REGISTRY_ENTRY_IN_PLANE_T)
   )
   (
   (Reply_io_object_get_retain_count :__REPLY__IO_OBJECT_GET_RETAIN_COUNT_T)
   )
   (
   (Reply_io_service_get_busy_state :__REPLY__IO_SERVICE_GET_BUSY_STATE_T)
   )
   (
   (Reply_io_service_wait_quiet :__REPLY__IO_SERVICE_WAIT_QUIET_T)
   )
   (
   (Reply_io_registry_entry_create_iterator :__REPLY__IO_REGISTRY_ENTRY_CREATE_ITERATOR_T)
   )
   (
   (Reply_io_iterator_is_valid :__REPLY__IO_ITERATOR_IS_VALID_T)
   )
   (
   (Reply_io_make_matching :__REPLY__IO_MAKE_MATCHING_T)
   )
   (
   (Reply_io_catalog_send_data :__REPLY__IO_CATALOG_SEND_DATA_T)
   )
   (
   (Reply_io_catalog_terminate :__REPLY__IO_CATALOG_TERMINATE_T)
   )
   (
   (Reply_io_catalog_get_data :__REPLY__IO_CATALOG_GET_DATA_T)
   )
   (
   (Reply_io_catalog_get_gen_count :__REPLY__IO_CATALOG_GET_GEN_COUNT_T)
   )
   (
   (Reply_io_catalog_module_loaded :__REPLY__IO_CATALOG_MODULE_LOADED_T)
   )
   (
   (Reply_io_catalog_reset :__REPLY__IO_CATALOG_RESET_T)
   )
   (
   (Reply_io_service_request_probe :__REPLY__IO_SERVICE_REQUEST_PROBE_T)
   )
   (
   (Reply_io_registry_entry_get_name_in_plane :__REPLY__IO_REGISTRY_ENTRY_GET_NAME_IN_PLANE_T)
   )
   (
   (Reply_io_service_match_property_table :__REPLY__IO_SERVICE_MATCH_PROPERTY_TABLE_T)
   )
   (
   (Reply_io_async_method_scalarI_scalarO :__REPLY__IO_ASYNC_METHOD_SCALARI_SCALARO_T)
   )
   (
   (Reply_io_async_method_scalarI_structureO :__REPLY__IO_ASYNC_METHOD_SCALARI_STRUCTUREO_T)
   )
   (
   (Reply_io_async_method_scalarI_structureI :__REPLY__IO_ASYNC_METHOD_SCALARI_STRUCTUREI_T)
   )
   (
   (Reply_io_async_method_structureI_structureO :__REPLY__IO_ASYNC_METHOD_STRUCTUREI_STRUCTUREO_T)
   )
   (
   (Reply_io_service_add_notification :__REPLY__IO_SERVICE_ADD_NOTIFICATION_T)
   )
   (
   (Reply_io_service_add_interest_notification :__REPLY__IO_SERVICE_ADD_INTEREST_NOTIFICATION_T)
   )
   (
   (Reply_io_service_acknowledge_notification :__REPLY__IO_SERVICE_ACKNOWLEDGE_NOTIFICATION_T)
   )
   (
   (Reply_io_connect_get_notification_semaphore :__REPLY__IO_CONNECT_GET_NOTIFICATION_SEMAPHORE_T)
   )
   (
   (Reply_io_connect_unmap_memory :__REPLY__IO_CONNECT_UNMAP_MEMORY_T)
   )
   (
   (Reply_io_registry_entry_get_location_in_plane :__REPLY__IO_REGISTRY_ENTRY_GET_LOCATION_IN_PLANE_T)
   )
   (
   (Reply_io_registry_entry_get_property_recursively :__REPLY__IO_REGISTRY_ENTRY_GET_PROPERTY_RECURSIVELY_T)
   )
   (
   (Reply_io_service_get_state :__REPLY__IO_SERVICE_GET_STATE_T)
   )
   (
   (Reply_io_service_get_matching_services_ool :__REPLY__IO_SERVICE_GET_MATCHING_SERVICES_OOL_T)
   )
   (
   (Reply_io_service_match_property_table_ool :__REPLY__IO_SERVICE_MATCH_PROPERTY_TABLE_OOL_T)
   )
   (
   (Reply_io_service_add_notification_ool :__REPLY__IO_SERVICE_ADD_NOTIFICATION_OOL_T)
   )
   )
)

; #endif /* !__RequestUnion__iokit_subsystem__defined */

; #ifndef subsystem_to_name_map_iokit
; #define subsystem_to_name_map_iokit     { "io_object_get_class", 2800 },    { "io_object_conforms_to", 2801 },    { "io_iterator_next", 2802 },    { "io_iterator_reset", 2803 },    { "io_service_get_matching_services", 2804 },    { "io_registry_entry_get_property", 2805 },    { "io_registry_create_iterator", 2806 },    { "io_registry_iterator_enter_entry", 2807 },    { "io_registry_iterator_exit_entry", 2808 },    { "io_registry_entry_from_path", 2809 },    { "io_registry_entry_get_name", 2810 },    { "io_registry_entry_get_properties", 2811 },    { "io_registry_entry_get_property_bytes", 2812 },    { "io_registry_entry_get_child_iterator", 2813 },    { "io_registry_entry_get_parent_iterator", 2814 },    { "io_service_open", 2815 },    { "io_service_close", 2816 },    { "io_connect_get_service", 2817 },    { "io_connect_set_notification_port", 2818 },    { "io_connect_map_memory", 2819 },    { "io_connect_add_client", 2820 },    { "io_connect_set_properties", 2821 },    { "io_connect_method_scalarI_scalarO", 2822 },    { "io_connect_method_scalarI_structureO", 2823 },    { "io_connect_method_scalarI_structureI", 2824 },    { "io_connect_method_structureI_structureO", 2825 },    { "io_registry_entry_get_path", 2826 },    { "io_registry_get_root_entry", 2827 },    { "io_registry_entry_set_properties", 2828 },    { "io_registry_entry_in_plane", 2829 },    { "io_object_get_retain_count", 2830 },    { "io_service_get_busy_state", 2831 },    { "io_service_wait_quiet", 2832 },    { "io_registry_entry_create_iterator", 2833 },    { "io_iterator_is_valid", 2834 },    { "io_make_matching", 2835 },    { "io_catalog_send_data", 2836 },    { "io_catalog_terminate", 2837 },    { "io_catalog_get_data", 2838 },    { "io_catalog_get_gen_count", 2839 },    { "io_catalog_module_loaded", 2840 },    { "io_catalog_reset", 2841 },    { "io_service_request_probe", 2842 },    { "io_registry_entry_get_name_in_plane", 2843 },    { "io_service_match_property_table", 2844 },    { "io_async_method_scalarI_scalarO", 2845 },    { "io_async_method_scalarI_structureO", 2846 },    { "io_async_method_scalarI_structureI", 2847 },    { "io_async_method_structureI_structureO", 2848 },    { "io_service_add_notification", 2849 },    { "io_service_add_interest_notification", 2850 },    { "io_service_acknowledge_notification", 2851 },    { "io_connect_get_notification_semaphore", 2852 },    { "io_connect_unmap_memory", 2853 },    { "io_registry_entry_get_location_in_plane", 2854 },    { "io_registry_entry_get_property_recursively", 2855 },    { "io_service_get_state", 2856 },    { "io_service_get_matching_services_ool", 2857 },    { "io_service_match_property_table_ool", 2858 },    { "io_service_add_notification_ool", 2859 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _iokit_user_ */


(provide-interface "iokitmig_c")