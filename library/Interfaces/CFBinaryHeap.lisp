(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFBinaryHeap.h"
; at Sunday July 2,2006 7:23:00 pm.
; 	CFBinaryHeap.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 
; !
;         @header CFBinaryHeap
;         CFBinaryHeap implements a container which stores values sorted using
;         a binary search algorithm.  CFBinaryHeaps can be useful as priority
; 	queues.
; 

; #if !defined(__COREFOUNDATION_CFBINARYHEAP__)
(defconstant $__COREFOUNDATION_CFBINARYHEAP__ 1)
; #define __COREFOUNDATION_CFBINARYHEAP__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
(defrecord CFBinaryHeapCompareContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)
; !
;         @typedef CFBinaryHeapCallBacks
; 	Structure containing the callbacks for values of a CFBinaryHeap.
;         @field version The version number of the structure type being passed
;                 in as a parameter to the CFBinaryHeap creation functions.
;                 This structure is version 0.
; 	@field retain The callback used to add a retain for the binary heap
; 		on values as they are put into the binary heap.
; 		This callback returns the value to use as the value in the
; 		binary heap, which is usually the value parameter passed to
; 		this callback, but may be a different value if a different
; 		value should be added to the binary heap. The binary heap's
; 		allocator is passed as the first argument.
; 	@field release The callback used to remove a retain previously added
; 		for the binary heap from values as they are removed from
; 		the binary heap. The binary heap's allocator is passed as the
; 		first argument.
; 	@field copyDescription The callback used to create a descriptive
; 		string representation of each value in the binary heap. This
; 		is used by the CFCopyDescription() function.
; 	@field compare The callback used to compare values in the binary heap for
; 		equality in some operations.
; 
(defrecord CFBinaryHeapCallBacks
   (version :SInt32)
   (retain (:pointer :callback))                ;(void * (CFAllocatorRef allocator , const void * ptr))
   (release (:pointer :callback))               ;(void (CFAllocatorRef allocator , const void * ptr))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * ptr))
   (compare (:pointer :callback))               ;(CFComparisonResult (const void * ptr1 , const void * ptr2 , void * context))
)
; !
; 	@constant kCFStringBinaryHeapCallBacks
; 	Predefined CFBinaryHeapCallBacks structure containing a set
; 	of callbacks appropriate for use when the values in a CFBinaryHeap
; 	are all CFString types.
; 
(%define-record :kCFStringBinaryHeapCallBacks (find-record-descriptor ':CFBinaryHeapCallBacks))
; !
; 	@typedef CFBinaryHeapApplierFunction
; 	Type of the callback function used by the apply functions of
; 		CFBinaryHeap.
; 	@param value The current value from the binary heap.
; 	@param context The user-defined context parameter given to the apply
; 		function.
; 

(def-mactype :CFBinaryHeapApplierFunction (find-mactype ':pointer)); (const void * val , void * context)
; !
; 	@typedef CFBinaryHeapRef
; 	This is the type of a reference to CFBinaryHeaps.
; 

(def-mactype :CFBinaryHeapRef (find-mactype '(:pointer :__CFBinaryHeap)))
; !
; 	@function CFBinaryHeapGetTypeID
; 	Returns the type identifier of all CFBinaryHeap instances.
; 

(deftrap-inline "_CFBinaryHeapGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function CFBinaryHeapCreate
; 	Creates a new mutable or fixed-mutable binary heap with the given values.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the binary heap and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param capacity The maximum number of values that can be contained
; 		by the CFBinaryHeap. The binary heap starts empty, and can grow to this
; 		number of values (and it can have less). If this parameter
; 		is 0, the binary heap's maximum capacity is unlimited (or rather,
; 		only limited by address space and available memory
; 		constraints). If this parameter is negative, the behavior is
; 		undefined.
; 	@param callBacks A pointer to a CFBinaryHeapCallBacks structure
; 		initialized with the callbacks for the binary heap to use on
; 		each value in the binary heap. A copy of the contents of the
; 		callbacks structure is made, so that a pointer to a structure
; 		on the stack can be passed in, or can be reused for multiple
; 		binary heap creations. If the version field of this callbacks
; 		structure is not one of the defined ones for CFBinaryHeap, the
; 		behavior is undefined. The retain field may be NULL, in which
; 		case the CFBinaryHeap will do nothing to add a retain to values
; 		as they are put into the binary heap. The release field may be
; 		NULL, in which case the CFBinaryHeap will do nothing to remove
; 		the binary heap's retain (if any) on the values when the
; 		heap is destroyed or a key-value pair is removed. If the
; 		copyDescription field is NULL, the binary heap will create a
; 		simple description for a value. If the equal field is NULL, the
; 		binary heap will use pointer equality to test for equality of
; 		values. This callbacks parameter itself may be NULL, which is
; 		treated as if a valid structure of version 0 with all fields
; 		NULL had been passed in. Otherwise,
; 		if any of the fields are not valid pointers to functions
; 		of the correct type, or this parameter is not a valid
; 		pointer to a CFBinaryHeapCallBacks callbacks structure,
; 		the behavior is undefined. If any of the values put into the
; 		binary heap is not one understood by one of the callback functions
; 		the behavior when that callback function is used is undefined.
;         @param compareContext A pointer to a CFBinaryHeapCompareContext structure.
; 	@result A reference to the new CFBinaryHeap.
; 

(deftrap-inline "_CFBinaryHeapCreate" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
    (callBacks (:pointer :CFBINARYHEAPCALLBACKS))
    (compareContext (:pointer :CFBINARYHEAPCOMPARECONTEXT))
   )
   (:pointer :__CFBinaryHeap)
() )
; !
; 	@function CFBinaryHeapCreateCopy
; 	Creates a new mutable or fixed-mutable binary heap with the values from the given binary heap.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the binary heap and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param capacity The maximum number of values that can be contained
; 		by the CFBinaryHeap. The binary heap starts empty, and can grow to this
; 		number of values (and it can have less). If this parameter
; 		is 0, the binary heap's maximum capacity is unlimited (or rather,
; 		only limited by address space and available memory
; 		constraints). If this parameter is negative, or less than the number of
;                 values in the given binary heap, the behavior is undefined.
; 	@param heap The binary heap which is to be copied. The values from the
; 		binary heap are copied as pointers into the new binary heap (that is,
; 		the values themselves are copied, not that which the values
; 		point to, if anything). However, the values are also
; 		retained by the new binary heap. The count of the new binary will
; 		be the same as the given binary heap. The new binary heap uses the same
; 		callbacks as the binary heap to be copied. If this parameter is
; 		not a valid CFBinaryHeap, the behavior is undefined.
; 	@result A reference to the new mutable or fixed-mutable binary heap.
; 

(deftrap-inline "_CFBinaryHeapCreateCopy" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
    (heap (:pointer :__CFBinaryHeap))
   )
   (:pointer :__CFBinaryHeap)
() )
; !
; 	@function CFBinaryHeapGetCount
; 	Returns the number of values currently in the binary heap.
; 	@param heap The binary heap to be queried. If this parameter is not a valid
; 		CFBinaryHeap, the behavior is undefined.
; 	@result The number of values in the binary heap.
; 

(deftrap-inline "_CFBinaryHeapGetCount" 
   ((heap (:pointer :__CFBinaryHeap))
   )
   :SInt32
() )
; !
; 	@function CFBinaryHeapGetCountOfValue
; 	Counts the number of times the given value occurs in the binary heap.
; 	@param heap The binary heap to be searched. If this parameter is not a
; 		valid CFBinaryHeap, the behavior is undefined.
; 	@param value The value for which to find matches in the binary heap. The
; 		compare() callback provided when the binary heap was created is
; 		used to compare. If the compare() callback was NULL, pointer
; 		equality (in C, ==) is used. If value, or any of the values
; 		in the binary heap, are not understood by the compare() callback,
; 		the behavior is undefined.
; 	@result The number of times the given value occurs in the binary heap.
; 

(deftrap-inline "_CFBinaryHeapGetCountOfValue" 
   ((heap (:pointer :__CFBinaryHeap))
    (value :pointer)
   )
   :SInt32
() )
; !
; 	@function CFBinaryHeapContainsValue
; 	Reports whether or not the value is in the binary heap.
; 	@param heap The binary heap to be searched. If this parameter is not a
; 		valid CFBinaryHeap, the behavior is undefined.
; 	@param value The value for which to find matches in the binary heap. The
; 		compare() callback provided when the binary heap was created is
; 		used to compare. If the compare() callback was NULL, pointer
; 		equality (in C, ==) is used. If value, or any of the values
; 		in the binary heap, are not understood by the compare() callback,
; 		the behavior is undefined.
; 	@result true, if the value is in the specified binary heap, otherwise false.
; 

(deftrap-inline "_CFBinaryHeapContainsValue" 
   ((heap (:pointer :__CFBinaryHeap))
    (value :pointer)
   )
   :Boolean
() )
; !
; 	@function CFBinaryHeapGetMinimum
; 	Returns the minimum value is in the binary heap.  If the heap contains several equal
;                 minimum values, any one may be returned.
; 	@param heap The binary heap to be searched. If this parameter is not a
; 		valid CFBinaryHeap, the behavior is undefined.
; 	@result A reference to the minimum value in the binary heap, or NULL if the
;                 binary heap contains no values.
; 

(deftrap-inline "_CFBinaryHeapGetMinimum" 
   ((heap (:pointer :__CFBinaryHeap))
   )
   (:pointer :void)
() )
; !
; 	@function CFBinaryHeapGetMinimumIfPresent
; 	Returns the minimum value is in the binary heap, if present.  If the heap contains several equal
;                 minimum values, any one may be returned.
; 	@param heap The binary heap to be searched. If this parameter is not a
; 		valid CFBinaryHeap, the behavior is undefined.
;         @param value A C pointer to pointer-sized storage to be filled with the minimum value in 
;                 the binary heap.  If this value is not a valid C pointer to a pointer-sized block
;                 of storage, the result is undefined.  If the result of the function is false, the value
;                 stored at this address is undefined.
; 	@result true, if a minimum value was found in the specified binary heap, otherwise false.
; 

(deftrap-inline "_CFBinaryHeapGetMinimumIfPresent" 
   ((heap (:pointer :__CFBinaryHeap))
    (value :pointer)
   )
   :Boolean
() )
; !
; 	@function CFBinaryHeapGetValues
; 	Fills the buffer with values from the binary heap.
; 	@param heap The binary heap to be queried. If this parameter is not a
; 		valid CFBinaryHeap, the behavior is undefined.
; 	@param values A C array of pointer-sized values to be filled with
; 		values from the binary heap. The values in the C array are ordered
; 		from least to greatest. If this parameter is not a valid pointer to a 
;                 C array of at least CFBinaryHeapGetCount() pointers, the behavior is undefined.
; 

(deftrap-inline "_CFBinaryHeapGetValues" 
   ((heap (:pointer :__CFBinaryHeap))
    (values :pointer)
   )
   nil
() )
; !
; 	@function CFBinaryHeapApplyFunction
; 	Calls a function once for each value in the binary heap.
; 	@param heap The binary heap to be operated upon. If this parameter is not a
; 		valid CFBinaryHeap, the behavior is undefined.
; 	@param applier The callback function to call once for each value in
; 		the given binary heap. If this parameter is not a
; 		pointer to a function of the correct prototype, the behavior
; 		is undefined. If there are values in the binary heap which the
; 		applier function does not expect or cannot properly apply
; 		to, the behavior is undefined. 
; 	@param context A pointer-sized user-defined value, which is passed
; 		as the second parameter to the applier function, but is
; 		otherwise unused by this function. If the context is not
; 		what is expected by the applier function, the behavior is
; 		undefined.
; 

(deftrap-inline "_CFBinaryHeapApplyFunction" 
   ((heap (:pointer :__CFBinaryHeap))
    (applier :pointer)
    (context :pointer)
   )
   nil
() )
; !
; 	@function CFBinaryHeapAddValue
; 	Adds the value to the binary heap.
; 	@param heap The binary heap to which the value is to be added. If this parameter is not a
; 		valid mutable CFBinaryHeap, the behavior is undefined.
;                 If the binary heap is a fixed-capacity binary heap and it
; 		is full before this operation, the behavior is undefined.
; 	@param value The value to add to the binary heap. The value is retained by
; 		the binary heap using the retain callback provided when the binary heap
; 		was created. If the value is not of the sort expected by the
; 		retain callback, the behavior is undefined.
; 

(deftrap-inline "_CFBinaryHeapAddValue" 
   ((heap (:pointer :__CFBinaryHeap))
    (value :pointer)
   )
   nil
() )
; !
; 	@function CFBinaryHeapRemoveMinimumValue
; 	Removes the minimum value from the binary heap.
; 	@param heap The binary heap from which the minimum value is to be removed. If this 
;                 parameter is not a valid mutable CFBinaryHeap, the behavior is undefined.
; 

(deftrap-inline "_CFBinaryHeapRemoveMinimumValue" 
   ((heap (:pointer :__CFBinaryHeap))
   )
   nil
() )
; !
; 	@function CFBinaryHeapRemoveAllValues
; 	Removes all the values from the binary heap, making it empty.
; 	@param heap The binary heap from which all of the values are to be
; 		removed. If this parameter is not a valid mutable CFBinaryHeap,
; 		the behavior is undefined.
; 

(deftrap-inline "_CFBinaryHeapRemoveAllValues" 
   ((heap (:pointer :__CFBinaryHeap))
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFBINARYHEAP__ */


(provide-interface "CFBinaryHeap")