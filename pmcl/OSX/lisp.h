#ifndef __lisp__
#define __lisp__

#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <MachineExceptions.h>
#include <Memory.h>
#endif
#include "constants.h"
#include "macros.h"

/* typedef char *BytePtr; - new headers don't like this */

unsigned
align_to_power_of_2(unsigned, unsigned);

extern unsigned os_version;
#define is_osx() (os_version >= 0x00001000)

extern Boolean can_use_stdio;


void
mclMakeDataExecutable(void *,unsigned long);
#endif

/* #define VBL_INTERRUPT */
/* #define ALARM_INTERRUPT */
#define THREAD_INTERRUPT


#ifdef ALARM_INTERRUPT
#define ALARM_SIGNAL SIGALRM
#define ITIMER_INTERRUPT ITIMER_REAL
#endif

#ifndef VBL_INTERRUPT
#ifndef ALARM_INTERRUPT
#ifndef THREAD_INTERRUPT
#define start_interrupt_timer()
#endif
#endif
#endif
