(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:device_tree.h"
; at Sunday July 2,2006 7:27:30 pm.
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
; #ifndef _PEXPERT_DEVICE_TREE_H_
; #define _PEXPERT_DEVICE_TREE_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

#ifdef__cplusplus
extern "C" {
#endif

enum {
	kDTPathNameSeparator	= ''				
};



enum {
	kDTMaxPropertyNameLength=31	
};

typedef char DTPropertyNameBuf[32];



enum {
	kDTMaxEntryNameLength		= 31	
};


typedef char DTEntryNameBuf[32];



typedef struct OpaqueDTEntry* DTEntry;


typedef struct OpaqueDTEntryIterator* DTEntryIterator;


typedef struct OpaqueDTPropertyIterator* DTPropertyIterator;



enum {
		kError = -1,
		kIterationDone = 0,
		kSuccess = 1
};



#define kPropNameLength	32

typedef struct DeviceTreeNodeProperty {
    char		name[kPropNameLength];	    unsigned long	length;							} DeviceTreeNodeProperty;

typedef struct OpaqueDTEntry {
    unsigned long	nProperties;	    unsigned long	nChildren;	} DeviceTreeNode;


#ifndef__MWERKS__




void DTInit(void *base);



extern int DTEntryIsEqual(const DTEntry ref1, const DTEntry ref2);



extern int DTFindEntry(const char *propName, const char *propValue, DTEntry *entryH);


extern int DTLookupEntry(const DTEntry searchPoint, const char *pathName, DTEntry *foundEntry);



extern int DTCreateEntryIterator(const DTEntry startEntry, DTEntryIterator *iterator);


extern int DTDisposeEntryIterator(DTEntryIterator iterator);


extern int DTEnterEntry(DTEntryIterator iterator, DTEntry childEntry);


extern int DTExitEntry(DTEntryIterator iterator, DTEntry *currentPosition);


extern int DTIterateEntries(DTEntryIterator iterator, DTEntry *nextEntry);


extern int DTRestartEntryIteration(DTEntryIterator iterator);



extern int DTGetProperty(const DTEntry entry, const char *propertyName, void **propertyValue, int *propertySize);




extern int DTCreatePropertyIterator(const DTEntry entry,
					DTPropertyIterator *iterator);


extern int DTDisposePropertyIterator(DTPropertyIterator iterator);



extern int DTIterateProperties(DTPropertyIterator iterator,
						char **foundProperty);



extern int DTRestartPropertyIteration(DTPropertyIterator iterator);

#ifdef__cplusplus
}
#endif
#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _PEXPERT_DEVICE_TREE_H_ */


(provide-interface "device_tree")