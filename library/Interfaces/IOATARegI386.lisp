(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOATARegI386.h"
; at Sunday July 2,2006 7:28:24 pm.
; 
;  * Copyright (c) 2000-2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOATAREGI386_H
; #define _IOATAREGI386_H

(require-interface "libkern/c++/OSObject")
; 
;  * IOATAReg: ATA register abstract base class.
;  
; #define DefineIOATAReg(w)                                   class IOATAReg##w : public OSObject                         {                                                               OSDeclareAbstractStructors( IOATAReg##w )                                                                           public:                                                         virtual void operator = (UInt##w rhs) = 0;                  virtual operator UInt##w() const = 0;                   }

(def-mactype :IOATARegPtr8 (find-mactype '(:pointer :IOATAReg8)))

(def-mactype :IOATARegPtr16 (find-mactype '(:pointer :IOATAReg16)))

(def-mactype :IOATARegPtr32 (find-mactype '(:pointer :IOATAReg32)))
(defconstant $IOATARegPtr8Cast 0)
; #define IOATARegPtr8Cast(x) (x)
; 
;  * IOATAIOReg: I/O mapped ATA registers.
;  
; #define DefineIOATAIOReg(w)                                 class IOATAIOReg##w : public IOATAReg##w                    {                                                               OSDeclareDefaultStructors( IOATAIOReg##w )                                                                          protected:                                                      UInt16 _address;                                                                                                    public:                                                         static IOATAIOReg##w * withAddress( UInt16 address );                                                                   virtual bool initWithAddress( UInt16 address );             virtual UInt16 getAddress() const;                                                                                      virtual void operator = (UInt##w rhs);                      virtual operator UInt##w() const;                       }

; #endif /* !_IOATAREGI386_H */


(provide-interface "IOATARegI386")