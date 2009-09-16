(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AVLTree.h"
; at Sunday July 2,2006 7:23:29 pm.
; 
;      File:       CarbonCore/AVLTree.h
;  
;      Contains:   Interfaces for AVL balanced trees.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AVLTREE__
; #define __AVLTREE__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
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
; 
;  *  AVLVisitStage
;  *  
;  *  Discussion:
;  *    The visit stage for AVLWalk() walkProcs
;  

(def-mactype :AVLVisitStage (find-mactype ':UInt16))
; 
;    * Passed the first time AVLWalk iterates thru a given node.
;    

(defconstant $kAVLPreOrder 0)
; 
;    * Passed the AVLWalk iterates thru a given node when it is 'in
;    * order'.
;    

(defconstant $kAVLInOrder 1)
; 
;    * Passed the last time AVLWalk iterates thru a given node.
;    

(defconstant $kAVLPostOrder 2)
; 
;  *  AVLOrder
;  *  
;  *  Discussion:
;  *    The order the tree is walked or disposed of.
;  

(def-mactype :AVLOrder (find-mactype ':UInt16))
; 
;    * Walk the tree in left-to-right order ( smaller to bigger, usually )
;    

(defconstant $kLeftToRight 0)
; 
;    * Walk the tree in right-to-left order ( bigger to smaller, usually )
;    

(defconstant $kRightToLeft 1)
; 
;  *  AVLNodeType
;  *  
;  *  Discussion:
;  *    The type of the node being passed to a callback proc.
;  

(def-mactype :AVLNodeType (find-mactype ':UInt16))

(defconstant $kAVLIsTree 0)
(defconstant $kAVLIsLeftBranch 1)
(defconstant $kAVLIsRightBranch 2)
(defconstant $kAVLIsLeaf 3)
(defconstant $kAVLNullNode 4)

(defconstant $errItemAlreadyInTree -960)
(defconstant $errNotValidTree -961)
(defconstant $errItemNotFoundInTree -962)
(defconstant $errCanNotInsertWhileWalkProcInProgress -963)
(defconstant $errTreeIsLocked -964)
; 
;  *  AVLTreeStruct
;  *  
;  *  Summary:
;  *    An opaque structure for a balanced binary tree.
;  *  
;  *  Discussion:
;  *    The structure of a tree.  It's opaque; don't assume it's 36 bytes
;  *    in size.
;  
(defrecord AVLTreeStruct
   (signature :OSType)
   (privateStuff (:array :UInt32 8))
)

;type name? (%define-record :AVLTreeStruct (find-record-descriptor ':AVLTreeStruct))

(def-mactype :AVLTreePtr (find-mactype '(:pointer :AVLTreeStruct)))
; 
;  *  AVLCompareItemsProcPtr
;  *  
;  *  Summary:
;  *    A callback function which compares two data items and returns
;  *    their ordering.
;  *  
;  *  Discussion:
;  *    Every tree must have a function which compares the data for two
;  *    items and returns < 0, 0, or >0 for the items - < 0 if the first
;  *    item is 'before' the second item according to some criteria, == 0
;  *    if the two items are identical according to the criteria, or > 0
;  *    if the first item is 'after' the second item according to the
;  *    criteria.  The comparison function is also passed the node type,
;  *    but most of the time this can be ignored.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree which contains the items being compared
;  *    
;  *    i1:
;  *      A pointer to the first item
;  *    
;  *    i2:
;  *      A pointer to the second item
;  *    
;  *    nd_typ:
;  *      The type of the nodes being compared.  This is not terribly
;  *      useful most of the time.
;  *  
;  *  Result:
;  *    A value < 0 if i1 is 'before' i2, > 0 if i1 is 'after' i2, or ==
;  *    0 if i1 is equal to i2.
;  

(def-mactype :AVLCompareItemsProcPtr (find-mactype ':pointer)); (AVLTreePtr tree , const void * i1 , const void * i2 , AVLNodeType nd_typ)
; 
;  *  AVLItemSizeProcPtr
;  *  
;  *  Summary:
;  *    A callback function which returns the size of an item.
;  *  
;  *  Discussion:
;  *    Every tree must have a itemSizeProc; this routine gets passed a
;  *    pointer to the item's data and returns the size of the data.  If
;  *    a tree contains records of a fixed size, this function can just
;  *    return sizeof( that-struct ); otherwise it should calculate the
;  *    size of the item based on the data for the item.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree which contains the item whose size is being requested.
;  *    
;  *    itemPtr:
;  *      A pointer to the item whose size is being returned.
;  *  
;  *  Result:
;  *    The size of the item.
;  

(def-mactype :AVLItemSizeProcPtr (find-mactype ':pointer)); (AVLTreePtr tree , const void * itemPtr)
; 
;  *  AVLDisposeItemProcPtr
;  *  
;  *  Summary:
;  *    Dispose of any additional memory associated with an item in the
;  *    tree.
;  *  
;  *  Discussion:
;  *    A tree may have an optional disposeItemProc, which gets called
;  *    whenever an item is removed from the tree ( via AVLRemove() or
;  *    when AVLDispose() deletes all of the items in the tree ). This
;  *    might be useful if the nodes in the tree own 'resources'  ( like,
;  *    open files ) which should be released before the item is removed.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree containing the item being disposed.
;  *    
;  *    dataP:
;  *      A pointer to the data for the item being disposed.
;  

(def-mactype :AVLDisposeItemProcPtr (find-mactype ':pointer)); (AVLTreePtr tree , const void * dataP)
; 
;  *  AVLWalkProcPtr
;  *  
;  *  Summary:
;  *    A callback function which gets passed each item in the tree, in a
;  *    specified order.
;  *  
;  *  Discussion:
;  *    The common way to iterate across all of the items in a tree is
;  *    via AVLWalk(), which takes a walkProcPtr.  This function will get
;  *    called for every item in the tree three times, as the tree is
;  *    being walked across.  First, the walkProc will get called with
;  *    visitStage == kAVLPreOrder, at which point internally the node of
;  *    the tree for the given data has just been reached.  Later, this
;  *    function will get called with visitStage == kAVLInOrder, and
;  *    lastly this function will get called with visitStage ==
;  *    kAVLPostOrder. The 'minimum' item in the tree will get called
;  *    with visitStage == kInOrder first, followed by the 'next' item in
;  *    the tree, up until the last item in the tree structure is called.
;  *    In general, you'll only care about calls to this function when
;  *    visitStage == kAVLInOrder.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree being walked.
;  *    
;  *    dataPtr:
;  *      A pointer to the data for an item in the tree.
;  *    
;  *    visitStage:
;  *      The stage of the walk for the given node.
;  *    
;  *    node:
;  *      The type of the given node. This is not terribly useful most of
;  *      the time.
;  *    
;  *    level:
;  *      How 'deep' in the tree the given node is.  This is not terribly
;  *      useful most of the time.
;  *    
;  *    balance:
;  *      How balanced the given node in the tree is.  This is not
;  *      terribly useful most of the time.
;  *    
;  *    refCon:
;  *      The refCon passed into AVLWalk() for this call.
;  *  
;  *  Result:
;  *    Return 0 to continue walking the tree, or 1 to terminate.
;  

(def-mactype :AVLWalkProcPtr (find-mactype ':pointer)); (AVLTreePtr tree , const void * dataPtr , AVLVisitStage visitStage , AVLNodeType node , UInt32 level , SInt32 balance , void * refCon)

(def-mactype :AVLCompareItemsUPP (find-mactype '(:pointer :OpaqueAVLCompareItemsProcPtr)))

(def-mactype :AVLItemSizeUPP (find-mactype '(:pointer :OpaqueAVLItemSizeProcPtr)))

(def-mactype :AVLDisposeItemUPP (find-mactype '(:pointer :OpaqueAVLDisposeItemProcPtr)))

(def-mactype :AVLWalkUPP (find-mactype '(:pointer :OpaqueAVLWalkProcPtr)))
; 
;  *  NewAVLCompareItemsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAVLCompareItemsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAVLCompareItemsProcPtr)
() )
; 
;  *  NewAVLItemSizeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAVLItemSizeUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAVLItemSizeProcPtr)
() )
; 
;  *  NewAVLDisposeItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAVLDisposeItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAVLDisposeItemProcPtr)
() )
; 
;  *  NewAVLWalkUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewAVLWalkUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueAVLWalkProcPtr)
() )
; 
;  *  DisposeAVLCompareItemsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAVLCompareItemsUPP" 
   ((userUPP (:pointer :OpaqueAVLCompareItemsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeAVLItemSizeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAVLItemSizeUPP" 
   ((userUPP (:pointer :OpaqueAVLItemSizeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeAVLDisposeItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAVLDisposeItemUPP" 
   ((userUPP (:pointer :OpaqueAVLDisposeItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeAVLWalkUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeAVLWalkUPP" 
   ((userUPP (:pointer :OpaqueAVLWalkProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeAVLCompareItemsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAVLCompareItemsUPP" 
   ((tree (:pointer :AVLTreeStruct))
    (i1 :pointer)
    (i2 :pointer)
    (nd_typ :UInt16)
    (userUPP (:pointer :OpaqueAVLCompareItemsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  InvokeAVLItemSizeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAVLItemSizeUPP" 
   ((tree (:pointer :AVLTreeStruct))
    (itemPtr :pointer)
    (userUPP (:pointer :OpaqueAVLItemSizeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  InvokeAVLDisposeItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAVLDisposeItemUPP" 
   ((tree (:pointer :AVLTreeStruct))
    (dataP :pointer)
    (userUPP (:pointer :OpaqueAVLDisposeItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeAVLWalkUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeAVLWalkUPP" 
   ((tree (:pointer :AVLTreeStruct))
    (dataPtr :pointer)
    (visitStage :UInt16)
    (node :UInt16)
    (level :UInt32)
    (balance :SInt32)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueAVLWalkProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLInit()
;  *  
;  *  Summary:
;  *    Create an AVL ( balanced binary ) tree
;  *  
;  *  Discussion:
;  *    Create an AVL tree.  The compareItemsProc and the sizeItemProc
;  *    are required; disposeItemProc is optional and can be nil.  The
;  *    refCon is stored with the list, and is passed back to the
;  *    compareItemsProc, sizeItemProc, and disposeItemsProc calls.  The
;  *    allocation of the tree ( and all nodes later added to the list
;  *    with AVLInsert ) will be created in what is the current zone at
;  *    the time AVLInit() is called.  Always call AVLDispose() to
;  *    dispose of a list created with AVLInit().
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Parameters:
;  *    
;  *    flags:
;  *      Creation flags.  Currently, no flags are defined, so pass 0.
;  *    
;  *    compareItemsProc:
;  *      A UPP for a function which compares two data items, and returns
;  *      a value which is < 0, == 0, or > 0 depending on whether the
;  *      first item is 'before', 'equal', or 'after' the first item.
;  *    
;  *    sizeItemProc:
;  *      A UPP for a function which takes a pointer to a data item, and
;  *      returns the size in bytes which it requires to store.
;  *    
;  *    disposeItemProc:
;  *      A UPP for a function which takes a pointer to a data item, and
;  *      disposes of any memory which may have been allocated for the
;  *      item.  This does not need to dispose of the item itself ( the
;  *      AVLTree Manager will do that ), only any memory which the item
;  *      passed in may be pointing to.  This function may be NULL if
;  *      data items do not use any memory besides that taken up by the
;  *      item itself.
;  *    
;  *    refCon:
;  *      A 32 bit quantity which is stored with this tree, and can be
;  *      retrieved at an time ( and in a callback, if desired ) with
;  *      AVLGetRefcon().
;  *    
;  *    tree:
;  *      The created AVLTree, or NULL if there is an error.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLInit" 
   ((flags :UInt32)
    (compareItemsProc (:pointer :OpaqueAVLCompareItemsProcPtr))
    (sizeItemProc (:pointer :OpaqueAVLItemSizeProcPtr))
    (disposeItemProc (:pointer :OpaqueAVLDisposeItemProcPtr))
    (refCon :pointer)
    (tree (:pointer :AVLTREEPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLDispose()
;  *  
;  *  Summary:
;  *    Dispose of an AVL tree created with AVLInit()
;  *  
;  *  Discussion:
;  *    Dispose of an AVL tree.  This will dispose of each item in the
;  *    tree in the order specified, call the tree's disposeProc proc for
;  *    each item, and then dispose of the space allocated for the tree
;  *    itself.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLDispose is thread safe provided no other thread is still using
;  *    the tree being dispose.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to dispose, which was created with AVLInit().
;  *    
;  *    order:
;  *      The order to dispose of the items in the tree.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLDispose" 
   ((tree (:pointer :AVLTREEPTR))
    (order :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLWalk()
;  *  
;  *  Summary:
;  *    Iterate across all of the items in an AVL tree, in a specified
;  *    order.
;  *  
;  *  Discussion:
;  *    Iterate across all of the items in the tree, in the order
;  *    specified.  kLeftToRight is basically lowest-to-highest order,
;  *    kRightToLeft is highest-to-lowest order.  For each node in the
;  *    tree, it will call the walkProc with three messages ( at the
;  *    appropriate time ).  First, with kAVLPreOrder when the walking
;  *    gets to this node in the tree, before handling either the left or
;  *    right subtree, secondly, with kAVLInOrder after handling one
;  *    subtree but before handling the other, and lastly with
;  *    kAVLPostOrder after handling both subtrees.  If you want to
;  *    handle items in order, then only do something if the visit stage
;  *    is kAVLInOrder.  You can only call AVLRemove() from inside a
;  *    walkProc if visit stage is kAVLPostOrder ( because if you remove
;  *    a node during the pre or in order stages you will corrupt the
;  *    list ) OR if you return a non-zero result from the walkProc call
;  *    which called AVLRemove() to immediately terminate the walkProc. 
;  *    Do not call AVLInsert() to insert a node into the tree from
;  *    inside a walkProc. The walkProc function gets called with the
;  *    AVLTreePtr, a pointer to the data for the current node ( which
;  *    you can change in place as long as you do not affect the order
;  *    within the tree ), the visit stage, the type of the current node
;  *    ( leaf node, right or left branch, or full tree ), the level
;  *    within the tree ( the root is level 1 ), the balance for the
;  *    current node, and the refCon passed to AVLWalk().  This refCon is
;  *    different from the one passed into AVLInit(); use AVLGetRefCon()
;  *    to get that refCon if you want it inside a walkProc. ( Most
;  *    walkProcs will not care about the values for node type, level, or
;  *    balance. )
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLWalk is thread safe as long as no other thread tries to modify
;  *    the tree by inserting or removing an item, or disposing of the
;  *    tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to dispose, which was created with AVLInit().
;  *    
;  *    walkProc:
;  *      A UPP for a function which is called during the walk thru the
;  *      tree for each item.
;  *    
;  *    order:
;  *      The order to iterate thru the tree.
;  *    
;  *    walkRefCon:
;  *      A 32 bit value passed to the walkProc each time it is called.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLWalk" 
   ((tree (:pointer :AVLTreeStruct))
    (walkProc (:pointer :OpaqueAVLWalkProcPtr))
    (order :UInt16)
    (walkRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLCount()
;  *  
;  *  Summary:
;  *    Return the number of items in the given tree.
;  *  
;  *  Discussion:
;  *    Return the number of items in the given tree.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLCount is thread safe as long as no other thread tries to
;  *    modify the tree by inserting or removing an item, or disposing of
;  *    the tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to return the count of items for.
;  *    
;  *    count:
;  *      On return, the count of items ( 1-based ) in the tree.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLCount" 
   ((tree (:pointer :AVLTreeStruct))
    (count (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLGetIndItem()
;  *  
;  *  Summary:
;  *    Return the data of the index-th item from the tree.
;  *  
;  *  Discussion:
;  *    Return the one-based index-th item from the tree by putting it's
;  *    data at dataPtr if dataPtr is non-nil, and it's size into
;  *    *itemSize if itemSize is non-nil. If index is out of range,
;  *    return errItemNotFoundInTree.  ( Internally, this does an
;  *    AVLWalk(), so the tree can not be modified while this call is in
;  *    progress ).
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLGetIndItem is thread safe as long as no other thread tries to
;  *    modify the tree by inserting or removing an item, or disposing of
;  *    the tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to return the index-th items for.
;  *    
;  *    index:
;  *      A index of the item to return.  The 'first' item in the tree is
;  *      index = 1, the last item is index = the count of items in the
;  *      tree.
;  *    
;  *    dataPtr:
;  *      An address in memory to return the data for the item, or NULL
;  *      if you don not want data returned.  The memory point to must be
;  *      large enough to hold all of the data for the item.
;  *    
;  *    itemSize:
;  *      On return, the size of the data for the index-th item.  If you
;  *      do not care about the size of the data, pass NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLGetIndItem" 
   ((tree (:pointer :AVLTreeStruct))
    (index :UInt32)
    (dataPtr :pointer)
    (itemSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLInsert()
;  *  
;  *  Summary:
;  *    Insert an item into the tree.
;  *  
;  *  Discussion:
;  *    Insert the given item into the tree.  This will call the tree's
;  *    sizeItemProc to determine how big the item at data is, and then
;  *    will make a copy of the item and insert it into the tree in the
;  *    appropriate place.  If an item already exists in the tree with
;  *    the same key ( so that the compareItemsUPP returns 0 when asked
;  *    to compare this item to an existing one ), then it will return
;  *    errItemNotFoundInTree.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLInsert is thread safe as long as no other thread tries to walk
;  *    or modify the tree by inserting or removing an item, or disposing
;  *    of the tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to return the index-th items for.
;  *    
;  *    data:
;  *      A pointer to the item to be inserted.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLInsert" 
   ((tree (:pointer :AVLTreeStruct))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLRemove()
;  *  
;  *  Summary:
;  *    Remove an item from the tree.
;  *  
;  *  Discussion:
;  *    Remove any item from the tree with the given key.  If dataPtr !=
;  *    nil, then copy the item's data to dataPtr before removing it from
;  *    the tree.  Before removing the item, call the tree's
;  *    disposeItemProc to let it release anything used by the data in
;  *    the tree.  It is not necessary to fill in a complete record for
;  *    key, only that the compareItemsProc return 0 when asked to
;  *    compare the data at key with the node in the tree to be deleted. 
;  *    If the item cannot be found in the tree, this will return
;  *    errItemNotFoundInTree.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLRemove is thread safe as long as no other thread tries to walk
;  *    or modify the tree by inserting or removing an item, or disposing
;  *    of the tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to return the index-th items for.
;  *    
;  *    key:
;  *      A pointer to the item to be removed ( or, enough of the item
;  *      that it can be found in the tree ).
;  *    
;  *    dataPtr:
;  *      An address in memory to return the data for the item, or NULL
;  *      if you don not want data returned.  The memory point to must be
;  *      large enough to hold all of the data for the item.
;  *    
;  *    itemSize:
;  *      On return, the size of the data for the index-th item.  If you
;  *      do not care about the size of the data, pass NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLRemove" 
   ((tree (:pointer :AVLTreeStruct))
    (key :pointer)
    (dataPtr :pointer)
    (itemSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLFind()
;  *  
;  *  Summary:
;  *    Remove an item from the tree.
;  *  
;  *  Discussion:
;  *    Find the item in the tree with the given key, and return it's
;  *    data in dataPtr ( if dataPtr != nil ), and it's size in *itemSize
;  *    ( if itemSize != nil ).  It is not necessary to fill in a
;  *    complete record for key, only that the compareItemsProc return 0
;  *    when asked to compare the data at key with the node in the tree
;  *    to be deleted.  If the item cannot be found in the tree, this
;  *    will return errItemNotFoundInTree.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLRemove is thread safe as long as no other thread tries to walk
;  *    or modify the tree by inserting or removing an item, or disposing
;  *    of the tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to return the index-th items for.
;  *    
;  *    key:
;  *      A pointer to the item to be found ( or, enough of the item that
;  *      it can be found in the tree ).
;  *    
;  *    dataPtr:
;  *      An address in memory to return the data for the item, or NULL
;  *      if you don not want data returned.  The memory point to must be
;  *      large enough to hold all of the data for the item.
;  *    
;  *    itemSize:
;  *      On return, the size of the data for the index-th item.  If you
;  *      do not care about the size of the data, pass NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLFind" 
   ((tree (:pointer :AVLTreeStruct))
    (key :pointer)
    (dataPtr :pointer)
    (itemSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AVLGetRefcon()
;  *  
;  *  Summary:
;  *    Return the refCon set when the tree was created.
;  *  
;  *  Discussion:
;  *    Get the refCon for the given tree ( set in AVLInit ) and return
;  *    it.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *    AVLGetRefcon is thread safe as long as no other thread tries to
;  *    dispose of the tree itself.
;  *  
;  *  Parameters:
;  *    
;  *    tree:
;  *      The tree to return the refcon for.
;  *    
;  *    refCon:
;  *      On return, the refCon for the tree, or NULL if tree is invalid.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_AVLGetRefcon" 
   ((tree (:pointer :AVLTreeStruct))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AVLTREE__ */


(provide-interface "AVLTree")