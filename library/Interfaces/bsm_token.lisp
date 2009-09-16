(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:bsm_token.h"
; at Sunday July 2,2006 7:27:11 pm.
; 
;  * Copyright (c) 2003 Apple Computer, Inc. All rights reserved.
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
; #ifndef _BSM_TOKEN_H_
; #define _BSM_TOKEN_H_

(require-interface "sys/vnode")

(require-interface "sys/ipc")

(require-interface "sys/un")

(require-interface "netinet/in_systm")

(require-interface "netinet/in")

(require-interface "netinet/ip")
;  We could determined the header and trailer sizes by
;  * defining appropriate structures. We hold off that approach
;  * till we have a consistant way of using structures for all tokens.
;  * This is not straightforward since these token structures may
;  * contain pointers of whose contents we dont know the size
;  * (e.g text tokens)
;  
(defconstant $HEADER_SIZE 18)
; #define HEADER_SIZE     18
(defconstant $TRAILER_SIZE 7)
; #define TRAILER_SIZE    7
; #define ADD_U_CHAR(loc, val)         do {		*loc = val;                loc += sizeof(u_char);        }while(0)
; #define ADD_U_INT16(loc, val)         do { 		memcpy(loc, (u_char *)&val, sizeof(u_int16_t));                loc += sizeof(u_int16_t);         }while(0)
; #define ADD_U_INT32(loc, val)         do { 		memcpy(loc, (u_char *)&val, sizeof(u_int32_t));                loc += sizeof(u_int32_t);         }while(0)
; #define ADD_U_INT64(loc, val)        do {		memcpy(loc, (u_char *)&val, sizeof(u_int64_t));                loc += sizeof(u_int64_t);         }while(0)
; #define ADD_MEM(loc, data, size)         do {                 memcpy(loc, data, size);                loc += size;        }while(0)
; #define ADD_STRING(loc, data, size) ADD_MEM(loc, data, size)
;  Various token id types 
;  
;  * Values inside the comments are not documented in the BSM pages and
;  * have been picked up from the header files 
;  
; 
;  * Values marked as XXX do not have a value defined in the BSM header files 
;  
; 
;  * Control token types
; 
; #define AUT_OTHER_FILE              ((char)0x11)
; #define AUT_OTHER_FILE32            AUT_OTHER_FILE
; #define AUT_OHEADER                 ((char)0x12)
; 
;  
(defconstant $AUT_INVALID 0)
; #define AUT_INVALID                 0x00
(defconstant $AU_FILE_TOKEN 17)
; #define AU_FILE_TOKEN               0x11
(defconstant $AU_TRAILER_TOKEN 19)
; #define AU_TRAILER_TOKEN            0x13 
(defconstant $AU_HEADER_32_TOKEN 20)
; #define AU_HEADER_32_TOKEN          0x14	
(defconstant $AU_HEADER_EX_32_TOKEN 21)
; #define AU_HEADER_EX_32_TOKEN       0x15
; 
;  * Data token types
; #define AUT_SERVER              ((char)0x25)
; #define AUT_SERVER32            AUT_SERVER
;  
(defconstant $AU_DATA_TOKEN 33)
; #define AU_DATA_TOKEN               0x21
; #define AU_ARB_TOKEN                AU_DATA_TOKEN	
(defconstant $AU_IPC_TOKEN 34)
; #define AU_IPC_TOKEN                0x22
(defconstant $AU_PATH_TOKEN 35)
; #define AU_PATH_TOKEN               0x23
(defconstant $AU_SUBJECT_32_TOKEN 36)
; #define AU_SUBJECT_32_TOKEN         0x24
(defconstant $AU_PROCESS_32_TOKEN 38)
; #define AU_PROCESS_32_TOKEN         0x26
(defconstant $AU_RETURN_32_TOKEN 39)
; #define AU_RETURN_32_TOKEN          0x27
(defconstant $AU_TEXT_TOKEN 40)
; #define AU_TEXT_TOKEN               0x28
(defconstant $AU_OPAQUE_TOKEN 41)
; #define AU_OPAQUE_TOKEN             0x29
(defconstant $AU_IN_ADDR_TOKEN 42)
; #define AU_IN_ADDR_TOKEN            0x2A
(defconstant $AU_IP_TOKEN 43)
; #define AU_IP_TOKEN                 0x2B
(defconstant $AU_IPORT_TOKEN 44)
; #define AU_IPORT_TOKEN              0x2C
(defconstant $AU_ARG32_TOKEN 45)
; #define AU_ARG32_TOKEN              0x2D	
(defconstant $AU_SOCK_TOKEN 46)
; #define AU_SOCK_TOKEN               0x2E
(defconstant $AU_SEQ_TOKEN 47)
; #define AU_SEQ_TOKEN                0x2F
; 
;  * Modifier token types
; 
; #define AUT_ACL                 ((char)0x30)
; #define AUT_LABEL               ((char)0x33)
; #define AUT_GROUPS              ((char)0x34)
; #define AUT_ILABEL              ((char)0x35)
; #define AUT_SLABEL              ((char)0x36)
; #define AUT_CLEAR               ((char)0x37)
; #define AUT_PRIV                ((char)0x38)
; #define AUT_UPRIV               ((char)0x39)
; #define AUT_LIAISON             ((char)0x3A)
;  
;  
(defconstant $AU_ATTR_TOKEN 49)
; #define AU_ATTR_TOKEN               0x31
(defconstant $AU_IPCPERM_TOKEN 50)
; #define AU_IPCPERM_TOKEN            0x32
(defconstant $AU_NEWGROUPS_TOKEN 59)
; #define AU_NEWGROUPS_TOKEN          0x3B
(defconstant $AU_EXEC_ARG_TOKEN 60)
; #define AU_EXEC_ARG_TOKEN           0x3C
(defconstant $AU_EXEC_ENV_TOKEN 61)
; #define AU_EXEC_ENV_TOKEN           0x3D
(defconstant $AU_ATTR32_TOKEN 62)
; #define AU_ATTR32_TOKEN             0x3E
; 
;  * Command token types
;  
(defconstant $AU_CMD_TOKEN 81)
; #define AU_CMD_TOKEN                0x51
(defconstant $AU_EXIT_TOKEN 82)
; #define AU_EXIT_TOKEN               0x52
; 
;  * Miscellaneous token types
; 
; #define AUT_HOST                ((char)0x70)
; 
;  
; 
;  * 64bit token types
; 
; #define AUT_SERVER64            ((char)0x76)
; #define AUT_OTHER_FILE64		((char)0x78)
; 
;  
(defconstant $AU_ARG64_TOKEN 113)
; #define AU_ARG64_TOKEN              0x71
(defconstant $AU_RETURN_64_TOKEN 114)
; #define AU_RETURN_64_TOKEN          0x72
(defconstant $AU_ATTR64_TOKEN 115)
; #define AU_ATTR64_TOKEN             0x73
(defconstant $AU_HEADER_64_TOKEN 116)
; #define AU_HEADER_64_TOKEN          0x74
(defconstant $AU_SUBJECT_64_TOKEN 117)
; #define AU_SUBJECT_64_TOKEN         0x75
(defconstant $AU_PROCESS_64_TOKEN 119)
; #define AU_PROCESS_64_TOKEN         0x77
; 
;  * Extended network address token types
;  
(defconstant $AU_HEADER_EX_64_TOKEN 121)
; #define AU_HEADER_EX_64_TOKEN       0x79
(defconstant $AU_SUBJECT_32_EX_TOKEN 122)
; #define AU_SUBJECT_32_EX_TOKEN      0x7a	
(defconstant $AU_PROCESS_32_EX_TOKEN 123)
; #define AU_PROCESS_32_EX_TOKEN      0x7b
(defconstant $AU_SUBJECT_64_EX_TOKEN 124)
; #define AU_SUBJECT_64_EX_TOKEN      0x7c
(defconstant $AU_PROCESS_64_EX_TOKEN 125)
; #define AU_PROCESS_64_EX_TOKEN      0x7d
(defconstant $AU_IN_ADDR_EX_TOKEN 126)
; #define AU_IN_ADDR_EX_TOKEN	        0x7e
(defconstant $AU_SOCK_EX32_TOKEN 127)
; #define AU_SOCK_EX32_TOKEN          0x7f
; #define AU_SOCK_EX128_TOKEN         AUT_INVALID         /*XXX*/
; #define AU_IP_EX_TOKEN              AUT_INVALID         /*XXX*/
; 
;  * The values for the following token ids is not
;  * defined by BSM
;  
(defconstant $AU_SOCK_INET_32_TOKEN 128)
; #define AU_SOCK_INET_32_TOKEN       0x80         /*XXX*/ 
(defconstant $AU_SOCK_INET_128_TOKEN 129)
; #define AU_SOCK_INET_128_TOKEN      0x81         /*XXX*/
(defconstant $AU_SOCK_UNIX_TOKEN 130)
; #define AU_SOCK_UNIX_TOKEN          0x82         /*XXX*/
;  print values for the arbitrary token 
(defconstant $AUP_BINARY 0)
; #define AUP_BINARY      0
(defconstant $AUP_OCTAL 1)
; #define AUP_OCTAL       1
(defconstant $AUP_DECIMAL 2)
; #define AUP_DECIMAL     2
(defconstant $AUP_HEX 3)
; #define AUP_HEX         3
(defconstant $AUP_STRING 4)
; #define AUP_STRING      4
;  data-types for the arbitrary token 
(defconstant $AUR_BYTE 0)
; #define AUR_BYTE        0
(defconstant $AUR_SHORT 1)
; #define AUR_SHORT       1
(defconstant $AUR_LONG 2)
; #define AUR_LONG        2
;  ... and their sizes 
; #define AUR_BYTE_SIZE       sizeof(u_char)	
; #define AUR_SHORT_SIZE      sizeof(u_int16_t)
; #define AUR_LONG_SIZE       sizeof(u_int32_t)
;  Modifiers for the header token 
(defconstant $PAD_NOTATTR 16384)
; #define PAD_NOTATTR  0x4000   /* nonattributable event */
(defconstant $PAD_FAILURE 32768)
; #define PAD_FAILURE  0x8000   /* fail audit event */
(defconstant $MAX_GROUPS 16)
; #define MAX_GROUPS          16
(defconstant $HEADER_VERSION 1)
; #define HEADER_VERSION      1
(defconstant $TRAILER_PAD_MAGIC 45317)
; #define TRAILER_PAD_MAGIC   0xB105
;  BSM library calls 

(deftrap-inline "_au_open" 
   (
   )
   :signed-long
() )

(deftrap-inline "_au_write" 
   ((d :signed-long)
    (m (:pointer :TOKEN_T))
   )
   :signed-long
() )

(deftrap-inline "_au_close" 
   ((d :signed-long)
    (keep :signed-long)
    (event :SInt16)
   )
   :signed-long
() )

(deftrap-inline "_au_to_file" 
   ((file (:pointer :char))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_header" 
   ((rec_size :signed-long)
    (e_type :UInt16)
    (e_mod :UInt16)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_header32" 
   ((rec_size :signed-long)
    (e_type :UInt16)
    (e_mod :UInt16)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_header64" 
   ((rec_size :signed-long)
    (e_type :UInt16)
    (e_mod :UInt16)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_me" 
   (
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_arg" 
   ((n :character)
    (text (:pointer :char))
    (v :UInt32)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_arg32" 
   ((n :character)
    (text (:pointer :char))
    (v :UInt32)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_arg64" 
   ((n :character)
    (text (:pointer :char))
    (v :u_int64_t)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_attr" 
   ((attr (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_attr32" 
   ((attr (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_attr64" 
   ((attr (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_data" 
   ((unit_print :character)
    (unit_type :character)
    (unit_count :character)
    (p (:pointer :char))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_exit" 
   ((retval :signed-long)
    (err :signed-long)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_groups" 
   ((groups (:pointer :int))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_newgroups" 
   ((n :UInt16)
    (groups (:pointer :gid_t))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_in_addr" 
   ((internet_addr (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_in_addr_ex" 
   ((internet_addr (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_ip" 
   ((ip (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_ipc" 
   ((type :character)
    (id :signed-long)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_ipc_perm" 
   ((perm (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_iport" 
   ((iport :UInt16)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_opaque" 
   ((data (:pointer :char))
    (bytes :UInt16)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_path" 
   ((path (:pointer :char))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_process" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_process32" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_process64" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_process_ex" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_ADDR_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_process32_ex" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_ADDR_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_process64_ex" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_ADDR_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_return" 
   ((status :character)
    (ret :UInt32)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_return32" 
   ((status :character)
    (ret :UInt32)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_return64" 
   ((status :character)
    (ret :u_int64_t)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_seq" 
   ((audit_count :signed-long)
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_socket" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_socket_ex_32" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_socket_ex_128" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_sock_inet" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_sock_inet32" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_sock_inet128" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_sock_unix" 
   ((so (:pointer :struct))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_subject" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_subject32" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_subject64" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_subject_ex" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_ADDR_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_subject32_ex" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_ADDR_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_subject64_ex" 
   ((auid :UInt32)
    (euid :UInt32)
    (egid :UInt32)
    (ruid :UInt32)
    (rgid :UInt32)
    (pid :SInt32)
    (sid :SInt32)
    (tid (:pointer :AU_TID_ADDR_T))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_exec_args" 
   ((ARGH (:pointer :char))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_exec_env" 
   ((ARGH (:pointer :char))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_text" 
   ((text (:pointer :char))
   )
   (:pointer :au_token)
() )

(deftrap-inline "_au_to_trailer" 
   ((rec_size :signed-long)
   )
   (:pointer :au_token)
() )

; #endif /* ! _BSM_TOKEN_H_ */


(provide-interface "bsm_token")