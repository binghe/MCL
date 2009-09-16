(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DirServicesUtils.h"
; at Sunday July 2,2006 7:27:33 pm.
; 
;  * Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; !
;  * @header DirServicesUtils
;  
; #ifndef __DirServicesUtils_h__
(defconstant $__DirServicesUtils_h__ 1)
; #define	__DirServicesUtils_h__	1
;  App

(require-interface "stdarg")

(require-interface "DirectoryService/DirServicesTypes")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; -----------------------------------------------
; !
;  * @function dsDataBufferAllocate
;  

(deftrap-inline "_dsDataBufferAllocate" 
   ((inDirReference :UInt32)
    (inBufferSize :UInt32)
   )
   (:pointer :tDataBuffer)
() )
; !
;  * @function dsDataBufferDeAllocate
;  

(deftrap-inline "_dsDataBufferDeAllocate" 
   ((inDirReference :UInt32)
    (inDataBufferPtr (:pointer :tDataBuffer))
   )
   :sint32
() )
; -----------------------------------------------
; -----------------------------------------------
; -----------------------------------------------
;  Data Node Routines
; -----------------------------------------------
; !
;  * @function dsDataNodeAllocateBlock
;  

(deftrap-inline "_dsDataNodeAllocateBlock" 
   ((inDirReference :UInt32)
    (inDataNodeSize :UInt32)
    (inDataNodeLength :UInt32)
    (inDataNodeBuffer (:pointer :void))
   )
   (:pointer :tDataBuffer)
() )
; !
;  * @function dsDataNodeAllocateString
;  

(deftrap-inline "_dsDataNodeAllocateString" 
   ((inDirReference :UInt32)
    (inCString (:pointer :char))
   )
   (:pointer :tDataBuffer)
() )
; !
;  * @function dsDataNodeDeAllocate
;  

(deftrap-inline "_dsDataNodeDeAllocate" 
   ((inDirReference :UInt32)
    (inDataNodePtr (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsDataNodeSetLength
;  

(deftrap-inline "_dsDataNodeSetLength" 
   ((inDataNodePtr (:pointer :tDataBuffer))
    (inDataNodeLength :UInt32)
   )
   :sint32
() )
; !
;  * @function dsDataNodeGetLength
;  

(deftrap-inline "_dsDataNodeGetLength" 
   ((inDataNodePtr (:pointer :tDataBuffer))
   )
   :UInt32
() )
; !
;  * @function dsDataNodeGetSize
;  

(deftrap-inline "_dsDataNodeGetSize" 
   ((inDataNodePtr (:pointer :tDataBuffer))
   )
   :UInt32
() )
; -----------------------------------------------
; -----------------------------------------------
; -----------------------------------------------
;  Data list Routines
; -----------------------------------------------
; !
;  * @function dsDataListAllocate
;  

(deftrap-inline "_dsDataListAllocate" 
   ((inDirReference :UInt32)
   )
   (:pointer :tDataList)
() )
; !
;  * @function dsDataListDeAllocate
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsDataListDeAllocate() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using it and instead use --> dsDataListDeallocate()   ( <-lower case 'a' ).
;  

(deftrap-inline "_dsDataListDeAllocate" 
   ((inDirReference :UInt32)
    (inDataList (:pointer :tDataList))
    (inDeAllocateNodesFlag :dsbool)
   )
   :sint32
() )
; !
;  * @function dsDataListDeallocate
;  

(deftrap-inline "_dsDataListDeallocate" 
   ((inDirReference :UInt32)
    (inDataList (:pointer :tDataList))
   )
   :sint32
() )
; -----------------------------------------------
; !
;  * @function dsGetPathFromList
;  

(deftrap-inline "_dsGetPathFromList" 
   ((inDirReference :UInt32)
    (inDataList (:pointer :tDataList))
    (inDelimiter (:pointer :char))
   )
   (:pointer :character)
() )
; !
;  * @function dsBuildFromPath
;  

(deftrap-inline "_dsBuildFromPath" 
   ((inDirReference :UInt32)
    (inPathCString (:pointer :char))
    (inPathSeparatorCString (:pointer :char))
   )
   (:pointer :tDataList)
() )
; !
;  * @function dsBuildListFromPathAlloc
;  

(deftrap-inline "_dsBuildListFromPathAlloc" 
   ((inDirReference :UInt32)
    (inDataList (:pointer :tDataList))
    (inPathCString (:pointer :char))
    (inPathSeparatorCString (:pointer :char))
   )
   :sint32
() )
; !
;  * @function dsBuildListFromNodes
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsBuildListFromNodes() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using it and instead use --> dsBuildListFromNodesAlloc().
;  

(deftrap-inline "_dsBuildListFromNodes" 
   ((inDirReferences :UInt32)
    (in1stDataNodePtr (:pointer :tDataBuffer))
#| |...|  ;; What should this do?
    |#
   )
   (:pointer :tDataList)
() )
; !
;  * @function dsBuildListFromNodesAlloc
;  

(deftrap-inline "_dsBuildListFromNodesAlloc" 
   ((inDirReferences :UInt32)
    (inDataList (:pointer :tDataList))
    (in1stDataNodePtr (:pointer :tDataBuffer))
#| |...|  ;; What should this do?
    |#
   )
   :sint32
() )
; !
;  * @function dsBuildListFromStrings
;  

(deftrap-inline "_dsBuildListFromStrings" 
   ((inDirReference :UInt32)
    (in1stCString (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   (:pointer :tDataList)
() )
; !
;  * @function dsBuildListFromStringsAlloc
;  

(deftrap-inline "_dsBuildListFromStringsAlloc" 
   ((inDirReferences :UInt32)
    (inDataList (:pointer :tDataList))
    (in1stCString (:pointer :char))
#| |...|  ;; What should this do?
    |#
   )
   :sint32
() )
; !
;  * @function dsBuildListFromStringsAllocV
;  

(deftrap-inline "_dsBuildListFromStringsAllocV" 
   ((inDirRef :UInt32)
    (inDataList (:pointer :tDataList))
    (in1stCString (:pointer :char))
    (args (:pointer :void))
   )
   :sint32
() )
; !
;  * @function dsAppendStringToList
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsAppendStringToList() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using it and instead use --> dsAppendStringToListAlloc().
;  

(deftrap-inline "_dsAppendStringToList" 
   ((inDataList (:pointer :tDataList))
    (inCString (:pointer :char))
   )
   :sint32
() )
; !
;  * @function dsAppendStringToListAlloc
;  

(deftrap-inline "_dsAppendStringToListAlloc" 
   ((inDirReferences :UInt32)
    (inDataList (:pointer :tDataList))
    (inCString (:pointer :char))
   )
   :sint32
() )
; -----------------------------------------------
; !
;  * @function dsDataListGetNodeCount
;  

(deftrap-inline "_dsDataListGetNodeCount" 
   ((inDataList (:pointer :tDataList))
   )
   :UInt32
() )
; !
;  * @function dsGetDataLength
;  

(deftrap-inline "_dsGetDataLength" 
   ((inDataList (:pointer :tDataList))
   )
   :UInt32
() )
; !
;  * @function dsDataListInsertNode
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsDataListInsertNode() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using it and instead use --> dsDataListInsertAfter().
;  

(deftrap-inline "_dsDataListInsertNode" 
   ((inDataList (:pointer :tDataList))
    (inAfterDataNode (:pointer :tDataBuffer))
    (inInsertDataNode (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsDataListInsertAfter
;  * @param inNodeIndex One-based index of the existing node to insert the new node after.
;  * 		If inNodeIndex is 0, then it is inserted at the head of the list.
;  

(deftrap-inline "_dsDataListInsertAfter" 
   ((inDirReferences :UInt32)
    (inDataList (:pointer :tDataList))
    (inInsertDataNode (:pointer :tDataBuffer))
    (inNodeIndex :UInt32)
   )
   :sint32
() )
; !
;  * @function dsDataListMergeList
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsDataListMergeList() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using it and instead use --> dsDataListMergeListAfter().
;  

(deftrap-inline "_dsDataListMergeList" 
   ((inDataList (:pointer :tDataList))
    (inAfterDataNode (:pointer :tDataBuffer))
    (inMergeDataList (:pointer :tDataList))
   )
   :sint32
() )
; !
;  * @function dsDataListMergeListAfter
;  

(deftrap-inline "_dsDataListMergeListAfter" 
   ((inTargetList (:pointer :tDataList))
    (inSourceList (:pointer :tDataList))
    (inNodeIndex :UInt32)
   )
   :sint32
() )
; !
;  * @function dsDataListCopyList
;  

(deftrap-inline "_dsDataListCopyList" 
   ((inDirReference :UInt32)
    (inDataListSource (:pointer :tDataList))
   )
   (:pointer :tDataList)
() )
; !
;  * @function dsDataListRemoveNodes
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsDataListRemoveNodes() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using them and instead use --> dsDataListDeleteThisNode()
;  

(deftrap-inline "_dsDataListRemoveNodes" 
   ((inDataList (:pointer :tDataList))
    (in1stDataNode (:pointer :tDataBuffer))
    (inDeleteCount :UInt32)
   )
   :sint32
() )
; !
;  * @function dsDataListRemoveThisNode
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsDataListRemoveThisNode() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using them and instead use --> dsDataListDeleteThisNode()
;  

(deftrap-inline "_dsDataListRemoveThisNode" 
   ((inDataList (:pointer :tDataList))
    (inNodeIndex :UInt32)
    (inDeleteCount :UInt32)
   )
   :sint32
() )
; !
;  * @function dsDataListDeleteThisNode
;  

(deftrap-inline "_dsDataListDeleteThisNode" 
   ((inDirReference :UInt32)
    (inDataList (:pointer :tDataList))
    (inNodeIndex :UInt32)
   )
   :sint32
() )
; !
;  * @function dsDataListGetNode
;  * @discussion Please Note: ******** API Change Soon ********
;  * 		dsDataListGetNode() will be soon be obsoleted and no longer supported.
;  * 		Please discontinue using it and instead use --> dsDataListGetNodeAlloc().
;  

(deftrap-inline "_dsDataListGetNode" 
   ((inDataListPtr (:pointer :tDataList))
    (inNodeIndex :UInt32)
    (outDataNode (:pointer :tDataNodePtr))
   )
   :sint32
() )
; !
;  * @function dsDataListGetNodeAlloc
;  

(deftrap-inline "_dsDataListGetNodeAlloc" 
   ((inDirReference :UInt32)
    (inDataListPtr (:pointer :tDataList))
    (inNodeIndex :UInt32)
    (outDataNode (:pointer :tDataNodePtr))
   )
   :sint32
() )
; -----------------------------------------------
; !
;  * @function dsAllocAttributeValueEntry
;  

(deftrap-inline "_dsAllocAttributeValueEntry" 
   ((inDirRef :UInt32)
    (inAttrValueID :UInt32)
    (inAttrValueData :pointer)
    (inAttrValueDataLen :UInt32)
   )
   (:pointer :tAttributeValueEntry)
() )
; !
;  * @function dsDeallocAttributeValueEntry
;  

(deftrap-inline "_dsDeallocAttributeValueEntry" 
   ((inDirRef :UInt32)
    (inAttrValueEntry (:pointer :tAttributeValueEntry))
   )
   :sint32
() )
; !
;  * @function dsDeallocAttributeEntry
;  

(deftrap-inline "_dsDeallocAttributeEntry" 
   ((inDirRef :UInt32)
    (inAttrEntry (:pointer :tAttributeEntry))
   )
   :sint32
() )
; !
;  * @function dsDeallocRecordEntry
;  

(deftrap-inline "_dsDeallocRecordEntry" 
   ((inDirRef :UInt32)
    (inRecEntry (:pointer :tRecordEntry))
   )
   :sint32
() )
; -----------------------------------------------
; !
;  * @function dsGetRecordNameFromEntry
;  * @param outRecName Used to return the record name to the client. Client is responsible for freeing
;  * 		the resulting string.
;  

(deftrap-inline "_dsGetRecordNameFromEntry" 
   ((inRecEntryPtr (:pointer :tRecordEntry))
    (outRecName (:pointer :char))
   )
   :sint32
() )
; !
;  * @function dsGetRecordTypeFromEntry
;  * @param outRecType Used to return the record name to the client. Client is responsible for freeing
;  * 		the resulting string.
;  

(deftrap-inline "_dsGetRecordTypeFromEntry" 
   ((inRecEntryPtr (:pointer :tRecordEntry))
    (outRecType (:pointer :char))
   )
   :sint32
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "DirServicesUtils")