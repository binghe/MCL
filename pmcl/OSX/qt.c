#include "lisp.h"
#include "lisp_globals.h"
#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Memory.h>
#include <Threads.h>
#endif
#include "qt.h"


#ifdef PMCL_OSX_NATIVE_KERNEL

extern mach_port_t TScurrent_mach_thread;

void
nuke_thread_exception_port(void *arg)
{
  if (arg) {
    mach_port_destroy((mach_port_t)arg);
  }
}

pthread_key_t
exception_port_key()
{
  static exception_port_tsd_key = (pthread_key_t) -1;
  
  if (exception_port_tsd_key == (pthread_key_t) -1) {
    pthread_key_create(&exception_port_tsd_key, nuke_thread_exception_port);
  }
  return exception_port_tsd_key;
}

void
register_thread_exception_port(mach_port_t exc_port)
{
  pthread_setspecific(exception_port_key(), (void *)exc_port);
}

void *
thread_startup_hook(void *arg)
{
  ThreadEntryProcPtr tepp = (ThreadEntryProcPtr)arg;

  install_pmcl_exception_handlers();
  TScurrent_mach_thread = mach_thread_self();
  /* DebugStr("\pin-startup-suck"); */
  return tepp(NULL);
}
#endif

/* 
   Our notion of a (pseudo) Mac thread.  The next and prev pointers
   are just to there to make insertion and deletion of 
   mac_thread structures easier; there's no implied ordering,
   aside from the fact that "current_mac_thread" points to
   the currently active mac_thread.
*/

typedef struct mac_thread
{
  struct mac_thread *prev;
  struct mac_thread *next;
  ThreadID id;
  void *stack_buf;		/* what was allocated, so we can free it */
  qt_t *q;
} mac_thread;

mac_thread  main_thread = {0}, *current_mac_thread = NULL;
int next_mac_thread_id = 1000;


#ifndef MAP_GROWSDOWN
#define MAP_GROWSDOWN 0
#endif

Ptr
create_stack(unsigned size)
{
  Ptr p;
  
  size = (size + 15) & ~15;
  p = NewPtr(size);
  if (p) {
    *((unsigned *)p) = size;
    return p;
  }
  
  allocation_failure(true, size);
}
  
void *
allocate_stack(unsigned size)
{
  return create_stack(size);
}

void
free_stack(void *s)
{
  DisposePtr(s);
}


mac_thread *
find_mac_thread(ThreadID id) 
{
  mac_thread *p = current_mac_thread, *q = p;

  if (id == (ThreadID)kCurrentThreadID) {
    return p;
  }
  do {
    if (p->id == id) {
      return p;
    }
    p = p->next;
  } while (p != q);
  return NULL;
}
void
qt_error (void)
{
  extern void abort(void);

  abort();
}
   
void
mac_thread_only(void *userparam, void *m, qt_userf_t *f)
{
  extern void invoke_user_function(void *, qt_userf_t *);
  current_mac_thread = (mac_thread *)m;
  invoke_user_function(userparam, f);
  qt_error();
}

ThreadEntryTPP mac_thread_onlyTPP = NULL, qt_startTPP = NULL;

void
init_mac_threads(void * stack_base)
{
  current_mac_thread = &main_thread;
  current_mac_thread->next = 
    current_mac_thread->prev =
    current_mac_thread;
  current_mac_thread->id = (ThreadID) kApplicationThreadID;
  current_mac_thread->stack_buf = stack_base;
  current_mac_thread->q = NULL;
  mac_thread_onlyTPP = NewThreadEntryUPP((ThreadEntryProcPtr)mac_thread_only);
  qt_startTPP = NewThreadEntryUPP((ThreadEntryProcPtr)qt_start);
#ifdef PMCL_OSX_NATIVE_KERNEL
  TScurrent_mach_thread = mach_thread_self();
#endif
}


void
mac_thread_insert(mac_thread *m)
{
  mac_thread *next = current_mac_thread,
    *prev = next->prev;

  prev->next = m;
  next->prev = m;
  m->next = next;
  m->prev = prev;
}

mac_thread *
mac_thread_create(Size stacksize, qt_userf_t *f, void *param)
{
  mac_thread *m = (mac_thread *) NewPtr(sizeof(mac_thread));
  void *s;
    
  s = allocate_stack(stacksize);
  if (m) {
    if (s == NULL) {
      DisposePtr((Ptr) m);
      return NULL;
    }
    m->id = (ThreadID) next_mac_thread_id++;
    m->stack_buf = s;
    m->q = QT_SP(s, stacksize);
    m->q = QT_ARGS(m->q, param, m, f, mac_thread_onlyTPP);
    mac_thread_insert(m);
  }
  return m;
}

void *
mac_thread_yieldhelp(qt_t *q, void *old, void *param)
{
  ((mac_thread *)old)->q = q;
  return param;
}

void
mac_thread_yield(mac_thread *new)
{
  mac_thread *old = current_mac_thread;
  current_mac_thread = new;
  QT_BLOCK(mac_thread_yieldhelp, old, NULL, new->q);
}

/* 
   This code pretends to be as much of the MacOS Thread
   Manager as the lisp uses: it handles thread creation,
   destruction, and context switch.
*/

OSErr
fakeNewThread(ThreadStyle style, 
	      ThreadEntryTPP entry,
	      void *param, 
	      Size stacksize, 
	      ThreadOptions options,
	      void **resultP,
	      ThreadID *idP)
{
  OSErr err = noErr;
  mac_thread *m;
  if (style != kCooperativeThread) {
    return -50;
  }
  m = mac_thread_create(stacksize, (qt_userf_t *)entry, param);
  if (m != NULL) {
    *idP = m->id;
    return 0;
  }
  return -50;
}

OSErr
fakeDisposeThread(ThreadID id, void *result, Boolean recycle)
{
  mac_thread *m = find_mac_thread(id),
    *prev,
    *next;

  if ((m == NULL) ||
      (m == current_mac_thread) ||
      (m->id == kApplicationThreadID)) {
    return -50;
  }
  next = m->next;
  prev = m->prev;
  
  prev->next = next;
  next->prev = prev;
  free_stack(m->stack_buf);
  DisposePtr((Ptr) m);
  return noErr;
}

OSErr
fakeYieldToThread(ThreadID id)
{
  mac_thread *m = find_mac_thread(id);
  if ((m != NULL) && (m != current_mac_thread)) {
    mac_thread_yield(m);
    return noErr;
  }
  return -50;
}
  
OSErr
fakeThreadCurrentStackSpace(ThreadID id, UInt32 *resultP)
{
  mac_thread *m = find_mac_thread(id);
  unsigned size = 0;
  OSErr result = noErr;

  if (m == NULL) {
    result = -50;
  } else {
    if (m == current_mac_thread) {
      size = (UInt32) ((char *)(&m) - (char *) m->stack_buf);
    } else {
      size = (UInt32) ((char *) m->q - (char *) m->stack_buf);
    }
  }
  if (resultP != NULL) {
    *resultP = size;
  }
  return result;
}


int use_thread_manager_threads_on_OSX = 
#ifdef PMCL_OSX_NATIVE_KERNEL
1
#else
0
#endif
;


int
use_new_threads()
{
  if (is_osx()) {
    return !use_thread_manager_threads_on_OSX;
  }
  return 0;
}

LispObj initial_saved_registers[8] = {0,0,0,0,0,0,0,0};

OSErr
xNewThread(ThreadStyle style, 
	   ThreadEntryTPP entry,
	   void *param, 
	   Size stacksize, 
	   ThreadOptions options,
	   void **resultP,
	   ThreadID *idP)
{
  lisp_global(EXCEPTION_SAVED_REGISTERS) = (LispObj)initial_saved_registers;

   if (use_new_threads()) {
     return fakeNewThread(style,entry,param,stacksize,options,resultP,idP);
   }
#ifdef PMCL_OSX_NATIVE_KERNEL
   if (stacksize < (1<<20)) {
     stacksize = 1<<20;
   }
   return NewThread(style,thread_startup_hook,(void *) entry,stacksize,options,resultP,idP);
#else
   return NewThread(style,entry,param,stacksize,options,resultP,idP);
#endif
}


OSErr
kernel_xYieldToThread(ThreadID id)
{
  OSErr err;
  if (use_new_threads()) {
    return fakeYieldToThread(id);
  }
#ifdef PMCL_OSX_NATIVE_KERNEL
  TScurrent_mach_thread = (mach_port_t)0;
#endif

  err = YieldToThread(id);
#ifdef PMCL_OSX_NATIVE_KERNEL
  TScurrent_mach_thread = mach_thread_self();
#endif
  return err;
}

/*
  This should only be called by STACK-GROUP-RESUME.
*/

OSErr
xYieldToThread(ThreadID id)
{ 
 OSErr err;
 
 err = kernel_xYieldToThread(id);
 lock_binding_stack();
  return err;
}

OSErr
xDisposeThread(ThreadID id, void *result, Boolean recycle)
{
  if (use_new_threads()) {
    return fakeDisposeThread(id, result, recycle);
  }
  return DisposeThread(id, result, recycle);
}

OSErr
xThreadCurrentStackSpace(ThreadID id, UInt32 *resultP)
{
  if (use_new_threads()) {
    return fakeThreadCurrentStackSpace(id, resultP);
  }
  return ThreadCurrentStackSpace(id, resultP);
}

void
qt_null (void)
{
}


