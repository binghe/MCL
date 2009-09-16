(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFRunLoop.h"
; at Sunday July 2,2006 7:22:51 pm.
; 	CFRunLoop.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 
; !
; 	@header CFRunLoop
; 	CFRunLoops monitor sources of input to a task and dispatch control
; 	when sources become ready for processing. Examples of input sources
; 	might include user input devices, network connections, periodic
; 	or time-delayed events, and asynchronous callbacks. Input sources
; 	are registered with a run loop, and when a run loop is "run",
; 	callback functions associated with each source are called when
; 	the sources have some activity.
; 
; 	There is one run loop per thread. Each run loop has different
; 	sets of input sources, called modes, which are named with strings.
; 	A run loop is run -- in a named mode -- to have it monitor the
; 	sources that have been registered in that mode, and the run loop
; 	blocks there until something happens. Examples of modes include
; 	the default mode, which a process would normally spend most of
; 	its time in, and a modal panel mode, which might be run when
; 	a modal panel is up, to restrict the set of input sources that
; 	are allowed to "fire". This is not to the granularity of, for
; 	example, what type of user input events are interesting, however.
; 	That sort of finer-grained granularity is given by UI-level
; 	frameworks with "get next event matching mask" or similar
; 	functionality.
; 
; 	The CFRunLoopSource type is an abstraction of input sources that
; 	can be put in a run loop. An input source type would normally
; 	define an API for creating and operating on instances of the type,
; 	as if it were a separate entity from the run loop, then provide a
; 	function to create a CFRunLoopSource for an instance. The
; 	CFRunLoopSource can then be registered with the run loop,
; 	represents the input source to the run loop, and acts as
; 	intermediary between the run loop and the actual input source
; 	type instance. Examples include CFMachPort and CFSocket.
; 
; 	A CFRunLoopTimer is a specialization of run loop sources, a way
; 	to generate either a one-shot delayed action, or a recurrent
; 	action.
; 
; 	While being run, a run loop goes through a cycle of activities.
; 	Input sources are checked, timers which need firing are fired,
; 	and then the run loop blocks, waiting for something to happen 
; 	(or in the case of timers, waiting for it to be time for
; 	something to happen). When something does happen, the run loop
; 	wakes up, processes the activity (usually by calling a callback
; 	function for an input source), checks other sources, fires timers,
; 	and goes back to sleep. And so on. CFRunLoopObservers can be
; 	used to do processing at special points in this cycle.
; 
; 
; 
; 
; 

; #if !defined(__COREFOUNDATION_CFRUNLOOP__)
(defconstant $__COREFOUNDATION_CFRUNLOOP__ 1)
; #define __COREFOUNDATION_CFRUNLOOP__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFDate")

(require-interface "CoreFoundation/CFString")

; #if defined(__MACH__)
#| |#

(require-interface "mach/port")

#|
 |#

; #endif


; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@typedef CFRunLoopRef
; 	This is the type of a reference to a run loop.
; 

(def-mactype :CFRunLoopRef (find-mactype '(:pointer :__CFRunLoop)))
; !
; 	@typedef CFRunLoopSourceRef
; 	This is the type of a reference to general run loop input sources.
; 

(def-mactype :CFRunLoopSourceRef (find-mactype '(:pointer :__CFRunLoopSource)))
; !
; 	@typedef CFRunLoopObserverRef
; 	This is the type of a reference to a run loop observer.
; 

(def-mactype :CFRunLoopObserverRef (find-mactype '(:pointer :__CFRunLoopObserver)))
; !
; 	@typedef CFRunLoopTimerRef
; 	This is the type of a reference to a run loop timer.
; 

(def-mactype :CFRunLoopTimerRef (find-mactype '(:pointer :__CFRunLoopTimer)))
;  Reasons for CFRunLoopRunInMode() to Return 

(defconstant $kCFRunLoopRunFinished 1)
(defconstant $kCFRunLoopRunStopped 2)
(defconstant $kCFRunLoopRunTimedOut 3)
(defconstant $kCFRunLoopRunHandledSource 4)
;  Run Loop Observer Activities 

(defconstant $kCFRunLoopEntry 1)
(defconstant $kCFRunLoopBeforeTimers 2)
(defconstant $kCFRunLoopBeforeSources 4)
(defconstant $kCFRunLoopBeforeWaiting 32)
(defconstant $kCFRunLoopAfterWaiting 64)
(defconstant $kCFRunLoopExit #x80)
(defconstant $kCFRunLoopAllActivities #xFFFFFFF)
(def-mactype :CFRunLoopActivity (find-mactype ':SINT32))
(def-mactype :kCFRunLoopDefaultMode (find-mactype ':CFStringRef))
(def-mactype :kCFRunLoopCommonModes (find-mactype ':CFStringRef))
; !
; 	@function CFRunLoopGetTypeID
; 	Returns the type identifier of all CFRunLoop instances.
; 

(deftrap-inline "_CFRunLoopGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function CFRunLoopGetCurrent
; 	Returns the run loop for the current thread. There is exactly
; 	one run loop per thread.
; 

(deftrap-inline "_CFRunLoopGetCurrent" 
   (
   )
   (:pointer :__CFRunLoop)
() )
; !
; 	@function CFRunLoopCopyCurrentMode
; 	Returns the name of the mode in which the run loop is running.
; 	NULL is returned if the run loop is not running.
; 	@param rl The run loop for which the current mode should be
; 		reported.
; 

(deftrap-inline "_CFRunLoopCopyCurrentMode" 
   ((rl (:pointer :__CFRunLoop))
   )
   (:pointer :__CFString)
() )
; !
; 	@function CFRunLoopCopyAllModes
; 	Returns an array of all the names of the modes known to the run
; 	loop.
; 	@param rl The run loop for which the mode list should be returned.
; 

(deftrap-inline "_CFRunLoopCopyAllModes" 
   ((rl (:pointer :__CFRunLoop))
   )
   (:pointer :__CFArray)
() )
; !
; 	@function CFRunLoopAddCommonMode
; 	Makes the named mode a "common mode" for the run loop. The set of
; 	common modes are collectively accessed with the global constant
; 	kCFRunLoopCommonModes. Input sources previously added to the
; 	common modes are added to the new common mode.
; 	@param rl The run loop for which the mode should be made common.
; 	@param mode The name of the mode to mark as a common mode.
; 

(deftrap-inline "_CFRunLoopAddCommonMode" 
   ((rl (:pointer :__CFRunLoop))
    (mode (:pointer :__CFString))
   )
   nil
() )
; !
; 	@function CFRunLoopGetNextTimerFireDate
; 	Returns the time at which the next timer will fire.
; 	@param rl The run loop for which the next timer fire date should
; 		be reported.
; 	@param mode The name of the mode to query.
; 

(deftrap-inline "_CFRunLoopGetNextTimerFireDate" 
   ((rl (:pointer :__CFRunLoop))
    (mode (:pointer :__CFString))
   )
   :double-float
() )

(deftrap-inline "_CFRunLoopRun" 
   (
   )
   nil
() )

(deftrap-inline "_CFRunLoopRunInMode" 
   ((mode (:pointer :__CFString))
    (seconds :double-float)
    (returnAfterSourceHandled :Boolean)
   )
   :SInt32
() )

(deftrap-inline "_CFRunLoopIsWaiting" 
   ((rl (:pointer :__CFRunLoop))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopWakeUp" 
   ((rl (:pointer :__CFRunLoop))
   )
   nil
() )

(deftrap-inline "_CFRunLoopStop" 
   ((rl (:pointer :__CFRunLoop))
   )
   nil
() )

(deftrap-inline "_CFRunLoopContainsSource" 
   ((rl (:pointer :__CFRunLoop))
    (source (:pointer :__CFRunLoopSource))
    (mode (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopAddSource" 
   ((rl (:pointer :__CFRunLoop))
    (source (:pointer :__CFRunLoopSource))
    (mode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFRunLoopRemoveSource" 
   ((rl (:pointer :__CFRunLoop))
    (source (:pointer :__CFRunLoopSource))
    (mode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFRunLoopContainsObserver" 
   ((rl (:pointer :__CFRunLoop))
    (observer (:pointer :__CFRunLoopObserver))
    (mode (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopAddObserver" 
   ((rl (:pointer :__CFRunLoop))
    (observer (:pointer :__CFRunLoopObserver))
    (mode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFRunLoopRemoveObserver" 
   ((rl (:pointer :__CFRunLoop))
    (observer (:pointer :__CFRunLoopObserver))
    (mode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFRunLoopContainsTimer" 
   ((rl (:pointer :__CFRunLoop))
    (timer (:pointer :__CFRunLoopTimer))
    (mode (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopAddTimer" 
   ((rl (:pointer :__CFRunLoop))
    (timer (:pointer :__CFRunLoopTimer))
    (mode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFRunLoopRemoveTimer" 
   ((rl (:pointer :__CFRunLoop))
    (timer (:pointer :__CFRunLoopTimer))
    (mode (:pointer :__CFString))
   )
   nil
() )
; !
; 	@typedef CFRunLoopSourceContext
; 	Structure containing the callbacks of a CFRunLoopSource.
; 	@field version The version number of the structure type being
; 		passed in as a parameter to the CFArray creation
; 		functions. Valid version numbers are currently 0 and 1.
; 		Version 0 sources are fairly generic, but may require a
; 		bit more implementation, or may require a separate
; 		thread as part of the implementation, for a complex
; 		source. Version 1 sources are available on Mach, and
; 		have performance advantages when the source type can
; 		be described with this style.
; 	@field info An arbitrary pointer to client-defined data, which
; 		can be associated with the source at creation time, and
; 		is passed to the callbacks.
; 	@field retain The callback used to add a retain for the source on
; 		the info pointer for the life of the source, and may be
; 		used for temporary references the source needs to take.
; 		This callback returns the actual info pointer to store in
; 		the source, almost always just the pointer passed as the
; 		parameter.
; 	@field release The callback used to remove a retain previously
; 		added for the source on the info pointer. 
; 	@field copyDescription The callback used to create a descriptive
; 		string representation of the info pointer (or the data
; 		pointed to by the info pointer) for debugging purposes.
; 		This is used by the CFCopyDescription() function.
; 	@field equal The callback used to compare the info pointers of
; 		two sources, to determine equality of sources.
; 	@field hash The callback used to compute a hash code for the info
; 		pointer for the source. The source uses this hash code
; 		information to produce its own hash code.
; 	@field schedule For a version 0 source, this callback is called
; 		whenever the source is added to a run loop mode. This
; 		information is often needed to implement complex sources.
; 	@field cancel For a version 0 source, this callback is called
; 		whenever the source is removed from a run loop mode. This
; 		information is often needed to implement complex sources.
; 	@field getPort Defined in version 1 sources, this function returns
; 		the Mach port to represent the source to the run loop.
; 		This function must return the same Mach port every time it
; 		is called, for the lifetime of the source, and should be
; 		quick.
; 	@field perform This callback is the workhorse of a run loop source.
; 		It is called when the source needs to be "handled" or
; 		processing is needed for input or conditions relating to
; 		the source. For version 0 sources, this function is called
; 		when the source has been marked "signaled" with the
; 		CFRunLoopSourceSignal() function, and should do whatever
; 		handling is required for the source. For a version 1
; 		source, this function is called when a Mach message arrives
; 		on the source's Mach port, with the Mach message, its
; 		length, an allocator, and the source's info pointer. A
; 		version 1 source performs whatever processing is required
; 		on the Mach message, then can return a pointer to a Mach
; 		message (or NULL if none) to be sent (usually this is a
; 		"reply" message), which should be allocated with the
; 		allocator (and will be deallocated by the run loop after
; 		sending).
; 
(defrecord CFRunLoopSourceContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
   (equal (:pointer :callback))                 ;(Boolean (const void * info1 , const void * info2))
   (hash (:pointer :callback))                  ;(CFHashCode (const void * info))
   (schedule (:pointer :callback))              ;(void (void * info , CFRunLoopRef rl , CFStringRef mode))
   (cancel (:pointer :callback))                ;(void (void * info , CFRunLoopRef rl , CFStringRef mode))
   (perform (:pointer :callback))               ;(void (void * info))
)

; #if defined(__MACH__)
#| 
(defrecord CFRunLoopSourceContext1
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
   (equal (:pointer :callback))                 ;(Boolean (const void * info1 , const void * info2))
   (hash (:pointer :callback))                  ;(CFHashCode (const void * info))
   (getPort (:pointer :callback))               ;(mach_port_t (void * info))
   (perform (:pointer :callback))               ;(void * (void * msg , CFIndex size , CFAllocatorRef allocator , void * info))
)
 |#

; #endif

; !
; 	@function CFRunLoopSourceGetTypeID
; 	Returns the type identifier of all CFRunLoopSource instances.
; 

(deftrap-inline "_CFRunLoopSourceGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function CFRunLoopSourceCreate
; 	Creates a new run loop source with the given context.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. If this
; 		reference is not a valid CFAllocator, the behavior is
; 		undefined.
; 	@param order On platforms which support it, for source versions
; 		which support it, this parameter determines the order in
; 		which the sources which are ready to be processed are
; 		handled. A lower order number causes processing before
; 		higher order number sources. It is inadvisable to depend
; 		on the order number for any architectural or design aspect
; 		of code. In the absence of any reason to do otherwise,
; 		zero should be used.
; 	@param context A pointer to the context structure for the source.
; 

(deftrap-inline "_CFRunLoopSourceCreate" 
   ((allocator (:pointer :__CFAllocator))
    (order :SInt32)
    (context (:pointer :CFRUNLOOPSOURCECONTEXT))
   )
   (:pointer :__CFRunLoopSource)
() )
; !
; 	@function CFRunLoopSourceGetOrder
; 	Returns the ordering parameter of the run loop source.
; 	@param source The run loop source for which the order number
; 		should be returned.
; 

(deftrap-inline "_CFRunLoopSourceGetOrder" 
   ((source (:pointer :__CFRunLoopSource))
   )
   :SInt32
() )
; !
; 	@function CFRunLoopSourceInvalidate
; 	Invalidates the run loop source. The run loop source is never
; 	performed again after it becomes invalid, and will automatically
; 	be removed from any run loops and modes which contain it. The
; 	source is not destroyed by this operation, however -- the memory
; 	is still valid; only the release of all references on the source
; 	through the reference counting system can do that. But note, that
; 	if the only retains on the source were held by run loops, those
; 	retains may all be released by the time this function returns,
; 	and the source may actually be destroyed through that process.
; 	@param source The run loop source which should be invalidated.
; 

(deftrap-inline "_CFRunLoopSourceInvalidate" 
   ((source (:pointer :__CFRunLoopSource))
   )
   nil
() )
; !
; 	@function CFRunLoopSourceIsValid
; 	Reports whether or not the source is valid.
; 	@param source The run loop source for which the validity should
; 		be returned.
; 

(deftrap-inline "_CFRunLoopSourceIsValid" 
   ((source (:pointer :__CFRunLoopSource))
   )
   :Boolean
() )
; !
; 	@function CFRunLoopSourceGetContext
; 	Fills the memory pointed to by the context parameter with the
; 	context structure of the source.
; 	@param source The run loop source for which the context structure
; 		should be returned.
; 	@param context A pointer to a context structure to be filled.
; 

(deftrap-inline "_CFRunLoopSourceGetContext" 
   ((source (:pointer :__CFRunLoopSource))
    (context (:pointer :CFRUNLOOPSOURCECONTEXT))
   )
   nil
() )
; !
; 	@function CFRunLoopSourceSignal
; 	Marks the source as signalled, ready for handling by the run loop.
; 	Has no effect on version 1 sources, which are automatically
; 	handled when Mach messages for them come in.
; 	@param source The run loop source which should be signalled.
; 

(deftrap-inline "_CFRunLoopSourceSignal" 
   ((source (:pointer :__CFRunLoopSource))
   )
   nil
() )
(defrecord CFRunLoopObserverContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)

(def-mactype :CFRunLoopObserverCallBack (find-mactype ':pointer)); (CFRunLoopObserverRef observer , CFRunLoopActivity activity , void * info)
; !
; 	@function CFRunLoopObserverGetTypeID
; 	Returns the type identifier of all CFRunLoopObserver instances.
; 

(deftrap-inline "_CFRunLoopObserverGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFRunLoopObserverCreate" 
   ((allocator (:pointer :__CFAllocator))
    (activities :UInt32)
    (repeats :Boolean)
    (order :SInt32)
    (callout :pointer)
    (context (:pointer :CFRUNLOOPOBSERVERCONTEXT))
   )
   (:pointer :__CFRunLoopObserver)
() )

(deftrap-inline "_CFRunLoopObserverGetActivities" 
   ((observer (:pointer :__CFRunLoopObserver))
   )
   :UInt32
() )

(deftrap-inline "_CFRunLoopObserverDoesRepeat" 
   ((observer (:pointer :__CFRunLoopObserver))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopObserverGetOrder" 
   ((observer (:pointer :__CFRunLoopObserver))
   )
   :SInt32
() )

(deftrap-inline "_CFRunLoopObserverInvalidate" 
   ((observer (:pointer :__CFRunLoopObserver))
   )
   nil
() )

(deftrap-inline "_CFRunLoopObserverIsValid" 
   ((observer (:pointer :__CFRunLoopObserver))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopObserverGetContext" 
   ((observer (:pointer :__CFRunLoopObserver))
    (context (:pointer :CFRUNLOOPOBSERVERCONTEXT))
   )
   nil
() )
(defrecord CFRunLoopTimerContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)

(def-mactype :CFRunLoopTimerCallBack (find-mactype ':pointer)); (CFRunLoopTimerRef timer , void * info)
; !
; 	@function CFRunLoopTimerGetTypeID
; 	Returns the type identifier of all CFRunLoopTimer instances.
; 

(deftrap-inline "_CFRunLoopTimerGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFRunLoopTimerCreate" 
   ((allocator (:pointer :__CFAllocator))
    (fireDate :double-float)
    (interval :double-float)
    (flags :UInt32)
    (order :SInt32)
    (callout :pointer)
    (context (:pointer :CFRUNLOOPTIMERCONTEXT))
   )
   (:pointer :__CFRunLoopTimer)
() )

(deftrap-inline "_CFRunLoopTimerGetNextFireDate" 
   ((timer (:pointer :__CFRunLoopTimer))
   )
   :double-float
() )

(deftrap-inline "_CFRunLoopTimerSetNextFireDate" 
   ((timer (:pointer :__CFRunLoopTimer))
    (fireDate :double-float)
   )
   nil
() )

(deftrap-inline "_CFRunLoopTimerGetInterval" 
   ((timer (:pointer :__CFRunLoopTimer))
   )
   :double-float
() )

(deftrap-inline "_CFRunLoopTimerDoesRepeat" 
   ((timer (:pointer :__CFRunLoopTimer))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopTimerGetOrder" 
   ((timer (:pointer :__CFRunLoopTimer))
   )
   :SInt32
() )

(deftrap-inline "_CFRunLoopTimerInvalidate" 
   ((timer (:pointer :__CFRunLoopTimer))
   )
   nil
() )

(deftrap-inline "_CFRunLoopTimerIsValid" 
   ((timer (:pointer :__CFRunLoopTimer))
   )
   :Boolean
() )

(deftrap-inline "_CFRunLoopTimerGetContext" 
   ((timer (:pointer :__CFRunLoopTimer))
    (context (:pointer :CFRUNLOOPTIMERCONTEXT))
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFRUNLOOP__ */


(provide-interface "CFRunLoop")