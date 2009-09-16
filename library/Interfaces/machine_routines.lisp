(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:machine_routines.h"
; at Sunday July 2,2006 7:26:34 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; 
;  * @OSF_COPYRIGHT@
;  
; #ifndef	_I386_MACHINE_ROUTINES_H_
; #define	_I386_MACHINE_ROUTINES_H_

(require-interface "mach/mach_types")

(require-interface "mach/boolean")

(require-interface "kern/kern_types")

(require-interface "pexpert/pexpert")

(require-interface "sys/appleapiopts")
;  Interrupt handling 
;  Initialize Interrupts 

(deftrap-inline "_ml_init_interrupt" 
   (
   )
   :void
() )
;  Get Interrupts Enabled 

(deftrap-inline "_ml_get_interrupts_enabled" 
   (
   )
   :signed-long
() )
;  Set Interrupts Enabled 

(deftrap-inline "_ml_set_interrupts_enabled" 
   ((enable :signed-long)
   )
   :signed-long
() )
;  Check if running at interrupt context 

(deftrap-inline "_ml_at_interrupt_context" 
   (
   )
   :signed-long
() )
;  Generate a fake interrupt 

(deftrap-inline "_ml_cause_interrupt" 
   (
   )
   :void
() )

(deftrap-inline "_ml_get_timebase" 
   ((timestamp (:pointer :UInt32))
   )
   :void
() )
;  Type for the Time Base Enable function 

(def-mactype :time_base_enable_t (find-mactype ':pointer)); (cpu_id_t cpu_id , boolean_t enable)
;  Type for the IPI Hander 

(def-mactype :ipi_handler_t (find-mactype ':pointer)); (void)
;  Struct for ml_processor_register 
(defrecord ml_processor_info
   (cpu_id :cpu_id_t)
#|
; Warning: type-size: unknown type CPU_ID_T
|#
   (boot_cpu :signed-long)
   (start_paddr :UInt32)
   (supports_nap :signed-long)
   (l2cr_value :UInt32)
   (time_base_enable :pointer)
)

(%define-record :ml_processor_info_t (find-record-descriptor ':ml_processor_info))
;  Register a processor 

(deftrap-inline "_ml_processor_register" 
   ((cpu_id :cpu_id_t)
    (lapic_id :UInt32)
    (processor (:pointer :processor_t))
    (ipi_handler (:pointer :IPI_HANDLER_T))
    (boot_cpu :signed-long)
   )
   :signed-long
() )
;  Initialize Interrupts 

(deftrap-inline "_ml_install_interrupt_handler" 
   ((nub :pointer)
    (source :signed-long)
    (target :pointer)
    (handler :iointerrupthandler)
    (refCon :pointer)
   )
   :void
() )
; #ifdef __APPLE_API_UNSTABLE
#| #|
vm_offset_t
ml_static_ptovirt(
	vm_offset_t);


boolean_t ml_probe_read(
	vm_offset_t paddr,
	unsigned int *val);
boolean_t ml_probe_read_64(
	addr64_t paddr,
	unsigned int *val);


unsigned int ml_phys_read_byte(
	vm_offset_t paddr);
unsigned int ml_phys_read_byte_64(
	addr64_t paddr);


unsigned int ml_phys_read_half(
	vm_offset_t paddr);
unsigned int ml_phys_read_half_64(
	addr64_t paddr);


unsigned int ml_phys_read(
	vm_offset_t paddr);
unsigned int ml_phys_read_64(
	addr64_t paddr);
unsigned int ml_phys_read_word(
	vm_offset_t paddr);
unsigned int ml_phys_read_word_64(
	addr64_t paddr);


unsigned long long ml_phys_read_double(
	vm_offset_t paddr);
unsigned long long ml_phys_read_double_64(
	addr64_t paddr);


void ml_phys_write_byte(
	vm_offset_t paddr, unsigned int data);
void ml_phys_write_byte_64(
	addr64_t paddr, unsigned int data);


void ml_phys_write_half(
	vm_offset_t paddr, unsigned int data);
void ml_phys_write_half_64(
	addr64_t paddr, unsigned int data);


void ml_phys_write(
	vm_offset_t paddr, unsigned int data);
void ml_phys_write_64(
	addr64_t paddr, unsigned int data);
void ml_phys_write_word(
	vm_offset_t paddr, unsigned int data);
void ml_phys_write_word_64(
	addr64_t paddr, unsigned int data);


void ml_phys_write_double(
	vm_offset_t paddr, unsigned long long data);
void ml_phys_write_double_64(
	addr64_t paddr, unsigned long long data);

void ml_static_mfree(
	vm_offset_t,
	vm_size_t);


vm_offset_t ml_vtophys(
	vm_offset_t vaddr);


struct ml_cpu_info {
	unsigned long		vector_unit;
	unsigned long		cache_line_size;
	unsigned long		l1_icache_size;
	unsigned long		l1_dcache_size;
	unsigned long		l2_settings;
	unsigned long		l2_cache_size;
	unsigned long		l3_settings;
	unsigned long		l3_cache_size;
};

typedef struct ml_cpu_info ml_cpu_info_t;


void ml_cpu_get_info(ml_cpu_info_t *cpu_info);

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #ifdef __APPLE_API_PRIVATE
#| #|
#ifdefined(PEXPERT_KERNEL_PRIVATE) || defined(MACH_KERNEL_PRIVATE)



vm_offset_t ml_io_map(
	vm_offset_t phys_addr, 
	vm_size_t size);


vm_offset_t ml_static_malloc(
	vm_size_t size);

#endif


void bzero_phys(
	addr64_t phys_address,
	uint32_t length);

#ifdef MACH_KERNEL_PRIVATE 

void machine_idle(void);

void machine_signal_idle(
        processor_t processor);
#endif

void ml_thread_policy(
	thread_t thread,
	unsigned policy_id,
	unsigned policy_info);

#define MACHINE_GROUP					0x00000001
#define MACHINE_NETWORK_GROUP			0x10000000
#define MACHINE_NETWORK_WORKLOOP		0x00000001
#define MACHINE_NETWORK_NETISR			0x00000002


void ml_init_max_cpus(
	unsigned long max_cpus);


int ml_get_max_cpus(
	void);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _I386_MACHINE_ROUTINES_H_ */


(provide-interface "machine_routines")