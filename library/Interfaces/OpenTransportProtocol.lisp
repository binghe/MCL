(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OpenTransportProtocol.h"
; at Sunday July 2,2006 7:23:35 pm.
; 
;      File:       OT/OpenTransportProtocol.h
;  
;      Contains:   Definitions likely to be used by low-level protocol stack implementation.
;  
;      Version:    OpenTransport-90~46
;  
;      Copyright:  й 1993-2003 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OPENTRANSPORTPROTOCOL__
; #define __OPENTRANSPORTPROTOCOL__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#

; #if CALL_NOT_IN_CARBON
#| ; #ifndef __FILES__
#|
#include <CarbonCoreFiles.h>
#endif
|#
; #ifndef __CODEFRAGMENTS__
#|
#include <CarbonCoreCodeFragments.h>
#endif
|#
 |#

; #endif  /* CALL_NOT_IN_CARBON */

; #ifndef __OPENTRANSPORT__
#| #|
#include <OSServicesOpenTransport.h>
#endif
|#
 |#
; #ifdef __cplusplus
#| #|
#include <stddef.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k

; #if defined(__MWERKS__) && TARGET_CPU_68K
#| ; #pragma push
; #pragma pointers_in_D0
 |#

; #endif

;  ***** Setup Default Compiler Variables *****
; 
;    OTKERNEL is used to indicate whether the code is being built
;    for the kernel environment.  It defaults to 0.  If you include
;    "OpenTransportKernel.h" before including this file,
;    it will be 1 and you will only be able to see stuff available
;    to kernel code.
;    As we've included "OpenTransport.h" and it defaults this variable
;    to 0 if it's not already been defined, it should always be defined
;    by the time we get here.  So we just assert that.  Assertions in
;    header files!  Cool (-:
; 
; #ifndef OTKERNEL

; #error OpenTransportProtocol.h expects OpenTransport.h to set up OTKERNEL.

; #endif  /* !defined(OTKERNEL) */

;  ***** Shared Client Memory *****

; #if !OTKERNEL
; 
;    These allocators allocate memory in the shared client pool,
;    which is shared between all clients and is not disposed when
;    a particular client goes away.  See DTS Technote еее
;    "Understanding Open Transport Memory Management" for details.
; 
; 
;  *  OTAllocSharedClientMem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTFreeSharedClientMem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !OTKERNEL */

;  ***** UNIX Types *****

; #if CALL_NOT_IN_CARBON
#| 
; 
;    On UNIX, uid_t and gid_t are defined to be big enough
;    to hold a user ID and group ID respectively.  As Mac OS
;    has no such concepts, we just define them as UInt32 place
;    holders.
; 

(def-mactype :uid_t (find-mactype ':UInt32))

(def-mactype :gid_t (find-mactype ':UInt32))
;  Similarly, dev_t is a UNIX type for denoting a device number.

(def-mactype :dev_t (find-mactype ':UInt32))
;  ***** From the Mentat "strstat.h" *****
;  module statistics structure 
(defrecord module_stat
   (ms_pcnt :signed-long)                       ;  count of calls to put proc 
   (ms_scnt :signed-long)                       ;  count of calls to service proc 
   (ms_ocnt :signed-long)                       ;  count of calls to open proc 
   (ms_ccnt :signed-long)                       ;  count of calls to close proc 
   (ms_acnt :signed-long)                       ;  count of calls to admin proc 
   (ms_xptr (:pointer :char))                   ;  pointer to private statistics 
   (ms_xsize :SInt16)                           ;  length of private statistics buffer 
)

;type name? (def-mactype :module_stat (find-mactype ':module_stat))
;  ***** From the Mentat "cred.h" *****
(defrecord cred
   (cr_ref :UInt16)                             ;  reference count on processes using cred structures 
   (cr_ngroups :UInt16)                         ;  number of groups in cr_groups 
   (cr_uid :UInt32)                             ;  effective user id 
   (cr_gid :UInt32)                             ;  effective group id 
   (cr_ruid :UInt32)                            ;  real user id 
   (cr_rgid :UInt32)                            ;  real group id 
   (cr_suid :UInt32)                            ;  user id saved by exec 
   (cr_sgid :UInt32)                            ;  group id saved by exec 
   (cr_groups (:array :UInt32 1))               ;  supplementary groups list 
)

;type name? (def-mactype :cred (find-mactype ':cred))

(def-mactype :cred_t (find-mactype ':cred))
;  Free return structure for esballoc 

(def-mactype :FreeFuncType (find-mactype ':pointer)); (char * arg)
(defrecord free_rtn
   (free_func :FreeFuncType)                    ;  Routine to call to free buffer 
   (free_arg (:pointer :char))                  ;  Parameter to free_func 
)

;type name? (def-mactype :free_rtn (find-mactype ':free_rtn))

(def-mactype :frtn_t (find-mactype ':free_rtn))
;  data descriptor 

;type name? (def-mactype :datab (find-mactype ':datab))
(defrecord datab_db_f
   (:variant
   (
   (freep (:pointer :datab))
   )
   (
   (frtnp (:pointer :free_rtn))
   )
   )
)

;type name? (def-mactype :datab_db_f (find-mactype ':datab_db_f))
(defrecord datab
   (db_f :datab_db_f)
   (db_base (:pointer :UInt8))                  ;  first byte of buffer 
   (db_lim (:pointer :UInt8))                   ;  last byte+1 of buffer 
   (db_ref :UInt8)                              ;  count of messages pointing to block
   (db_type :UInt8)                             ;  message type 
   (db_iswhat :UInt8)                           ;  message status 
   (db_filler2 :UInt8)                          ;  for spacing 
   (db_size :UInt32)                            ;  used internally 
   (db_msgaddr (:pointer :UInt8))               ;  used internally 
   (db_filler :signed-long)
)

(def-mactype :dblk_t (find-mactype ':datab))
; #define db_freep        db_f.freep
; #define db_frtnp        db_f.frtnp
;  message block 
(defrecord msgb
   (b_next (:pointer :msgb))                    ;  next message on queue 
   (b_prev (:pointer :msgb))                    ;  previous message on queue 
   (b_cont (:pointer :msgb))                    ;  next message block of message 
   (b_rptr (:pointer :UInt8))                   ;  first unread data byte in buffer 
   (b_wptr (:pointer :UInt8))                   ;  first unwritten data byte 
   (b_datap (:pointer :datab))                  ;  data block 
   (b_band :UInt8)                              ;  message priority 
   (b_pad1 :UInt8)
   (b_flag :UInt16)
; #ifdef  MSGB_XTRA
#|

    MSGB_XTRA

#endif
|#
)

;type name? (def-mactype :msgb (find-mactype ':msgb))

(def-mactype :mblk_t (find-mactype ':msgb))
;  mblk flags 

(defconstant $MSGMARK 1)                        ;  last byte of message is tagged 

(defconstant $MSGNOLOOP 2)                      ;  don't pass message to write-side of stream 

(defconstant $MSGDELIM 4)                       ;  message is delimited 

(defconstant $MSGNOGET 8)
;  STREAMS environments are expected to define these constants in a public header file.

(defconstant $STRCTLSZ #x100)                   ;  Maximum Control buffer size for messages   

(defconstant $STRMSGSZ #x2000)                  ;  Maximum # data bytes for messages   

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define STRCTLSZ STRCTLSZ
; #define STRMSGSZ STRMSGSZ
;  Message types 

(defconstant $QNORM 0)
(defconstant $M_DATA 0)                         ;  Ordinary data 

(defconstant $M_PROTO 1)                        ;  Internal control info and data 

(defconstant $M_BREAK 8)                        ;  Request a driver to send a break 

(defconstant $M_PASSFP 9)                       ;  Used to pass a file pointer 

(defconstant $M_SIG 11)                         ;  Requests a signal to be sent 

(defconstant $M_DELAY 12)                       ;  Request a real-time delay 

(defconstant $M_CTL 13)                         ;  For inter-module communication 

(defconstant $M_IOCTL 14)                       ;  Used internally for I_STR requests 

(defconstant $M_SETOPTS 16)                     ;  Alters characteristics of Stream head 

(defconstant $M_RSE 17)                         ;  Reserved for internal use 

;  MPS private type 

(defconstant $M_MI 64)
(defconstant $M_MI_READ_RESET 1)
(defconstant $M_MI_READ_SEEK 2)
(defconstant $M_MI_READ_END 4)
;  Priority messages types 

(defconstant $QPCTL #x80)
(defconstant $M_IOCACK #x81)                    ;  Positive ack of previous M_IOCTL 

(defconstant $M_IOCNAK #x82)                    ;  Previous M_IOCTL failed 

(defconstant $M_PCPROTO #x83)                   ;  Same as M_PROTO except for priority 

(defconstant $M_PCSIG #x84)                     ;  Priority signal 

(defconstant $M_FLUSH #x86)                     ;  Requests modules to flush queues 

(defconstant $M_STOP #x87)                      ;  Request drivers to stop output 

(defconstant $M_START #x88)                     ;  Request drivers to start output 

(defconstant $M_HANGUP #x89)                    ;  Driver can no longer produce data 

(defconstant $M_ERROR #x8A)                     ;  Reports downstream error condition 

(defconstant $M_READ #x8B)                      ;  Reports client read at Stream head 

(defconstant $M_COPYIN #x8C)                    ;  Requests the Stream to copy data in for a module 

(defconstant $M_COPYOUT #x8D)                   ;  Requests the Stream to copy data out for a module 

(defconstant $M_IOCDATA #x8E)                   ;  Status from M_COPYIN/M_COPYOUT message 

(defconstant $M_PCRSE #x90)                     ;  Reserved for internal use 

(defconstant $M_STOPI #x91)                     ;  Request drivers to stop input 

(defconstant $M_STARTI #x92)                    ;  Request drivers to start input 

(defconstant $M_HPDATA #x93)                    ;  MPS-private type; high priority data 

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define M_DATA M_DATA
; #define M_COPYIN M_COPYIN
; #define M_COPYOUT M_COPYOUT
;  Defines for flush messages 

(defconstant $FLUSHALL 1)
(defconstant $FLUSHDATA 0)
;  used in M_ERROR messages 

(defconstant $NOERROR -1)

;type name? (def-mactype :sth_s (find-mactype ':sth_s))

;type name? (def-mactype :sqh_s (find-mactype ':sqh_s))

;type name? (def-mactype :q_xtra (find-mactype ':q_xtra))

; #if OTKERNEL
; 
;    module_info is aligned differently on 68K than
;    on PowerPC.  Yucky.  I can't defined a conditionalised
;    pad field because a) you can't conditionalise specific
;    fields in the interface definition language used to
;    create Universal Interfaces, and b) lots of code 
;    assigns C structured constants to global variables
;    of this type, and these assignments break if you
;    add an extra field to the type.  Instead, I
;    set the alignment appropriately before defining the 
;    structure.  The problem with doing that is that
;    the interface definition language doesn't allow
;    my to set the alignment in the middle of a file,
;    so I have to do this via "pass throughs".  This
;    works fine for the well known languages (C, Pascal),
;    but may cause problems for other languages (Java,
;    Asm).
; 

; #if TARGET_CPU_PPC
; #pragma options align=power

; #endif

(defrecord module_info
   (mi_idnum :UInt16)                           ;  module ID number 
   (mi_idname (:pointer :char))                 ;  module name 
   (mi_minpsz :signed-long)                     ;  min pkt size, for developer use 
   (mi_maxpsz :signed-long)                     ;  max pkt size, for developer use 
   (mi_hiwat :UInt32)                           ;  hi-water mark, for flow control 
   (mi_lowat :UInt32)                           ;  lo-water mark, for flow control 
)

;type name? (def-mactype :module_info (find-mactype ':module_info))

(def-mactype :module_infoPtr (find-mactype '(:pointer :module_info)))

; #if TARGET_CPU_PPC
; #pragma options align=reset

; #endif


;type name? (def-mactype :queue (find-mactype ':queue))

(def-mactype :admin_t (find-mactype ':pointer)) ; (void)

(def-mactype :bufcall_t (find-mactype ':pointer)); (long size)

(def-mactype :bufcallp_t (find-mactype ':pointer)); (long size)

(def-mactype :closep_t (find-mactype ':pointer)); (queue * q , OTInt32 foo , cred_t * cred)

(def-mactype :old_closep_t (find-mactype ':pointer)); (queue * q)

(def-mactype :openp_t (find-mactype ':pointer)) ; (queue * q , dev_t * dev , OTInt32 foo , OTInt32 bar , cred_t * cred)

(def-mactype :openOld_t (find-mactype ':pointer)); (queue * q , dev_t dev , OTInt32 foo , OTInt32 bar)

(def-mactype :old_openp_t (find-mactype ':pointer)); (queue * q , dev_t dev , OTInt32 foo , OTInt32 bar)

(def-mactype :closeOld_t (find-mactype ':pointer)); (queue * q)

(def-mactype :putp_t (find-mactype ':pointer))  ; (queue * q , msgb * mp)

(def-mactype :srvp_t (find-mactype ':pointer))  ; (queue * q)
(defrecord qinit
   (qi_putp :putp_t)                            ;  put procedure 
   (qi_srvp :srvp_t)                            ;  service procedure 
   (qi_qopen :openp_t)                          ;  called on each open or a push 
   (qi_qclose :closep_t)                        ;  called on last close or a pop 
   (qi_qadmin :admin_t)                         ;  reserved for future use 
   (qi_minfo (:pointer :module_info))           ;  information structure 
   (qi_mstat (:pointer :module_stat))           ;  statistics structure - optional 
)

;type name? (def-mactype :qinit (find-mactype ':qinit))
;  defines module or driver 
(defrecord streamtab
   (st_rdinit (:pointer :qinit))                ;  defines read QUEUE 
   (st_wrinit (:pointer :qinit))                ;  defines write QUEUE 
   (st_muxrinit (:pointer :qinit))              ;  for multiplexing drivers only 
   (st_muxwinit (:pointer :qinit))              ;  ditto 
)

;type name? (def-mactype :streamtab (find-mactype ':streamtab))
(defrecord qband
   (qb_next (:pointer :qband))                  ;  next band for this queue 
   (qb_count :UInt32)                           ;  weighted count of characters in this band 
   (qb_first (:pointer :msgb))                  ;  head of message queue 
   (qb_last (:pointer :msgb))                   ;  tail of message queue 
   (qb_hiwat :UInt32)                           ;  high water mark 
   (qb_lowat :UInt32)                           ;  low water mark 
   (qb_flag :UInt16)                            ;  еее╩state 
   (qb_pad1 :SInt16)                            ;  еее reserved 
)

;type name? (def-mactype :qband (find-mactype ':qband))

(def-mactype :qband_t (find-mactype ':qband))
(defrecord queue_q_u
   (:variant
   (
   (q_u_link (:pointer :queue))
   )
                                                ;  link to scheduling queue 
   (
   (q_u_sqh_parent (:pointer :sqh_s))
   )
   )
)

;type name? (def-mactype :queue_q_u (find-mactype ':queue_q_u))
(defrecord queue
   (q_qinfo (:pointer :qinit))                  ;  procedures and limits for queue 
   (q_first (:pointer :msgb))                   ;  head of message queue 
   (q_last (:pointer :msgb))                    ;  tail of message queue 
   (q_next (:pointer :queue))                   ;  next queue in Stream 
   (q_u :queue_q_u)
   (q_ptr (:pointer :char))                     ;  to private data structure 
   (q_count :UInt32)                            ;  weighted count of characters on q 
   (q_minpsz :signed-long)                      ;  min packet size accepted 
   (q_maxpsz :signed-long)                      ;  max packet size accepted 
   (q_hiwat :UInt32)                            ;  high water mark, for flow control 
   (q_lowat :UInt32)                            ;  low water mark 
   (q_bandp (:pointer :qband))                  ;  band information 
   (q_flag :UInt16)                             ;  еее queue state 
   (q_nband :UInt8)                             ;  еее number of bands 
   (q_pad1 (:array :UInt8 1))                   ;  еее reserved 
   (q_osx (:pointer :q_xtra))                   ;  Pointer to OS-dependent extra stuff 
   (q_ffcp (:pointer :queue))                   ;  Forward flow control pointer 
   (q_bfcp (:pointer :queue))                   ;  Backward flow control pointer 
)

(def-mactype :queuePtr (find-mactype '(:pointer :queue)))

(def-mactype :queue_t (find-mactype ':queue))
; #define q_link          q_u.q_u_link
; #define q_sqh_parent    q_u.q_u_sqh_parent
;  queue_t flag defines 

(defconstant $QREADR 1)                         ;  This queue is a read queue 

(defconstant $QNOENB 2)                         ;  Don't enable in putq 

(defconstant $QFULL 4)                          ;  The queue is full 

(defconstant $QWANTR 8)                         ;  The queue should be scheduled in the next putq 

(defconstant $QWANTW 16)                        ;  The stream should be back enabled when this queue drains 

(defconstant $QUSE 32)                          ;  The queue is allocated and ready for use 

(defconstant $QENAB 64)                         ;  The queue is scheduled (on the run queue) 

(defconstant $QBACK #x80)                       ;  The queue has been back enabled 

(defconstant $QOLD #x100)                       ;  Module supports old style opens and closes 

(defconstant $QHLIST #x200)                     ;  The Stream head is doing something with this queue (Not supported by MPS) 

(defconstant $QWELDED #x400)                    ;  Mentat flag for welded queues 

(defconstant $QUNWELDING #x800)                 ;  Queue is scheduled to be unwelded 

(defconstant $QPROTECTED #x1000)                ;  Mentat flag for unsafe q access 

(defconstant $QEXCOPENCLOSE #x2000)             ;  Queue wants exclusive open/close calls 

;  qband_t flag defines 

(defconstant $QB_FULL 1)                        ;  The band is full 

(defconstant $QB_WANTW 2)                       ;  The stream should be back enabled when this band/queue drains 

(defconstant $QB_BACK 4)                        ;  The queue has been back enabled 


; #else
; 
;    Client code views a queue_t as a simple cookie.
;    The real definition lives above and is only available
;    to kernel code.
; 

(def-mactype :queue_t (find-mactype ':SInt32))

; #endif  /* OTKERNEL */

;  structure contained in M_COPYIN/M_COPYOUT messages 

(def-mactype :caddr_t (find-mactype '(:pointer :character)))
(defrecord copyreq
   (cq_cmd :SInt32)                             ;  ioctl command (from ioc_cmd) 
   (cq_cr (:pointer :cred))                     ;  pointer to full credentials 
   (cq_id :UInt32)                              ;  ioctl id (from ioc_id) 
   (cq_addr (:pointer :character))              ;  address to copy data to/from 
   (cq_size :UInt32)                            ;  number of bytes to copy 
   (cq_flag :SInt32)                            ;  state 
   (cq_private (:pointer :mblk_t))              ;  private state information 
   (cq_filler (:array :signed-long 4))
)

;type name? (def-mactype :copyreq (find-mactype ':copyreq))
; #define cq_uid  cq_cr->cr_uid
; #define cq_gid  cq_cr->cr_gid
;  copyreq defines 

(defconstant $STRCANON 1)                       ;  b_cont data block contains canonical format specifier 

(defconstant $RECOPY 2)                         ;  perform I_STR copyin again this time using canonical format specifier 

;  structure contained in M_IOCDATA message block 
(defrecord copyresp
   (cp_cmd :SInt32)                             ;  ioctl command (from ioc_cmd) 
   (cp_cr (:pointer :cred))                     ;  pointer to full credentials 
   (cp_id :UInt32)                              ;  ioctl id (from ioc_id) 
   (cp_rval (:pointer :character))              ;  status of request; 0 for success; error value for failure 
   (cp_pad1 :UInt32)
   (cp_pad2 :SInt32)
   (cp_private (:pointer :mblk_t))              ;  private state information 
   (cp_filler (:array :signed-long 4))
)

;type name? (def-mactype :copyresp (find-mactype ':copyresp))
; #define cp_uid  cp_cr->cr_uid
; #define cp_gid  cp_cr->cr_gid
;  structure contained in an M_IOCTL message block 
(defrecord iocblk
   (ioc_cmd :SInt32)                            ;  ioctl command type 
   (ioc_cr (:pointer :cred))                    ;  pointer to full credentials 
   (ioc_id :UInt32)                             ;  ioctl id 
   (ioc_count :UInt32)                          ;  count of bytes in data field 
   (ioc_error :SInt32)                          ;  error code 
   (ioc_rval :SInt32)                           ;  return value 
   (ioc_filler (:array :signed-long 4))
)

;type name? (def-mactype :iocblk (find-mactype ':iocblk))
; #define ioc_uid ioc_cr->cr_uid
; #define ioc_gid ioc_cr->cr_gid

(defconstant $TRANSPARENT #xFFFFFFFF)
; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define TRANSPARENT TRANSPARENT
;  Used in M_IOCTL mblks to muxes (ioc_cmd I_LINK) 
(defrecord linkblk
   (l_qtop (:pointer :queue_t))                 ;  lowest level write queue of upper stream 
   (l_qbot (:pointer :queue_t))                 ;  highest level write queue of lower stream 
   (l_index :SInt32)                            ;  system-unique index for lower stream 
   (l_pad (:array :signed-long 5))
)

;type name? (def-mactype :linkblk (find-mactype ':linkblk))
;  structure contained in an M_PASSFP message block 
(defrecord strpfp
   (pass_file_cookie :UInt32)                   ;  file 'pointer' 
   (pass_uid :UInt16)                           ;  user id of sending stream 
   (pass_gid :UInt16)
   (pass_sth (:pointer :sth_s))                 ;  Stream head pointer of passed stream 
)

;type name? (def-mactype :strpfp (find-mactype ':strpfp))
;  structure contained in an M_SETOPTS message block 
(defrecord stroptions
   (so_flags :UInt32)                           ;  options to set 
   (so_readopt :SInt16)                         ;  read option 
   (so_wroff :UInt16)                           ;  write offset 
   (so_minpsz :signed-long)                     ;  minimum read packet size 
   (so_maxpsz :signed-long)                     ;  maximum read packet size 
   (so_hiwat :UInt32)                           ;  read queue high-water mark 
   (so_lowat :UInt32)                           ;  read queue low-water mark 
   (so_band :UInt8)                             ;  band for water marks 
   (so_filler (:array :UInt8 3))                ;  added for alignment 
   (so_poll_set :UInt32)                        ;  poll events to set 
   (so_poll_clr :UInt32)                        ;  poll events to clear 
)

;type name? (def-mactype :stroptions (find-mactype ':stroptions))
;  definitions for so_flags field 

(defconstant $SO_ALL #x7FFF)                    ;  Update all options 

(defconstant $SO_READOPT 1)                     ;  Set the read mode 

(defconstant $SO_WROFF 2)                       ;  Insert an offset in write M_DATA mblks 

(defconstant $SO_MINPSZ 4)                      ;  Change the min packet size on sth rq 

(defconstant $SO_MAXPSZ 8)                      ;  Change the max packet size on sth rq 

(defconstant $SO_HIWAT 16)                      ;  Change the high water mark on sth rq 

(defconstant $SO_LOWAT 32)                      ;  Change the low water mark 

(defconstant $SO_MREADON 64)                    ;  Request M_READ messages 

(defconstant $SO_MREADOFF #x80)                 ;  Don't gen M_READ messages 

(defconstant $SO_NDELON #x100)                  ;  old TTY semantics for O_NDELAY reads and writes 

(defconstant $SO_NDELOFF #x200)                 ;  STREAMS semantics for O_NDELAY reads and writes 

(defconstant $SO_ISTTY #x400)                   ;  Become a controlling tty 

(defconstant $SO_ISNTTY #x800)                  ;  No longer a controlling tty 

(defconstant $SO_TOSTOP #x1000)                 ;  Stop on background writes 

(defconstant $SO_TONSTOP #x2000)                ;  Don't stop on background writes 

(defconstant $SO_BAND #x4000)                   ;  Water marks are for a band 

(defconstant $SO_POLL_SET #x8000)               ;  Set events to poll 

(defconstant $SO_POLL_CLR #x10000)              ;  Clear events to poll 

;  Buffer Allocation Priority 

(defconstant $BPRI_LO 1)
(defconstant $BPRI_MED 2)
(defconstant $BPRI_HI 3)

(defconstant $INFPSZ -1)
; * Test whether message is a data message 
; #define datamsg(type)   ((type) == M_DATA || (type) == M_PROTO || (type) == M_PCPROTO  ||  (type) == M_DELAY)

(defconstant $CLONEOPEN 2)
(defconstant $MODOPEN 1)
(defconstant $OPENFAIL -1)
;  Enumeration values for strqget and strqset 

(def-mactype :qfields (find-mactype ':SInt32))

(defconstant $QHIWAT 0)
(defconstant $QLOWAT 1)
(defconstant $QMAXPSZ 2)
(defconstant $QMINPSZ 3)
(defconstant $QCOUNT 4)
(defconstant $QFIRST 5)
(defconstant $QLAST 6)
(defconstant $QFLAG 7)
(defconstant $QBAD 8)

(def-mactype :qfields_t (find-mactype ':qfields))
 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  ***** From the Mentat "stropts.h" *****

(defconstant $I_NREAD #x4101)                   ;  return the number of bytes in 1st msg 

(defconstant $I_PUSH #x4102)                    ;  push module just below stream head 

(defconstant $I_POP #x4103)                     ;  pop module below stream head 

(defconstant $I_LOOK #x4104)                    ;  retrieve name of first stream module 

(defconstant $I_FLUSH #x4105)                   ;  flush all input and/or output queues 

(defconstant $I_SRDOPT #x4106)                  ;  set the read mode 

(defconstant $I_GRDOPT #x4107)                  ;  get the current read mode 

(defconstant $I_STR #x4108)                     ;  create an internal ioctl message      

(defconstant $I_SETSIG #x4109)                  ;  request SIGPOLL signal on events 

(defconstant $I_GETSIG #x410A)                  ;  query the registered events 

(defconstant $I_FIND #x410B)                    ;  check for module in stream          

(defconstant $I_LINK #x410C)                    ;  connect stream under mux fd 

(defconstant $I_UNLINK #x410D)                  ;  disconnect two streams 

(defconstant $I_PEEK #x410F)                    ;  peek at data on read queue 

(defconstant $I_FDINSERT #x4110)                ;  create a message and send downstream 

(defconstant $I_SENDFD #x4111)                  ;  send an fd to a connected pipe stream 

(defconstant $I_RECVFD #x4112)                  ;  retrieve a file descriptor 

(defconstant $I_FLUSHBAND #x4113)               ;  flush a particular input and/or output band 

(defconstant $I_SWROPT #x4114)                  ;  set the write mode 

(defconstant $I_GWROPT #x4115)                  ;  get the current write mode 

(defconstant $I_LIST #x4116)                    ;  get a list of all modules on a stream  

(defconstant $I_ATMARK #x4117)                  ;  check to see if the next message is "marked" 

(defconstant $I_CKBAND #x4118)                  ;  check for a message of a particular band 

(defconstant $I_GETBAND #x4119)                 ;  get the band of the next message to be read 

(defconstant $I_CANPUT #x411A)                  ;  check to see if a message may be passed on a stream 

(defconstant $I_SETCLTIME #x411B)               ;  set the close timeout wait 

(defconstant $I_GETCLTIME #x411C)               ;  get the current close timeout wait 

(defconstant $I_PLINK #x411D)                   ;  permanently connect a stream under a mux 

(defconstant $I_PUNLINK #x411E)                 ;  disconnect a permanent link 

(defconstant $I_GETMSG #x4128)                  ;  getmsg() system call 

(defconstant $I_PUTMSG #x4129)                  ;  putmsg() system call 

(defconstant $I_POLL #x412A)                    ;  poll() system call 

(defconstant $I_SETDELAY #x412B)                ;  set blocking status 

(defconstant $I_GETDELAY #x412C)                ;  get blocking status 

(defconstant $I_RUN_QUEUES #x412D)              ;  sacrifice for the greater good 

(defconstant $I_GETPMSG #x412E)                 ;  getpmsg() system call 

(defconstant $I_PUTPMSG #x412F)                 ;  putpmsg() system call 

(defconstant $I_AUTOPUSH #x4130)                ;  for systems that cannot do the autopush in open 

(defconstant $I_PIPE #x4131)                    ;  for pipe library call 

(defconstant $I_HEAP_REPORT #x4132)             ;  get heap statistics 
;  for fifo library call 

(defconstant $I_FIFO #x4133)
; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define I_SWROPT I_SWROPT
; #define I_PUSH I_PUSH
;  priority message request on putmsg() or strpeek 

(defconstant $RS_HIPRI 1)
;  flags for getpmsg and putpmsg 

(defconstant $MSG_HIPRI 1)
(defconstant $MSG_BAND 2)                       ;  Retrieve a message from a particular band 

(defconstant $MSG_ANY 4)                        ;  Retrieve a message from any band 

;  return values from getmsg(), 0 indicates all ok 

(defconstant $MORECTL 1)                        ;  more control info available 

(defconstant $MOREDATA 2)                       ;  more data available 


(defconstant $FMNAMESZ 31)                      ;  maximum length of a module or device name 

;  Infinite poll wait time 

(defconstant $INFTIM #xFFFFFFFF)
;  flush requests 

(defconstant $FLUSHR 1)                         ;  Flush the read queue 

(defconstant $FLUSHW 2)                         ;  Flush the write queue 
;  Flush both 

(defconstant $FLUSHRW 3)

(defconstant $FLUSHBAND 64)                     ;  Flush a particular band 

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define FLUSHBAND FLUSHBAND
;  I_FLUSHBAND 
(defrecord bandinfo
   (bi_pri :UInt8)                              ;  Band to flush 
   (pad1 :character)
   (bi_flag :SInt32)                            ;  One of the above flush requests 
)

;type name? (%define-record :bandinfo (find-record-descriptor ':bandinfo))
;  flags for I_ATMARK 

(defconstant $ANYMARK 1)                        ;  Check if message is marked 

(defconstant $LASTMARK 2)                       ;  Check if this is the only message marked 

;  signal event masks 

(defconstant $S_INPUT 1)                        ;  A non-M_PCPROTO message has arrived 

(defconstant $S_HIPRI 2)                        ;  A priority (M_PCPROTO) message is available 

(defconstant $S_OUTPUT 4)                       ;  The write queue is no longer full 

(defconstant $S_MSG 8)                          ;  A signal message has reached the front of read queue 

(defconstant $S_RDNORM 16)                      ;  A non-priority message is available 

(defconstant $S_RDBAND 32)                      ;  A banded messsage is available 

(defconstant $S_WRNORM 64)                      ;  Same as S_OUTPUT 

(defconstant $S_WRBAND #x80)                    ;  A priority band exists and is writable 

(defconstant $S_ERROR #x100)                    ;  Error message has arrived 

(defconstant $S_HANGUP #x200)                   ;  Hangup message has arrived 

(defconstant $S_BANDURG #x400)                  ;  Use SIGURG instead of SIGPOLL on S_RDBAND signals 

;  read mode bits for I_S|GRDOPT; choose one of the following 

(defconstant $RNORM 1)                          ;  byte-stream mode, default 

(defconstant $RMSGD 2)                          ;  message-discard mode 

(defconstant $RMSGN 4)                          ;  message-nondiscard mode 

(defconstant $RFILL 8)                          ;  fill read buffer mode (PSE private) 

;  More read modes, these are bitwise or'ed with the modes above 

(defconstant $RPROTNORM 16)                     ;  Normal handling of M_PROTO/M_PCPROTO messages, default 

(defconstant $RPROTDIS 32)                      ;  Discard M_PROTO/M_PCPROTO message blocks 

(defconstant $RPROTDAT 64)                      ;  Convert M_PROTO/M_PCPROTO message blocks into M_DATA 

;  write modes for I_S|GWROPT 

(defconstant $SNDZERO 1)                        ;  Send a zero-length message downstream on a write of zero bytes 

;  Unlink all lower streams for I_UNLINK and I_PUNLINK 

(defconstant $MUXID_ALL -1)
; 
;    strbuf is moved to "OpenTransport.h" because that header file
;    exports provider routines that take it as a parameter.
; 
;  structure of ioctl data on I_FDINSERT 
(defrecord strfdinsert
   (ctlbuf :strbuf)
   (databuf :strbuf)
   (flags :signed-long)                         ;  type of message, 0 or RS_HIPRI 
   (fildes :signed-long)                        ;  fd of other stream (FDCELL) 
   (offset :SInt32)                             ;  where to put other stream read qp 
)

;type name? (%define-record :strfdinsert (find-record-descriptor ':strfdinsert))
;  I_LIST structures 
(defrecord str_mlist
   (l_name (:array :character 32))
)

;type name? (%define-record :str_mlist (find-record-descriptor ':str_mlist))
(defrecord str_list
   (sl_nmods :SInt32)                           ;  number of modules in sl_modlist array 
   (sl_modlist (:pointer :str_mlist))
)

;type name? (%define-record :str_list (find-record-descriptor ':str_list))
;  I_PEEK structure 
(defrecord strpeek
   (ctlbuf :strbuf)
   (databuf :strbuf)
   (flags :signed-long)                         ;  if RS_HIPRI, get priority messages only 
)

;type name? (%define-record :strpeek (find-record-descriptor ':strpeek))
;  structure for getpmsg and putpmsg 
(defrecord strpmsg
   (ctlbuf :strbuf)
   (databuf :strbuf)
   (band :SInt32)
   (flags :signed-long)
)

;type name? (%define-record :strpmsg (find-record-descriptor ':strpmsg))
;  structure of ioctl data on I_RECVFD 
(defrecord strrecvfd
   (fd :signed-long)                            ;  new file descriptor (FDCELL) 
   (uid :UInt16)                                ;  user id of sending stream 
   (gid :UInt16)
   (fill (:array :character 8))
)

;type name? (%define-record :strrecvfd (find-record-descriptor ':strrecvfd))
;  structure of ioctl data on I_STR 
(defrecord strioctl
   (ic_cmd :SInt32)                             ;  downstream command 
   (ic_timout :SInt32)                          ;  ACK/NAK timeout 
   (ic_len :SInt32)                             ;  length of data arg 
   (ic_dp (:pointer :char))                     ;  ptr to data arg 
)

;type name? (%define-record :strioctl (find-record-descriptor ':strioctl))
;  ***** From the Mentat "strlog.h" *****
(defrecord log_ctl
   (mid :SInt16)
   (sid :SInt16)
   (level :character)
   (pad1 :character)
   (flags :SInt16)
   (ltime :signed-long)
   (ttime :signed-long)
   (seq_no :SInt32)
)

;type name? (%define-record :log_ctl (find-record-descriptor ':log_ctl))

(defconstant $SL_FATAL 1)                       ;  Fatal error 

(defconstant $SL_NOTIFY 2)                      ;  Notify the system administrator 

(defconstant $SL_ERROR 4)                       ;  Pass message to error logger 

(defconstant $SL_TRACE 8)                       ;  Pass message to tracer 

(defconstant $SL_CONSOLE 0)                     ;  Console messages are disabled 

(defconstant $SL_WARN 32)                       ;  Warning 

(defconstant $SL_NOTE 64)                       ;  Notice this message 

(defrecord trace_ids
   (ti_mid :SInt16)
   (ti_sid :SInt16)
   (ti_level :character)
)

;type name? (%define-record :trace_ids (find-record-descriptor ':trace_ids))

(defconstant $I_TRCLOG #x6201)
(defconstant $I_ERRLOG #x6202)

(defconstant $LOGMSGSZ #x80)
;  ***** From the Mentat "tihdr.h" *****

; #if CALL_NOT_IN_CARBON
#|                                              ;  TPI Primitives

(defconstant $T_BIND_REQ 101)
(defconstant $T_CONN_REQ 102)                   ;  connection request 

(defconstant $T_CONN_RES 103)                   ;  respond to connection indication 

(defconstant $T_DATA_REQ 104)
(defconstant $T_DISCON_REQ 105)
(defconstant $T_EXDATA_REQ 106)
(defconstant $T_INFO_REQ 107)
(defconstant $T_OPTMGMT_REQ 108)
(defconstant $T_ORDREL_REQ 109)
(defconstant $T_UNBIND_REQ 110)
(defconstant $T_UNITDATA_REQ 111)
(defconstant $T_ADDR_REQ 112)                   ;  Get address request              

(defconstant $T_UREQUEST_REQ 113)               ;  UnitRequest (transaction) req    

(defconstant $T_REQUEST_REQ 114)                ;  Request (CO transaction) req     

(defconstant $T_UREPLY_REQ 115)                 ;  UnitRequest (transaction) req    

(defconstant $T_REPLY_REQ 116)                  ;  REPLY (CO transaction) req       

(defconstant $T_CANCELREQUEST_REQ 117)          ;  Cancel outgoing request          

(defconstant $T_CANCELREPLY_REQ 118)            ;  Cancel incoming request          

(defconstant $T_REGNAME_REQ 119)                ;  Request name registration        

(defconstant $T_DELNAME_REQ 120)                ;  Request delete name registration 

(defconstant $T_LKUPNAME_REQ 121)               ;  Request name lookup              

(defconstant $T_BIND_ACK 122)
(defconstant $T_CONN_CON 123)                   ;  connection confirmation          

(defconstant $T_CONN_IND 124)                   ;  incoming connection indication   

(defconstant $T_DATA_IND 125)
(defconstant $T_DISCON_IND 126)
(defconstant $T_ERROR_ACK 127)
(defconstant $T_EXDATA_IND #x80)
(defconstant $T_INFO_ACK #x81)
(defconstant $T_OK_ACK #x82)
(defconstant $T_OPTMGMT_ACK #x83)
(defconstant $T_ORDREL_IND #x84)
(defconstant $T_UNITDATA_IND #x85)
(defconstant $T_UDERROR_IND #x86)
(defconstant $T_ADDR_ACK #x87)                  ;  Get address ack                  

(defconstant $T_UREQUEST_IND #x88)              ;  UnitRequest (transaction) ind    

(defconstant $T_REQUEST_IND #x89)               ;  Request (CO transaction) ind     

(defconstant $T_UREPLY_IND #x8A)                ;  Incoming unit reply              

(defconstant $T_REPLY_IND #x8B)                 ;  Incoming reply                   

(defconstant $T_UREPLY_ACK #x8C)                ;  outgoing Unit Reply is complete  

(defconstant $T_REPLY_ACK #x8D)                 ;  outgoing Reply is complete       

(defconstant $T_RESOLVEADDR_REQ #x8E)
(defconstant $T_RESOLVEADDR_ACK #x8F)
(defconstant $T_LKUPNAME_CON #x92)              ;  Results of name lookup           

(defconstant $T_LKUPNAME_RES #x93)              ;  Partial results of name lookup   

(defconstant $T_REGNAME_ACK #x94)               ;  Request name registration        

(defconstant $T_SEQUENCED_ACK #x95)             ;  Sequenced version of OK or ERROR ACK 

(defconstant $T_EVENT_IND #xA0)                 ;  Miscellaneous event Indication       

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define T_ADDR_REQ T_ADDR_REQ
; #define T_ADDR_ACK T_ADDR_ACK
;  State values 

(defconstant $TS_UNBND 1)
(defconstant $TS_WACK_BREQ 2)
(defconstant $TS_WACK_UREQ 3)
(defconstant $TS_IDLE 4)
(defconstant $TS_WACK_OPTREQ 5)
(defconstant $TS_WACK_CREQ 6)
(defconstant $TS_WCON_CREQ 7)
(defconstant $TS_WRES_CIND 8)
(defconstant $TS_WACK_CRES 9)
(defconstant $TS_DATA_XFER 10)
(defconstant $TS_WIND_ORDREL 11)
(defconstant $TS_WREQ_ORDREL 12)
(defconstant $TS_WACK_DREQ6 13)
(defconstant $TS_WACK_DREQ7 14)
(defconstant $TS_WACK_DREQ9 15)
(defconstant $TS_WACK_DREQ10 16)
(defconstant $TS_WACK_DREQ11 17)
(defconstant $TS_WACK_ORDREL 18)
(defconstant $TS_NOSTATES 19)
(defconstant $TS_BAD_STATE 19)
;  Transport events 

(defconstant $TE_OPENED 1)
(defconstant $TE_BIND 2)
(defconstant $TE_OPTMGMT 3)
(defconstant $TE_UNBIND 4)
(defconstant $TE_CLOSED 5)
(defconstant $TE_CONNECT1 6)
(defconstant $TE_CONNECT2 7)
(defconstant $TE_ACCEPT1 8)
(defconstant $TE_ACCEPT2 9)
(defconstant $TE_ACCEPT3 10)
(defconstant $TE_SND 11)
(defconstant $TE_SNDDIS1 12)
(defconstant $TE_SNDDIS2 13)
(defconstant $TE_SNDREL 14)
(defconstant $TE_SNDUDATA 15)
(defconstant $TE_LISTEN 16)
(defconstant $TE_RCVCONNECT 17)
(defconstant $TE_RCV 18)
(defconstant $TE_RCVDIS1 19)
(defconstant $TE_RCVDIS2 20)
(defconstant $TE_RCVDIS3 21)
(defconstant $TE_RCVREL 22)
(defconstant $TE_RCVUDATA 23)
(defconstant $TE_RCVUDERR 24)
(defconstant $TE_PASS_CONN 25)
(defconstant $TE_BAD_EVENT 26)
(defrecord T_addr_ack
   (PRIM_type :signed-long)                     ;  Always T_ADDR_ACK 
   (LOCADDR_length :signed-long)
   (LOCADDR_offset :signed-long)
   (REMADDR_length :signed-long)
   (REMADDR_offset :signed-long)
)

;type name? (def-mactype :T_addr_ack (find-mactype ':T_addr_ack))
(defrecord T_addr_req
   (PRIM_type :signed-long)                     ;  Always T_ADDR_REQ 
)

;type name? (def-mactype :T_addr_req (find-mactype ':T_addr_req))
(defrecord T_bind_ack
   (PRIM_type :signed-long)                     ;  always T_BIND_ACK 
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
   (CONIND_number :UInt32)
)

;type name? (def-mactype :T_bind_ack (find-mactype ':T_bind_ack))
(defrecord T_bind_req
   (PRIM_type :signed-long)                     ;  always T_BIND_REQ 
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
   (CONIND_number :UInt32)
)

;type name? (def-mactype :T_bind_req (find-mactype ':T_bind_req))
(defrecord T_conn_con
   (PRIM_type :signed-long)                     ;  always T_CONN_CON 
   (RES_length :signed-long)                    ;  responding address length 
   (RES_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
)

;type name? (def-mactype :T_conn_con (find-mactype ':T_conn_con))
(defrecord T_conn_ind
   (PRIM_type :signed-long)                     ;  always T_CONN_IND 
   (SRC_length :signed-long)
   (SRC_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (SEQ_number :signed-long)
)

;type name? (def-mactype :T_conn_ind (find-mactype ':T_conn_ind))
(defrecord T_conn_req
   (PRIM_type :signed-long)                     ;  always T_CONN_REQ 
   (DEST_length :signed-long)
   (DEST_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
)

;type name? (def-mactype :T_conn_req (find-mactype ':T_conn_req))
(defrecord T_conn_res
   (PRIM_type :signed-long)                     ;  always T_CONN_RES 
   (QUEUE_ptr (:pointer :queue_t))
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (SEQ_number :signed-long)
)

;type name? (def-mactype :T_conn_res (find-mactype ':T_conn_res))
(defrecord T_data_ind
   (PRIM_type :signed-long)                     ;  always T_DATA_IND 
   (MORE_flag :signed-long)
)

;type name? (def-mactype :T_data_ind (find-mactype ':T_data_ind))
(defrecord T_data_req
   (PRIM_type :signed-long)                     ;  always T_DATA_REQ 
   (MORE_flag :signed-long)
)

;type name? (def-mactype :T_data_req (find-mactype ':T_data_req))
(defrecord T_discon_ind
   (PRIM_type :signed-long)                     ;  always T_DISCON_IND 
   (DISCON_reason :signed-long)
   (SEQ_number :signed-long)
)

;type name? (def-mactype :T_discon_ind (find-mactype ':T_discon_ind))
(defrecord T_discon_req
   (PRIM_type :signed-long)                     ;  always T_DISCON_REQ 
   (SEQ_number :signed-long)
)

;type name? (def-mactype :T_discon_req (find-mactype ':T_discon_req))
(defrecord T_exdata_ind
   (PRIM_type :signed-long)                     ;  always T_EXDATA_IND 
   (MORE_flag :signed-long)
)

;type name? (def-mactype :T_exdata_ind (find-mactype ':T_exdata_ind))
(defrecord T_exdata_req
   (PRIM_type :signed-long)                     ;  always T_EXDATA_REQ 
   (MORE_flag :signed-long)
)

;type name? (def-mactype :T_exdata_req (find-mactype ':T_exdata_req))
(defrecord T_error_ack
   (PRIM_type :signed-long)                     ;  always T_ERROR_ACK 
   (ERROR_prim :signed-long)                    ;  primitive in error 
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_error_ack (find-mactype ':T_error_ack))
(defrecord T_info_ack
   (PRIM_type :signed-long)                     ;  always T_INFO_ACK 
   (TSDU_size :signed-long)                     ;  max TSDU size 
   (ETSDU_size :signed-long)                    ;  max ETSDU size 
   (CDATA_size :signed-long)                    ;  connect data size 
   (DDATA_size :signed-long)                    ;  disconnect data size 
   (ADDR_size :signed-long)                     ;  TSAP size 
   (OPT_size :signed-long)                      ;  options size 
   (TIDU_size :signed-long)                     ;  TIDU size 
   (SERV_type :signed-long)                     ;  service type 
   (CURRENT_state :signed-long)                 ;  current state 
   (PROVIDER_flag :signed-long)                 ;  provider flags (see xti.h for defines) 
)

;type name? (def-mactype :T_info_ack (find-mactype ':T_info_ack))
;  Provider flags 

(defconstant $SENDZERO 1)                       ;  supports 0-length TSDU's 

(defconstant $XPG4_1 2)                         ;  provider supports recent stuff 

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define XPG4_1 XPG4_1
(defrecord T_info_req
   (PRIM_type :signed-long)                     ;  always T_INFO_REQ 
)

;type name? (def-mactype :T_info_req (find-mactype ':T_info_req))
(defrecord T_ok_ack
   (PRIM_type :signed-long)                     ;  always T_OK_ACK 
   (CORRECT_prim :signed-long)
)

;type name? (def-mactype :T_ok_ack (find-mactype ':T_ok_ack))
(defrecord T_optmgmt_ack
   (PRIM_type :signed-long)                     ;  always T_OPTMGMT_ACK 
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (MGMT_flags :signed-long)
)

;type name? (def-mactype :T_optmgmt_ack (find-mactype ':T_optmgmt_ack))
(defrecord T_optmgmt_req
   (PRIM_type :signed-long)                     ;  always T_OPTMGMT_REQ 
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (MGMT_flags :signed-long)
)

;type name? (def-mactype :T_optmgmt_req (find-mactype ':T_optmgmt_req))
(defrecord T_ordrel_ind
   (PRIM_type :signed-long)                     ;  always T_ORDREL_IND 
)

;type name? (def-mactype :T_ordrel_ind (find-mactype ':T_ordrel_ind))
(defrecord T_ordrel_req
   (PRIM_type :signed-long)                     ;  always T_ORDREL_REQ 
)

;type name? (def-mactype :T_ordrel_req (find-mactype ':T_ordrel_req))
(defrecord T_unbind_req
   (PRIM_type :signed-long)                     ;  always T_UNBIND_REQ 
)

;type name? (def-mactype :T_unbind_req (find-mactype ':T_unbind_req))
(defrecord T_uderror_ind
   (PRIM_type :signed-long)                     ;  always T_UDERROR_IND 
   (DEST_length :signed-long)
   (DEST_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (ERROR_type :signed-long)
)

;type name? (def-mactype :T_uderror_ind (find-mactype ':T_uderror_ind))
(defrecord T_unitdata_ind
   (PRIM_type :signed-long)                     ;  always T_UNITDATA_IND 
   (SRC_length :signed-long)
   (SRC_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
)

;type name? (def-mactype :T_unitdata_ind (find-mactype ':T_unitdata_ind))
(defrecord T_unitdata_req
   (PRIM_type :signed-long)                     ;  always T_UNITDATA_REQ 
   (DEST_length :signed-long)
   (DEST_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
)

;type name? (def-mactype :T_unitdata_req (find-mactype ':T_unitdata_req))
(defrecord T_resolveaddr_ack
   (PRIM_type :signed-long)                     ;  always T_RESOLVEADDR_ACK 
   (SEQ_number :signed-long)
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
   (ORIG_client :signed-long)
   (ORIG_data :signed-long)
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_resolveaddr_ack (find-mactype ':T_resolveaddr_ack))
(defrecord T_resolveaddr_req
   (PRIM_type :signed-long)                     ;  always T_RESOLVEADDR_REQ 
   (SEQ_number :signed-long)
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
   (ORIG_client :signed-long)
   (ORIG_data :signed-long)
   (MAX_milliseconds :signed-long)
)

;type name? (def-mactype :T_resolveaddr_req (find-mactype ':T_resolveaddr_req))
(defrecord T_unitreply_ind
   (PRIM_type :signed-long)                     ;  Always T_UREPLY_IND 
   (SEQ_number :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REP_flags :signed-long)
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_unitreply_ind (find-mactype ':T_unitreply_ind))
(defrecord T_unitrequest_ind
   (PRIM_type :signed-long)                     ;  Always T_UREQUEST_IND 
   (SEQ_number :signed-long)
   (SRC_length :signed-long)
   (SRC_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REQ_flags :signed-long)
)

;type name? (def-mactype :T_unitrequest_ind (find-mactype ':T_unitrequest_ind))
(defrecord T_unitrequest_req
   (PRIM_type :signed-long)                     ;  Always T_UREQUEST_REQ 
   (SEQ_number :signed-long)
   (DEST_length :signed-long)
   (DEST_offset :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REQ_flags :signed-long)
)

;type name? (def-mactype :T_unitrequest_req (find-mactype ':T_unitrequest_req))
(defrecord T_unitreply_req
   (PRIM_type :signed-long)                     ;  Always T_UREPLY_REQ 
   (SEQ_number :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REP_flags :signed-long)
)

;type name? (def-mactype :T_unitreply_req (find-mactype ':T_unitreply_req))
(defrecord T_unitreply_ack
   (PRIM_type :signed-long)                     ;  Always T_UREPLY_ACK 
   (SEQ_number :signed-long)
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_unitreply_ack (find-mactype ':T_unitreply_ack))
(defrecord T_cancelrequest_req
   (PRIM_type :signed-long)                     ;  Always T_CANCELREQUEST_REQ 
   (SEQ_number :signed-long)
)

;type name? (def-mactype :T_cancelrequest_req (find-mactype ':T_cancelrequest_req))
(defrecord T_cancelreply_req
   (PRIM_type :signed-long)                     ;  Always T_CANCELREPLY_REQ 
   (SEQ_number :signed-long)
)

;type name? (def-mactype :T_cancelreply_req (find-mactype ':T_cancelreply_req))
(defrecord T_reply_ind
   (PRIM_type :signed-long)                     ;  Always T_REPLY_IND 
   (SEQ_number :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REP_flags :signed-long)
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_reply_ind (find-mactype ':T_reply_ind))
(defrecord T_request_ind
   (PRIM_type :signed-long)                     ;  Always T_REQUEST_IND 
   (SEQ_number :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REQ_flags :signed-long)
)

;type name? (def-mactype :T_request_ind (find-mactype ':T_request_ind))
(defrecord T_request_req
   (PRIM_type :signed-long)                     ;  Always T_REQUEST_REQ 
   (SEQ_number :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REQ_flags :signed-long)
)

;type name? (def-mactype :T_request_req (find-mactype ':T_request_req))
(defrecord T_reply_req
   (PRIM_type :signed-long)                     ;  Always T_REPLY_REQ 
   (SEQ_number :signed-long)
   (OPT_length :signed-long)
   (OPT_offset :signed-long)
   (REP_flags :signed-long)
)

;type name? (def-mactype :T_reply_req (find-mactype ':T_reply_req))
(defrecord T_reply_ack
   (PRIM_type :signed-long)                     ;  Always T_REPLY_ACK 
   (SEQ_number :signed-long)
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_reply_ack (find-mactype ':T_reply_ack))
(defrecord T_regname_req
   (PRIM_type :signed-long)                     ;  Always T_REGNAME_REQ 
   (SEQ_number :signed-long)                    ;  Reply is sequence ack 
   (NAME_length :signed-long)
   (NAME_offset :signed-long)
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
   (REQ_flags :signed-long)
)

;type name? (def-mactype :T_regname_req (find-mactype ':T_regname_req))
(defrecord T_regname_ack
   (PRIM_type :signed-long)                     ;  always T_REGNAME_ACK     
   (SEQ_number :signed-long)
   (REG_id :signed-long)
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
)

;type name? (def-mactype :T_regname_ack (find-mactype ':T_regname_ack))
(defrecord T_delname_req
   (PRIM_type :signed-long)                     ;  Always T_DELNAME_REQ 
   (SEQ_number :signed-long)                    ;  Reply is sequence ack 
   (NAME_length :signed-long)
   (NAME_offset :signed-long)
)

;type name? (def-mactype :T_delname_req (find-mactype ':T_delname_req))
(defrecord T_lkupname_req
   (PRIM_type :signed-long)                     ;  Always T_LKUPNAME_REQ 
   (SEQ_number :signed-long)                    ;  Reply is sequence ack 
   (NAME_length :signed-long)                   ;  ... or T_LKUPNAME_CON 
   (NAME_offset :signed-long)
   (ADDR_length :signed-long)
   (ADDR_offset :signed-long)
   (MAX_number :signed-long)
   (MAX_milliseconds :signed-long)
   (REQ_flags :signed-long)
)

;type name? (def-mactype :T_lkupname_req (find-mactype ':T_lkupname_req))
(defrecord T_lkupname_con
   (PRIM_type :signed-long)                     ;  Either T_LKUPNAME_CON 
   (SEQ_number :signed-long)                    ;  Or T_LKUPNAME_RES 
   (NAME_length :signed-long)
   (NAME_offset :signed-long)
   (RSP_count :signed-long)
   (RSP_cumcount :signed-long)
)

;type name? (def-mactype :T_lkupname_con (find-mactype ':T_lkupname_con))
(defrecord T_sequence_ack
   (PRIM_type :signed-long)                     ;  always T_SEQUENCED_ACK     
   (ORIG_prim :signed-long)                     ;  original primitive        
   (SEQ_number :signed-long)
   (TLI_error :signed-long)
   (UNIX_error :signed-long)
)

;type name? (def-mactype :T_sequence_ack (find-mactype ':T_sequence_ack))
(defrecord T_event_ind
   (PRIM_type :signed-long)                     ;  always T_EVENT_IND        
   (EVENT_code :signed-long)
   (EVENT_cookie :signed-long)
)

;type name? (def-mactype :T_event_ind (find-mactype ':T_event_ind))
(defrecord T_primitives
   (:variant
   (
   (type :signed-long)
   )
   (
   (primType :signed-long)
   )
   (
   (taddrack :T_addr_ack)
   )
   (
   (tbindack :T_bind_ack)
   )
   (
   (tbindreq :T_bind_req)
   )
   (
   (tconncon :T_conn_con)
   )
   (
   (tconnind :T_conn_ind)
   )
   (
   (tconnreq :T_conn_req)
   )
   (
   (tconnres :T_conn_res)
   )
   (
   (tdataind :T_data_ind)
   )
   (
   (tdatareq :T_data_req)
   )
   (
   (tdisconind :T_discon_ind)
   )
   (
   (tdisconreq :T_discon_req)
   )
   (
   (texdataind :T_exdata_ind)
   )
   (
   (texdatareq :T_exdata_req)
   )
   (
   (terrorack :T_error_ack)
   )
   (
   (tinfoack :T_info_ack)
   )
   (
   (tinforeq :T_info_req)
   )
   (
   (tokack :T_ok_ack)
   )
   (
   (toptmgmtack :T_optmgmt_ack)
   )
   (
   (toptmgmtreq :T_optmgmt_req)
   )
   (
   (tordrelind :T_ordrel_ind)
   )
   (
   (tordrelreq :T_ordrel_req)
   )
   (
   (tunbindreq :T_unbind_req)
   )
   (
   (tuderrorind :T_uderror_ind)
   )
   (
   (tunitdataind :T_unitdata_ind)
   )
   (
   (tunitdatareq :T_unitdata_req)
   )
   (
   (tunitreplyind :T_unitreply_ind)
   )
   (
   (tunitrequestind :T_unitrequest_ind)
   )
   (
   (tunitrequestreq :T_unitrequest_req)
   )
   (
   (tunitreplyreq :T_unitreply_req)
   )
   (
   (tunitreplyack :T_unitreply_ack)
   )
   (
   (treplyind :T_reply_ind)
   )
   (
   (trequestind :T_request_ind)
   )
   (
   (trequestreq :T_request_req)
   )
   (
   (treplyreq :T_reply_req)
   )
   (
   (treplyack :T_reply_ack)
   )
   (
   (tcancelreqreq :T_cancelrequest_req)
   )
   (
   (tresolvereq :T_resolveaddr_req)
   )
   (
   (tresolveack :T_resolveaddr_ack)
   )
   (
   (tregnamereq :T_regname_req)
   )
   (
   (tregnameack :T_regname_ack)
   )
   (
   (tdelnamereq :T_delname_req)
   )
   (
   (tlkupnamereq :T_lkupname_req)
   )
   (
   (tlkupnamecon :T_lkupname_con)
   )
   (
   (tsequenceack :T_sequence_ack)
   )
   (
   (teventind :T_event_ind)
   )
   )
)

;type name? (def-mactype :T_primitives (find-mactype ':T_primitives))
;  ***** From the Mentat "dlpi.h" *****
; 
;    This header file has encoded the values so an existing driver
;    or user which was written with the Logical Link Interface(LLI)
;    can migrate to the DLPI interface in a binary compatible manner.
;    Any fields which require a specific format or value are flagged
;    with a comment containing the message LLI compatibility.
; 
;  DLPI revision definition history

(defconstant $DL_CURRENT_VERSION 2)             ;  current version of dlpi 

(defconstant $DL_VERSION_2 2)                   ;  version of dlpi March 12,1991 


(defconstant $DL_INFO_REQ 0)                    ;  Information Req, LLI compatibility 

(defconstant $DL_INFO_ACK 3)                    ;  Information Ack, LLI compatibility 

(defconstant $DL_ATTACH_REQ 11)                 ;  Attach a PPA 

(defconstant $DL_DETACH_REQ 12)                 ;  Detach a PPA 

(defconstant $DL_BIND_REQ 1)                    ;  Bind dlsap address, LLI compatibility 

(defconstant $DL_BIND_ACK 4)                    ;  Dlsap address bound, LLI compatibility 

(defconstant $DL_UNBIND_REQ 2)                  ;  Unbind dlsap address, LLI compatibility 

(defconstant $DL_OK_ACK 6)                      ;  Success acknowledgment, LLI compatibility 

(defconstant $DL_ERROR_ACK 5)                   ;  Error acknowledgment, LLI compatibility 

(defconstant $DL_SUBS_BIND_REQ 27)              ;  Bind Subsequent DLSAP address 

(defconstant $DL_SUBS_BIND_ACK 28)              ;  Subsequent DLSAP address bound 

(defconstant $DL_SUBS_UNBIND_REQ 21)            ;  Subsequent unbind 

(defconstant $DL_ENABMULTI_REQ 29)              ;  Enable multicast addresses 

(defconstant $DL_DISABMULTI_REQ 30)             ;  Disable multicast addresses 

(defconstant $DL_PROMISCON_REQ 31)              ;  Turn on promiscuous mode 

(defconstant $DL_PROMISCOFF_REQ 32)             ;  Turn off promiscuous mode 

(defconstant $DL_UNITDATA_REQ 7)                ;  datagram send request, LLI compatibility 

(defconstant $DL_UNITDATA_IND 8)                ;  datagram receive indication, LLI compatibility 

(defconstant $DL_UDERROR_IND 9)                 ;  datagram error indication, LLI compatibility 

(defconstant $DL_UDQOS_REQ 10)                  ;  set QOS for subsequent datagram transmissions 

(defconstant $DL_CONNECT_REQ 13)                ;  Connect request 

(defconstant $DL_CONNECT_IND 14)                ;  Incoming connect indication 

(defconstant $DL_CONNECT_RES 15)                ;  Accept previous connect indication 

(defconstant $DL_CONNECT_CON 16)                ;  Connection established 

(defconstant $DL_TOKEN_REQ 17)                  ;  Passoff token request 

(defconstant $DL_TOKEN_ACK 18)                  ;  Passoff token ack 

(defconstant $DL_DISCONNECT_REQ 19)             ;  Disconnect request 

(defconstant $DL_DISCONNECT_IND 20)             ;  Disconnect indication 

(defconstant $DL_RESET_REQ 23)                  ;  Reset service request 

(defconstant $DL_RESET_IND 24)                  ;  Incoming reset indication 

(defconstant $DL_RESET_RES 25)                  ;  Complete reset processing 

(defconstant $DL_RESET_CON 26)                  ;  Reset processing complete 

(defconstant $DL_DATA_ACK_REQ 33)               ;  data unit transmission request 

(defconstant $DL_DATA_ACK_IND 34)               ;  Arrival of a command PDU 

(defconstant $DL_DATA_ACK_STATUS_IND 35)        ;  Status indication of DATA_ACK_REQ

(defconstant $DL_REPLY_REQ 36)                  ;  Request a DLSDU from the remote 

(defconstant $DL_REPLY_IND 37)                  ;  Arrival of a command PDU 

(defconstant $DL_REPLY_STATUS_IND 38)           ;  Status indication of REPLY_REQ 

(defconstant $DL_REPLY_UPDATE_REQ 39)           ;  Hold a DLSDU for transmission 

(defconstant $DL_REPLY_UPDATE_STATUS_IND 40)    ;  Status of REPLY_UPDATE req 

(defconstant $DL_XID_REQ 41)                    ;  Request to send an XID PDU 

(defconstant $DL_XID_IND 42)                    ;  Arrival of an XID PDU 

(defconstant $DL_XID_RES 43)                    ;  request to send a response XID PDU

(defconstant $DL_XID_CON 44)                    ;  Arrival of a response XID PDU 

(defconstant $DL_TEST_REQ 45)                   ;  TEST command request 

(defconstant $DL_TEST_IND 46)                   ;  TEST response indication 

(defconstant $DL_TEST_RES 47)                   ;  TEST response 

(defconstant $DL_TEST_CON 48)                   ;  TEST Confirmation 

(defconstant $DL_PHYS_ADDR_REQ 49)              ;  Request to get physical addr 

(defconstant $DL_PHYS_ADDR_ACK 50)              ;  Return physical addr 

(defconstant $DL_SET_PHYS_ADDR_REQ 51)          ;  set physical addr 

(defconstant $DL_GET_STATISTICS_REQ 52)         ;  Request to get statistics 

(defconstant $DL_GET_STATISTICS_ACK 53)         ;  Return statistics 

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define DL_PROMISCON_REQ DL_PROMISCON_REQ
; #define DL_PROMISCOFF_REQ DL_PROMISCOFF_REQ
;  DLPI interface states

(defconstant $DL_UNATTACHED 4)                  ;  PPA not attached 

(defconstant $DL_ATTACH_PENDING 5)              ;  Waiting ack of DL_ATTACH_REQ 

(defconstant $DL_DETACH_PENDING 6)              ;  Waiting ack of DL_DETACH_REQ 

(defconstant $DL_UNBOUND 0)                     ;  PPA attached, LLI compatibility 

(defconstant $DL_BIND_PENDING 1)                ;  Waiting ack of DL_BIND_REQ, LLI compatibility 

(defconstant $DL_UNBIND_PENDING 2)              ;  Waiting ack of DL_UNBIND_REQ, LLI compatibility 

(defconstant $DL_IDLE 3)                        ;  dlsap bound, awaiting use, LLI compatibility 

(defconstant $DL_UDQOS_PENDING 7)               ;  Waiting ack of DL_UDQOS_REQ 

(defconstant $DL_OUTCON_PENDING 8)              ;  outgoing connection, awaiting DL_CONN_CON 

(defconstant $DL_INCON_PENDING 9)               ;  incoming connection, awaiting DL_CONN_RES 

(defconstant $DL_CONN_RES_PENDING 10)           ;  Waiting ack of DL_CONNECT_RES 

(defconstant $DL_DATAXFER 11)                   ;  connection-oriented data transfer 

(defconstant $DL_USER_RESET_PENDING 12)         ;  user initiated reset, awaiting DL_RESET_CON 

(defconstant $DL_PROV_RESET_PENDING 13)         ;  provider initiated reset, awaiting DL_RESET_RES 

(defconstant $DL_RESET_RES_PENDING 14)          ;  Waiting ack of DL_RESET_RES 

(defconstant $DL_DISCON8_PENDING 15)            ;  Waiting ack of DL_DISC_REQ when in DL_OUTCON_PENDING 

(defconstant $DL_DISCON9_PENDING 16)            ;  Waiting ack of DL_DISC_REQ when in DL_INCON_PENDING 

(defconstant $DL_DISCON11_PENDING 17)           ;  Waiting ack of DL_DISC_REQ when in DL_DATAXFER 

(defconstant $DL_DISCON12_PENDING 18)           ;  Waiting ack of DL_DISC_REQ when in DL_USER_RESET_PENDING 

(defconstant $DL_DISCON13_PENDING 19)           ;  Waiting ack of DL_DISC_REQ when in DL_DL_PROV_RESET_PENDING 

(defconstant $DL_SUBS_BIND_PND 20)              ;  Waiting ack of DL_SUBS_BIND_REQ 

(defconstant $DL_SUBS_UNBIND_PND 21)            ;  Waiting ack of DL_SUBS_UNBIND_REQ 

;  DL_ERROR_ACK error return values

(defconstant $DL_ACCESS 2)                      ;  Improper permissions for request, LLI compatibility 

(defconstant $DL_BADADDR 1)                     ;  DLSAP address in improper format or invalid 

(defconstant $DL_BADCORR 5)                     ;  Sequence number not from outstanding DL_CONN_IND 

(defconstant $DL_BADDATA 6)                     ;  User data exceeded provider limit 

(defconstant $DL_BADPPA 8)                      ;  Specified PPA was invalid 

(defconstant $DL_BADPRIM 9)                     ;  Primitive received is not known by DLS provider 

(defconstant $DL_BADQOSPARAM 10)                ;  QOS parameters contained invalid values 

(defconstant $DL_BADQOSTYPE 11)                 ;  QOS structure type is unknown or unsupported 

(defconstant $DL_BADSAP 0)                      ;  Bad LSAP selector, LLI compatibility 

(defconstant $DL_BADTOKEN 12)                   ;  Token used not associated with an active stream 

(defconstant $DL_BOUND 13)                      ;  Attempted second bind with dl_max_conind or    
;     dl_conn_mgmt > 0 on same DLSAP or PPA 

(defconstant $DL_INITFAILED 14)                 ;  Physical Link initialization failed 

(defconstant $DL_NOADDR 15)                     ;  Provider couldn't allocate alternate address 

(defconstant $DL_NOTINIT 16)                    ;  Physical Link not initialized 

(defconstant $DL_OUTSTATE 3)                    ;  Primitive issued in improper state, LLI compatibility 

(defconstant $DL_SYSERR 4)                      ;  UNIX system error occurred, LLI compatibility 

(defconstant $DL_UNSUPPORTED 7)                 ;  Requested service not supplied by provider 

(defconstant $DL_UNDELIVERABLE 17)              ;  Previous data unit could not be delivered 

(defconstant $DL_NOTSUPPORTED 18)               ;  Primitive is known but not supported by DLS provider 

(defconstant $DL_TOOMANY 19)                    ;  limit exceeded 

(defconstant $DL_NOTENAB 20)                    ;  Promiscuous mode not enabled 

(defconstant $DL_BUSY 21)                       ;  Other streams for a particular PPA in the post-attached state 

(defconstant $DL_NOAUTO 22)                     ;  Automatic handling of XID & TEST responses not supported 

(defconstant $DL_NOXIDAUTO 23)                  ;  Automatic handling of XID not supported 

(defconstant $DL_NOTESTAUTO 24)                 ;  Automatic handling of TEST not supported 

(defconstant $DL_XIDAUTO 25)                    ;  Automatic handling of XID response 

(defconstant $DL_TESTAUTO 26)                   ;  AUtomatic handling of TEST response

(defconstant $DL_PENDING 27)                    ;  pending outstanding connect indications 

;  DLPI media types supported

(defconstant $DL_CSMACD 0)                      ;  IEEE 802.3 CSMA/CD network, LLI Compatibility 

(defconstant $DL_TPB 1)                         ;  IEEE 802.4 Token Passing Bus, LLI Compatibility 

(defconstant $DL_TPR 2)                         ;  IEEE 802.5 Token Passing Ring, LLI Compatibility 

(defconstant $DL_METRO 3)                       ;  IEEE 802.6 Metro Net, LLI Compatibility 

(defconstant $DL_ETHER 4)                       ;  Ethernet Bus, LLI Compatibility 

(defconstant $DL_HDLC 5)                        ;  ISO HDLC protocol support, bit synchronous 

(defconstant $DL_CHAR 6)                        ;  Character Synchronous protocol support, eg BISYNC 

(defconstant $DL_CTCA 7)                        ;  IBM Channel-to-Channel Adapter 

(defconstant $DL_FDDI 8)                        ;  Fiber Distributed data interface 

(defconstant $DL_OTHER 9)                       ;  Any other medium not listed above 

; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define DL_FDDI DL_FDDI
; 
;    DLPI provider service supported.
;    These must be allowed to be bitwise-OR for dl_service_mode in
;    DL_INFO_ACK.
; 

(defconstant $DL_CODLS 1)                       ;  support connection-oriented service 

(defconstant $DL_CLDLS 2)                       ;  support connectionless data link service 

(defconstant $DL_ACLDLS 4)                      ;  support acknowledged connectionless service

; 
;    DLPI provider style.
;    The DLPI provider style which determines whether a provider
;    requires a DL_ATTACH_REQ to inform the provider which PPA
;    user messages should be sent/received on.
; 

(defconstant $DL_STYLE1 #x500)                  ;  PPA is implicitly bound by open(2) 

(defconstant $DL_STYLE2 #x501)                  ;  PPA must be explicitly bound via DL_ATTACH_REQ 

;  DLPI Originator for Disconnect and Resets

(defconstant $DL_PROVIDER #x700)
(defconstant $DL_USER #x701)
;  DLPI Disconnect Reasons

(defconstant $DL_CONREJ_DEST_UNKNOWN #x800)
(defconstant $DL_CONREJ_DEST_UNREACH_PERMANENT #x801)
(defconstant $DL_CONREJ_DEST_UNREACH_TRANSIENT #x802)
(defconstant $DL_CONREJ_QOS_UNAVAIL_PERMANENT #x803)
(defconstant $DL_CONREJ_QOS_UNAVAIL_TRANSIENT #x804)
(defconstant $DL_CONREJ_PERMANENT_COND #x805)
(defconstant $DL_CONREJ_TRANSIENT_COND #x806)
(defconstant $DL_DISC_ABNORMAL_CONDITION #x807)
(defconstant $DL_DISC_NORMAL_CONDITION #x808)
(defconstant $DL_DISC_PERMANENT_CONDITION #x809)
(defconstant $DL_DISC_TRANSIENT_CONDITION #x80A)
(defconstant $DL_DISC_UNSPECIFIED #x80B)
;  DLPI Reset Reasons

(defconstant $DL_RESET_FLOW_CONTROL #x900)
(defconstant $DL_RESET_LINK_ERROR #x901)
(defconstant $DL_RESET_RESYNCH #x902)
;  DLPI status values for acknowledged connectionless data transfer

(defconstant $DL_CMD_MASK 15)                   ;  mask for command portion of status 

(defconstant $DL_CMD_OK 0)                      ;  Command Accepted 

(defconstant $DL_CMD_RS 1)                      ;  Unimplemented or inactivated service 

(defconstant $DL_CMD_UE 5)                      ;  Data Link User interface error 

(defconstant $DL_CMD_PE 6)                      ;  Protocol error 

(defconstant $DL_CMD_IP 7)                      ;  Permanent implementation dependent error

(defconstant $DL_CMD_UN 9)                      ;  Resources temporarily unavailable 

(defconstant $DL_CMD_IT 15)                     ;  Temporary implementation dependent error 

(defconstant $DL_RSP_MASK #xF0)                 ;  mask for response portion of status 

(defconstant $DL_RSP_OK 0)                      ;  Response DLSDU present 

(defconstant $DL_RSP_RS 16)                     ;  Unimplemented or inactivated service 

(defconstant $DL_RSP_NE 48)                     ;  Response DLSDU never submitted 

(defconstant $DL_RSP_NR 64)                     ;  Response DLSDU not requested 

(defconstant $DL_RSP_UE 80)                     ;  Data Link User interface error 

(defconstant $DL_RSP_IP 112)                    ;  Permanent implementation dependent error 

(defconstant $DL_RSP_UN #x90)                   ;  Resources temporarily unavailable 

(defconstant $DL_RSP_IT #xF0)                   ;  Temporary implementation dependent error 

;  Service Class values for acknowledged connectionless data transfer

(defconstant $DL_RQST_RSP 1)                    ;  Use acknowledge capability in MAC sublayer

(defconstant $DL_RQST_NORSP 2)                  ;  No acknowledgement service requested 

;  DLPI address type definition

(defconstant $DL_FACT_PHYS_ADDR 1)              ;  factory physical address 

(defconstant $DL_CURR_PHYS_ADDR 2)              ;  current physical address 

;  DLPI flag definitions

(defconstant $DL_POLL_FINAL 1)                  ;  if set,indicates poll/final bit set

;  XID and TEST responses supported by the provider

(defconstant $DL_AUTO_XID 1)                    ;  provider will respond to XID 

(defconstant $DL_AUTO_TEST 2)                   ;  provider will respond to TEST 

;  Subsequent bind type

(defconstant $DL_PEER_BIND 1)                   ;  subsequent bind on a peer addr 

(defconstant $DL_HIERARCHICAL_BIND 2)           ;  subs_bind on a hierarchical addr

;  DLPI promiscuous mode definitions

(defconstant $DL_PROMISC_PHYS 1)                ;  promiscuous mode at phys level 

(defconstant $DL_PROMISC_SAP 2)                 ;  promiscous mode at sap level 

(defconstant $DL_PROMISC_MULTI 3)               ;  promiscuous mode for multicast 

;  M_DATA "raw" mode 
; #define DLIOCRAW MIOC_CMD(MIOC_DLPI,1)
; 
;    DLPI Quality Of Service definition for use in QOS structure definitions.
;    The QOS structures are used in connection establishment, DL_INFO_ACK,
;    and setting connectionless QOS values.
; 
; 
;    Throughput
;    
;    This parameter is specified for both directions.
; 
(defrecord dl_through_t
   (dl_target_value :SInt32)                    ;  desired bits/second desired 
   (dl_accept_value :SInt32)                    ;  min. acceptable bits/second 
)

;type name? (def-mactype :dl_through_t (find-mactype ':dl_through_t))
; 
;    transit delay specification
;    
;    This parameter is specified for both directions.
;    expressed in milliseconds assuming a DLSDU size of 128 octets.
;    The scaling of the value to the current DLSDU size is provider dependent.
; 
(defrecord dl_transdelay_t
   (dl_target_value :SInt32)                    ;  desired value of service 
   (dl_accept_value :SInt32)                    ;  min. acceptable value of service 
)

;type name? (def-mactype :dl_transdelay_t (find-mactype ':dl_transdelay_t))
; 
;    priority specification
;    priority range is 0-100, with 0 being highest value.
; 
(defrecord dl_priority_t
   (dl_min :SInt32)
   (dl_max :SInt32)
)

;type name? (def-mactype :dl_priority_t (find-mactype ':dl_priority_t))
;  protection specification

(defconstant $DL_NONE #xB01)                    ;  no protection supplied 

(defconstant $DL_MONITOR #xB02)                 ;  protection against passive monitoring 

(defconstant $DL_MAXIMUM #xB03)                 ;  protection against modification, replay, addition, or deletion 

(defrecord dl_protect_t
   (dl_min :SInt32)
   (dl_max :SInt32)
)

;type name? (def-mactype :dl_protect_t (find-mactype ':dl_protect_t))
; 
;    Resilience specification
;    probabilities are scaled by a factor of 10,000 with a time interval
;    of 10,000 seconds.
; 
(defrecord dl_resilience_t
   (dl_disc_prob :SInt32)                       ;  probability of provider init DISC 
   (dl_reset_prob :SInt32)                      ;  probability of provider init RESET 
)

;type name? (def-mactype :dl_resilience_t (find-mactype ':dl_resilience_t))
; 
;     QOS type definition to be used for negotiation with the
;     remote end of a connection, or a connectionless unitdata request.
;     There are two type definitions to handle the negotiation 
;     process at connection establishment. The typedef dl_qos_range_t
;     is used to present a range for parameters. This is used
;     in the DL_CONNECT_REQ and DL_CONNECT_IND messages. The typedef
;     dl_qos_sel_t is used to select a specific value for the QOS
;     parameters. This is used in the DL_CONNECT_RES, DL_CONNECT_CON,
;     and DL_INFO_ACK messages to define the selected QOS parameters
;     for a connection.
; 
;     NOTE
;     A DataLink provider which has unknown values for any of the fields
;     will use a value of DL_UNKNOWN for all values in the fields.
; 
;     NOTE
;     A QOS parameter value of DL_QOS_DONT_CARE informs the DLS
;     provider the user requesting this value doesn't care 
;     what the QOS parameter is set to. This value becomes the
;     least possible value in the range of QOS parameters.
;     The order of the QOS parameter range is then:
; 
;         DL_QOS_DONT_CARE < 0 < MAXIMUM QOS VALUE
; 

(defconstant $DL_UNKNOWN -1)
(defconstant $DL_QOS_DONT_CARE -2)
; 
;     Every QOS structure has the first 4 bytes containing a type
;     field, denoting the definition of the rest of the structure.
;     This is used in the same manner has the dl_primitive variable
;     is in messages.
; 
;     The following list is the defined QOS structure type values and structures.
; 

(defconstant $DL_QOS_CO_RANGE1 #x101)           ;  QOS range struct. for Connection modeservice 

(defconstant $DL_QOS_CO_SEL1 #x102)             ;  QOS selection structure 

(defconstant $DL_QOS_CL_RANGE1 #x103)           ;  QOS range struct. for connectionless

(defconstant $DL_QOS_CL_SEL1 #x104)             ;  QOS selection for connectionless mode

(defrecord dl_qos_co_range1_t
   (dl_qos_type :UInt32)
   (dl_rcv_throughput :dl_through_t)            ;  desired and acceptable
   (dl_rcv_trans_delay :dl_transdelay_t)        ;  desired and acceptable
   (dl_xmt_throughput :dl_through_t)
   (dl_xmt_trans_delay :dl_transdelay_t)
   (dl_priority :dl_priority_t)                 ;  min and max values 
   (dl_protection :dl_protect_t)                ;  min and max values 
   (dl_residual_error :SInt32)
   (dl_resilience :dl_resilience_t)
)

;type name? (def-mactype :dl_qos_co_range1_t (find-mactype ':dl_qos_co_range1_t))
(defrecord dl_qos_co_sel1_t
   (dl_qos_type :UInt32)
   (dl_rcv_throughput :SInt32)
   (dl_rcv_trans_delay :SInt32)
   (dl_xmt_throughput :SInt32)
   (dl_xmt_trans_delay :SInt32)
   (dl_priority :SInt32)
   (dl_protection :SInt32)
   (dl_residual_error :SInt32)
   (dl_resilience :dl_resilience_t)
)

;type name? (def-mactype :dl_qos_co_sel1_t (find-mactype ':dl_qos_co_sel1_t))
(defrecord dl_qos_cl_range1_t
   (dl_qos_type :UInt32)
   (dl_trans_delay :dl_transdelay_t)
   (dl_priority :dl_priority_t)
   (dl_protection :dl_protect_t)
   (dl_residual_error :SInt32)
)

;type name? (def-mactype :dl_qos_cl_range1_t (find-mactype ':dl_qos_cl_range1_t))
(defrecord dl_qos_cl_sel1_t
   (dl_qos_type :UInt32)
   (dl_trans_delay :SInt32)
   (dl_priority :SInt32)
   (dl_protection :SInt32)
   (dl_residual_error :SInt32)
)

;type name? (def-mactype :dl_qos_cl_sel1_t (find-mactype ':dl_qos_cl_sel1_t))
; 
;     DLPI interface primitive definitions.
; 
;     Each primitive is sent as a stream message. It is possible that
;     the messages may be viewed as a sequence of bytes that have the
;     following form without any padding. The structure definition
;     of the following messages may have to change depending on the
;     underlying hardware architecture and crossing of a hardware
;     boundary with a different hardware architecture.
; 
;     Fields in the primitives having a name of the form
;     dl_reserved cannot be used and have the value of
;     binary zero, no bits turned on.
; 
;     Each message has the name defined followed by the
;     stream message type (M_PROTO, M_PCPROTO, M_DATA)
;  
;  LOCAL MANAGEMENT SERVICE PRIMITIVES
;  DL_INFO_REQ, M_PCPROTO type
(defrecord dl_info_req_t
   (dl_primitive :UInt32)                       ;  set to DL_INFO_REQ 
)

;type name? (def-mactype :dl_info_req_t (find-mactype ':dl_info_req_t))
;  DL_INFO_ACK, M_PCPROTO type
(defrecord dl_info_ack_t
   (dl_primitive :UInt32)                       ;  set to DL_INFO_ACK 
   (dl_max_sdu :UInt32)                         ;  Max bytes in a DLSDU 
   (dl_min_sdu :UInt32)                         ;  Min bytes in a DLSDU 
   (dl_addr_length :UInt32)                     ;  length of DLSAP address 
   (dl_mac_type :UInt32)                        ;  type of medium supported
   (dl_reserved :UInt32)                        ;  value set to zero 
   (dl_current_state :UInt32)                   ;  state of DLPI interface 
   (dl_sap_length :SInt32)                      ;  current length of SAP part of dlsap address 
   (dl_service_mode :UInt32)                    ;  CO, CL or ACL 
   (dl_qos_length :UInt32)                      ;  length of qos values 
   (dl_qos_offset :UInt32)                      ;  offset from beg. of block
   (dl_qos_range_length :UInt32)                ;  available range of qos 
   (dl_qos_range_offset :UInt32)                ;  offset from beg. of block
   (dl_provider_style :UInt32)                  ;  style1 or style2 
   (dl_addr_offset :UInt32)                     ;  offset of the dlsap addr 
   (dl_version :UInt32)                         ;  version number 
   (dl_brdcst_addr_length :UInt32)              ;  length of broadcast addr 
   (dl_brdcst_addr_offset :UInt32)              ;  offset from beg. of block
   (dl_growth :UInt32)                          ;  set to zero 
)

;type name? (def-mactype :dl_info_ack_t (find-mactype ':dl_info_ack_t))
;  DL_ATTACH_REQ, M_PROTO type
(defrecord dl_attach_req_t
   (dl_primitive :UInt32)                       ;  set to DL_ATTACH_REQ
   (dl_ppa :UInt32)                             ;  id of the PPA 
)

;type name? (def-mactype :dl_attach_req_t (find-mactype ':dl_attach_req_t))
;  DL_DETACH_REQ, M_PROTO type
(defrecord dl_detach_req_t
   (dl_primitive :UInt32)                       ;  set to DL_DETACH_REQ 
)

;type name? (def-mactype :dl_detach_req_t (find-mactype ':dl_detach_req_t))
;  DL_BIND_REQ, M_PROTO type
(defrecord dl_bind_req_t
   (dl_primitive :UInt32)                       ;  set to DL_BIND_REQ 
   (dl_sap :UInt32)                             ;  info to identify dlsap addr
   (dl_max_conind :UInt32)                      ;  max # of outstanding con_ind
   (dl_service_mode :UInt16)                    ;  CO, CL or ACL 
   (dl_conn_mgmt :UInt16)                       ;  if non-zero, is con-mgmt stream
   (dl_xidtest_flg :UInt32)                     ;  if set to 1 indicates automatic initiation of test and xid frames 
)

;type name? (def-mactype :dl_bind_req_t (find-mactype ':dl_bind_req_t))
;  DL_BIND_ACK, M_PCPROTO type
(defrecord dl_bind_ack_t
   (dl_primitive :UInt32)                       ;  DL_BIND_ACK 
   (dl_sap :UInt32)                             ;  DLSAP addr info 
   (dl_addr_length :UInt32)                     ;  length of complete DLSAP addr 
   (dl_addr_offset :UInt32)                     ;  offset from beginning of M_PCPROTO
   (dl_max_conind :UInt32)                      ;  allowed max. # of con-ind 
   (dl_xidtest_flg :UInt32)                     ;  responses supported by provider
)

;type name? (def-mactype :dl_bind_ack_t (find-mactype ':dl_bind_ack_t))
;  DL_SUBS_BIND_REQ, M_PROTO type
(defrecord dl_subs_bind_req_t
   (dl_primitive :UInt32)                       ;  DL_SUBS_BIND_REQ 
   (dl_subs_sap_offset :UInt32)                 ;  offset of subs_sap 
   (dl_subs_sap_length :UInt32)                 ;  length of subs_sap 
   (dl_subs_bind_class :UInt32)                 ;  peer or hierarchical 
)

;type name? (def-mactype :dl_subs_bind_req_t (find-mactype ':dl_subs_bind_req_t))
;  DL_SUBS_BIND_ACK, M_PCPROTO type
(defrecord dl_subs_bind_ack_t
   (dl_primitive :UInt32)                       ;  DL_SUBS_BIND_ACK 
   (dl_subs_sap_offset :UInt32)                 ;  offset of subs_sap 
   (dl_subs_sap_length :UInt32)                 ;  length of subs_sap 
)

;type name? (def-mactype :dl_subs_bind_ack_t (find-mactype ':dl_subs_bind_ack_t))
;  DL_UNBIND_REQ, M_PROTO type
(defrecord dl_unbind_req_t
   (dl_primitive :UInt32)                       ;  DL_UNBIND_REQ 
)

;type name? (def-mactype :dl_unbind_req_t (find-mactype ':dl_unbind_req_t))
;  DL_SUBS_UNBIND_REQ, M_PROTO type
(defrecord dl_subs_unbind_req_t
   (dl_primitive :UInt32)                       ;  DL_SUBS_UNBIND_REQ 
   (dl_subs_sap_offset :UInt32)                 ;  offset of subs_sap 
   (dl_subs_sap_length :UInt32)                 ;  length of subs_sap 
)

;type name? (def-mactype :dl_subs_unbind_req_t (find-mactype ':dl_subs_unbind_req_t))
;  DL_OK_ACK, M_PCPROTO type
(defrecord dl_ok_ack_t
   (dl_primitive :UInt32)                       ;  DL_OK_ACK 
   (dl_correct_primitive :UInt32)               ;  primitive being acknowledged 
)

;type name? (def-mactype :dl_ok_ack_t (find-mactype ':dl_ok_ack_t))
;  DL_ERROR_ACK, M_PCPROTO type
(defrecord dl_error_ack_t
   (dl_primitive :UInt32)                       ;  DL_ERROR_ACK 
   (dl_error_primitive :UInt32)                 ;  primitive in error 
   (dl_errno :UInt32)                           ;  DLPI error code 
   (dl_unix_errno :UInt32)                      ;  UNIX system error code 
)

;type name? (def-mactype :dl_error_ack_t (find-mactype ':dl_error_ack_t))
;  DL_ENABMULTI_REQ, M_PROTO type
(defrecord dl_enabmulti_req_t
   (dl_primitive :UInt32)                       ;  DL_ENABMULTI_REQ 
   (dl_addr_length :UInt32)                     ;  length of multicast address 
   (dl_addr_offset :UInt32)                     ;  offset from beg. of M_PROTO block
)

;type name? (def-mactype :dl_enabmulti_req_t (find-mactype ':dl_enabmulti_req_t))
;  DL_DISABMULTI_REQ, M_PROTO type
(defrecord dl_disabmulti_req_t
   (dl_primitive :UInt32)                       ;  DL_DISABMULTI_REQ 
   (dl_addr_length :UInt32)                     ;  length of multicast address 
   (dl_addr_offset :UInt32)                     ;  offset from beg. of M_PROTO block
)

;type name? (def-mactype :dl_disabmulti_req_t (find-mactype ':dl_disabmulti_req_t))
;  DL_PROMISCON_REQ, M_PROTO type
(defrecord dl_promiscon_req_t
   (dl_primitive :UInt32)                       ;  DL_PROMISCON_REQ 
   (dl_level :UInt32)                           ;  physical,SAP level or ALL multicast
)

;type name? (def-mactype :dl_promiscon_req_t (find-mactype ':dl_promiscon_req_t))
;  DL_PROMISCOFF_REQ, M_PROTO type
(defrecord dl_promiscoff_req_t
   (dl_primitive :UInt32)                       ;  DL_PROMISCOFF_REQ 
   (dl_level :UInt32)                           ;  Physical,SAP level or ALL multicast
)

;type name? (def-mactype :dl_promiscoff_req_t (find-mactype ':dl_promiscoff_req_t))
;  Primitives to get and set the Physical address
;  DL_PHYS_ADDR_REQ, M_PROTO type
(defrecord dl_phys_addr_req_t
   (dl_primitive :UInt32)                       ;  DL_PHYS_ADDR_REQ 
   (dl_addr_type :UInt32)                       ;  factory or current physical addr 
)

;type name? (def-mactype :dl_phys_addr_req_t (find-mactype ':dl_phys_addr_req_t))
;  DL_PHYS_ADDR_ACK, M_PCPROTO type
(defrecord dl_phys_addr_ack_t
   (dl_primitive :UInt32)                       ;  DL_PHYS_ADDR_ACK 
   (dl_addr_length :UInt32)                     ;  length of the physical addr 
   (dl_addr_offset :UInt32)                     ;  offset from beg. of block 
)

;type name? (def-mactype :dl_phys_addr_ack_t (find-mactype ':dl_phys_addr_ack_t))
;  DL_SET_PHYS_ADDR_REQ, M_PROTO type
(defrecord dl_set_phys_addr_req_t
   (dl_primitive :UInt32)                       ;  DL_SET_PHYS_ADDR_REQ 
   (dl_addr_length :UInt32)                     ;  length of physical addr 
   (dl_addr_offset :UInt32)                     ;  offset from beg. of block 
)

;type name? (def-mactype :dl_set_phys_addr_req_t (find-mactype ':dl_set_phys_addr_req_t))
;  Primitives to get statistics
;  DL_GET_STATISTICS_REQ, M_PROTO type
(defrecord dl_get_statistics_req_t
   (dl_primitive :UInt32)                       ;  DL_GET_STATISTICS_REQ 
)

;type name? (def-mactype :dl_get_statistics_req_t (find-mactype ':dl_get_statistics_req_t))
;  DL_GET_STATISTICS_ACK, M_PCPROTO type
(defrecord dl_get_statistics_ack_t
   (dl_primitive :UInt32)                       ;  DL_GET_STATISTICS_ACK 
   (dl_stat_length :UInt32)                     ;  length of statistics structure
   (dl_stat_offset :UInt32)                     ;  offset from beg. of block 
)

;type name? (def-mactype :dl_get_statistics_ack_t (find-mactype ':dl_get_statistics_ack_t))
;  CONNECTION-ORIENTED SERVICE PRIMITIVES
;  DL_CONNECT_REQ, M_PROTO type
(defrecord dl_connect_req_t
   (dl_primitive :UInt32)                       ;  DL_CONNECT_REQ 
   (dl_dest_addr_length :UInt32)                ;  len. of dlsap addr
   (dl_dest_addr_offset :UInt32)                ;  offset 
   (dl_qos_length :UInt32)                      ;  len. of QOS parm val
   (dl_qos_offset :UInt32)                      ;  offset 
   (dl_growth :UInt32)                          ;  set to zero 
)

;type name? (def-mactype :dl_connect_req_t (find-mactype ':dl_connect_req_t))
;  DL_CONNECT_IND, M_PROTO type
(defrecord dl_connect_ind_t
   (dl_primitive :UInt32)                       ;  DL_CONNECT_IND 
   (dl_correlation :UInt32)                     ;  provider's correlation token
   (dl_called_addr_length :UInt32)              ;  length of called address 
   (dl_called_addr_offset :UInt32)              ;  offset from beginning of block 
   (dl_calling_addr_length :UInt32)             ;  length of calling address 
   (dl_calling_addr_offset :UInt32)             ;  offset from beginning of block 
   (dl_qos_length :UInt32)                      ;  length of qos structure 
   (dl_qos_offset :UInt32)                      ;  offset from beginning of block 
   (dl_growth :UInt32)                          ;  set to zero 
)

;type name? (def-mactype :dl_connect_ind_t (find-mactype ':dl_connect_ind_t))
;  DL_CONNECT_RES, M_PROTO type
(defrecord dl_connect_res_t
   (dl_primitive :UInt32)                       ;  DL_CONNECT_RES 
   (dl_correlation :UInt32)                     ;  provider's correlation token 
   (dl_resp_token :UInt32)                      ;  token associated with responding stream 
   (dl_qos_length :UInt32)                      ;  length of qos structure 
   (dl_qos_offset :UInt32)                      ;  offset from beginning of block 
   (dl_growth :UInt32)                          ;  set to zero 
)

;type name? (def-mactype :dl_connect_res_t (find-mactype ':dl_connect_res_t))
;  DL_CONNECT_CON, M_PROTO type
(defrecord dl_connect_con_t
   (dl_primitive :UInt32)                       ;  DL_CONNECT_CON
   (dl_resp_addr_length :UInt32)                ;  length of responder's address 
   (dl_resp_addr_offset :UInt32)                ;  offset from beginning of block
   (dl_qos_length :UInt32)                      ;  length of qos structure 
   (dl_qos_offset :UInt32)                      ;  offset from beginning of block
   (dl_growth :UInt32)                          ;  set to zero 
)

;type name? (def-mactype :dl_connect_con_t (find-mactype ':dl_connect_con_t))
;  DL_TOKEN_REQ, M_PCPROTO type
(defrecord dl_token_req_t
   (dl_primitive :UInt32)                       ;  DL_TOKEN_REQ 
)

;type name? (def-mactype :dl_token_req_t (find-mactype ':dl_token_req_t))
;  DL_TOKEN_ACK, M_PCPROTO type
(defrecord dl_token_ack_t
   (dl_primitive :UInt32)                       ;  DL_TOKEN_ACK 
   (dl_token :UInt32)                           ;  Connection response token associated with the stream 
)

;type name? (def-mactype :dl_token_ack_t (find-mactype ':dl_token_ack_t))
;  DL_DISCONNECT_REQ, M_PROTO type
(defrecord dl_disconnect_req_t
   (dl_primitive :UInt32)                       ;  DL_DISCONNECT_REQ 
   (dl_reason :UInt32)                          ; normal, abnormal, perm. or transient
   (dl_correlation :UInt32)                     ;  association with connect_ind 
)

;type name? (def-mactype :dl_disconnect_req_t (find-mactype ':dl_disconnect_req_t))
;  DL_DISCONNECT_IND, M_PROTO type
(defrecord dl_disconnect_ind_t
   (dl_primitive :UInt32)                       ;  DL_DISCONNECT_IND 
   (dl_originator :UInt32)                      ;  USER or PROVIDER 
   (dl_reason :UInt32)                          ;  permanent or transient 
   (dl_correlation :UInt32)                     ;  association with connect_ind 
)

;type name? (def-mactype :dl_disconnect_ind_t (find-mactype ':dl_disconnect_ind_t))
;  DL_RESET_REQ, M_PROTO type
(defrecord dl_reset_req_t
   (dl_primitive :UInt32)                       ;  DL_RESET_REQ 
)

;type name? (def-mactype :dl_reset_req_t (find-mactype ':dl_reset_req_t))
;  DL_RESET_IND, M_PROTO type
(defrecord dl_reset_ind_t
   (dl_primitive :UInt32)                       ;  DL_RESET_IND 
   (dl_originator :UInt32)                      ;  Provider or User 
   (dl_reason :UInt32)                          ;  flow control, link error or resynch
)

;type name? (def-mactype :dl_reset_ind_t (find-mactype ':dl_reset_ind_t))
;  DL_RESET_RES, M_PROTO type
(defrecord dl_reset_res_t
   (dl_primitive :UInt32)                       ;  DL_RESET_RES 
)

;type name? (def-mactype :dl_reset_res_t (find-mactype ':dl_reset_res_t))
;  DL_RESET_CON, M_PROTO type
(defrecord dl_reset_con_t
   (dl_primitive :UInt32)                       ;  DL_RESET_CON 
)

;type name? (def-mactype :dl_reset_con_t (find-mactype ':dl_reset_con_t))
;  CONNECTIONLESS SERVICE PRIMITIVES
;  DL_UNITDATA_REQ, M_PROTO type, with M_DATA block(s)
(defrecord dl_unitdata_req_t
   (dl_primitive :UInt32)                       ;  DL_UNITDATA_REQ 
   (dl_dest_addr_length :UInt32)                ;  DLSAP length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
   (dl_priority :dl_priority_t)                 ;  priority value 
)

;type name? (def-mactype :dl_unitdata_req_t (find-mactype ':dl_unitdata_req_t))
;  DL_UNITDATA_IND, M_PROTO type, with M_DATA block(s)
(defrecord dl_unitdata_ind_t
   (dl_primitive :UInt32)                       ;  DL_UNITDATA_IND 
   (dl_dest_addr_length :UInt32)                ;  DLSAP length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
   (dl_src_addr_length :UInt32)                 ;  DLSAP addr length of sending user
   (dl_src_addr_offset :UInt32)                 ;  offset from beg. of block 
   (dl_group_address :UInt32)                   ;  set to one if multicast/broadcast
)

;type name? (def-mactype :dl_unitdata_ind_t (find-mactype ':dl_unitdata_ind_t))
; 
;    DL_UDERROR_IND, M_PROTO type
;    (or M_PCPROTO type if LLI-based provider)
; 
(defrecord dl_uderror_ind_t
   (dl_primitive :UInt32)                       ;  DL_UDERROR_IND 
   (dl_dest_addr_length :UInt32)                ;  Destination DLSAP 
   (dl_dest_addr_offset :UInt32)                ;  Offset from beg. of block 
   (dl_unix_errno :UInt32)                      ;  unix system error code
   (dl_errno :UInt32)                           ;  DLPI error code 
)

;type name? (def-mactype :dl_uderror_ind_t (find-mactype ':dl_uderror_ind_t))
;  DL_UDQOS_REQ, M_PROTO type
(defrecord dl_udqos_req_t
   (dl_primitive :UInt32)                       ;  DL_UDQOS_REQ 
   (dl_qos_length :UInt32)                      ;  length in bytes of requested qos
   (dl_qos_offset :UInt32)                      ;  offset from beg. of block 
)

;type name? (def-mactype :dl_udqos_req_t (find-mactype ':dl_udqos_req_t))
;  Primitives to handle XID and TEST operations
;  DL_TEST_REQ, M_PROTO type
(defrecord dl_test_req_t
   (dl_primitive :UInt32)                       ;  DL_TEST_REQ 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  DLSAP length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
)

;type name? (def-mactype :dl_test_req_t (find-mactype ':dl_test_req_t))
;  DL_TEST_IND, M_PROTO type
(defrecord dl_test_ind_t
   (dl_primitive :UInt32)                       ;  DL_TEST_IND 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  dlsap length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
   (dl_src_addr_length :UInt32)                 ;  dlsap length of source user 
   (dl_src_addr_offset :UInt32)                 ;  offset from beg. of block 
)

;type name? (def-mactype :dl_test_ind_t (find-mactype ':dl_test_ind_t))
;  DL_TEST_RES, M_PROTO type
(defrecord dl_test_res_t
   (dl_primitive :UInt32)                       ;  DL_TEST_RES 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  DLSAP length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
)

;type name? (def-mactype :dl_test_res_t (find-mactype ':dl_test_res_t))
;  DL_TEST_CON, M_PROTO type
(defrecord dl_test_con_t
   (dl_primitive :UInt32)                       ;  DL_TEST_CON 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  dlsap length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
   (dl_src_addr_length :UInt32)                 ;  dlsap length of source user 
   (dl_src_addr_offset :UInt32)                 ;  offset from beg. of block 
)

;type name? (def-mactype :dl_test_con_t (find-mactype ':dl_test_con_t))
;  DL_XID_REQ, M_PROTO type
(defrecord dl_xid_req_t
   (dl_primitive :UInt32)                       ;  DL_XID_REQ 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  dlsap length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
)

;type name? (def-mactype :dl_xid_req_t (find-mactype ':dl_xid_req_t))
;  DL_XID_IND, M_PROTO type
(defrecord dl_xid_ind_t
   (dl_primitive :UInt32)                       ;  DL_XID_IND 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  dlsap length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
   (dl_src_addr_length :UInt32)                 ;  dlsap length of source user 
   (dl_src_addr_offset :UInt32)                 ;  offset from beg. of block 
)

;type name? (def-mactype :dl_xid_ind_t (find-mactype ':dl_xid_ind_t))
;  DL_XID_RES, M_PROTO type
(defrecord dl_xid_res_t
   (dl_primitive :UInt32)                       ;  DL_XID_RES 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  DLSAP length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
)

;type name? (def-mactype :dl_xid_res_t (find-mactype ':dl_xid_res_t))
;  DL_XID_CON, M_PROTO type
(defrecord dl_xid_con_t
   (dl_primitive :UInt32)                       ;  DL_XID_CON 
   (dl_flag :UInt32)                            ;  poll/final 
   (dl_dest_addr_length :UInt32)                ;  dlsap length of dest. user 
   (dl_dest_addr_offset :UInt32)                ;  offset from beg. of block 
   (dl_src_addr_length :UInt32)                 ;  dlsap length of source user 
   (dl_src_addr_offset :UInt32)                 ;  offset from beg. of block 
)

;type name? (def-mactype :dl_xid_con_t (find-mactype ':dl_xid_con_t))
;  ACKNOWLEDGED CONNECTIONLESS SERVICE PRIMITIVES
;  DL_DATA_ACK_REQ, M_PROTO type
(defrecord dl_data_ack_req_t
   (dl_primitive :UInt32)                       ;  DL_DATA_ACK_REQ 
   (dl_correlation :UInt32)                     ;  User's correlation token 
   (dl_dest_addr_length :UInt32)                ;  length of destination addr 
   (dl_dest_addr_offset :UInt32)                ;  offset from beginning of block 
   (dl_src_addr_length :UInt32)                 ;  length of source address 
   (dl_src_addr_offset :UInt32)                 ;  offset from beginning of block 
   (dl_priority :UInt32)                        ;  priority 
   (dl_service_class :UInt32)                   ;  DL_RQST_RSP or DL_RQST_NORSP 
)

;type name? (def-mactype :dl_data_ack_req_t (find-mactype ':dl_data_ack_req_t))
;  DL_DATA_ACK_IND, M_PROTO type
(defrecord dl_data_ack_ind_t
   (dl_primitive :UInt32)                       ;  DL_DATA_ACK_IND 
   (dl_dest_addr_length :UInt32)                ;  length of destination addr 
   (dl_dest_addr_offset :UInt32)                ;  offset from beginning of block 
   (dl_src_addr_length :UInt32)                 ;  length of source address 
   (dl_src_addr_offset :UInt32)                 ;  offset from beginning of block 
   (dl_priority :UInt32)                        ;  priority for data unit transm. 
   (dl_service_class :UInt32)                   ;  DL_RQST_RSP or DL_RQST_NORSP 
)

;type name? (def-mactype :dl_data_ack_ind_t (find-mactype ':dl_data_ack_ind_t))
;  DL_DATA_ACK_STATUS_IND, M_PROTO type
(defrecord dl_data_ack_status_ind_t
   (dl_primitive :UInt32)                       ;  DL_DATA_ACK_STATUS_IND 
   (dl_correlation :UInt32)                     ;  User's correlation token 
   (dl_status :UInt32)                          ;  success or failure of previous req
)

;type name? (def-mactype :dl_data_ack_status_ind_t (find-mactype ':dl_data_ack_status_ind_t))
;  DL_REPLY_REQ, M_PROTO type
(defrecord dl_reply_req_t
   (dl_primitive :UInt32)                       ;  DL_REPLY_REQ 
   (dl_correlation :UInt32)                     ;  User's correlation token 
   (dl_dest_addr_length :UInt32)                ;  length of destination address 
   (dl_dest_addr_offset :UInt32)                ;  offset from beginning of block 
   (dl_src_addr_length :UInt32)                 ;  source address length 
   (dl_src_addr_offset :UInt32)                 ;  offset from beginning of block 
   (dl_priority :UInt32)                        ;  priority for data unit transmission
   (dl_service_class :UInt32)
)

;type name? (def-mactype :dl_reply_req_t (find-mactype ':dl_reply_req_t))
;  DL_REPLY_IND, M_PROTO type
(defrecord dl_reply_ind_t
   (dl_primitive :UInt32)                       ;  DL_REPLY_IND 
   (dl_dest_addr_length :UInt32)                ;  length of destination address 
   (dl_dest_addr_offset :UInt32)                ;  offset from beginning of block
   (dl_src_addr_length :UInt32)                 ;  length of source address 
   (dl_src_addr_offset :UInt32)                 ;  offset from beginning of block 
   (dl_priority :UInt32)                        ;  priority for data unit transmission
   (dl_service_class :UInt32)                   ;  DL_RQST_RSP or DL_RQST_NORSP 
)

;type name? (def-mactype :dl_reply_ind_t (find-mactype ':dl_reply_ind_t))
;  DL_REPLY_STATUS_IND, M_PROTO type
(defrecord dl_reply_status_ind_t
   (dl_primitive :UInt32)                       ;  DL_REPLY_STATUS_IND 
   (dl_correlation :UInt32)                     ;  User's correlation token 
   (dl_status :UInt32)                          ;  success or failure of previous req
)

;type name? (def-mactype :dl_reply_status_ind_t (find-mactype ':dl_reply_status_ind_t))
;  DL_REPLY_UPDATE_REQ, M_PROTO type
(defrecord dl_reply_update_req_t
   (dl_primitive :UInt32)                       ;  DL_REPLY_UPDATE_REQ 
   (dl_correlation :UInt32)                     ;  user's correlation token 
   (dl_src_addr_length :UInt32)                 ;  length of source address 
   (dl_src_addr_offset :UInt32)                 ;  offset from beginning of block 
)

;type name? (def-mactype :dl_reply_update_req_t (find-mactype ':dl_reply_update_req_t))
;  DL_REPLY_UPDATE_STATUS_IND, M_PROTO type
(defrecord dl_reply_update_status_ind_t
   (dl_primitive :UInt32)                       ;  DL_REPLY_UPDATE_STATUS_IND 
   (dl_correlation :UInt32)                     ;  User's correlation token 
   (dl_status :UInt32)                          ;  success or failure of previous req
)

;type name? (def-mactype :dl_reply_update_status_ind_t (find-mactype ':dl_reply_update_status_ind_t))
(defrecord DL_primitives
   (:variant
   (
   (dl_primitive :UInt32)
   )
   (
   (info_req :dl_info_req_t)
   )
   (
   (info_ack :dl_info_ack_t)
   )
   (
   (attach_req :dl_attach_req_t)
   )
   (
   (detach_req :dl_detach_req_t)
   )
   (
   (bind_req :dl_bind_req_t)
   )
   (
   (bind_ack :dl_bind_ack_t)
   )
   (
   (unbind_req :dl_unbind_req_t)
   )
   (
   (subs_bind_req :dl_subs_bind_req_t)
   )
   (
   (subs_bind_ack :dl_subs_bind_ack_t)
   )
   (
   (subs_unbind_req :dl_subs_unbind_req_t)
   )
   (
   (ok_ack :dl_ok_ack_t)
   )
   (
   (error_ack :dl_error_ack_t)
   )
   (
   (connect_req :dl_connect_req_t)
   )
   (
   (connect_ind :dl_connect_ind_t)
   )
   (
   (connect_res :dl_connect_res_t)
   )
   (
   (connect_con :dl_connect_con_t)
   )
   (
   (token_req :dl_token_req_t)
   )
   (
   (token_ack :dl_token_ack_t)
   )
   (
   (disconnect_req :dl_disconnect_req_t)
   )
   (
   (disconnect_ind :dl_disconnect_ind_t)
   )
   (
   (reset_req :dl_reset_req_t)
   )
   (
   (reset_ind :dl_reset_ind_t)
   )
   (
   (reset_res :dl_reset_res_t)
   )
   (
   (reset_con :dl_reset_con_t)
   )
   (
   (unitdata_req :dl_unitdata_req_t)
   )
   (
   (unitdata_ind :dl_unitdata_ind_t)
   )
   (
   (uderror_ind :dl_uderror_ind_t)
   )
   (
   (udqos_req :dl_udqos_req_t)
   )
   (
   (enabmulti_req :dl_enabmulti_req_t)
   )
   (
   (disabmulti_req :dl_disabmulti_req_t)
   )
   (
   (promiscon_req :dl_promiscon_req_t)
   )
   (
   (promiscoff_req :dl_promiscoff_req_t)
   )
   (
   (physaddr_req :dl_phys_addr_req_t)
   )
   (
   (physaddr_ack :dl_phys_addr_ack_t)
   )
   (
   (set_physaddr_req :dl_set_phys_addr_req_t)
   )
   (
   (get_statistics_req :dl_get_statistics_req_t)
   )
   (
   (get_statistics_ack :dl_get_statistics_ack_t)
   )
   (
   (test_req :dl_test_req_t)
   )
   (
   (test_ind :dl_test_ind_t)
   )
   (
   (test_res :dl_test_res_t)
   )
   (
   (test_con :dl_test_con_t)
   )
   (
   (xid_req :dl_xid_req_t)
   )
   (
   (xid_ind :dl_xid_ind_t)
   )
   (
   (xid_res :dl_xid_res_t)
   )
   (
   (xid_con :dl_xid_con_t)
   )
   (
   (data_ack_req :dl_data_ack_req_t)
   )
   (
   (data_ack_ind :dl_data_ack_ind_t)
   )
   (
   (data_ack_status_ind :dl_data_ack_status_ind_t)
   )
   (
   (reply_req :dl_reply_req_t)
   )
   (
   (reply_ind :dl_reply_ind_t)
   )
   (
   (reply_status_ind :dl_reply_status_ind_t)
   )
   (
   (reply_update_req :dl_reply_update_req_t)
   )
   (
   (reply_update_status_ind :dl_reply_update_status_ind_t)
   )
   )
)

;type name? (def-mactype :DL_primitives (find-mactype ':DL_primitives))

(defconstant $DL_INFO_REQ_SIZE 0)
(defconstant $DL_INFO_ACK_SIZE 0)
(defconstant $DL_ATTACH_REQ_SIZE 0)
(defconstant $DL_DETACH_REQ_SIZE 0)
(defconstant $DL_BIND_REQ_SIZE 0)
(defconstant $DL_BIND_ACK_SIZE 0)
(defconstant $DL_UNBIND_REQ_SIZE 0)
(defconstant $DL_SUBS_BIND_REQ_SIZE 0)
(defconstant $DL_SUBS_BIND_ACK_SIZE 0)
(defconstant $DL_SUBS_UNBIND_REQ_SIZE 0)
(defconstant $DL_OK_ACK_SIZE 0)
(defconstant $DL_ERROR_ACK_SIZE 0)
(defconstant $DL_CONNECT_REQ_SIZE 0)
(defconstant $DL_CONNECT_IND_SIZE 0)
(defconstant $DL_CONNECT_RES_SIZE 0)
(defconstant $DL_CONNECT_CON_SIZE 0)
(defconstant $DL_TOKEN_REQ_SIZE 0)
(defconstant $DL_TOKEN_ACK_SIZE 0)
(defconstant $DL_DISCONNECT_REQ_SIZE 0)
(defconstant $DL_DISCONNECT_IND_SIZE 0)
(defconstant $DL_RESET_REQ_SIZE 0)
(defconstant $DL_RESET_IND_SIZE 0)
(defconstant $DL_RESET_RES_SIZE 0)
(defconstant $DL_RESET_CON_SIZE 0)
(defconstant $DL_UNITDATA_REQ_SIZE 0)
(defconstant $DL_UNITDATA_IND_SIZE 0)
(defconstant $DL_UDERROR_IND_SIZE 0)
(defconstant $DL_UDQOS_REQ_SIZE 0)
(defconstant $DL_ENABMULTI_REQ_SIZE 0)
(defconstant $DL_DISABMULTI_REQ_SIZE 0)
(defconstant $DL_PROMISCON_REQ_SIZE 0)
(defconstant $DL_PROMISCOFF_REQ_SIZE 0)
(defconstant $DL_PHYS_ADDR_REQ_SIZE 0)
(defconstant $DL_PHYS_ADDR_ACK_SIZE 0)
(defconstant $DL_SET_PHYS_ADDR_REQ_SIZE 0)
(defconstant $DL_GET_STATISTICS_REQ_SIZE 0)
(defconstant $DL_GET_STATISTICS_ACK_SIZE 0)
(defconstant $DL_XID_REQ_SIZE 0)
(defconstant $DL_XID_IND_SIZE 0)
(defconstant $DL_XID_RES_SIZE 0)
(defconstant $DL_XID_CON_SIZE 0)
(defconstant $DL_TEST_REQ_SIZE 0)
(defconstant $DL_TEST_IND_SIZE 0)
(defconstant $DL_TEST_RES_SIZE 0)
(defconstant $DL_TEST_CON_SIZE 0)
(defconstant $DL_DATA_ACK_REQ_SIZE 0)
(defconstant $DL_DATA_ACK_IND_SIZE 0)
(defconstant $DL_DATA_ACK_STATUS_IND_SIZE 0)
(defconstant $DL_REPLY_REQ_SIZE 0)
(defconstant $DL_REPLY_IND_SIZE 0)
(defconstant $DL_REPLY_STATUS_IND_SIZE 0)
(defconstant $DL_REPLY_UPDATE_REQ_SIZE 0)
(defconstant $DL_REPLY_UPDATE_STATUS_IND_SIZE 0)
;  Fast path request 

(defconstant $DL_IOC_HDR_INFO #x6C0A)
; 
;    Mentat's code does an #ifdef on this symbol, so we have to #define
;    it as well as declare it as an enum.  But only for Apple builds because
;    we don't want internal weirdness to propagate to developers.
; 
; #define DL_IOC_HDR_INFO DL_IOC_HDR_INFO
;  ***** From the Mentat "modnames.h" *****
; #define MI_AFU_NAME         "afu"
; #define MI_AHARP_NAME       "ahar"
; #define MI_AHENET_NAME      "ahen"
; #define MI_ARP_NAME         "arp"
; #define MI_ARPM_NAME        "arpm"
; #define MI_COURMUX_NAME     "courmux"
; #define MI_CLONE_NAME       "clone"
; #define MI_DLB_NAME         "dlb"
; #define MI_DLM_NAME         "dlm"
; #define MI_DMODD_NAME       "disdlpi"
; #define MI_DMODT_NAME       "distpi"
; #define MI_DN_NAME          "dn"
; #define MI_DNF_NAME         "dnf"
; #define MI_DRVE_NAME        "drve"
; #define MI_ECHO_NAME        "echo"
; #define MI_ENXR_NAME        "enxr"
; #define MI_RAWIP_NAME       "rawip"
; #define MI_RAWIPM_NAME      "rawipm"
; #define MI_HAVOC_NAME       "havoc"
; #define MI_HAVOCM_NAME      "havocm"
; #define MI_IP_NAME          "ip"
; #define MI_IPM_NAME         "ipm"
; #define MI_IPX_NAME         "ipx"
; #define MI_LOG_NAME         "log"
; #define MI_MODE_NAME        "mode"
; #define MI_MUX_NAME         "mux"
; #define MI_NECHO_NAME       "necho"
; #define MI_NPEP_NAME        "npep"
; #define MI_NULS_NAME        "nuls"
; #define MI_NULZ_NAME        "nulz"
; #define MI_PASS_NAME        "pass"
; #define MI_PIPEMOD_NAME     "pipemod"
; #define MI_SAD_NAME         "sad"
; #define MI_SC_NAME          "sc"
; #define MI_SOCKMOD_NAME     "sockmod"
; #define MI_SPASS_NAME       "spass"
; #define MI_SPX_NAME         "spx"
; #define MI_STH_NAME         "mi_sth"
; #define MI_TCP_NAME         "tcp"
; #define MI_TCPM_NAME        "tcpm"
; #define MI_TIMOD_NAME       "timod"
; #define MI_TIRDWR_NAME      "tirdwr"
; #define MI_TMOD_NAME        "tmod"
; #define MI_TMUX_NAME        "tmux"
; #define MI_TPIT_NAME        "tpit"
; #define MI_TRSR_NAME        "trsr"
; #define MI_TRXR_NAME        "trxr"
; #define MI_UDP_NAME         "udp"
; #define MI_UDPM_NAME        "udpm"
; #define MI_WELD_NAME        "mi_weld"
; #define MI_XDG_NAME         "xdg"
; #define MI_XECHO_NAME       "xecho"
; #define MI_XF_NAME          "xf"
; #define MI_XFIPX_NAME       "xfipx"
; #define MI_XFXNS_NAME       "xfxns"
; #define MI_XPE_NAME         "xpe"
; #define MI_XS_NAME          "xs"
; #define MI_XTINDG_NAME      "xtindg"
; #define MI_XTINVC_NAME      "xtinvc"
; #define MI_XTM_NAME         "xtm"
; #define MI_XTMIP_NAME       "xtmip"
; #define MI_AFU_DEVICE       "/dev/afu"
; #define MI_ARP_DEVICE       "/dev/arp"
; #define MI_COURMUX_DEVICE   "/dev/courmux"
; #define MI_CLONE_DEVICE     "/dev/clone"
; #define MI_DLB_DEVICE       "/dev/dlb"
; #define MI_DN_DEVICE        "/dev/dn"
; #define MI_DNF_DEVICE       "/dev/dnf"
; #define MI_DRVE_DEVICE      "/dev/drve"
; #define MI_ECHO_DEVICE      "/dev/echo"
; #define MI_RAWIP_DEVICE     "/dev/rawip"
; #define MI_HAVOC_DEVICE     "/dev/havoc"
; #define MI_IP_DEVICE        "/dev/ip"
; #define MI_IPX_DEVICE       "/dev/ipx"
; #define MI_LOG_DEVICE       "/dev/log"
; #define MI_MODE_DEVICE      "/dev/mode"
; #define MI_MUX_DEVICE       "/dev/mux"
; #define MI_NECHO_DEVICE     "/dev/necho"
; #define MI_NPEP_DEVICE      "/dev/npep"
; #define MI_NULS_DEVICE      "/dev/nuls"
; #define MI_NULZ_DEVICE      "/dev/nulz"
; #define MI_SAD_DEVICE       "/dev/sad"
; #define MI_SPX_DEVICE       "/dev/spx"
; #define MI_TCP_DEVICE       "/dev/tcp"
; #define MI_TMUX_DEVICE      "/dev/tmux"
; #define MI_TMUX0_DEVICE     "/dev/tmux#0"
; #define MI_TMUX1_DEVICE     "/dev/tmux#1"
; #define MI_TPIT_DEVICE      "/dev/tpit"
; #define MI_UDP_DEVICE       "/dev/udp"
; #define MI_XDG_DEVICE       "/dev/xdg"
; #define MI_XECHO_DEVICE     "/dev/xecho"
; #define MI_XF_DEVICE        "/dev/xf"
; #define MI_XPE_DEVICE       "/dev/xpe"
; #define MI_XS_DEVICE        "/dev/xs"
; #define MI_XTINDG_DEVICE    "/dev/xtindg"
; #define MI_XTINVC_DEVICE    "/dev/xtinvc"
;  Streamtab entries 
; #define MI_AFU_STREAMTAB    afuinfo
; #define MI_AHARP_STREAMTAB  aharinfo
; #define MI_AHENET_STREAMTAB aheninfo
; #define MI_ARP_STREAMTAB    arpinfo
; #define MI_ARPM_STREAMTAB   arpminfo
; #define MI_COURMUX_STREAMTAB    courmuxinfo
; #define MI_CLONE_STREAMTAB  cloneinfo
; #define MI_DLB_STREAMTAB    dlbinfo
; #define MI_DLM_STREAMTAB    dlminfo
; #define MI_DMODD_STREAMTAB  dmoddinfo
; #define MI_DMODT_STREAMTAB  dmodtinfo
; #define MI_DN_STREAMTAB     dninfo
; #define MI_DNF_STREAMTAB    dnfinfo
; #define MI_DRVE_STREAMTAB   drveinfo
; #define MI_ECHO_STREAMTAB   echoinfo
; #define MI_ENXR_STREAMTAB   enxrinfo
; #define MI_HAVOC_STREAMTAB  hvcinfo
; #define MI_HAVOCM_STREAMTAB hvcminfo
; #define MI_IP_STREAMTAB     ipinfo
; #define MI_IPM_STREAMTAB    ipminfo
; #define MI_IPX_STREAMTAB    ipxinfo
; #define MI_LOG_STREAMTAB    loginfo
; #define MI_MODE_STREAMTAB   modeinfo
; #define MI_MUX_STREAMTAB    muxinfo
; #define MI_NECHO_STREAMTAB  nechoinfo
; #define MI_NPEP_STREAMTAB   npepinfo
; #define MI_NULS_STREAMTAB   nulsinfo
; #define MI_NULZ_STREAMTAB   nulzinfo
; #define MI_PASS_STREAMTAB   passinfo
; #define MI_PIPEMOD_STREAMTAB    pmodinfo
; #define MI_RAWIP_STREAMTAB  rawipinfo
; #define MI_RAWIPM_STREAMTAB rawipminfo
; #define MI_SAD_STREAMTAB    sadinfo
; #define MI_SC_STREAMTAB     scinfo
; #define MI_SOCKMOD_STREAMTAB    sockmodinfo
; #define MI_SPASS_STREAMTAB  spassinfo
; #define MI_SPX_STREAMTAB    spxinfo
; #define MI_STH_STREAMTAB    mi_sthinfo
; #define MI_TCP_STREAMTAB    tcpinfo
; #define MI_TCPM_STREAMTAB   tcpminfo
; #define MI_TIMOD_STREAMTAB  timodinfo
; #define MI_TIRDWR_STREAMTAB tirdwrinfo
; #define MI_TMOD_STREAMTAB   tmodinfo
; #define MI_TMUX_STREAMTAB   tmuxinfo
; #define MI_TPIT_STREAMTAB   tpitinfo
; #define MI_TRSR_STREAMTAB   trsrinfo
; #define MI_TRXR_STREAMTAB   trxrinfo
; #define MI_UDP_STREAMTAB    udpinfo
; #define MI_UDPM_STREAMTAB   udpminfo
; #define MI_WELD_STREAMTAB   mi_weldinfo
; #define MI_XDG_STREAMTAB    xdginfo
; #define MI_XECHO_STREAMTAB  xechoinfo
; #define MI_XF_STREAMTAB     xfinfo
; #define MI_XFIPX_STREAMTAB  xfipxinfo
; #define MI_XFXNS_STREAMTAB  xfxnsinfo
; #define MI_XPE_STREAMTAB    xpeinfo
; #define MI_XS_STREAMTAB     xsinfo
; #define MI_XTINDG_STREAMTAB xtindginfo
; #define MI_XTINVC_STREAMTAB xtinvcinfo
; #define MI_XTM_STREAMTAB    xtminfo
; #define MI_XTMIP_STREAMTAB  xtmipinfo
; #define MI_AFU_DEVFLAG      afudevflag
; #define MI_AHARP_DEVFLAG    ahardevflag
; #define MI_AHENET_DEVFLAG   ahendevflag
; #define MI_ARP_DEVFLAG      arpdevflag
; #define MI_ARPM_DEVFLAG     arpmdevflag
; #define MI_COURMUX_DEVFLAG  courmuxdevflag
; #define MI_CLONE_DEVFLAG    clonedevflag
; #define MI_DLB_DEVFLAG      dlbdevflag
; #define MI_DLM_DEVFLAG      dlmdevflag
; #define MI_DMODD_DEVFLAG    dmodddevflag
; #define MI_DMODT_DEVFLAG    dmodtdevflag
; #define MI_DN_DEVFLAG       dndevflag
; #define MI_DNF_DEVFLAG      dnfdevflag
; #define MI_DRVE_DEVFLAG     drvedevflag
; #define MI_ECHO_DEVFLAG     echodevflag
; #define MI_ENXR_DEVFLAG     enxrdevflag
; #define MI_HAVOC_DEVFLAG    hvcdevflag
; #define MI_HAVOCM_DEVFLAG   hvcmdevflag
; #define MI_IP_DEVFLAG       ipdevflag
; #define MI_IPM_DEVFLAG      ipmdevflag
; #define MI_IPX_DEVFLAG      ipxdevflag
; #define MI_LOG_DEVFLAG      logdevflag
; #define MI_MODE_DEVFLAG     modedevflag
; #define MI_MUX_DEVFLAG      muxdevflag
; #define MI_NECHO_DEVFLAG    nechodevflag
; #define MI_NPEP_DEVFLAG     npepdevflag
; #define MI_NULS_DEVFLAG     nulsdevflag
; #define MI_NULZ_DEVFLAG     nulzdevflag
; #define MI_PASS_DEVFLAG     passdevflag
; #define MI_PIPEMOD_DEVFLAG  pipemoddevflag
; #define MI_RAWIP_DEVFLAG    rawipdevflag
; #define MI_RAWIPM_DEVFLAG   rawipmdevflag
; #define MI_SAD_DEVFLAG      saddevflag
; #define MI_SC_DEVFLAG       scdevflag
; #define MI_SOCKMOD_DEVFLAG  sockmoddevflag
; #define MI_SPASS_DEVFLAG    spassdevflag
; #define MI_SPX_DEVFLAG      spxdevflag
; #define MI_TCP_DEVFLAG      tcpdevflag
; #define MI_TCPM_DEVFLAG     tcpmdevflag
; #define MI_TIMOD_DEVFLAG    timoddevflag
; #define MI_TIRDWR_DEVFLAG   tirdwrdevflag
; #define MI_TMOD_DEVFLAG     tmoddevflag
; #define MI_TMUX_DEVFLAG     tmuxdevflag
; #define MI_TPIT_DEVFLAG     tpitdevflag
; #define MI_TRSR_DEVFLAG     trsrdevflag
; #define MI_TRXR_DEVFLAG     trxrdevflag
; #define MI_UDP_DEVFLAG      udpdevflag
; #define MI_UDPM_DEVFLAG     udpmdevflag
; #define MI_XDG_DEVFLAG      xdgdevflag
; #define MI_XECHO_DEVFLAG    xechodevflag
; #define MI_XF_DEVFLAG       xfdevflag
; #define MI_XFIPX_DEVFLAG    xfipxdevflag
; #define MI_XFXNS_DEVFLAG    xfxnsdevflag
; #define MI_XPE_DEVFLAG      xpedevflag
; #define MI_XS_DEVFLAG       xsdevflag
; #define MI_XTINDG_DEVFLAG   xtindgdevflag
; #define MI_XTINVC_DEVFLAG   xtinvcdevflag
; #define MI_XTM_DEVFLAG      xtmdevflag
; #define MI_XTMIP_DEVFLAG    xtmipdevflag
; #define MI_AFU_SQLVL        SQLVL_QUEUEPAIR
; #define MI_AHARP_SQLVL      SQLVL_QUEUE
; #define MI_AHENET_SQLVL     SQLVL_QUEUE
; #define MI_ARP_SQLVL        SQLVL_MODULE
; #define MI_ARPM_SQLVL       SQLVL_MODULE
; #define MI_COURMUX_SQLVL    SQLVL_MODULE
; #define MI_CLONE_SQLVL      SQLVL_MODULE
; #define MI_DLB_SQLVL        SQLVL_QUEUE
; #define MI_DLM_SQLVL        SQLVL_QUEUE
; #define MI_DMODD_SQLVL      SQLVL_QUEUE
; #define MI_DMODT_SQLVL      SQLVL_QUEUE
; #define MI_DN_SQLVL         SQLVL_QUEUE
; #define MI_DNF_SQLVL        SQLVL_QUEUE
; #define MI_DRVE_SQLVL       SQLVL_QUEUEPAIR
; #define MI_ECHO_SQLVL       SQLVL_QUEUE
; #define MI_ENXR_SQLVL       SQLVL_QUEUE
; #define MI_RAWIP_SQLVL      SQLVL_QUEUE
; #define MI_RAWIPM_SQLVL     SQLVL_QUEUE
; #define MI_HAVOC_SQLVL      SQLVL_QUEUE
; #define MI_HAVOCM_SQLVL     SQLVL_QUEUE
; #define MI_IP_SQLVL         SQLVL_QUEUEPAIR
; #define MI_IPM_SQLVL        SQLVL_QUEUEPAIR
; #define MI_IPX_SQLVL        SQLVL_QUEUE
; #define MI_LOG_SQLVL        SQLVL_MODULE
; #define MI_MODE_SQLVL       SQLVL_QUEUEPAIR
; #define MI_MUX_SQLVL        SQLVL_MODULE
; #define MI_NECHO_SQLVL      SQLVL_QUEUE
; #define MI_NPEP_SQLVL       SQLVL_QUEUE
; #define MI_NULS_SQLVL       SQLVL_QUEUE
; #define MI_NULZ_SQLVL       SQLVL_QUEUE
; #define MI_PASS_SQLVL       SQLVL_QUEUE
; #define MI_PIPEMOD_SQLVL    SQLVL_QUEUE
; #define MI_SAD_SQLVL        SQLVL_MODULE
; #define MI_SC_SQLVL         SQLVL_QUEUE
; #define MI_SOCKMOD_SQLVL    SQLVL_QUEUEPAIR
; #define MI_SPASS_SQLVL      SQLVL_QUEUE
; #define MI_SPX_SQLVL        SQLVL_QUEUE
; #define MI_TCP_SQLVL        SQLVL_QUEUEPAIR
; #define MI_TCPM_SQLVL       SQLVL_QUEUEPAIR
; #define MI_TIMOD_SQLVL      SQLVL_QUEUEPAIR
; #define MI_TIRDWR_SQLVL     SQLVL_QUEUE
; #define MI_TMOD_SQLVL       SQLVL_QUEUEPAIR
; #define MI_TMUX_SQLVL       SQLVL_MODULE
; #define MI_TPIT_SQLVL       SQLVL_MODULE
; #define MI_TRSR_SQLVL       SQLVL_MODULE
; #define MI_TRXR_SQLVL       SQLVL_QUEUE
; #define MI_UDP_SQLVL        SQLVL_QUEUE
; #define MI_UDPM_SQLVL       SQLVL_QUEUE
; #define MI_XDG_SQLVL        SQLVL_QUEUE
; #define MI_XECHO_SQLVL      SQLVL_QUEUE
; #define MI_XF_SQLVL         SQLVL_MODULE
; #define MI_XFIPX_SQLVL      SQLVL_MODULE
; #define MI_XFXNS_SQLVL      SQLVL_MODULE
; #define MI_XPE_SQLVL        SQLVL_QUEUE
; #define MI_XS_SQLVL         SQLVL_QUEUEPAIR
; #define MI_XTINDG_SQLVL     SQLVL_QUEUEPAIR
; #define MI_XTINVC_SQLVL     SQLVL_QUEUEPAIR
; #define MI_XTM_SQLVL        SQLVL_QUEUEPAIR
; #define MI_XTMIP_SQLVL      SQLVL_QUEUEPAIR
;  ***** Raw Streams *****
; 
;    Flags used in the fType field of OTReadInfo for functions.
;    I've removed the terse and confusing comments in this header
;    file.  For a full description, read "Open Transport Advanced
;    Client Programming".
; 

(defconstant $kOTNoMessagesAvailable #xFFFFFFFF)
(defconstant $kOTAnyMsgType #xFFFFFFFE)
(defconstant $kOTDataMsgTypes #xFFFFFFFC)
(defconstant $kOTMProtoMsgTypes #xFFFFFFFB)
(defconstant $kOTOnlyMProtoMsgTypes #xFFFFFFFA)
; 
;    OTPutCommand, OTPutData, and OTPutWriteData flags.
;    These equates must not conflict with any of the other putmsg flags,
;    ie MSG_ANY, MSG_BAND, MSG_HIPRI, or RS_HIPRI.
;    еее These should probably move into whereever their
;    corresponding functions end up but, seeing as this
;    is APPLE_ONLY, I'm not too concerned еее
; 

(defconstant $RS_EXDATA 32)
(defconstant $RS_ALLOWAGAIN 64)
(defconstant $RS_DELIMITMSG #x80)

; #if !OTKERNEL
;  StreamRef is an opaque reference to a raw stream.
; #ifdef __cplusplus
#|
    typedef class TSTREAM*      StreamRef;
|#

; #else

(def-mactype :StreamRef (find-mactype '(:pointer :void)))

; #endif

; #define kOTInvalidStreamRef ((StreamRef)0L)
;  PollRef structure is used with the OTStreamPoll function.
(defrecord PollRef
   (filler :SInt32)                             ;  holds a file descriptor an a UNIX system, replaced by ref (at end of structure) under OT
   (events :SInt16)
   (revents :SInt16)
   (ref :StreamRef)
)

;type name? (def-mactype :PollRef (find-mactype ':PollRef))
;  Poll masks for use with OTStreamPoll: 
; #define POLLIN          0x001   /* A non-priority message is available                 */
; #define POLLPRI         0x002   /* A high priority message is available                */
; #define POLLOUT         0x004   /* The stream is writable for non-priority messages    */
; #define POLLERR         0x008   /* A error message has arrived                         */
; #define POLLHUP         0x010   /* A hangup has occurred                               */
; #define POLLNVAL        0x020   /* This fd is bogus                                    */
; #define POLLRDNORM      0x040   /* A non-priority message is available                 */
; #define POLLRDBAND      0x080   /* A priority message (band > 0) message is available  */
; #define POLLWRNORM      0x100   /* Same as POLLOUT                                     */
; #define POLLWRBAND      0x200   /* A priority band exists and is writable              */
; #define POLLMSG         0x400   /* A signal message has reached the front of the queue */
;  OTReadInfo structure is used with the various functions that read and peek at the stream head.
(defrecord OTReadInfo
   (fType :UInt32)
   (fCommand :SInt32)
   (fFiller :UInt32)                            ;  For compatibility with OT 1.0 and 1.1 
   (fBytes :UInt32)
   (fError :SInt32)
)

;type name? (def-mactype :OTReadInfo (find-mactype ':OTReadInfo))
;  Opening and closing raw streams
; 
;  *  OTStreamOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTAsyncStreamOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCreateStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTAsyncCreateStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamClose()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Polling a stream for activity
; 
;  *  OTStreamPoll()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTAsyncStreamPoll()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Classic UNIX file descriptor operations
; 
;  *  OTStreamRead()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamWrite()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamIoctl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamPipe()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  there can be only 2!
;  Notifiers and modes of operation
; 
;  *  OTStreamInstallNotifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamRemoveNotifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamUseSyncIdleEvents()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamSetBlocking()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamSetNonBlocking()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamIsBlocking()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamSetSynchronous()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamSetAsynchronous()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamIsSynchronous()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  STREAMS primitives
; 
;  *  OTStreamGetMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamGetPriorityMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamPutMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTStreamPutPriorityMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Miscellaneous stuff
; 
;  *  OTStreamSetControlMask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    Opening endpoints and mappers on a Stream - these calls are synchronous, and may
;    only be used at System Task time. Once the stream has been installed into a provider
;    or endpoint, you should not continue to use STREAMS APIs on it
; 
; 
;  *  OTOpenProviderOnStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTOpenEndpointOnStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    To quote an earlier version of this header file:
;    
;         Some functions that should only be used if
;         you really know what you're doing.
; 
; 
;  *  OTRemoveStreamFromProvider()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTPeekMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTReadMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTPutBackBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTPutBackPartialBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !OTKERNEL */

 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  ***** Port Utilities *****

; #if !OTKERNEL
; 
;    These types and routines are used during sophisticated
;    port management.  High-level clients may get involved
;    for things like request a port to be yielding, but typically
;    this stuff is used by protocol infrastructure.
; 
; 
;    OTPortCloseStruct is used when processing the kOTClosePortRequest
;    and kOTYieldPortRequest events.
; 
(defrecord OTPortCloseStruct
   (fPortRef :UInt32)                           ;  The port requested to be closed.
   (fTheProvider (:pointer :void))              ;  The provider using the port.
   (fDenyReason :SInt32)                        ;  Set to a negative number to deny the request
)

;type name? (%define-record :OTPortCloseStruct (find-record-descriptor ':OTPortCloseStruct))
;  OTClientList structure is used with the OTYieldPortRequest function.
(defrecord OTClientList
   (fNumClients :UInt32)
   (fBuffer (:array :UInt8 4))
)

;type name? (%define-record :OTClientList (find-record-descriptor ':OTClientList))
; 
;    Returns a buffer containing all of the clients that refused to yield the port.
;    "size" is the total number of bytes @ buffer, including the fNumClients field.
; 
; 
;  *  OTYieldPortRequest()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Send a notification to all Open Transport registered clients
; 
;  *  OTNotifyAllClients()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Determine if "child" is a child port of "parent"
; 
;  *  OTIsDependentPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !OTKERNEL */

;  ***** Timers ***** 
; 
;    STREAMS plug-ins code should not use these timers, instead
;    they should use timer messages, ie mi_timer etc.
; 

; #if !OTKERNEL

(def-mactype :OTTimerTask (find-mactype ':signed-long))
; 
;    Under Carbon, OTCreateTimerTask takes a client context pointer.  Applications may pass NULL
;    after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
;    valid client context.
; 
; 
;  *  OTCreateTimerTaskInContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTCreateTimerTaskInContext" 
   ((upp (:pointer :OpaqueOTProcessProcPtr))
    (arg :pointer)
    (clientContext (:pointer :OpaqueOTClientContextPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  OTCreateTimerTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCancelTimerTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTCancelTimerTask" 
   ((timerTask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTDestroyTimerTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTDestroyTimerTask" 
   ((timerTask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OTScheduleTimerTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OTScheduleTimerTask" 
   ((timerTask :signed-long)
    (milliSeconds :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )

; #if OTCARBONAPPLICATION
#|                                              ;  The following macro may be used by applications only.
; #define OTCreateTimerTask(upp, arg) OTCreateTimerTaskInContext(upp, arg, NULL)
 |#

; #endif  /* OTCARBONAPPLICATION */


; #endif  /* !OTKERNEL */

;  ***** Miscellaneous Helpful Functions *****

; #if !OTKERNEL
; 
;    These routines allow you to manipulate OT's buffer structures.
;    If you use no-copy receives (described in "OpenTransport.h")
;    you will need some of these routines, and may choose to use others.
;    See "Open Tranport Advanced Client Programming" for documentation.
; 
; 
;  *  OTBufferDataSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTBufferDataSize" 
   ((buffer (:pointer :OTBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  OTReadBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTReadBuffer" 
   ((buffer (:pointer :OTBufferInfo))
    (dest :pointer)
    (len (:pointer :OTBYTECOUNT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTReleaseBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTReleaseBuffer" 
   ((buffer (:pointer :OTBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StoreIntoNetbuf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  StoreMsgIntoNetbuf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !OTKERNEL */

;  ***** OTConfiguration *****

; #if CALL_NOT_IN_CARBON
#| 
; #if !OTKERNEL
; 
;    As promised in "OpenTransport.h", here are the routines
;    for advanced operations on configurations.
; 
;  Manipulating a configuration
; 
;  *  OTCfigNewConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigDeleteConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigCloneConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigPushNewSingleChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigPushParent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigPushChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigPopChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigGetChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigSetPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigNewChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigAddChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigRemoveChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigSetPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigChangeProviderName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Query a configuration
; 
;  *  OTCfigNumberOfChildren()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigGetParent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigGetOptionNetbuf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigGetPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigGetInstallFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigGetProviderName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCfigIsPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !OTKERNEL */

;  ***** Configurators *****
; 
;    The kOTConfiguratorInterfaceID define is what you need to add to your
;    export file for the "interfaceID = " clause to export a configurator
;    for ASLM.  Similarly, kOTConfiguratorCFMTag is used for CFM-based
;    configurators.
; 
; #define kOTConfiguratorInterfaceID  kOTClientPrefix "cfigMkr"
; #define kOTConfiguratorCFMTag       kOTClientPrefix "cfigMkr"

; #if !OTKERNEL
; #ifdef __cplusplus
#|
    class TOTConfigurator;
    typedef class TOTConfigurator* TOTConfiguratorRef;
|#

; #else

;type name? (def-mactype :TOTConfigurator (find-mactype ':TOTConfigurator))

(def-mactype :TOTConfiguratorRef (find-mactype '(:pointer :TOTConfigurator)))

; #endif

; 
;    Typedef for the OTCanConfigure function, and the enum for which pass we're doing.
;    The first (kOTSpecificConfigPass) is to give configurators a shot at the configuration
;    before we start allowing the generic configurators to get into the act.
; 

(defconstant $kOTSpecificConfigPass 0)
(defconstant $kOTGenericConfigPass 1)

(def-mactype :OTCanConfigureProcPtr (find-mactype ':pointer)); (OTConfigurationRef cfig , UInt32 pass)
;  Typedef for the function to create and return a configurator object

(def-mactype :OTCreateConfiguratorProcPtr (find-mactype ':pointer)); (TOTConfiguratorRef * cfigor)
; 
;    Typedef for the "OTSetupConfigurator" function that your configurator library must export.
;    The enum is for the type of configurator that it is.
; 
; #define kOTSetupConfiguratorID "OTSetupConfigurator"

(defconstant $kOTDefaultConfigurator 0)
(defconstant $kOTProtocolFamilyConfigurator 1)
(defconstant $kOTLinkDriverConfigurator 2)

(def-mactype :OTSetupConfiguratorProcPtr (find-mactype ':pointer)); (OTCanConfigureProcPtr * canConfigure , OTCreateConfiguratorProcPtr * createConfigurator , UInt8 * configuratorType)
; 
;    Procedure pointer definitions for the three key callbacks associated
;    with a configurator, as established by OTNewConfigurator.
; 

(def-mactype :OTCFConfigureProcPtr (find-mactype ':pointer)); (TOTConfiguratorRef cfigor , OTConfigurationRef cfig)

(def-mactype :OTCFCreateStreamProcPtr (find-mactype ':pointer)); (TOTConfiguratorRef cfigor , OTConfigurationRef cfig , OTOpenFlags oFlags , OTNotifyUPP proc , void * contextPtr)

(def-mactype :OTCFHandleSystemEventProcPtr (find-mactype ':pointer)); (TOTConfiguratorRef cfigor , OTEventCode code , OTResult result , void * cookie)
; 
;    Determine if this instance of your configurator is the "master"
;    (the one that can create and destroy control streams)
; 
; 
;  *  OTIsMasterConfigurator()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Get back the userData you passed in to OTNewConfigurator
; 
;  *  OTGetConfiguratorUserData()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Create a configurator object for use by Open Transport
; 
;  *  OTNewConfigurator()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Delete a configurator object created by OTNewConfigurator
; 
;  *  OTDeleteConfigurator()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    A utility function to send notifications to the user - it takes care of calls
;    from deferred tasks
; 
; 
;  *  OTNotifyUser()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Call when the configurator unloads from memory
; 
;  *  OTConfiguratorUnloaded()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    Call to create your control stream if you're not the master
;    configurator.  You can also use the state machine function
;    OTSMCreateControlStream(OTStateMachine*, OTConfigurationRef, TOTConfiguratorRef cfigor).
; 
; 
;  *  OTCreateControlStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    A helpful function for the configurators to
;    be able to recursively configure the children.
; 
; 
;  *  OTConfigureChildren()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Allocate a bit in the system-wide control mask for streams.
; 
;  *  OTNewControlMask()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Warning: These 2 APIs is going away
; 
;  *  OTCloseProvidersByUseCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCloseProvidersByPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  These are the "real" APIs
; 
;  *  OTCloseProviderByStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTCloseMatchingProviders()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  The following defines are for use in building an 'epcf' resource: 
;  Defines for fFlags field: 
; #define kIsReliable             0x00000001
; #define kIsNotReliable          0x00000002
; #define kSupportsOrderlyRelease 0x00000004
;  Defines for fProtocolType field: 
; #define kStream                 0x0001
; #define kUStream                0x0002
; #define kTransaction            0x0004
; #define kUTransaction           0x0008
; #define kMapper                 0x0010
; #define kGenericProtocol        0x0020
;  Defines for optionType field: 
; #define kBooleanOption          0
; #define kUnsignedValueOption    1
; #define kSignedValueOption      2
; #define kHexValueOption         3
; #define kPrintableStringOption  4
; #define kOctetStringOption      5
;  Defines for fUpperInterface and fLowerInterface: 
; #define kTPIInterface           'TPI '
; #define kDLPIInterface          'DLPI'
; #define kMapperInterface        'MAPR'
; #define kPrivateInterface       -1
; #define kNoInterface            0

; #endif  /* !OTKERNEL */

 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  ***** OTStateMachine *****

; #if CALL_NOT_IN_CARBON
#| 
; 
;    This utility set allows you to write an asynchronous chain of code that looks 
;    somewhat like it is synchronous.  This is primarily used for plumbing 
;    streams asynchronously, especially in configurators
; 

; #if !OTKERNEL
;  Alas, the state machine is only available to client code.  Sorry.
; 
;    There are 12 or 8 bytes of reserved space at the front of
;    the OTStateMachine structure, depending on whether you're
;    building PowerPC or 68K code..  The OTStateMachineDataPad
;    type compensates for this.
; 

; #if TARGET_CPU_PPC
(defrecord OTStateMachineDataPad
   (contents (:array :UInt8 12))
)
; #else
(defrecord OTStateMachineDataPad
   (contents (:array :UInt8 8))
)
; #endif  /* TARGET_CPU_PPC */

; 
;    Forward define OTStateMachine so that OTStateProcPtr has
;    access to it.
; 

;type name? (def-mactype :OTStateMachine (find-mactype ':OTStateMachine))
; 
;    This type is is the required prototype of a state machine
;    entry point.
; 

(def-mactype :OTStateProcPtr (find-mactype ':pointer)); (OTStateMachine * sm)
; 
;    This type defines a routine that the state machine will
;    call when the top level completes.
; 

(def-mactype :OTSMCompleteProcPtr (find-mactype ':pointer)); (void * contextPtr)
;  And now for the state machine structure itself.
(defrecord OTStateMachine
   (fData :otstatemachinedatapad)
   (fCookie :pointer)
   (fCode :UInt32)
   (fResult :SInt32)
; #ifdef __cplusplus
#|

    


    void*       GetClientData();

    Boolean     CallStateProc(OTStateProcPtr proc, UInt32 state = 0);

    UInt16      GetState();

    void        SetState(UInt32 state);

    void        Complete();

    void        Complete(OTResult result);

    void        Complete(OTResult result, OTEventCode code, void* contextPtr);

    void        CompleteToClient();

    void        CompleteToClient(OTResult result);

    void        CompleteToClient(OTResult result, OTEventCode code, void* contexPtr);

    void        PopCallback();

    Boolean     CreateStream(OTConfigurationRef cfig, OTOpenFlags flags);

    Boolean     OpenStream(const char* name, OTOpenFlags flags);

    Boolean     SendIoctl(StreamRef ref, UInt32 type, void* data);

    Boolean     SendIoctl(StreamRef ref, UInt32 type, long data);

    Boolean     PutMessage(StreamRef ref, strbuf* ctl, strbuf* data, OTFlags flags);

    Boolean     GetMessage(StreamRef ref, strbuf* ctl, strbuf* data, OTFlags* flagPtr);

    OSStatus    ReturnToCaller();

#endif
|#
)
; #define kOTSMBufferSize(callDepth) (80 + (callDepth * 8))
; 
;    For structSize, pass the size of your structure that you want associated with
;    the state machine.  It can later be obtained by calling OTSMGetClientData.
;    For bufSize, use the kOTSMBufferSize macro, plus the size of your structure
;    to create a buffer on the stack. For synchronous calls, the stack buffer will
;    be used (unless you pass in NULL).  The callDepth is the depth level of nested
;    calls using OTSMCallStateProc.
; 
; 
;  *  OTCreateStateMachine()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTDestroyStateMachine()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    OTSMCallStateProc used to take a parameter of type UInt16_p,
;    which was defined to be the same as UInt32.  In an attempt
;    to reduce the number of wacky types defined by the OT
;    interfaces, we've changed these routines to just take a
;    straight UInt32.  You should be warned that the current
;    implementation does not support values outside of the
;    range 0..32767.  The same applies to OTSMSetState.
; 
; 
;  *  OTSMCallStateProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMGetState()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMSetState()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Fill out the fCookie, fCode, and fResult fields before calling!
; 
;  *  OTSMComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMPopCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMWaitForComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMCreateStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMOpenStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMIoctl()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMPutMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMGetMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMReturnToCaller()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMGetClientData()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMInstallCompletionProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  OTSMCreateControlStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; #ifdef __cplusplus
#|
    inline void*        OTStateMachine::GetClientData() { return OTSMGetClientData(this); }
    inline Boolean      OTStateMachine::CallStateProc(OTStateProcPtr proc, UInt32 state)
                                                        { return OTSMCallStateProc(this, proc, state); }
    inline UInt16       OTStateMachine::GetState()      { return OTSMGetState(this); }
    inline void         OTStateMachine::SetState(UInt32 state)
                                                        { OTSMSetState(this, state); }
    inline void         OTStateMachine::PopCallback()   { OTSMPopCallback(this); }
    inline void         OTStateMachine::Complete()      { OTSMComplete(this); }
    inline void         OTStateMachine::Complete(OTResult result, OTEventCode code, void* cookie)
                                                        { fCookie = cookie; fCode = code; fResult = result; Complete(); }
    inline void         OTStateMachine::Complete(OTResult result)
                                                        { fResult = result; Complete(); }
    inline void         OTStateMachine::CompleteToClient()
                                                        { PopCallback(); Complete(); }
    inline void         OTStateMachine::CompleteToClient(OTResult result)
                                                        { fResult   = result; CompleteToClient(); }
    
    inline void         OTStateMachine::CompleteToClient(OTResult result, OTEventCode code, void* cookie)
                                                        { fCookie = cookie; fCode = code; fResult = result; CompleteToClient(); }
    inline Boolean      OTStateMachine::CreateStream(OTConfigurationRef cfig, OTOpenFlags flags)
                                                        { return OTSMCreateStream(this, cfig, flags); }
    inline Boolean      OTStateMachine::OpenStream(const char* name, OTOpenFlags flags)
                                                        { return OTSMOpenStream(this, name, flags); }
    inline Boolean      OTStateMachine::SendIoctl(StreamRef ref, UInt32 type, void* data)
                                                        { return OTSMIoctl(this, ref, type, (long)data); }
    inline Boolean      OTStateMachine::SendIoctl(StreamRef ref, UInt32 type, long data)
                                                        { return OTSMIoctl(this, ref, type, data); }
    inline Boolean      OTStateMachine::PutMessage(StreamRef ref, struct strbuf* ctl, struct strbuf* data, OTFlags flags)
                                                        { return OTSMPutMessage(this, ref, ctl, data, flags); }
    inline Boolean      OTStateMachine::GetMessage(StreamRef ref, struct strbuf* ctl, struct strbuf* data, OTFlags* flagPtr)
                                                        { return OTSMGetMessage(this, ref, ctl, data, flagPtr); }
    inline OSStatus     OTStateMachine::ReturnToCaller()
                                                        { return OTSMReturnToCaller(this); }
#endif
|#

; #endif  /* !OTKERNEL */

;  ***** Autopush Definitions *****
; 
;    The autopush functionality for Open Transport is based on the names of
;    devices and modules, rather than on the major number information like 
;    SVR4.  This is so that autopush information can be set up for modules
;    that are not yet loaded.
; 
;  The name of the STREAMS driver you open and send the ioctls to.
; #define kSADModuleName  "sad"
;  Autopush ioctls.

(defconstant $I_SAD_SAP #x6701)                 ;  Set autopush information     

(defconstant $I_SAD_GAP #x6702)                 ;  Get autopush information     
;  Validate a list of modules (uses str_list structure) 

(defconstant $I_SAD_VML #x6703)
;  Maximum number of modules autopushed on a driver.

(defconstant $kOTAutopushMax 8)
;  ioctl structure used for SAD_SAP and SAD_GAP commands.
(defrecord OTAutopushInfo
   (sap_cmd :UInt32)
   (sap_device_name (:array :character 32))
   (sap_minor :SInt32)
   (sap_lastminor :SInt32)
   (sap_npush :SInt32)
   (sap_list (:array :character 256))
)

;type name? (def-mactype :OTAutopushInfo (find-mactype ':OTAutopushInfo))
;  Command values for sap_cmd field of the above.

(defconstant $kSAP_ONE 1)                       ;  Configure a single minor device         

(defconstant $kSAP_RANGE 2)                     ;  Configure a range of minor devices     

(defconstant $kSAP_ALL 3)                       ;  Configure all minor devices          

(defconstant $kSAP_CLEAR 4)                     ;  Clear autopush information          

;  ***** Configuration Helpers *****
; 
;    These definitions are used by device driver and port scanner
;    developers to provide a library giving client-side information about
;    the registered ports, such as a user-visible name or an icon.
; 
;  Configuration helper library prefix
; 
;    This prefix is prepended to the string found in the "fResourceInfo"
;    field of the OTPortRecord to build the actual library name of the
;    configuration helper library.
; 
; #define kPortConfigLibPrefix "OTPortCfg$"
;  Get user visible port name entry point.
; 
;    This entry point returns the user visible name of the port.  If includeSlot
;    is true, a slot distinguishing suffix (eg "slot X") should be added.  If
;    includePort is true, a port distinguishing suffix (eg " port X") should be added for
;    multiport cards.
; 
; #define kOTGetUserPortNameID "OTGetUserPortName"

(def-mactype :OTGetPortNameProcPtr (find-mactype ':pointer)); (OTPortRecord * port , OTBooleanParam includeSlot , OTBooleanParam includePort , Str255 userVisibleName)
;  Get icon entry point.
; 
;    This entry point returns the location of the icon for the port.  Return false if no
;    icon is provided.
; 
; #define kOTGetPortIconID "OTGetPortIcon"
(defrecord OTResourceLocator
   (fFile :FSSpec)
   (fResID :UInt16)
)

;type name? (def-mactype :OTResourceLocator (find-mactype ':OTResourceLocator))

(def-mactype :OTGetPortIconProcPtr (find-mactype ':pointer)); (OTPortRecord * port , OTResourceLocator * iconLocation)
;  ***** Application Access to Configuration Helpers *****

; #if !OTKERNEL
; 
;    These routines are used by clients to get information about ports.
;    The canonical user of these routines is the OT control panel(s),
;    but applications may want to use them as well (to display the list
;    of available Ethernet cards, for example).
; 
;   Returns a user friendly name for a port.
; 
;  *  OTGetUserPortNameFromPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;     Returns the location for the icon familly representing the port.
;     Returns false if the port has no icon.
; 
; 
;  *  OTGetPortIconFromPortRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;     Gets the slot and other value for the default port of the given device type
;     Returns false if there is no default port of that device type
; 
; 
;  *  OTGetDefaultPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Returns true if the port can be used with the specified protocol.
; 
;  *  OTIsPortCompatibleWith()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !OTKERNEL */

 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  ***** Common Utilities *****
; 
;    The utilities defined in this section are available to both client
;    and kernel code.  Cool huh?  These utilities differ from those
;    provided in "OpenTransport.h" in that they are only available to native
;    architecture clients.
; 
;  Bitmap functions
;  These functions atomically deal with a bitmap that is multiple-bytes long
; 
;    Set the first clear bit in "bitMap", starting with bit "startBit",
;    giving up after "numBits".  Returns the bit # that was set, or
;    a kOTNotFoundErr if there was no clear bit available
; 
; 
;  *  OTSetFirstClearBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTSetFirstClearBit" 
   ((bitMap (:pointer :UInt8))
    (startBit :UInt32)
    (numBits :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
;  Standard clear, set and test bit functions
; 
;  *  OTClearBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTClearBit" 
   ((bitMap (:pointer :UInt8))
    (bitNo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTSetBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTSetBit" 
   ((bitMap (:pointer :UInt8))
    (bitNo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OTTestBit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  

(deftrap-inline "_OTTestBit" 
   ((bitMap (:pointer :UInt8))
    (bitNo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  OTHashList
; 
;    This implements a simple, but efficient hash list.  It is not
;    thread-safe.
; 

(def-mactype :OTHashProcPtr (find-mactype ':pointer)); (OTLink * linkToHash)

(def-mactype :OTHashSearchProcPtr (find-mactype ':pointer)); (const void * ref , OTLink * linkToCheck)
(defrecord OTHashList
   (fHashProc :pointer)
   (fHashTableSize :UInt32)
   (** (:pointer :callback))                    ;(OTLink fHashBuckets)
; #ifdef __cplusplus
#| #|

    


    void            Add(OTLink* toAdd);

    Boolean         RemoveLink(OTLink* toRemove);

    OTLink*         Remove(OTHashSearchProcPtr proc, const void* refPtr, UInt32 hashValue);

    Boolean         IsInList(OTLink* toFind);

    OTLink*         FindLink(OTHashSearchProcPtr proc, const void* refPtr, UInt32 hash);

#endif
|#
 |#
)

;type name? (%define-record :OTHashList (find-record-descriptor ':OTHashList))
; 
;    Return the number of bytes of memory needed to create a hash list
;    of at least "numEntries" entries.
; 
; 
;  *  OTCalculateHashListMemoryNeeds()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;    Create an OTHashList from "memory".  Return an error if it
;    couldn't be done.
; 
; 
;  *  OTInitHashList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTAddToHashList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTRemoveLinkFromHashList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTIsInHashList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTFindInHashList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTRemoveFromHashList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
;  Random functions
; 
;    These implement a very simple random number generator, suitable
;    for protocol implementations but not "cryptographically" random.
; 
; 
;  *  OTGetRandomSeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTGetRandomNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
;  Concurrency Control
; 
;    OTGate implements a cool concurrency control primitive.
;    You're not going to understand it without reading the documentation!
;    See "Open Transport Advanced Client Programming" for details.
;    WARNING:
;    This structure must be on a 4-byte boundary.
; 

(def-mactype :OTGateProcPtr (find-mactype ':pointer)); (OTLink * thisLink)
(defrecord OTGate
   (fLIFO :OTLIFO)
   (fList :OTList)
   (fProc :pointer)
   (fNumQueued :SInt32)
   (fInside :SInt32)
)

;type name? (%define-record :OTGate (find-record-descriptor ':OTGate))
; 
;  *  OTInitGate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTEnterGate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
; 
;  *  OTLeaveGate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in OTUtilityLib 1.0 and later
;  
;  ***** Shared Library Bonus Extras *****

; #if CALL_NOT_IN_CARBON
#| 
; 
;    These routines provide addition shared library support beyond
;    that provided by the base shared library mechanism.
; 
; 
;    Some flags which can be passed to the "loadFlags" parameter of the
;    various CFM routines.  Not all flags can be used with all routines.
;    See "Open Transport Advanced Client Programming" for details.
; 

(defconstant $kOTGetDataSymbol 0)
(defconstant $kOTGetCodeSymbol 1)
(defconstant $kOTLoadNewCopy 2)
(defconstant $kOTLoadACopy 4)
(defconstant $kOTFindACopy 8)
(defconstant $kOTLibMask 14)
(defconstant $kOTLoadLibResident 32)
;  Finding all matching CFM libraries.
; 
;    The routine OTFindCFMLibraries allows you to find all CFM libraries
;    that match specific criteria.  The result is placed in a list
;    of CFMLibraryInfo structures.  OT allocates those structures using
;    a routine of type OTAllocMemProcPtr that you pass to OTFindCFMLibraries.
; 
; 
;    A list of CFMLibraryInfo structures is returned by the OTFindCFMLibraries routine.
;    The list is created out of the data that is passed to the function.
;    
;    IMPORTANT:
;    Only the first 3 fields are valid when using OT 1.2 and older.
; 
(defrecord CFMLibraryInfo
   (link :OTLink)                               ;  To link them all up on a list            
   (libName (:pointer :char))                   ;  "C" String which is fragment name          
   (intlName (:pointer :UInt8))                 ;  Pascal String which is internationalized name  
   (fileSpec (:pointer :FSSpec))                ;  location of fragment's file 
   (pstring2 (:pointer :UInt8))                 ;  Secondary string from extended cfrg          
   (pstring3 (:pointer :UInt8))                 ;  Extra info from extended cfrg            
)

;type name? (def-mactype :CFMLibraryInfo (find-mactype ':CFMLibraryInfo))
; 
;    You must pass a routine of type OTAllocMemProcPtr to OTFindCFMLibraries
;    which it calls to allocate memory for the CFMLibraryInfo structures.
; 

(def-mactype :OTAllocMemProcPtr (find-mactype ':pointer)); (OTByteCount size)
;  Find CFM libraries of the specified kind and type
; 
;  *  OTFindCFMLibraries()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Loading libraries and connecting to symbols.
;  Load a CFM library by name
; 
;  *  OTLoadCFMLibrary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Load a CFM library and get a named pointer from it
; 
;  *  OTGetCFMPointer()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Get a named pointer from a CFM library that's already loaded
; 
;  *  OTGetCFMSymbol()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Release a connection to a CFM library
; 
;  *  OTReleaseCFMConnection()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    You can call these routines in your CFM initialisation and termination
;    routines to hold or unhold your libraries sections.
; 
; 
;    Used in a CFM InitProc, will hold the executable code, if applicable.
;    This can also be the InitProc of the library
; 
; 
;  *  OTHoldThisCFMLibrary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    Used in a CFM terminate proc, will unhold the executable code, if applicable.
;    This can also be the terminate proc of the library
; 
; 
;  *  OTUnholdThisCFMLibrary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  ASLM Utilities
;  Load an ASLM library
; 
;  *  OTLoadASLMLibrary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  Unload an ASLM library
; 
;  *  OTUnloadASLMLibrary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;    This is an ASLM utility routine.  You can get it by including
;    "LibraryManagerUtilities.h", but since we only use a few ASLM utilities,
;    we put the prototype here for convenience.
; 
; 
;  *  UnloadUnusedLibraries()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if !OTKERNEL
; ******************************************************************************
; ** A few C++ objects for C++ fans
; *******************************************************************************

; #if CALL_NOT_IN_CARBON
; #ifdef __cplusplus
#|
}                   
    class OTConfiguration
    {
        public:
                    OTConfigurationRef  Clone()
                                        { return OTCfigCloneConfiguration(this); }
                                                                    OTConfigurationRef  PushChild(const char* path, OSStatus* errPtr)
                                        { return OTCfigPushNewSingleChild(this, path, errPtr); }
                    OTConfigurationRef  PushParent(const char* path, OSStatus* errPtr)
                                        { return OTCfigPushParent(this, path, errPtr); }
                    OTConfigurationRef  PushNthChild(OTItemCount index, const char* path,
                                                     OSStatus* errPtr)
                                        { return OTCfigPushChild(this, index, path, errPtr); }
                    OSStatus            PopChild(OTItemCount index)
                                        { return OTCfigPopChild(this, index); }

                    OTConfigurationRef  GetChild(OTItemCount index = 0)
                                        { return OTCfigGetChild(this, index); }
                    OTConfigurationRef  GetParent()
                                        { return OTCfigGetParent(this); }
            
                    OSStatus            AddChild(OTConfigurationRef child)
                                        { return OTCfigAddChild(this, child); }
                    
                    OTConfigurationRef  NewChild(const char* path, OSStatus* errPtr)
                                        { return OTCfigNewChild(this, path, errPtr); }
        
                    OSStatus            SetPath(const char* path)
                                        { return OTCfigSetPath(this, path); }
            
                    Boolean             HasOptions()
                                        { return OTCfigGetOptionNetbuf(this)->len != 0; }
    };



    enum                                                                
    {                                                                   
        kOTBenignChange = 0, kOTKillsServices = 1, kOTMustReboot = 2,   
        kOTIncompatiblePrefs = 3                                        
    };                                                                  
                                                                        
    enum                                                                
    {                                                                   
        kOTConfiguratorIsMasterBit = 0                                  
    };                                                                  
                                                                        
#ifTARGET_CPU_68K && !defined(__SC__) && !defined(THINK_CPLUS)
    class TOTConfigurator : public SingleObject
#else    class TOTConfigurator
#endif    {
    #ifdefined(__SC__) || defined(THINK_CPLUS) || defined(__MRC__)
        private:
            virtual     void DummyVirtualFunction();
    #endif                
        public:
                void*           operator new(size_t size)
                                { return OTAllocSharedClientMem((OTByteCount)size); }
                void            operator delete(void* mem)
                                { OTFreeSharedClientMem(mem); };
                                
                                _MDECL TOTConfigurator();
            virtual             ~ _MDECL TOTConfigurator();
    
            virtual void        _MDECL HandleSystemEvent(OTEventCode event, OTResult result,
                                                         void* cookie)                      = 0;
            
            virtual OSStatus    _MDECL Configure(OTConfigurationRef)                            = 0;
            virtual OSStatus    _MDECL CreateStream(OTConfigurationRef, OTOpenFlags,
                                                     OTNotifyUPP, void* contextPtr)     = 0;
            virtual Boolean     _MDECL CheckUseCounts()                                     = 0;            
            virtual SInt32*     _MDECL GetUseCountPtr(OTPortRef theRef)                     = 0;            
                                                                                                            
                                                                                                            
            virtual OTResult    _MDECL RemoveInterface(OTPortRef, OTResult why, OTBooleanParam doneDeal) = 0;   
                                                                                                            
            virtual OTResult    _MDECL AddInterface(OTConfigurationRef, void* prefs, OTCommand cmd) = 0;        
                                                                                                            
            virtual OTResult    _MDECL CheckPreferenceChanges(void* contextPtr, OTPortRef,                  
                                                              UInt32 which, void* prefs)    = 0;            
            virtual OTResult    _MDECL ChangePreferences(void* contextPtr, OTPortRef,                       
                                                         UInt32 which, void* prefs)         = 0;            
    };

extern "C" {        #endif
|#
; __cplusplus

; #endif /* CALL_NOT_IN_CARBON */


; #endif  /* !OTKERNEL */

 |#

; #endif  /* CALL_NOT_IN_CARBON */


; #if defined(__MWERKS__) && TARGET_CPU_68K
#| ; #pragma pop
 |#

; #endif

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __OPENTRANSPORTPROTOCOL__ */


(provide-interface "OpenTransportProtocol")