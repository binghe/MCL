(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DirServices.h"
; at Sunday July 2,2006 7:27:32 pm.
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
;  * @header DirServices
;  * APIs.
;  
; !
;  * @header DirectoryServices
;  * Directory Services introduction text.
;  
; #ifndef __DirServices_h__
; #define __DirServices_h__

(require-interface "DirectoryService/DirServicesTypes")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; -----------------------------------------------
;  Directory Services Calls
; #pragma mark Calls
; !
;  * @function dsOpenDirService
;  * @discussion Opens Directory Services API reference. Must be called before any other
;  * 		Directory Services API calls because this reference is needed for any other call.
;  * @param outDirReference reference to use in subsequent Directory Services API calls
;  

(deftrap-inline "_dsOpenDirService" 
   ((outDirReference (:pointer :TDIRREFERENCE))
   )
   :sint32
() )
; !
;  * @function dsOpenDirServiceProxy
;  * @discussion Opens Directory Services API reference via TCP. Must be called before any other
;  * 		Directory Services API calls because this reference is needed for any other call.
;  * @param outDirRef reference to use in subsequent Directory Services API calls
;  * @param inIPAddress either the domain or IP (dot) address of the remote DirectoryService machine
;  * @param inIPPort either the client defined port or "0" which then allows use of the default
;  
(defconstant $DSPROXY 1)
; #define DSPROXY 1

(deftrap-inline "_dsOpenDirServiceProxy" 
   ((outDirRef (:pointer :TDIRREFERENCE))
    (inIPAddress (:pointer :char))
    (inIPPort :UInt32)
    (inAuthMethod (:pointer :tDataBuffer))
    (inAuthStepData (:pointer :tDataBuffer))
    (outAuthStepDataResponse (:pointer :tDataBuffer))
    (ioContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsCloseDirService
;  * @param inDirReference Directory Services API reference to be closed
;  

(deftrap-inline "_dsCloseDirService" 
   ((inDirReference :UInt32)
   )
   :sint32
() )
; !
;  * @function dsAddChildPIDToReference
;  

(deftrap-inline "_dsAddChildPIDToReference" 
   ((inDirRef :UInt32)
    (inValidChildPID :signed-long)
    (inValidAPIReferenceToGrantChild :UInt32)
   )
   :sint32
() )
; !
;  * @function dsIsDirServiceRunning
;  

(deftrap-inline "_dsIsDirServiceRunning" 
   ((ARG2 (:nil :nil))
   )
   :sint32
() )
; -------------------------------------------------------------------------
;  register custom allocate/deallocate routines MacOS Classic Applications Only

(deftrap-inline "_dsRegisterCustomMemory" 
   ((inDirReference :UInt32)
    (inCustomAllocate :pointer)
    (inCustomDeAllocate :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )

(deftrap-inline "_dsGetCustomAllocate" 
   ((inDirReference :UInt32)
    (outCustomAllocate (:pointer :FPCUSTOMALLOCATE))
    (outCustomDeAllocate (:pointer :FPCUSTOMDEALLOCATE))
    (outClientData (:pointer :TCLIENTDATA))
   )
   :sint32
() )

(deftrap-inline "_dsUnRegisterCustomMemory" 
   ((inDirReference :UInt32)
    (inCustomAllocate :pointer)
    (inCustomDeAllocate :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )
; ------------------------------------------------------------
;  register custom thread routines MacOS Classic Applications Only

(deftrap-inline "_dsRegisterCustomThread" 
   ((inDirReference :UInt32)
    (inCustomBlock :pointer)
    (inCustomUnBlock :pointer)
    (inCustomYield :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )

(deftrap-inline "_dsGetCustomThread" 
   ((inDirReference :UInt32)
    (outCustomBlock (:pointer :FPCUSTOMTHREADBLOCK))
    (outCustomUnBlock (:pointer :FPCUSTOMTHREADUNBLOCK))
    (outCustomYield (:pointer :FPCUSTOMTHREADYIELD))
    (outClientData (:pointer :TCLIENTDATA))
   )
   :sint32
() )

(deftrap-inline "_dsUnRegisterCustomThread" 
   ((inDirReference :UInt32)
    (inCustomBlock :pointer)
    (inCustomUnBlock :pointer)
    (inCustomYield :pointer)
    (inClientData (:pointer :void))
   )
   :sint32
() )
; -----------------------------------------------
; !
;  * @function dsGetDirNodeCount
;  * @discussion Get the count of the total number of directory nodes in the system.
;  * @param inDirReference Directory reference established with dsOpenDirService.
;  * @param outDirectoryNodeCount Contains count of the total number of directory nodes.
;  

(deftrap-inline "_dsGetDirNodeCount" 
   ((inDirReference :UInt32)
    (outDirectoryNodeCount (:pointer :UInt32))
   )
   :sint32
() )
; !
;  * @function dsGetDirNodeCountWithInfo
;  * @discussion Get the count of the total number of DirNodes in the Directory System with change information
;  * 		ie. a token gets returned with a different value if there has been a change in the registered nodes
;  * 		so the client can retain the first token and compare with the second to see if any registered nodes have changed
;  * @param inDirReference Directory Reference Established with dsOpenDirService
;  * @param outDirectoryNodeCount Contains count of the total number of nodes in the directory
;  * @param outDirectoryNodeChangeToken Contains token that changes upon any registered node changes.
;  

(deftrap-inline "_dsGetDirNodeCountWithInfo" 
   ((inDirReference :UInt32)
    (outDirectoryNodeCount (:pointer :UInt32))
    (outDirectoryNodeChangeToken (:pointer :UInt32))
   )
   :sint32
() )
; !
;  * @function dsGetDirNodeList
;  * @discussion Fill a buffer with the names of all the directory nodes.
;  * @param inDirReference Directory reference established with dsOpenDirService
;  * @param inOutDataBufferPtr Contains a client allocated buffer to store results..data is extracted with dsGetDirNodeName
;  * @param outDirNodeCount Number of directory node names contained in dataBuffer
;  * @param inOutContinueData Pointer to a tContextData variable, if (*inOutCountinueData == NULL) there is no more data
;  * 		otherwise can be used in a 2nd call to the same routine to get the remainder of the directory node list.
;  * 		if client does not use  if (*inOutCountinueData != NULL) and the client doesn't wish to continue
;  * 		then dsReleaseContinueData should be called to clean up..
;  

(deftrap-inline "_dsGetDirNodeList" 
   ((inDirReference :UInt32)
    (inOutDataBufferPtr (:pointer :tDataBuffer))
    (outDirNodeCount (:pointer :UInt32))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsReleaseContinueData
;  * @discussion If continue data from dsGetDirNodeList or any other Directory Services
;  * 		function is non-NULL, then call this routine to release the continue data
;  * 		if the client chooses not to continue the directory node listing or other operation.
;  * @param inDirReference Directory reference established with dsOpenDirService
;  * @param inContinueData Pointer to a tContextData variable which will be cleaned up by Directory Services
;  

(deftrap-inline "_dsReleaseContinueData" 
   ((inDirReference :UInt32)
    (inContinueData (:pointer :void))
   )
   :sint32
() )
; !
;  * @function dsFindDirNodes
;  * @discussion Find directory nodes matching a certain pattern.
;  * @param inDirReference Directory reference established with dsOpenDirService
;  * @param inOutDataBufferPtr Contains a client allocated buffer to store results. Data is extracted with dsGetDirNodeName.
;  * @param inNodeNamePattern A tDataList pointer, which contains the pattern to be matched.
;  * @param inPatternMatchType What type of match to perform on inNodeNamePattern.
;  * 		Valid values for this are: 	eDSExact, eDSStartsWith, eDSEndsWith, eDSContains.
;  * 		Other match types will return an error.
;  * @param outDirNodeCount Number of items in the client buffer.
;  * @param inOutContinueData Pointer to a tContextData variable, if (*inOutCountinueData == NULL) there is no more data
;  * 		otherwise can be used in a 2nd call to the same routine to get the remainder of the directory node list.
;  * 		if client does not use  if (*inOutCountinueData != NULL) and the client doesn't wish to continue
;  * 		then dsReleaseContinueData should be called to clean up.
;  

(deftrap-inline "_dsFindDirNodes" 
   ((inDirReference :UInt32)
    (inOutDataBufferPtr (:pointer :tDataBuffer))
    (inNodeNamePattern (:pointer :tDataList))
    (inPatternMatchType :sint32)
    (outDirNodeCount (:pointer :UInt32))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsGetDirNodeName
;  * @discussion Parse the return Buffer from dsFindDirNodes or dsGetDirNodeList
;  * 		and build a tDataList representing the directory node's name.
;  * @param inDirReference Directory reference established with dsOpenDirService
;  * @param inOutDataBuffer A buffer containing all the directory node names from
;  * 		dsGetDirNodeList or dsFindDirNodes
;  * @param inDirNodeIndex One-based index of directory node name to fetch/build.
;  * @param inOutDataList Address of tDataListPtr that is built by this call.
;  * 		The client is responsible for disposing of it with dsDataListDeAllocate.
;  

(deftrap-inline "_dsGetDirNodeName" 
   ((inDirReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inDirNodeIndex :UInt32)
    (inOutDataList (:pointer :TDATALISTPTR))
   )
   :sint32
() )
; !
;  * @function dsOpenDirNode
;  * @discussion Establish a session for a particular directory node.
;  * @param inDirReference Directory reference established with dsOpenDirService.
;  * @param inDirNodeName Directory node name to open. Should be split into path
;  * 		components, for example as a result of dsBuildListFromPath
;  * @param outDirNodeReference Valid call with noErr, results in a directory node session reference.
;  * 		This reference represents the client's session context for the contents of the given directory node.
;  

(deftrap-inline "_dsOpenDirNode" 
   ((inDirReference :UInt32)
    (inDirNodeName (:pointer :tDataList))
    (outDirNodeReference (:pointer :TDIRNODEREFERENCE))
   )
   :sint32
() )
; !
;  * @function dsCloseDirNode
;  * @discussion Tear down a directory node session.
;  * @param inDirNodeReference Directory node reference obtained from dsOpenDirNode
;  

(deftrap-inline "_dsCloseDirNode" 
   ((inDirNodeReference :UInt32)
   )
   :sint32
() )
; !
;  * @function dsGetDirNodeInfo
;  * @discussion Get information about a directory node: authentication methods, unique ID's,
;  * 		ICON information, access controls, record types contained in this node, plug-in information,
;  * 		directory node/type/signature.
;  * @param inDirNodeReference Directory node reference obtained from dsOpenDirNode.
;  * @param inDirNodeInfoTypeList tDataList containing the types of requested data.
;  * @param inOutDataBuffer Client-allocated buffer to hold the data results.
;  * @param inAttributeInfoOnly This flag is set to true if the client wants attribute info only,
;  * 		not attribute values.
;  * @param outAttributeInfoCount A count of the number of data types present in the DataBuffer.
;  * @param inOutContinueData Pointer to a tContextData variable. If (*inOutCountinueData == NULL)
;  * 		there is no more data. Otherwise can be used in the next call to the same routine to get
;  * 		the remainder of the information. If client does not use non-NULL continue data,
;  * 		then dsReleaseContinueData should be called to clean up.
;  

(deftrap-inline "_dsGetDirNodeInfo" 
   ((inDirNodeReference :UInt32)
    (inDirNodeInfoTypeList (:pointer :tDataList))
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inAttributeInfoOnly :dsbool)
    (outAttributeInfoCount (:pointer :UInt32))
    (outAttributeListRef (:pointer :TATTRIBUTELISTREF))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsGetRecordList
;  * @discussion Get a list of records, optionally: by name, by type, with or without attribute info,
;  * 		with or without attribute value data.
;  * @param inDirNodeReference Directory node reference obtained from dsOpenDirNode.
;  * @param inOutDataBuffer A client-allocated buffer to hold the data results.
;  * @param inRecordNameList A tDataList of Record names to be matched.
;  * @param inPatternMatchType How is the pattern matched for the inRecordNameList.
;  * @param inRecordTypeList What record types do we want returned?
;  * @param inAttributeTypeList What type of attributes do we want for each record.
;  * @param inAttributeInfoOnly Do we want attribute information only, or do we also want attribute values.
;  * @param inOutRecordEntryCount How many record entries are there in the client buffer.
;  * 		However, also a limit of the maximum records returned as provided by the client.
;  * 		If zero or less, then assuming no limit on number of records to be returned.
;  * @param inOutContinueData Pointer to a tContextData variable. If (*inOutCountinueData == NULL)
;  * 		there is no more data. Otherwise can be used in the next call to the same routine to get
;  * 		the remainder of the information. If client does not use and continue data is non-NULL
;  * 		then dsReleaseContinueData should be called to clean up.
;  

(deftrap-inline "_dsGetRecordList" 
   ((inDirNodeReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inRecordNameList (:pointer :tDataList))
    (inPatternMatchType :sint32)
    (inRecordTypeList (:pointer :tDataList))
    (inAttributeTypeList (:pointer :tDataList))
    (inAttributeInfoOnly :dsbool)
    (inOutRecordEntryCount (:pointer :UInt32))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsGetRecordEntry
;  * @discussion Get a record entry from a buffer.
;  * @param inDirNodeReference Directory node reference obtained from dsOpenDirNode.
;  * @param inOutDataBuffer A client-allocated buffer to hold the data results.
;  

(deftrap-inline "_dsGetRecordEntry" 
   ((inDirNodeReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inRecordEntryIndex :UInt32)
    (outAttributeListRef (:pointer :TATTRIBUTELISTREF))
    (outRecordEntryPtr (:pointer :TRECORDENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsGetAttributeEntry
;  * @discussion Get an attribute entry from a buffer.
;  

(deftrap-inline "_dsGetAttributeEntry" 
   ((inDirNodeReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inAttributeListRef :UInt32)
    (inAttributeInfoIndex :UInt32)
    (outAttributeValueListRef (:pointer :TATTRIBUTEVALUELISTREF))
    (outAttributeInfoPtr (:pointer :TATTRIBUTEENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsGetAttributeValue
;  * @discussion Get an attribute value from a buffer.
;  

(deftrap-inline "_dsGetAttributeValue" 
   ((inDirNodeReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inAttributeValueIndex :UInt32)
    (inAttributeValueListRef :UInt32)
    (outAttributeValue (:pointer :TATTRIBUTEVALUEENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsCloseAttributeList
;  

(deftrap-inline "_dsCloseAttributeList" 
   ((inAttributeListRef :UInt32)
   )
   :sint32
() )
; !
;  * @function dsCloseAttributeValueList
;  

(deftrap-inline "_dsCloseAttributeValueList" 
   ((inAttributeValueListRef :UInt32)
   )
   :sint32
() )
; !
;  * @function dsOpenRecord
;  

(deftrap-inline "_dsOpenRecord" 
   ((inDirNodeReference :UInt32)
    (inRecordType (:pointer :tDataBuffer))
    (inRecordName (:pointer :tDataBuffer))
    (outRecordReference (:pointer :TRECORDREFERENCE))
   )
   :sint32
() )
; !
;  * @function dsGetRecordReferenceInfo
;  

(deftrap-inline "_dsGetRecordReferenceInfo" 
   ((inRecordReference :UInt32)
    (outRecordInfo (:pointer :TRECORDENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsGetRecordAttributeInfo
;  

(deftrap-inline "_dsGetRecordAttributeInfo" 
   ((inRecordReference :UInt32)
    (inAttributeType (:pointer :tDataBuffer))
    (outAttributeInfoPtr (:pointer :TATTRIBUTEENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsGetRecordAttributeValueByID
;  

(deftrap-inline "_dsGetRecordAttributeValueByID" 
   ((inRecordReference :UInt32)
    (inAttributeType (:pointer :tDataBuffer))
    (inValueID :UInt32)
    (outEntryPtr (:pointer :TATTRIBUTEVALUEENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsGetRecordAttributeValueByIndex
;  

(deftrap-inline "_dsGetRecordAttributeValueByIndex" 
   ((inRecordReference :UInt32)
    (inAttributeType (:pointer :tDataBuffer))
    (inValueIndex :UInt32)
    (outEntryPtr (:pointer :TATTRIBUTEVALUEENTRYPTR))
   )
   :sint32
() )
; !
;  * @function dsFlushRecord
;  

(deftrap-inline "_dsFlushRecord" 
   ((inRecordReference :UInt32)
   )
   :sint32
() )
; !
;  * @function dsCloseRecord
;  

(deftrap-inline "_dsCloseRecord" 
   ((inRecordReference :UInt32)
   )
   :sint32
() )
; !
;  * @function dsSetRecordName
;  

(deftrap-inline "_dsSetRecordName" 
   ((inRecordReference :UInt32)
    (inNewRecordName (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsSetRecordType
;  

(deftrap-inline "_dsSetRecordType" 
   ((inRecordReference :UInt32)
    (inNewRecordType (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsDeleteRecord
;  

(deftrap-inline "_dsDeleteRecord" 
   ((inRecordReference :UInt32)
   )
   :sint32
() )
; !
;  * @function dsCreateRecord
;  

(deftrap-inline "_dsCreateRecord" 
   ((inDirNodeReference :UInt32)
    (inRecordType (:pointer :tDataBuffer))
    (inRecordName (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsCreateRecordAndOpen
;  

(deftrap-inline "_dsCreateRecordAndOpen" 
   ((inDirNodeReference :UInt32)
    (inRecordType (:pointer :tDataBuffer))
    (inRecordName (:pointer :tDataBuffer))
    (outRecordReference (:pointer :TRECORDREFERENCE))
   )
   :sint32
() )
; !
;  * @function dsAddAttribute
;  * @discussion Add an attribute type to a record.
;  

(deftrap-inline "_dsAddAttribute" 
   ((inRecordReference :UInt32)
    (inNewAttribute (:pointer :tDataBuffer))
    (inNewAttributeAccess (:pointer :tAccessControlEntry))
    (inFirstAttributeValue (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsRemoveAttribute
;  

(deftrap-inline "_dsRemoveAttribute" 
   ((inRecordReference :UInt32)
    (inAttribute (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsAddAttributeValue
;  * @discussion Add data to a record.
;  

(deftrap-inline "_dsAddAttributeValue" 
   ((inRecordReference :UInt32)
    (inAttributeType (:pointer :tDataBuffer))
    (inAttributeValue (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsRemoveAttributeValue
;  

(deftrap-inline "_dsRemoveAttributeValue" 
   ((inRecordReference :UInt32)
    (inAttributeType (:pointer :tDataBuffer))
    (inAttributeValueID :UInt32)
   )
   :sint32
() )
; !
;  * @function dsSetAttributeValue
;  

(deftrap-inline "_dsSetAttributeValue" 
   ((inRecordReference :UInt32)
    (inAttributeType (:pointer :tDataBuffer))
    (inAttributeValuePtr (:pointer :tAttributeValueEntry))
   )
   :sint32
() )
; !
;  * @function dsDoDirNodeAuth
;  * @discussion
;  *		Do an authentication session with the given authentication type.
;  *		When a authentication is successful the error code 'eDSNoErr' is returned
;  * 		and the outAuthStepDataResponse parameter will contain a correctly formed
;  * 		kDS1AttrAuthCredential value.  This AuthCredential can be used for future
;  * 		authentications for this and other directory nodes in the directory system.
;  * 		Not all directory nodes will support authenticating in this manner, but most
;  * 		should.  In addition the current kDS1AttrAuthCredential value can always be
;  * 		obtained via dsGetDirNodeInfo call with kDS1AttrAuthCredential as one of the
;  * 		requested attributes.  Directory Nodes that support using a kDS1AttrAuthCredential
;  * 		will list DSAuthCredential as a support authentication method.  Support
;  * 		authentication methods can be determined by calling dsGetDirNodeInfo and requesting
;  * 		the kDSNAttrAuthMethod attribute for that directory node.
;  * 		NOTE: it is important to note that while some Directory Nodes may support
;  * 		the attempt of using a kDS1AttrAuthCredential to authenticate, when the Directory
;  * 		Node plug-in decodes the Credential the authentication attempt may still fail
;  * 		for plug-in specific reasons (the plug-in may find the level of original authentication
;  * 		insufficient for it's requirements or configuration, or the credential may have expired
;  * 		and is no longer valid).  In addition when using a kDS1AttrAuthCredential to authentication
;  * 		to a different directory node than the original kDS1AttrAuthCredential was generated, the
;  * 		level of access granted by the directory node plug-in may not match the level in the
;  * 		original directory node.  Access granted to the contents of a directory node is entirely
;  * 		at the descretion of the directory node plug-in and the directory system it represents.
;  * @param inDirNodeAuthOnlyFlag Indicates if the client wishes to use
;  * 		the results of this authentication process as their identity for this directory session
;  * 		(inDirNodeReference) for directory node access authorization.
;  * 		If the flag value is "false", then at the completion of the auth process both the
;  * 		Directory Services API and the Plug-in should use this "identity" to grant
;  * 		or deny access for all future directory service calls.
;  * 		If the flag value is "true", then at the completion of of the auth process no identity
;  * 		information will be used by the directory services or Plug-in for authorization purposes.
;  * 		A file server just wishing to authenticate a user, but not change how/who it is accessing
;  * 		the directory as would set this parameter to "true".
;  

(deftrap-inline "_dsDoDirNodeAuth" 
   ((inDirNodeReference :UInt32)
    (inDirNodeAuthName (:pointer :tDataBuffer))
    (inDirNodeAuthOnlyFlag :dsbool)
    (inAuthStepData (:pointer :tDataBuffer))
    (outAuthStepDataResponse (:pointer :tDataBuffer))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsDoDirNodeAuthOnRecordType
;  * @discussion
;  *		Do an authentication session with the given authentication type on the specified record type. 
;  *		When a authentication is successful the error code 'eDSNoErr' is returned
;  * 		and the outAuthStepDataResponse parameter will contain a correctly formed
;  * 		kDS1AttrAuthCredential value.  This AuthCredential can be used for future
;  * 		authentications for this and other directory nodes in the directory system.
;  * 		Not all directory nodes will support authenticating in this manner, but most
;  * 		should.  In addition the current kDS1AttrAuthCredential value can always be
;  * 		obtained via dsGetDirNodeInfo call with kDS1AttrAuthCredential as one of the
;  * 		requested attributes.  Directory Nodes that support using a kDS1AttrAuthCredential
;  * 		will list DSAuthCredential as a supported authentication method.  Support
;  * 		authentication methods can be determined by calling dsGetDirNodeInfo and requesting
;  * 		the kDSNAttrAuthMethod attribute for that directory node.
;  * 		NOTE: it is important to note that while some Directory Nodes may support
;  * 		the attempt of using a kDS1AttrAuthCredential to authenticate, when the Directory
;  * 		Node plug-in decodes the Credential the authentication attempt may still fail
;  * 		for plug-in specific reasons (the plug-in may find the level of original authentication
;  * 		insufficient for it's requirements or configuration, or the credential may have expired
;  * 		and is no longer valid).  In addition when using a kDS1AttrAuthCredential to authentication
;  * 		to a different directory node than the original kDS1AttrAuthCredential was generated, the
;  * 		level of access granted by the directory node plug-in may not match the level in the
;  * 		original directory node.  Access granted to the contents of a directory node is entirely
;  * 		at the descretion of the directory node plug-in and the directory system it represents.
;  * @param inDirNodeAuthOnlyFlag Indicates if the client wishes to use
;  * 		the results of this authentication process as their identity for this directory session
;  * 		(inDirNodeReference) for directory node access authorization.
;  * 		If the flag value is "false", then at the completion of the auth process both the
;  * 		Directory Services API and the Plug-in should use this "identity" to grant
;  * 		or deny access for all future directory service calls.
;  * 		If the flag value is "true", then at the completion of of the auth process no identity
;  * 		information will be used by the directory services or Plug-in for authorization purposes.
;  * 		A file server just wishing to authenticate a user, but not change how/who it is accessing
;  * 		the directory as would set this parameter to "true".
;  * @param inRecordType The record type to perform the auth against for the inDirNodeAuthName.
;  *		If this is passed in as NULL then call will be routed as dsDoDirNodeAuth() which assumes
;  *		a record type of kDSStdRecordTypeUsers.
;  

(deftrap-inline "_dsDoDirNodeAuthOnRecordType" 
   ((inDirNodeReference :UInt32)
    (inDirNodeAuthName (:pointer :tDataBuffer))
    (inDirNodeAuthOnlyFlag :dsbool)
    (inAuthStepData (:pointer :tDataBuffer))
    (outAuthStepDataResponse (:pointer :tDataBuffer))
    (inOutContinueData (:pointer :TCONTEXTDATA))
    (inRecordType (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsDoAttributeValueSearch
;  * @discussion Use dsGetRecordEntry, dsGetAttributeEntry, and dsGetAttributeValue
;  * 		to parse the inOutDataBuffer parameter for results.
;  * @param inOutDataBuffer A client-allocated buffer to hold the data results.
;  * @param inRecordTypeList The list of record types to search within.
;  * @param inAttributeType What type of attributes we want for each record.
;  * @param inOutMatchRecordCount How many records we found that met the match criteria.
;  * 		However, also a limit of the maximum records returned as provided by the client.
;  * 		If zero or less, then assuming no limit on number of records to be returned.
;  

(deftrap-inline "_dsDoAttributeValueSearch" 
   ((inDirNodeReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inRecordTypeList (:pointer :tDataList))
    (inAttributeType (:pointer :tDataBuffer))
    (inPatternMatchType :sint32)
    (inPattern2Match (:pointer :tDataBuffer))
    (inOutMatchRecordCount (:pointer :UInt32))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsDoAttributeValueSearchWithData
;  * @param inOutDataBuffer A client-allocated buffer to hold the data results.
;  * @param inRecordTypeList The type of records to search for.
;  * @param inAttributeMatchType Which attribute we are to match on.
;  * @param inPatternMatchType Pattern match.
;  * @param inPatternToMatch Value to match for the above attribute.
;  * @param inAttributeTypeRequestList What type of attributes do we want for each record.
;  * @param inAttributeInfoOnly Do we want attribute information only, or values too.
;  * @param inOutMatchRecordCount How many records we found that met the match criteria.
;  * 		However, also a limit of the maximum records returned as provided by the client.
;  * 		If zero or less, then assuming no limit on number of records to be returned.
;  

(deftrap-inline "_dsDoAttributeValueSearchWithData" 
   ((inDirNodeReference :UInt32)
    (inOutDataBuffer (:pointer :tDataBuffer))
    (inRecordTypeList (:pointer :tDataList))
    (inAttributeMatchType (:pointer :tDataBuffer))
    (inPatternMatchType :sint32)
    (inPatternToMatch (:pointer :tDataBuffer))
    (inAttributeTypeRequestList (:pointer :tDataList))
    (inAttributeInfoOnly :dsbool)
    (inOutMatchRecordCount (:pointer :UInt32))
    (inOutContinueData (:pointer :TCONTEXTDATA))
   )
   :sint32
() )
; !
;  * @function dsDoPlugInCustomCall
;  * @discussion Used for custom direct communications with plugs-ins.
;  

(deftrap-inline "_dsDoPlugInCustomCall" 
   ((inDirNodeReference :UInt32)
    (inCustomRequestCode :UInt32)
    (inCustomRequestData (:pointer :tDataBuffer))
    (outCustomRequestResponse (:pointer :tDataBuffer))
   )
   :sint32
() )
; !
;  * @function dsVerifyDirRefNum
;  * @discussion Verify an existing tDirReference.
;  

(deftrap-inline "_dsVerifyDirRefNum" 
   ((inDirReference :UInt32)
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


(provide-interface "DirServices")