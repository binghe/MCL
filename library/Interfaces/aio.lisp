(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:aio.h"
; at Sunday July 2,2006 7:25:39 pm.
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
;  
;  *	File:	sys/aio.h
;  *	Author:	Umesh Vaishampayan [umeshv@apple.com]
;  *			05-Feb-2003	umeshv	Created.
;  *
;  *	Header file for POSIX Asynchronous IO APIs
;  *
;  
; #ifndef _SYS_AIO_H_
; #define	_SYS_AIO_H_

(require-interface "sys/signal")
(defrecord aiocb
   (aio_fildes :signed-long)
                                                ;  File descriptor 
   (aio_offset :OFF_T)
                                                ;  File offset 
   (aio_buf :pointer)
                                                ;  Location of buffer 
   (aio_nbytes :unsigned-long)
                                                ;  Length of transfer 
   (aio_reqprio :signed-long)
                                                ;  Request priority offset 
   (aio_sigevent :sigevent)
#|
; Warning: type-size: unknown type SIGEVENT
|#
                                                ;  Signal number and value 
   (aio_lio_opcode :signed-long)
                                                ;  Operation to be performed 
)
; 
;  * aio_cancel() return values
;  
; 
;  * none of the requested operations could be canceled since they are
;  * already complete.
;  
(defconstant $AIO_ALLDONE 1)
; #define	AIO_ALLDONE			0x1
;  all requested operations have been canceled 
(defconstant $AIO_CANCELED 2)
; #define	AIO_CANCELED		0x2
; 
;  * some of the requested operations could not be canceled since
;  * they are in progress
;  
(defconstant $AIO_NOTCANCELED 4)
; #define	AIO_NOTCANCELED		0x4
; 
;  * lio_listio operation options
;  
(defconstant $LIO_NOP 0)
; #define	LIO_NOP			0x0 	/* option indicating that no transfer is requested */
(defconstant $LIO_READ 1)
; #define	LIO_READ		0x1		/* option requesting a read */
(defconstant $LIO_WRITE 2)
; #define	LIO_WRITE		0x2		/* option requesting a write */
; 
;  * lio_listio() modes
;  
; 
;  * A lio_listio() synchronization operation indicating
;  * that the calling thread is to continue execution while
;  * the lio_listio() operation is being performed, and no
;  * notification is given when the operation is complete
;  
(defconstant $LIO_NOWAIT 1)
; #define	LIO_NOWAIT		0x1
; 
;  * A lio_listio() synchronization operation indicating
;  * that the calling thread is to suspend until the
;  * lio_listio() operation is complete.
;  
(defconstant $LIO_WAIT 2)
; #define	LIO_WAIT		0x2
; 
;  * Maximum number of operations in single lio_listio call
;  
(defconstant $AIO_LISTIO_MAX 16)
; #define	AIO_LISTIO_MAX		16
; 
;  * A aio_fsync() options
;  * that the calling thread is to continue execution while
;  * the lio_listio() operation is being performed, and no
;  * notification is given when the operation is complete
;  
(defconstant $O_SYNC 0)
; #define	O_SYNC			0x0 	/* queued IO is completed as if by fsync() */

; #if 0 /* O_DSYNC - NOT SUPPORTED */
;  O_DSYNC - NOT SUPPORTED 
#| 
; #define	O_DSYNC			0x1		/* queued async IO is completed as if by fdatasync() */
 |#

; #endif

; #ifndef KERNEL
; 
;  * Prototypes
;  
; 
;  * Attempt to cancel one or more asynchronous I/O requests currently outstanding 
;  * against file descriptor fd. The aiocbp argument points to the asynchronous I/O 
;  * control block for a particular request to be canceled.  If aiocbp is NULL, then 
;  * all outstanding cancelable asynchronous I/O requests against fd shall be canceled.
;  

(deftrap-inline "_aio_cancel" 
   ((fd :signed-long)
    (aiocbp (:pointer :struct))
   )
   :signed-long
() )
; 
;  * Return the error status associated with the aiocb structure referenced by the 
;  * aiocbp argument. The error status for an asynchronous I/O operation is the errno 
;  * value that would be set by the corresponding read(), write(),  or fsync()
;  * operation.  If the operation has not yet completed, then the error status shall 
;  * be equal to [EINPROGRESS].
;  

(deftrap-inline "_aio_error" 
   ((aiocbp (:pointer :AIOCB))
   )
   :signed-long
() )
; 
;  * Asynchronously force all I/O operations associated with the file indicated by 
;  * the file descriptor aio_fildes member of the aiocb structure referenced by the 
;  * aiocbp argument and queued at the time of the call to aio_fsync() to the 
;  * synchronized I/O completion state.  The function call shall return when the
;  * synchronization request has been initiated or queued.  op O_SYNC is the only
;  * supported opertation at this time.
;  * The aiocbp argument refers to an asynchronous I/O control block. The aiocbp 
;  * value may be used as an argument to aio_error() and aio_return() in order to 
;  * determine the error status and return status, respectively, of the asynchronous 
;  * operation while it is proceeding.  When the request is queued, the error status 
;  * for the operation is [EINPROGRESS]. When all data has been successfully 
;  * transferred, the error status shall be reset to reflect the success or failure 
;  * of the operation.
;  

(deftrap-inline "_aio_fsync" 
   ((op :signed-long)
    (aiocbp (:pointer :struct))
   )
   :signed-long
() )
; 
;  * Read aiocbp->aio_nbytes from the file associated with aiocbp->aio_fildes into 
;  * the buffer pointed to by aiocbp->aio_buf.  The function call shall return when 
;  * the read request has been initiated or queued.
;  * The aiocbp value may be used as an argument to aio_error() and aio_return() in 
;  * order to determine the error status and return status, respectively, of the 
;  * asynchronous operation while it is proceeding. If an error condition is 
;  * encountered during queuing, the function call shall return without having 
;  * initiated or queued the request. The requested operation takes place at the 
;  * absolute position in the file as given by aio_offset, as if lseek() were called 
;  * immediately prior to the operation with an offset equal to aio_offset and a 
;  * whence equal to SEEK_SET.  After a successful call to enqueue an asynchronous 
;  * I/O operation, the value of the file offset for the file is unspecified.
;  

(deftrap-inline "_aio_read" 
   ((aiocbp (:pointer :struct))
   )
   :signed-long
() )
; 
;  * Return the return status associated with the aiocb structure referenced by 
;  * the aiocbp argument.  The return status for an asynchronous I/O operation is 
;  * the value that would be returned by the corresponding read(), write(), or 
;  * fsync() function call.  If the error status for the operation is equal to 
;  * [EINPROGRESS], then the return status for the operation is undefined.  The 
;  * aio_return() function may be called exactly once to retrieve the return status 
;  * of a given asynchronous operation; thereafter, if the same aiocb structure 
;  * is used in a call to aio_return() or aio_error(), an error may be returned. 
;  * When the aiocb structure referred to by aiocbp is used to submit another
;  * asynchronous operation, then aio_return() may be successfully used to 
;  * retrieve the return status of that operation.
;  

(deftrap-inline "_aio_return" 
   ((aiocbp (:pointer :struct))
   )
   :signed-long
() )
; 
;  * Suspend the calling thread until at least one of the asynchronous I/O 
;  * operations referenced by the aiocblist argument has completed, until a signal 
;  * interrupts the function, or, if timeout is not NULL, until the time 
;  * interval specified by timeout has passed.  If any of the aiocb structures 
;  * in the aiocblist correspond to completed asynchronous I/O operations (that is, 
;  * the error status for the operation is not equal to [EINPROGRESS]) at the 
;  * time of the call, the function shall return without suspending the calling 
;  * thread.  The aiocblist argument is an array of pointers to asynchronous I/O 
;  * control blocks.  The nent argument indicates the number of elements in the 
;  * array.  Each aiocb structure pointed to has been used in initiating an 
;  * asynchronous I/O request via aio_read(), aio_write(), or lio_listio(). This 
;  * array may contain NULL pointers, which are ignored.
;  

(deftrap-inline "_aio_suspend" 
   ((aiocblist (:pointer :AIOCB))
    (nent :signed-long)
    (timeoutp (:pointer :TIMESPEC))
   )
   :signed-long
() )
; 
;  * Write aiocbp->aio_nbytes to the file associated with aiocbp->aio_fildes from 
;  * the buffer pointed to by aiocbp->aio_buf.  The function shall return when the 
;  * write request has been initiated or, at a minimum, queued.
;  * The aiocbp argument may be used as an argument to aio_error() and aio_return() 
;  * in order to determine the error status and return status, respectively, of the 
;  * asynchronous operation while it is proceeding.
;  

(deftrap-inline "_aio_write" 
   ((aiocbp (:pointer :struct))
   )
   :signed-long
() )
; 
;  * Initiate a list of I/O requests with a single function call.  The mode 
;  * argument takes one of the values LIO_WAIT or LIO_NOWAIT and determines whether 
;  * the function returns when the I/O operations have been completed, or as soon 
;  * as the operations have been queued.  If the mode argument is LIO_WAIT, the 
;  * function shall wait until all I/O is complete and the sig argument shall be 
;  * ignored. 
;  * If the mode argument is LIO_NOWAIT, the function shall return immediately, and 
;  * asynchronous notification shall occur, according to the sig argument, when all 
;  * the I/O operations complete.  If sig is NULL, then no asynchronous notification
;  * shall occur.
;  

(deftrap-inline "_lio_listio" 
   ((mode :signed-long)
    (aiocblist (:pointer :struct))
    (nent :signed-long)
    (sigp (:pointer :struct))
   )
   :signed-long
() )

; #endif /* KERNEL */


; #endif /* _SYS_AIO_H_ */


(provide-interface "aio")