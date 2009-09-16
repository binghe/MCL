(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vm_map.h"
; at Sunday July 2,2006 7:26:26 pm.
; #ifndef	_vm_map_user_
; #define	_vm_map_user_
;  Module vm_map 

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
; #ifndef	vm_map_MSG_COUNT
(defconstant $vm_map_MSG_COUNT 30)
; #define	vm_map_MSG_COUNT	30

; #endif	/* vm_map_MSG_COUNT */


(require-interface "mach/std_types")

(require-interface "mach/mig")

(require-interface "mach/mig")

(require-interface "mach/mach_types")

(require-interface "mach_debug/mach_debug_types")
; #ifdef __BeforeMigUserHeader
#| #|
__BeforeMigUserHeader
#endif
|#
 |#
;  __BeforeMigUserHeader 

(require-interface "sys/cdefs")
;  Routine vm_region 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_region" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size (:pointer :VM_SIZE_T))
    (flavor :signed-long)
    (info (:pointer :signed-long))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (object_name (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine vm_allocate 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_allocate" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size :UInt32)
    (flags :signed-long)
   )
   :signed-long
() )
;  Routine vm_deallocate 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_deallocate" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
   )
   :signed-long
() )
;  Routine vm_protect 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_protect" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (set_maximum :signed-long)
    (new_protection :signed-long)
   )
   :signed-long
() )
;  Routine vm_inherit 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_inherit" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (new_inheritance :UInt32)
   )
   :signed-long
() )
;  Routine vm_read 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_read" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (data (:pointer :vm_offset_t))
    (dataCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine vm_read_list 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_read_list" 
   ((target_task :vm_map_t)
    (data_list (:pointer :VM_READ_ENTRY_T))
    (count :UInt32)
   )
   :signed-long
() )
;  Routine vm_write 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_write" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (data :UInt32)
    (dataCnt :UInt32)
   )
   :signed-long
() )
;  Routine vm_copy 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_copy" 
   ((target_task :vm_map_t)
    (source_address :vm_address_t)
    (size :UInt32)
    (dest_address :vm_address_t)
   )
   :signed-long
() )
;  Routine vm_read_overwrite 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_read_overwrite" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (data :vm_address_t)
    (outsize (:pointer :VM_SIZE_T))
   )
   :signed-long
() )
;  Routine vm_msync 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_msync" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (sync_flags :UInt32)
   )
   :signed-long
() )
;  Routine vm_behavior_set 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_behavior_set" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (new_behavior :signed-long)
   )
   :signed-long
() )
;  Routine vm_map 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_map" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size :UInt32)
    (mask :vm_address_t)
    (flags :signed-long)
    (object :pointer)
    (offset :UInt32)
    (copy :signed-long)
    (cur_protection :signed-long)
    (max_protection :signed-long)
    (inheritance :UInt32)
   )
   :signed-long
() )
;  Routine vm_machine_attribute 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_machine_attribute" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size :UInt32)
    (attribute :UInt32)
    (value (:pointer :VM_MACHINE_ATTRIBUTE_VAL_T))
   )
   :signed-long
() )
;  Routine vm_remap 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_remap" 
   ((target_task :vm_map_t)
    (target_address (:pointer :vm_address_t))
    (size :UInt32)
    (mask :vm_address_t)
    (anywhere :signed-long)
    (src_task :vm_map_t)
    (src_address :vm_address_t)
    (copy :signed-long)
    (cur_protection (:pointer :VM_PROT_T))
    (max_protection (:pointer :VM_PROT_T))
    (inheritance :UInt32)
   )
   :signed-long
() )
;  Routine task_wire 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_task_wire" 
   ((target_task :vm_map_t)
    (must_wire :signed-long)
   )
   :signed-long
() )
;  Routine mach_make_memory_entry 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_make_memory_entry" 
   ((target_task :vm_map_t)
    (size (:pointer :VM_SIZE_T))
    (offset :UInt32)
    (permission :signed-long)
    (object_handle (:pointer :mach_port_t))
    (parent_entry :pointer)
   )
   :signed-long
() )
;  Routine vm_map_page_query 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_map_page_query" 
   ((target_map :vm_map_t)
    (offset :UInt32)
    (disposition (:pointer :integer_t))
    (ref_count (:pointer :integer_t))
   )
   :signed-long
() )
;  Routine mach_vm_region_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_vm_region_info" 
   ((task :vm_map_t)
    (address :vm_address_t)
    (region (:pointer :VM_INFO_REGION_T))
    (objects (:pointer :VM_INFO_OBJECT_ARRAY_T))
    (objectsCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine vm_mapped_pages_info 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_mapped_pages_info" 
   ((task :vm_map_t)
    (pages (:pointer :PAGE_ADDRESS_ARRAY_T))
    (pagesCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine vm_region_object_create 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_region_object_create" 
   ((target_task :vm_map_t)
    (size :UInt32)
    (region_object (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine vm_region_recurse 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_region_recurse" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size (:pointer :VM_SIZE_T))
    (nesting_depth (:pointer :natural_t))
    (info (:pointer :signed-long))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine vm_region_recurse_64 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_region_recurse_64" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size (:pointer :VM_SIZE_T))
    (nesting_depth (:pointer :natural_t))
    (info (:pointer :signed-long))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine mach_vm_region_info_64 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_vm_region_info_64" 
   ((task :vm_map_t)
    (address :vm_address_t)
    (region (:pointer :VM_INFO_REGION_64_T))
    (objects (:pointer :VM_INFO_OBJECT_ARRAY_T))
    (objectsCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
   )
   :signed-long
() )
;  Routine vm_region_64 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_region_64" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size (:pointer :VM_SIZE_T))
    (flavor :signed-long)
    (info (:pointer :signed-long))
    (infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (object_name (:pointer :mach_port_t))
   )
   :signed-long
() )
;  Routine mach_make_memory_entry_64 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_mach_make_memory_entry_64" 
   ((target_task :vm_map_t)
    (size (:pointer :memory_object_size_t))
    (offset :memory_object_offset_t)
    (permission :signed-long)
    (object_handle (:pointer :mach_port_t))
    (parent_entry :pointer)
   )
   :signed-long
() )
;  Routine vm_map_64 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_map_64" 
   ((target_task :vm_map_t)
    (address (:pointer :vm_address_t))
    (size :UInt32)
    (mask :vm_address_t)
    (flags :signed-long)
    (object :pointer)
    (offset :memory_object_offset_t)
    (copy :signed-long)
    (cur_protection :signed-long)
    (max_protection :signed-long)
    (inheritance :UInt32)
   )
   :signed-long
() )
;  Routine vm_map_get_upl 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_map_get_upl" 
   ((target_task :vm_map_t)
    (address :vm_address_t)
    (size (:pointer :VM_SIZE_T))
    (upl (:pointer :upl_t))
    (page_info :upl_page_info_array_t)
    (page_infoCnt (:pointer :MACH_MSG_TYPE_NUMBER_T))
    (flags (:pointer :integer_t))
    (force_data_sync :signed-long)
   )
   :signed-long
() )
;  Routine vm_upl_map 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_upl_map" 
   ((target_task :vm_map_t)
    (upl :upl_t)
    (address (:pointer :vm_address_t))
   )
   :signed-long
() )
;  Routine vm_upl_unmap 
; #ifdef	mig_external
#| #|
mig_external
|#
 |#

; #else

; #endif	/* mig_external */


(deftrap-inline "_vm_upl_unmap" 
   ((target_task :vm_map_t)
    (upl :upl_t)
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
; #ifndef __Request__vm_map_subsystem__defined
; #define __Request__vm_map_subsystem__defined
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_region_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (flavor :signed-long)
   (infoCnt :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_allocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (flags :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_deallocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_protect_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (set_maximum :signed-long)
   (new_protection :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_inherit_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (new_inheritance :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_read_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
)
(defrecord __Request__vm_read_list_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (data_list :VM_READ_ENTRY_T)
   (count :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_write_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (data :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (dataCnt :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_copy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (source_address :vm_address_t)
   (size :UInt32)
   (dest_address :vm_address_t)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_read_overwrite_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (data :vm_address_t)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_msync_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (sync_flags :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_behavior_set_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (new_behavior :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_map_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (mask :vm_address_t)
   (flags :signed-long)
   (offset :UInt32)
   (copy :signed-long)
   (cur_protection :signed-long)
   (max_protection :signed-long)
   (inheritance :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_machine_attribute_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (attribute :UInt32)
   (value :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_remap_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (src_task :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (target_address :vm_address_t)
   (size :UInt32)
   (mask :vm_address_t)
   (anywhere :signed-long)
   (src_address :vm_address_t)
   (copy :signed-long)
   (inheritance :UInt32)
)
(defrecord __Request__task_wire_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (must_wire :signed-long)
)
(defrecord __Request__mach_make_memory_entry_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (parent_entry :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (size :UInt32)
   (offset :UInt32)
   (permission :signed-long)
)
(defrecord __Request__vm_map_page_query_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (offset :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__mach_vm_region_info_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
)
(defrecord __Request__vm_mapped_pages_info_t
   (Head :MACH_MSG_HEADER_T)
)
(defrecord __Request__vm_region_object_create_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (size :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_region_recurse_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (nesting_depth :UInt32)
   (infoCnt :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_region_recurse_64_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (nesting_depth :UInt32)
   (infoCnt :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__mach_vm_region_info_64_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_region_64_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (flavor :signed-long)
   (infoCnt :UInt32)
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_SIZE_T
|#
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__mach_make_memory_entry_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (parent_entry :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (size :memory_object_size_t)
   (offset :memory_object_offset_t)
   (permission :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
#|
; Warning: type-size: unknown type MEMORY_OBJECT_OFFSET_T
|#
(defrecord __Request__vm_map_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (mask :vm_address_t)
   (flags :signed-long)
   (offset :memory_object_offset_t)
   (copy :signed-long)
   (cur_protection :signed-long)
   (max_protection :signed-long)
   (inheritance :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_map_get_upl_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (page_infoCnt :UInt32)
   (flags :signed-long)
   (force_data_sync :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Request__vm_upl_map_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (upl :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
)
(defrecord __Request__vm_upl_unmap_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (upl :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)

; #endif /* !__Request__vm_map_subsystem__defined */

;  union of all requests 
; #ifndef __RequestUnion__vm_map_subsystem__defined
; #define __RequestUnion__vm_map_subsystem__defined
(defrecord __RequestUnion__vm_map_subsystem
   (:variant
   (
   (Request_vm_region :__REQUEST__VM_REGION_T)
   )
   (
   (Request_vm_allocate :__REQUEST__VM_ALLOCATE_T)
   )
   (
   (Request_vm_deallocate :__REQUEST__VM_DEALLOCATE_T)
   )
   (
   (Request_vm_protect :__REQUEST__VM_PROTECT_T)
   )
   (
   (Request_vm_inherit :__REQUEST__VM_INHERIT_T)
   )
   (
   (Request_vm_read :__REQUEST__VM_READ_T)
   )
   (
   (Request_vm_read_list :__REQUEST__VM_READ_LIST_T)
   )
   (
   (Request_vm_write :__REQUEST__VM_WRITE_T)
   )
   (
   (Request_vm_copy :__REQUEST__VM_COPY_T)
   )
   (
   (Request_vm_read_overwrite :__REQUEST__VM_READ_OVERWRITE_T)
   )
   (
   (Request_vm_msync :__REQUEST__VM_MSYNC_T)
   )
   (
   (Request_vm_behavior_set :__REQUEST__VM_BEHAVIOR_SET_T)
   )
   (
   (Request_vm_map :__REQUEST__VM_MAP_T)
   )
   (
   (Request_vm_machine_attribute :__REQUEST__VM_MACHINE_ATTRIBUTE_T)
   )
   (
   (Request_vm_remap :__REQUEST__VM_REMAP_T)
   )
   (
   (Request_task_wire :__REQUEST__TASK_WIRE_T)
   )
   (
   (Request_mach_make_memory_entry :__REQUEST__MACH_MAKE_MEMORY_ENTRY_T)
   )
   (
   (Request_vm_map_page_query :__REQUEST__VM_MAP_PAGE_QUERY_T)
   )
   (
   (Request_mach_vm_region_info :__REQUEST__MACH_VM_REGION_INFO_T)
   )
   (
   (Request_vm_mapped_pages_info :__REQUEST__VM_MAPPED_PAGES_INFO_T)
   )
   (
   (Request_vm_region_object_create :__REQUEST__VM_REGION_OBJECT_CREATE_T)
   )
   (
   (Request_vm_region_recurse :__REQUEST__VM_REGION_RECURSE_T)
   )
   (
   (Request_vm_region_recurse_64 :__REQUEST__VM_REGION_RECURSE_64_T)
   )
   (
   (Request_mach_vm_region_info_64 :__REQUEST__MACH_VM_REGION_INFO_64_T)
   )
   (
   (Request_vm_region_64 :__REQUEST__VM_REGION_64_T)
   )
   (
   (Request_mach_make_memory_entry_64 :__REQUEST__MACH_MAKE_MEMORY_ENTRY_64_T)
   )
   (
   (Request_vm_map_64 :__REQUEST__VM_MAP_64_T)
   )
   (
   (Request_vm_map_get_upl :__REQUEST__VM_MAP_GET_UPL_T)
   )
   (
   (Request_vm_upl_map :__REQUEST__VM_UPL_MAP_T)
   )
   (
   (Request_vm_upl_unmap :__REQUEST__VM_UPL_UNMAP_T)
   )
   )
)

; #endif /* !__RequestUnion__vm_map_subsystem__defined */

;  typedefs for all replies 
; #ifndef __Reply__vm_map_subsystem__defined
; #define __Reply__vm_map_subsystem__defined
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_region_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object_name :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (infoCnt :UInt32)
   (info (:array :signed-long 9))
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_allocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
)
(defrecord __Reply__vm_deallocate_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__vm_protect_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__vm_inherit_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__vm_read_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (data :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (dataCnt :UInt32)
)
(defrecord __Reply__vm_read_list_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (data_list :VM_READ_ENTRY_T)
)
(defrecord __Reply__vm_write_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__vm_copy_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__vm_read_overwrite_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (outsize :UInt32)
)
(defrecord __Reply__vm_msync_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__vm_behavior_set_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_map_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
)
(defrecord __Reply__vm_machine_attribute_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (value :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_remap_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (target_address :vm_address_t)
   (cur_protection :signed-long)
   (max_protection :signed-long)
)
(defrecord __Reply__task_wire_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)
(defrecord __Reply__mach_make_memory_entry_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object_handle :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (size :UInt32)
)
(defrecord __Reply__vm_map_page_query_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (disposition :signed-long)
   (ref_count :signed-long)
)
(defrecord __Reply__mach_vm_region_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (objects :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (region :VM_INFO_REGION)
   (objectsCnt :UInt32)
)
(defrecord __Reply__vm_mapped_pages_info_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (pages :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (pagesCnt :UInt32)
)
(defrecord __Reply__vm_region_object_create_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (region_object :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_region_recurse_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
   (size :UInt32)
   (nesting_depth :UInt32)
   (infoCnt :UInt32)
   (info (:array :signed-long 19))
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_region_recurse_64_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
   (size :UInt32)
   (nesting_depth :UInt32)
   (infoCnt :UInt32)
   (info (:array :signed-long 19))
)
(defrecord __Reply__mach_vm_region_info_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (objects :MACH_MSG_OOL_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (region :VM_INFO_REGION_64)
   (objectsCnt :UInt32)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_region_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object_name :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (address :vm_address_t)
   (size :UInt32)
   (infoCnt :UInt32)
   (info (:array :signed-long 10))
)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_SIZE_T
|#
(defrecord __Reply__mach_make_memory_entry_64_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (object_handle :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (size :memory_object_size_t)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_map_64_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
)
#|
; Warning: type-size: unknown type upl_page_info_t
|#
(defrecord __Reply__vm_map_get_upl_t
   (Head :MACH_MSG_HEADER_T)
                                                ;  start of the kernel processed data 
   (msgh_body :MACH_MSG_BODY_T)
   (upl :MACH_MSG_PORT_DESCRIPTOR_T)
                                                ;  end of the kernel processed data 
   (NDR :NDR_RECORD_T)
   (size :UInt32)
   (page_infoCnt :UInt32)
   (page_info (:array :upl_page_info_t 20))
   (flags :signed-long)
)
#|
; Warning: type-size: unknown type VM_ADDRESS_T
|#
(defrecord __Reply__vm_upl_map_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
   (address :vm_address_t)
)
(defrecord __Reply__vm_upl_unmap_t
   (Head :MACH_MSG_HEADER_T)
   (NDR :NDR_RECORD_T)
   (RetCode :signed-long)
)

; #endif /* !__Reply__vm_map_subsystem__defined */

;  union of all replies 
; #ifndef __ReplyUnion__vm_map_subsystem__defined
; #define __ReplyUnion__vm_map_subsystem__defined
(defrecord __ReplyUnion__vm_map_subsystem
   (:variant
   (
   (Reply_vm_region :__REPLY__VM_REGION_T)
   )
   (
   (Reply_vm_allocate :__REPLY__VM_ALLOCATE_T)
   )
   (
   (Reply_vm_deallocate :__REPLY__VM_DEALLOCATE_T)
   )
   (
   (Reply_vm_protect :__REPLY__VM_PROTECT_T)
   )
   (
   (Reply_vm_inherit :__REPLY__VM_INHERIT_T)
   )
   (
   (Reply_vm_read :__REPLY__VM_READ_T)
   )
   (
   (Reply_vm_read_list :__REPLY__VM_READ_LIST_T)
   )
   (
   (Reply_vm_write :__REPLY__VM_WRITE_T)
   )
   (
   (Reply_vm_copy :__REPLY__VM_COPY_T)
   )
   (
   (Reply_vm_read_overwrite :__REPLY__VM_READ_OVERWRITE_T)
   )
   (
   (Reply_vm_msync :__REPLY__VM_MSYNC_T)
   )
   (
   (Reply_vm_behavior_set :__REPLY__VM_BEHAVIOR_SET_T)
   )
   (
   (Reply_vm_map :__REPLY__VM_MAP_T)
   )
   (
   (Reply_vm_machine_attribute :__REPLY__VM_MACHINE_ATTRIBUTE_T)
   )
   (
   (Reply_vm_remap :__REPLY__VM_REMAP_T)
   )
   (
   (Reply_task_wire :__REPLY__TASK_WIRE_T)
   )
   (
   (Reply_mach_make_memory_entry :__REPLY__MACH_MAKE_MEMORY_ENTRY_T)
   )
   (
   (Reply_vm_map_page_query :__REPLY__VM_MAP_PAGE_QUERY_T)
   )
   (
   (Reply_mach_vm_region_info :__REPLY__MACH_VM_REGION_INFO_T)
   )
   (
   (Reply_vm_mapped_pages_info :__REPLY__VM_MAPPED_PAGES_INFO_T)
   )
   (
   (Reply_vm_region_object_create :__REPLY__VM_REGION_OBJECT_CREATE_T)
   )
   (
   (Reply_vm_region_recurse :__REPLY__VM_REGION_RECURSE_T)
   )
   (
   (Reply_vm_region_recurse_64 :__REPLY__VM_REGION_RECURSE_64_T)
   )
   (
   (Reply_mach_vm_region_info_64 :__REPLY__MACH_VM_REGION_INFO_64_T)
   )
   (
   (Reply_vm_region_64 :__REPLY__VM_REGION_64_T)
   )
   (
   (Reply_mach_make_memory_entry_64 :__REPLY__MACH_MAKE_MEMORY_ENTRY_64_T)
   )
   (
   (Reply_vm_map_64 :__REPLY__VM_MAP_64_T)
   )
   (
   (Reply_vm_map_get_upl :__REPLY__VM_MAP_GET_UPL_T)
   )
   (
   (Reply_vm_upl_map :__REPLY__VM_UPL_MAP_T)
   )
   (
   (Reply_vm_upl_unmap :__REPLY__VM_UPL_UNMAP_T)
   )
   )
)

; #endif /* !__RequestUnion__vm_map_subsystem__defined */

; #ifndef subsystem_to_name_map_vm_map
; #define subsystem_to_name_map_vm_map     { "vm_region", 3800 },    { "vm_allocate", 3801 },    { "vm_deallocate", 3802 },    { "vm_protect", 3803 },    { "vm_inherit", 3804 },    { "vm_read", 3805 },    { "vm_read_list", 3806 },    { "vm_write", 3807 },    { "vm_copy", 3808 },    { "vm_read_overwrite", 3809 },    { "vm_msync", 3810 },    { "vm_behavior_set", 3811 },    { "vm_map", 3812 },    { "vm_machine_attribute", 3813 },    { "vm_remap", 3814 },    { "task_wire", 3815 },    { "mach_make_memory_entry", 3816 },    { "vm_map_page_query", 3817 },    { "mach_vm_region_info", 3818 },    { "vm_mapped_pages_info", 3819 },    { "vm_region_object_create", 3820 },    { "vm_region_recurse", 3821 },    { "vm_region_recurse_64", 3822 },    { "mach_vm_region_info_64", 3823 },    { "vm_region_64", 3824 },    { "mach_make_memory_entry_64", 3825 },    { "vm_map_64", 3826 },    { "vm_map_get_upl", 3827 },    { "vm_upl_map", 3828 },    { "vm_upl_unmap", 3829 }

; #endif

; #ifdef __AfterMigUserHeader
#| #|
__AfterMigUserHeader
#endif
|#
 |#
;  __AfterMigUserHeader 

; #endif	 /* _vm_map_user_ */


(provide-interface "vm_map")