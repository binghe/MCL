(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vfs_journal.h"
; at Sunday July 2,2006 7:32:11 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
;  * This header contains the structures and function prototypes
;  * for the vfs journaling code.  The data types are not meant
;  * to be modified by user code.  Just use the functions and do
;  * not mess around with the structs.
;  
; #ifndef _SYS_VFS_JOURNAL_H_
; #define _SYS_VFS_JOURNAL_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|

#include <systypes.h>
#include <syslock.h>

typedef struct block_info {
    off_t       bnum;                    size_t      bsize;                   struct buf *bp;
} block_info;

typedef struct block_list_header {
    u_int16_t   max_blocks;              u_int16_t   num_blocks;              int32_t     bytes_used;              int32_t     checksum;                int32_t     pad;                     block_info  binfo[1];            } block_list_header;


struct journal;

typedef struct transaction {
    int                 tbuffer_size;      char               *tbuffer;           block_list_header  *blhdr;             int                 num_blhdrs;        int                 total_bytes;       int                 num_flushed;       int                 num_killed;        off_t               journal_start;     off_t               journal_end;       struct journal     *jnl;               struct transaction *next;          } transaction;



typedef struct journal_header {
    int32_t        magic;
    int32_t        endian;
    volatile off_t start;             volatile off_t end;               off_t          size;              int32_t        blhdr_size;        int32_t        checksum;
    int32_t        jhdr_size;     } journal_header;

#define JOURNAL_HEADER_MAGIC  0x4a4e4c78   #define ENDIAN_MAGIC          0x12345678

#define OLD_JOURNAL_HEADER_MAGIC  0x4a484452   


typedef struct journal {
	struct lock__bsd__	jlock;

    struct vnode       *jdev;                  off_t               jdev_offset;       
    struct vnode       *fsdev;                 
    void              (*flush)(void *arg);     void               *flush_arg;         
    int32_t             flags;
    int32_t             tbuffer_size;      
    char               *header_buf;            journal_header     *jhdr;              
    transaction        *cur_tr;                transaction        *completed_trs;         transaction        *active_tr;             int32_t             nested_count;          void               *owner;             
    transaction        *tr_freeme;         
	volatile off_t      active_start;      	simple_lock_data_t  old_start_lock;    	volatile off_t      old_start[16];     
	int                 last_flush_err;    } journal;


#define JOURNAL_CLOSE_PENDING     0x00010000
#define JOURNAL_INVALID           0x00020000
#define JOURNAL_FLUSHCACHE_ERR    0x00040000   #define JOURNAL_NEED_SWAP         0x00080000   

#define JOURNAL_OPTION_FLAGS_MASK 0x0000ffff




journal *journal_create(struct vnode *jvp,
						off_t         offset,
						off_t         journal_size,
						struct vnode *fsvp,
						size_t        min_fs_block_size,
						int32_t       flags,
						int32_t       tbuffer_size,
						void        (*flush)(void *arg),
						void         *arg);


journal  *journal_open(struct vnode *jvp,
					   off_t         offset,
					   off_t         journal_size,
					   struct vnode *fsvp,
					   size_t        min_fs_block_size,
					   int32_t       flags,
					   int32_t       tbuffer_size,
					   void        (*flush)(void *arg),
					   void         *arg);


void      journal_close(journal *journal);


#define JOURNAL_NO_GROUP_COMMIT   0x00000001
#define JOURNAL_RESET             0x00000002


int   journal_start_transaction(journal *jnl);
int   journal_modify_block_start(journal *jnl, struct buf *bp);
int   journal_modify_block_abort(journal *jnl, struct buf *bp);
int   journal_modify_block_end(journal *jnl, struct buf *bp);
int   journal_kill_block(journal *jnl, struct buf *bp);
int   journal_end_transaction(journal *jnl);

int   journal_active(journal *jnl);
int   journal_flush(journal *jnl);

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !_SYS_VFS_JOURNAL_H_ */


(provide-interface "vfs_journal")