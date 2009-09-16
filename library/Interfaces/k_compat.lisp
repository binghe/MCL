(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:k_compat.h"
; at Sunday July 2,2006 7:29:35 pm.
; ======================================================================
; 
;     The contents of this file are subject to the Mozilla Public
;     License Version 1.1 (the "License"); you may not use this file
;     except in compliance with the License. You may obtain a copy of
;     the License at http://www.mozilla.org/MPL/
; 
;     Software distributed under the License is distributed on an "AS
;     IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
;     implied. See the License for the specific language governing
;     rights and limitations under the License.
; 
;     The initial developer of the original code is David A. Hinds
;     <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
;     are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
; 
;     Contributor:  Apple Computer, Inc.  Portions © 2003 Apple Computer, 
;     Inc. All rights reserved.
; 
;     Alternatively, the contents of this file may be used under the
;     terms of the GNU Public License version 2 (the "GPL"), in which
;     case the provisions of the GPL are applicable instead of the
;     above.  If you wish to allow the use of your version of this file
;     only under the terms of the GPL and not to allow others to use
;     your version of this file under the MPL, indicate your decision
;     by deleting the provisions above and replace them with the notice
;     and other provisions required by the GPL.  If you do not delete
;     the provisions above, a recipient may use your version of this
;     file under either the MPL or the GPL.
; 
; ======================================================================
; #ifndef _LINUX_K_COMPAT_H
; #define _LINUX_K_COMPAT_H

(require-interface "IOKit/assert")

(require-interface "IOKit/IOLib")

(require-interface "libkern/OSByteOrder")

(require-interface "sys/errno")

(def-mactype :u8 (find-mactype ':UInt8))

(def-mactype :u16 (find-mactype ':UInt16))

(def-mactype :u32 (find-mactype ':UInt32))
; #define printk IOLog
(defconstant $KERN_INFO "IOPCCard info:   ")
; #define KERN_INFO	"IOPCCard info:   "
(defconstant $KERN_NOTICE "IOPCCard notice: ")
; #define KERN_NOTICE	"IOPCCard notice: "
(defconstant $KERN_DEBUG "IOPCCard debug:  ")
; #define KERN_DEBUG	"IOPCCard debug:  "
; #define MODULE_PARM(a,b)
; #define MODULE_AUTHOR(a)
; #define MODULE_DESCRIPTION(a)
; #define MOD_DEC_USE_COUNT
; #define MOD_INC_USE_COUNT
; #define __init
; #define __exit
;  we don't need these if we are always inside the workloop
; #define ACQUIRE_RESOURCE_LOCK
; #define RELEASE_RESOURCE_LOCK
(defconstant $NR_IRQS 256)
; #define NR_IRQS			256
(defconstant $PCI_INTERRUPT_LINE 60)
; #define PCI_INTERRUPT_LINE	0x3c
(defconstant $PCI_CACHE_LINE_SIZE 12)
; #define PCI_CACHE_LINE_SIZE	0xc
(defconstant $PCI_LATENCY_TIMER 13)
; #define PCI_LATENCY_TIMER	0xd
(defconstant $PCI_BASE_ADDRESS_0 16)
; #define PCI_BASE_ADDRESS_0	0x10
(defconstant $PCI_COMMAND 4)
; #define PCI_COMMAND		0x4
(defconstant $PCI_COMMAND_IO 1)
; #define PCI_COMMAND_IO		0x1
(defconstant $PCI_COMMAND_MEMORY 2)
; #define PCI_COMMAND_MEMORY	0x2
(defconstant $PCI_COMMAND_MASTER 4)
; #define PCI_COMMAND_MASTER	0x4
(defconstant $PCI_COMMAND_WAIT 128)
; #define PCI_COMMAND_WAIT	0x80
(defconstant $PCI_HEADER_TYPE 14)
; #define PCI_HEADER_TYPE		0xe
(defconstant $PCI_CLASS_REVISION 8)
; #define PCI_CLASS_REVISION	0x8
(defconstant $PCI_VENDOR_ID 0)
; #define PCI_VENDOR_ID		0x0
(defconstant $PCI_DEVICE_ID 2)
; #define PCI_DEVICE_ID		0x2
(defconstant $PCI_STATUS 6)
; #define PCI_STATUS		0x6
(defconstant $PCI_CLASS_BRIDGE_CARDBUS 1543)
; #define PCI_CLASS_BRIDGE_CARDBUS	0x0607
(defconstant $PCI_CLASS_BRIDGE_PCMCIA 1541)
; #define PCI_CLASS_BRIDGE_PCMCIA		0x0605
(defconstant $PCI_BASE_ADDRESS_SPACE_IO 1)
; #define PCI_BASE_ADDRESS_SPACE_IO 	0x1
(defconstant $PCI_BASE_ADDRESS_SPACE_MEMORY 0)
; #define PCI_BASE_ADDRESS_SPACE_MEMORY	0x0
(defconstant $PCI_BASE_ADDRESS_MEM_PREFETCH 8)
; #define PCI_BASE_ADDRESS_MEM_PREFETCH	0x8
; #define PCI_BASE_ADDRESS_MEM_MASK 	(~0x0fUL)
(defconstant $PCI_BASE_ADDRESS_SPACE 1)
; #define PCI_BASE_ADDRESS_SPACE		0x1
; #define PCI_BASE_ADDRESS_IO_MASK	(~0x03UL)
(defconstant $PCI_INTERRUPT_PIN 61)
; #define	PCI_INTERRUPT_PIN		0x3d
(defrecord pt_regs
)
(defconstant $HZ 100)
; #define HZ		100
; #define mdelay(i)	IODelay( i * 1000 )
; #define udelay(i)	IODelay( i )
(defrecord timer_list
   (expires :UInt32)
   (function (:pointer :callback))              ;(void (unsigned long))
   (data :UInt32)
)

(deftrap-inline "_IOPCCardAddTimer" 
   ((timer (:pointer :struct))
   )
   nil
() )

(deftrap-inline "_IOPCCardDeleteTimer" 
   ((timer (:pointer :struct))
   )
   :signed-long
() )
(defconstant $jiffies 0)
; #define jiffies (0)	// just cheat on the whole jiffies thing :-)
; #define add_timer(t)	IOPCCardAddTimer(t)
; #define del_timer(t)	IOPCCardDeleteTimer(t)
; #define mod_timer(a, b)	do { del_timer(a); (a)->expires = (b); add_timer(a); } while (0)

(deftrap-inline "_kern_os_malloc" 
   ((size :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_kern_os_realloc" 
   ((addr :pointer)
    (size :unsigned-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_kern_os_free" 
   ((addr :pointer)
   )
   nil
() )
; #define kmalloc(s, x) kern_os_malloc(s)
; #define krealloc(a, s, x) kern_os_realloc(a, s)
; #define kfree(a) kern_os_free(a)
(defconstant $le16_to_cpu 0)
; #define le16_to_cpu(x)	OSSwapLittleToHostInt16(x)
(defconstant $le32_to_cpu 0)
; #define le32_to_cpu(x)	OSSwapLittleToHostInt32(x)
; MACOSXXX - all this needs to be cleaned up

(def-mactype :wait_queue_head_t (find-mactype '(:pointer :wait_queue)))
; #define init_waitqueue_head(p)	DEBUG(0, "init_waitqueue_head stubbed out!\n");
; #define wacquire(w)		do { } while (0)
; #define wrelease(w)		do { } while (0)
; #define wsleep(w)		DEBUG(0, "wsleep stubbed out!\n");
; #define wsleeptimeout(w,t)	DEBUG(0, "wsleeptimeout stubbed out!\n");
; #define wakeup(w)		DEBUG(0, "wakeup stubbed out!\n");

(deftrap-inline "_IOPCCardReadByte" 
   ((virt :pointer)
   )
   :UInt8
() )

(deftrap-inline "_IOPCCardReadLong" 
   ((virt :pointer)
   )
   :UInt32
() )

(deftrap-inline "_IOPCCardWriteByte" 
   ((virt :pointer)
    (value :UInt8)
   )
   nil
() )

(deftrap-inline "_IOPCCardWriteLong" 
   ((virt :pointer)
    (value :UInt32)
   )
   nil
() )
; #define readb(a)		IOPCCardReadByte(a)
; #define readl(a)		IOPCCardReadLong(a)
; #define writeb(v, a)		IOPCCardWriteByte(a, v)
; #define writel(v, a)		IOPCCardWriteLong(a, v)

(deftrap-inline "_IOPCCardIORemap" 
   ((paddr :UInt32)
    (size :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_IOPCCardIOUnmap" 
   ((vaddr :pointer)
   )
   nil
() )
; #define ioremap(p, s)	IOPCCardIORemap(p, s)
; #define iounmap(v)	IOPCCardIOUnmap(v)
; #ifdef IOPCCARD_IN_IOKIT_CODE

#|class IOPCIDevice;
|#

#|class IOPCCardBridge;
|#

#|class IOCardBusDevice;
|#

#|class IOPCCard16Device;
|#

(deftrap-inline "_init_i82365" 
   ((bus (:pointer :iopccardbridge))
    (bridge (:pointer :iopcidevice))
    (device_regs :IOVirtualAddress)
   )
   :signed-long
() )

(deftrap-inline "_init_pcmcia_cs" 
   (
   )
   :signed-long
() )
#| 
; #else /* !IOPCCARD_IN_IOKIT_CODE */

;type name? (def-mactype :IOPCIDevice (find-mactype ':IOPCIDevice))

;type name? (def-mactype :IOPCCardBridge (find-mactype ':IOPCCardBridge))
; #define        IOCardBusDevice	IOPCIDevice	// subclassing C style

;type name? (def-mactype :IOPCCard16Device (find-mactype ':IOPCCard16Device))

(deftrap-inline "_IOPCCardCreateCardBusNub" 
   ((bus (:pointer :IOPCCardBridge))
    (socket :UInt32)
    (function :UInt32)
   )
   (:pointer :iocardbusdevice)
() )

(deftrap-inline "_IOPCCardRetainNub" 
   ((nub :pointer)
   )
   nil
() )

(deftrap-inline "_IOPCCardReleaseNub" 
   ((nub :pointer)
   )
   nil
() )

(deftrap-inline "_IOPCCardAddCSCInterruptHandlers" 
   ((bus (:pointer :IOPCCardBridge))
    (socket :UInt32)
    (irq :UInt32)
    (top_handler (:pointer :callback))          ;(u_int (u_int))

    (bottom_handler (:pointer :callback))       ;(u_int (u_int))

    (enable_functional (:pointer :callback))    ;(u_int (u_int))

    (disable_functional (:pointer :callback))   ;(u_int (u_int))

    (name (:pointer :char))
   )
   :signed-long
() )

(deftrap-inline "_IOPCCardRemoveCSCInterruptHandlers" 
   ((bus (:pointer :IOPCCardBridge))
    (socket :UInt32)
   )
   :signed-long
() )
;  MACOSXXX - i82365.c and cardbus.c currently use these differently :-)
;  the #defines are in those files for now

(deftrap-inline "_IOPCCardReadConfigByte" 
   ((bus (:pointer :IOPCIDevice))
    (r :signed-long)
    (v (:pointer :u_char))
   )
   :signed-long
() )

(deftrap-inline "_IOPCCardWriteConfigByte" 
   ((bus (:pointer :IOPCIDevice))
    (r :signed-long)
    (v :UInt8)
   )
   :signed-long
() )

(deftrap-inline "_IOPCCardReadConfigWord" 
   ((bus (:pointer :IOPCIDevice))
    (r :signed-long)
    (v (:pointer :u_short))
   )
   :signed-long
() )

(deftrap-inline "_IOPCCardWriteConfigWord" 
   ((bus (:pointer :IOPCIDevice))
    (r :signed-long)
    (v :UInt16)
   )
   :signed-long
() )

(deftrap-inline "_IOPCCardReadConfigLong" 
   ((bus (:pointer :IOPCIDevice))
    (r :signed-long)
    (v (:pointer :u_int))
   )
   :signed-long
() )

(deftrap-inline "_IOPCCardWriteConfigLong" 
   ((bus (:pointer :IOPCIDevice))
    (r :signed-long)
    (v :UInt32)
   )
   :signed-long
() )
;  MACOSXXX these need to use IOPCCardBridge *bus, if we have multiple controllers
;  on different pci bridges, the current code breaks down, this is currently
;  not really an issue on laptops :-)

(deftrap-inline "_check_mem_region" 
   ((base :UInt32)
    (num :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_request_mem_region" 
   ((base :UInt32)
    (num :UInt32)
    (name (:pointer :char))
   )
   nil
() )

(deftrap-inline "_release_mem_region" 
   ((base :UInt32)
    (num :UInt32)
   )
   nil
() )

(deftrap-inline "_check_io_region" 
   ((base :UInt32)
    (num :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_request_io_region" 
   ((base :UInt32)
    (num :UInt32)
    (name (:pointer :char))
   )
   nil
() )

(deftrap-inline "_release_io_region" 
   ((base :UInt32)
    (num :UInt32)
   )
   nil
() )
; #define check_region(a, l) 	check_io_region(a, l)
; #define request_region(a, l, n)	request_io_region(a, l, n)
; #define release_region(a, l)	release_io_region(a, l)

(deftrap-inline "_configure_i82365" 
   ((pccard_nub (:pointer :IOPCCardBridge))
    (bridge_nub (:pointer :IOPCIDevice))
    (device_regs :pointer)
   )
   :signed-long
() )
 |#

; #endif /* IOPCCARD_IN_IOKIT_CODE */

;  Flags for device state, from ds.h 
(defconstant $DEV_PRESENT 1)
; #define DEV_PRESENT		0x01
(defconstant $DEV_CONFIG 2)
; #define DEV_CONFIG		0x02
(defconstant $DEV_STALE_CONFIG 4)
; #define DEV_STALE_CONFIG	0x04	/* release on close */
(defconstant $DEV_STALE_LINK 8)
; #define DEV_STALE_LINK		0x08	/* detach on release */
(defconstant $DEV_CONFIG_PENDING 16)
; #define DEV_CONFIG_PENDING	0x10
(defconstant $DEV_RELEASE_PENDING 32)
; #define DEV_RELEASE_PENDING	0x20
(defconstant $DEV_SUSPEND 64)
; #define DEV_SUSPEND		0x40
(defconstant $DEV_BUSY 128)
; #define DEV_BUSY		0x80
; #define DEV_OK(state) (((state) & ~DEV_BUSY) == (DEV_CONFIG|DEV_PRESENT))

; #endif /* _LINUX_K_COMPAT_H */


(provide-interface "k_compat")